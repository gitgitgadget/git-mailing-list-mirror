From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Split sample update hook into post-receive hook
Date: Thu, 8 Mar 2007 10:57:01 +0100
Message-ID: <81b0412b0703080157n413de6f6q35ae24e2620df91d@mail.gmail.com>
References: <20070308041618.GA29744@spearce.org>
	 <81b0412b0703080026v6f3990c3x2cefca661b64e00d@mail.gmail.com>
	 <20070308083317.GB30289@spearce.org>
	 <7vy7m8aytt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Andy Parkins" <andyparkins@gmail.com>,
	"Bill Lear" <rael@zopyra.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 10:57:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFN2-0004l6-OU
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 10:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbXCHJ5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 04:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030545AbXCHJ5E
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 04:57:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:35539 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030525AbXCHJ5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 04:57:03 -0500
Received: by nf-out-0910.google.com with SMTP id o25so573157nfa
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 01:57:01 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R/ZiyguMQPU/g0Mi53H3d6RuANyN7/KUHfyPJUNa1WU1bn783vO4ecEGCTwVu4Z8cDFsBA+yDmtwZQVau5Yq+ih/P40xxpDkonTRfQX8A0b20Ku0I34dB4LT6p9twSX6fncgl5/l5K7JMFXBvINeM6A+tGplStiRAVmqWU+tPDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ins99SwWwzJyDsoLw4z5I9M20Lu7Vkkw7qAkanvpTSJ1sV/ljj67HjRC54NilRPJBPKzlwgzdsDpZHHucVri7Ox51HWi1HtNSlY0SHP/5TFYk6eI9cnwa5g31DVKIem4axAQy13yuYGcTxLFbM50haN12PRzCtW1uU/g8la2sAE=
Received: by 10.78.195.9 with SMTP id s9mr20610huf.1173347821434;
        Thu, 08 Mar 2007 01:57:01 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Thu, 8 Mar 2007 01:57:01 -0800 (PST)
In-Reply-To: <7vy7m8aytt.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41728>

On 3/8/07, Junio C Hamano <junkio@cox.net> wrote:
> But this is only true if you want to make it really nice.  I
> personally feel that nobody would scream if pushing 1300 refs at
> once (4K pages and MAX_ARG_PAGES at 32 would give 128K for
> **argv and its strings, and one ref's worth of data is two
> 40-digit hex plus refname, roughly 100-byte per ref) is not
> supported and always failed.

I'm not too worried about linux. It wont have any problems
even if you supply megabytes of arguments (if someone will
really need such lists, he can increase MAX_ARG_PAGES
and be done with it).

The proprietary OS' will have the problem, though. And far sooner
than 1300 refs (w2k has only 32767 bytes for command line).
Besides, don't overestimate peoples readiness to be careful
about reference names. I would expect reference names over
100 bytes in length to happen regularly (generated from file names
appended with a timestamp, for example).

Maybe provide this hooks with simply formatted list on stdin? I.e.

<old-ref> <new-ref> <ref-name> LF
