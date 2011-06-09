From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/19] git_remote_helpers: push all refs during a
 non-local export
Date: Thu, 9 Jun 2011 03:43:42 -0500
Message-ID: <20110609084342.GC4885@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-7-git-send-email-srabbelier@gmail.com>
 <20110608194205.GI27715@elie>
 <20110608221908.GB15530@sigill.intra.peff.net>
 <20110609080912.GB4885@elie>
 <BANLkTincedbjH+ta6g7+uA3=3k_30RQaCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 10:43:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUaqI-0000q3-R2
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 10:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873Ab1FIInu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 04:43:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52183 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab1FIInt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 04:43:49 -0400
Received: by iwn34 with SMTP id 34so1120294iwn.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2LcMisLUWs3D1DHoAosV2CKD3a/HQOOPx7d9fReI1M0=;
        b=mqJiMtepZz7slxX+fpORQBcw3u6+BejS4xDsd6rBD4roOeBBOf+zp5L8PqUOSO9FMw
         n7TR/x8FoARCwytKvi6DvjYCF/4etWbDrW8P1ew+PX7tQT/qq32+y4nKz2YNw8SGY+hM
         6v6lP10G+4TBtARroX9V5wMgpqi6NCIao7HBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mBwaoX2Ycd99mrTkQ7EcORQP62P74+jQHNi0ffnTzlFTRGsKt7lgFnMMqCIcelOJdg
         bq8JM4QCzz9vUNFJC0+IUpy17B4MlAnrgzt/rw75ywO5gSYi08UWDUvGslGmLAiJfBul
         zEFNdNXfJMTXiVwMOX+s743BPBQG2AgpHT4YY=
Received: by 10.42.168.198 with SMTP id x6mr743977icy.273.1307609028204;
        Thu, 09 Jun 2011 01:43:48 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.ameritech.net [69.209.61.87])
        by mx.google.com with ESMTPS id vo3sm1167841icb.10.2011.06.09.01.43.45
        (version=SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 01:43:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTincedbjH+ta6g7+uA3=3k_30RQaCg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175506>

Sverre Rabbelier wrote:
> On Thu, Jun 9, 2011 at 10:09, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0export :1 refs/heads/foo
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0export :2 refs/heads/bar
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0export :3 +refs/heads/force
>>
>> with :1, :2, and :3 being marks in the fast-import stream.
>
> The only problem there is that we don't know the relevant marks befor=
ehand.

Since this requires changing "git fast-export" anyway, we could
arrange to know.

A related problem, though: it is not friendly to stomp on mark numbers
which an exporter might want to use for some other purpose.  So yeah,
the precise syntax above is not so great.
