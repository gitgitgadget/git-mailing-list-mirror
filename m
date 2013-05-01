From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/5] remote.c: teach branch_get() to treat symrefs other
 than HEAD
Date: Wed, 1 May 2013 15:48:55 -0500
Message-ID: <CAMP44s1dWhpVhUar2-u1NAqK-TPssxZYgGMY9_SVxvuKSFT4QA@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-5-git-send-email-artagnon@gmail.com>
	<CAMP44s20F-QALd18VPHLF4Fj=eFFvXmkhC4XK__kxNhMoeN=ug@mail.gmail.com>
	<CALkWK0n2odCn=GnYSXv7g113PFEX42WF1d2GBGV=ye2TuY3CHA@mail.gmail.com>
	<CAMP44s34X+6c2V0iU_+dfNR9ULXD+Q0CDFk0S9qdK0n8AC81DQ@mail.gmail.com>
	<CALkWK0mfHVBLPdU7jyiBR=-kSguCBFOhsEsXYYthBuQbtX7MuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 22:49:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXdxZ-0002pH-3a
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 22:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab3EAUs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 16:48:58 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35475 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757020Ab3EAUs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 16:48:57 -0400
Received: by mail-lb0-f172.google.com with SMTP id o10so1801481lbi.31
        for <git@vger.kernel.org>; Wed, 01 May 2013 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=s7gzYFTuOGMP+Bd3UKuvwcAlGWSc47oNLyt+oDgKTe0=;
        b=F315ONLkXC0lnVCAseu8CzRbIMeBeO2C8f95UKMbCEip+T73dTv9+mDRH65dCG2UIt
         R2nl2YLVmxVbAkor6g9w84rF7GbAX00TsN5rI3BVmzhtPOjpjspZx6DrqHvGGmH9aoIl
         fXXkWdt39F9h5bE35EkF1mP5fpw64ttObguDMB5uuObKua07YZr7yLcEFIUYwRJwrnpG
         Fbs6FTz8ro46oPuoDjrf579GL2rc362xhIfIm7I2V3+CYCNTUsH+3NPPPbqgKwSBKuaa
         jliAqqXhU7Sm9OH3boCrPdUKW++meZhg3pEiNxp0XNMJKDh9S3zbL/gnotZWyrQErNRX
         hQig==
X-Received: by 10.112.145.72 with SMTP id ss8mr943909lbb.12.1367441335547;
 Wed, 01 May 2013 13:48:55 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 13:48:55 -0700 (PDT)
In-Reply-To: <CALkWK0mfHVBLPdU7jyiBR=-kSguCBFOhsEsXYYthBuQbtX7MuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223141>

On Wed, May 1, 2013 at 2:50 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> As I said, the @@{u} thing can be fixed through other ways.
>
> It's not just @@{u}.  I can have lots of custom symbolic refs working
> properly; I might choose D for my deleted-reflogs, M for master and so
> on.

And that doesn't require the changes you did to sha1_name.c, or
t/t1508-at-combinations.sh, does it?

If you are arguing in favor of arbitrary symbolic refs plus @{u} to
work, a patch that allows that, and nothing else, should make sense.
Such patch would trigger further discussion, for example, if
get_branch() is the right place to achieve that.

> The point is that my solution solves the problem in the more general case.
>
>> Moreover, "HEAD" is still a special case in remote.c::branch_get()
>> that you just modified.
>
> It's not.  It's just a quick shortcut for the common case because
> read_config() already sets it up.

I still see this in the code:

	if (!name || !*name || !strcmp(name, "HEAD"))
		ret = current_branch;
	else
		ret = make_branch(name, 0);

-- 
Felipe Contreras
