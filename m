From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Help creating git alias
Date: Thu, 31 Oct 2013 11:36:59 -0400
Message-ID: <CAPZPVFYFSBRHThO08LmuN_0fc55gYX-A+Y3=yA_MESko1t6fXQ@mail.gmail.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
	<CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
	<CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
	<xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
	<CAPZPVFarK_jKpM2f62mErAmL+mck6EN1QPfHDHqqfJbJ2AfzXg@mail.gmail.com>
	<xmqqk3gu9jst.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 16:37:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbuJ1-0004Ty-Sj
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 16:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab3JaPhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 11:37:01 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:63246 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab3JaPhA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 11:37:00 -0400
Received: by mail-wi0-f171.google.com with SMTP id f4so4598066wiw.4
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+M1mdfZhf3hnjJf6txsDiwo6QOROwnfLDtPTF64UAP0=;
        b=M502hye7ndFqW+eZchApr9G0TmXwLgPhHwlFQ6jKplosgG95XIxncTBNfHTIBIXRsX
         gpgz4vJfIZoMNLPOcZ1kfvIsvVQQGPD95s5/vB5GZ6TWbrmrFryEZl6aNczEEnzSck4u
         v0F3pD2wuuqPFc1BGij0rYdW207vZa/78ZFndGpxipTlFmy6MM6y2S2EU6o6INe+OLyx
         cwxXVoyt4QUfWqNPwWbo+NG0O7+RTVtDKEk2E26iS9yBN0lTYOGwpFGbF2c+lwKOqNJk
         TW0nrBfy2KtUD7aF97dBBeKOxmOn20N5WZw+EAJFz3whvYfUXGM8Og74DdHREtS/v8tm
         rdMw==
X-Received: by 10.194.238.230 with SMTP id vn6mr3036615wjc.57.1383233819620;
 Thu, 31 Oct 2013 08:36:59 -0700 (PDT)
Received: by 10.216.123.145 with HTTP; Thu, 31 Oct 2013 08:36:59 -0700 (PDT)
In-Reply-To: <xmqqk3gu9jst.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237127>

On Wed, Oct 30, 2013 at 11:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> That was my initial intention, because I would like to be able to pass
>> parameters like to git log or git blame correctly without the explicit
>> use of $1. Could you please advise about how to make it work with the
>> !sh -c ?
>>
>> Because the same exact (sed 's/@\\S*//') syntax didn't work with "sh -c".
>
> You can make it work if you think step-by-step.  First, this is what
> you want to run:
>
>         sh -c 'git log --format="..." "$@" | sed "s/@\S*//"' -
>
> so that "git euguess master..next" would turn into
>
>         sh -c 'git log --format="..." "$@" | sed "s/@\S*//"' - master..next
>
> Now, you want to wrap it into an alias, i.e.
>
>         [alias]
>                 euguess = "!sh -c ..."
>
> That ... part is read by our configuration reader, so you need to
> quote the double quotes and backslashes with backslash, which would
> give you something like:
>
>         [alias]
>                 euguess = "!sh -c 'git log --format=\"%h %ae %s\" --date=short \"$@\" | sed \"s/@\\S*//\"' -"
>
>

Junio,

Thanks for taking the time - I appreciate that a lot.
It does work properly now except there is some difference between the
required pathnames:

when i'm in a subfolder in git repo i can say

git log filename

But it seems that if the alias is used i need to specify full path
from the root of the repo no matter where i am.

git log a/b/c/filename

the difference is obviously in the working directory

when i add an alias:

pd = "!sh -c 'pwd'"

i get this:

$ git pd
/home/users/euguess/repo

$ pwd
/home/users/euguess/repo/a/b/c

Is there any way to help that situation?

Thanks,
Eugene

Thanks,
Eugene
