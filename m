From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 2/2] submodule: fix handling of supermodules with relative
 origin URLs
Date: Sun, 20 May 2012 11:25:07 +1000
Message-ID: <CAH3AnrqM_T1kzHjtbZ5Vxz+jN6b-ZcxGUd5F=q23RXQLyQ2SYg@mail.gmail.com>
References: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com>
	<1337402403-7546-2-git-send-email-jon.seymour@gmail.com>
	<4FB7ECCF.9020403@web.de>
	<CAH3AnrrqiXqdHHGZPyOPJ3Zend5JrQX0rKV+pz_mjs3SDjv9DA@mail.gmail.com>
	<4FB83BFC.4000702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun May 20 03:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVutb-0005wC-CM
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 03:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741Ab2ETBZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 21:25:10 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55590 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab2ETBZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 21:25:09 -0400
Received: by wgbdr13 with SMTP id dr13so3860175wgb.1
        for <git@vger.kernel.org>; Sat, 19 May 2012 18:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EpZDrrvAUfOJcK7bNyVxArANz/BLDChmQeFw46MmabA=;
        b=BO782dBd1T5bFz8vIHz2I4lQ2ZcwnMCMRThwHmy3ellhq2yAG7N+l5CWg0eismO00Q
         8uviwOaJkZrLb4aZm7VHVxH2x1JtrO+oiDYYO8lGofDjyEH7LXm7pLDC2sorx0plh+BO
         6ChE2HQBaN7mxZQHKf3ifq4pHH0qcMCiLsTg9sApeFeV7MdIiImseK+o+ASH4qyx7Yct
         3eNNA94nc3tiDzbC/RTUvmTK4KpOINv4UhdY4JDXam2ej/WdhS9LRvnloOlYngupN5tT
         XU1Zs9bHO82a/iV3TLiQLQJo4ThGTMGaIb8igxx6h3HD0LPTWN7K6U5fhgd6dPTvvhKC
         h0rQ==
Received: by 10.180.75.241 with SMTP id f17mr13272172wiw.11.1337477107996;
 Sat, 19 May 2012 18:25:07 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sat, 19 May 2012 18:25:07 -0700 (PDT)
In-Reply-To: <4FB83BFC.4000702@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198048>

On Sun, May 20, 2012 at 10:34 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 20.05.2012 00:51, schrieb Jon Seymour:
>> On Sun, May 20, 2012 at 4:56 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Am 19.05.2012 06:40, schrieb Jon Seymour:
>>>
>>> Just a small nit: I'd prefer to replace the 4 occurrences of the term
>>> "supermodule" with "superproject".
>>
>> Sure. I can't argue with precedent, of course, but I guess I was
>> favouring the consistency in the suffixes used with sub and super.
>
> No big deal, but in recent posts "superproject" has been used and
> the similarity between "supermodule" and "submodule" fooled me when
> I read your RFC patch. So even though a superproject might be the a
> submodule of another superproject, I'm all for using the term
> "superproject" to make the distinction obvious.
>
>>> So no objection on the code changes from my side.
>>
>> I noticed one relative case that is not handled properly yet, but
>> there is a workaround. If the superproject's origin URL is of the
>> form: foo/bar (a case I actually have myself for reasons I can explain
>> if you want me to), then the correct rule doesn't get matched by
>> .*/*). The workaround is for the user to change foo/bar style origin
>> URLs to ./foo/bar.
>>
>> Let me know if I should fix this case now too.
>
> Me thinks that this is subject for a subsequent patch. Having the
> URL of the superproject *below* the root directory of the
> superproject seems like a rather odd case which warrants a fix of
> its own ;-)

The situation arises in my case because my working directory (which
has git controlled elements) contains a subdirectory called mnt with a
symbolic link called git which points to the actual location of my git
respositories. So, in this case:

    mnt/git/public/work.git -> /var/git/public/work.git

So, if I want to set my origin to be my public git repositories, I naturally do:

   git remote set-url origin mnt/git/public/work.git

I'll wait to hear Junio's preference with regard to how I should split
the patches up before posting v3 that includes support for foo/bar in
addition to ../foo/bar and ./foo/bar.

Regards,

jon.
