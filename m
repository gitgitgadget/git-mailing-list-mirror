From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 14:17:55 -0800
Message-ID: <20140123221755.GA18964@google.com>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <CAJo=hJtQG_u4=SjPAgU8h4Wew9LjaXUxnHqTT3Q9E1=_5LJ6Sw@mail.gmail.com>
 <20140123202645.GA329@sigill.intra.peff.net>
 <20140123215325.GA28829@vauxhall.crustytoothpaste.net>
 <20140123220742.GA29357@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 23:18:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6SbB-0000B5-O9
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 23:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbaAWWSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 17:18:04 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:37217 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbaAWWSC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 17:18:02 -0500
Received: by mail-bk0-f44.google.com with SMTP id mz12so707222bkb.17
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 14:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yywGyxF0V+03bOxAV4XpH2ugG3jL3zXgTb+nR3aXQOQ=;
        b=i7hrV0MIAcaeF6Hyo+ZqzE0OXPhF/LIUD2u5M8p4TcOvvqCGWvoKqncrWtPKcmZF1+
         DNxPRptFQ7PsmMezP1GGOataMqTxz5JYWTXFcUUIKXWuK7riJLiKgwnTqcbpUNuttKED
         3Gdg+TYuc3UpkNKKgukpyETVcEhztBnbdmWysxv422Tk0ChXUiYeaXfnlyvgTbROFJ99
         pirQ8WN8DwuN1Bi2bcA6P2yr2ZfEkxdfD/4uRVv1NpOlhrOH16cUA0ON9AvAHTgtgwnq
         Q2zq2+yV0CS9teCFN/Wvb5sNhVurll8nXCXSQv6gLIb9XP519NhwhJ5U0IG9zdgztp+k
         Ddlg==
X-Received: by 10.204.229.139 with SMTP id ji11mr5514770bkb.4.1390515481292;
        Thu, 23 Jan 2014 14:18:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id rf10sm480061bkb.3.2014.01.23.14.17.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 14:18:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123220742.GA29357@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240966>

Jeff King wrote:
> On Thu, Jan 23, 2014 at 09:53:26PM +0000, brian m. carlson wrote:

>> Yes, it will.  SPARC requires all loads be naturally aligned (4-byte to
>> an address that's a multiple of 4, 8-byte to a multiple of 8, and so
>> on).  In general, architectures that do not support unaligned access
>> require natural alignment for all quantities.
>
> In that case, I think we cannot even blame Shawn. The ewah serialization
> format itself (which JGit inherited from the javaewah library) has 8
> bytes of header and 4 bytes of trailer. So packed serialized ewahs
> wouldn't be 8-byte aligned

I don't think that's a big issue.  A pair of 4-byte reads would not be
too slow.

Even on x86, aligned reads are supposed to be faster than unaligned
reads (though I haven't looked at benchmarks recently).
