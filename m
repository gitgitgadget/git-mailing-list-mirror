From: Alexander Kostikov <alex.kostikov@gmail.com>
Subject: Re: Rebase doesn't restore branch pointer back on out of memory
Date: Thu, 4 Oct 2012 14:39:02 -0700
Message-ID: <CAGAhT3nXeTCNyfywEtcpwaB2CDfOw8+eUK-oyXL-jA2TeajkOg@mail.gmail.com>
References: <CAGAhT3kofdaQEye9QHnvFhAAzoQqZtR7d5UzbxU+zEdkAHVfuQ@mail.gmail.com>
	<506CB3B5.808@gmail.com>
	<CAGAhT3mVn-W5P-n_YeafZ_7bntkJGArJ3o6+dA5GO_H44=KHFg@mail.gmail.com>
	<506DA7AE.50005@gmail.com>
	<CAGAhT3k=T0SGngMQkbXHqNfh-=LUb71C7CSrWXP2wsAgc8Tb8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:39:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtjP-00033L-H4
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946183Ab2JDVjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 17:39:08 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:55077 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946191Ab2JDVjD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 17:39:03 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1029992oag.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5V9YDQMLVoJg8cLqFpiA74C0SUvnfSYfWOLXGSWFey4=;
        b=LqICQRGN1sjrqa2B1TVrDN7Frq15VPY48SOwbE9jUP7gQRlG4caQjT40dKetW9xmfj
         J1A405Mr3Hd/sSro94Ng6W469VPxKHjZG+54PlAIXe9t+wC8qcV+Ty08+ff4/ATuWBvo
         zNYIi3edzqvVne29Ol7jJtET/IrIoY69jOFSG1DjIJVgFxcpwWJK4ytGy01Edt4AOIQg
         gzmlg1yHXBL8Bx4B0DIB+15ntMB++YJG8POy/GtxjINc+izmxgwi5I9O65BCbUoN7exJ
         OXw78PHWPrCCEhSiuv1Mw+VGwQy/v9s+gkrXk0+H4Xs10KehbUon0dTFSRHGTeHx9Bfm
         5fGw==
Received: by 10.60.28.6 with SMTP id x6mr5698934oeg.61.1349386742415; Thu, 04
 Oct 2012 14:39:02 -0700 (PDT)
Received: by 10.182.86.164 with HTTP; Thu, 4 Oct 2012 14:39:02 -0700 (PDT)
In-Reply-To: <CAGAhT3k=T0SGngMQkbXHqNfh-=LUb71C7CSrWXP2wsAgc8Tb8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207014>

> rebase -i fails with different error:
Also in case of rebase -i the branch pointer is not changed. Thus
nothing to fix there.

-- Alexander

On Thu, Oct 4, 2012 at 2:09 PM, Alexander Kostikov
<alex.kostikov@gmail.com> wrote:
>> Having the
>> last page of that output should give us enough context as to where i=
t's
>> failing.
> Full script is uploaded to
> https://dl.dropbox.com/u/10828740/rebase.log Here is the last page:
>
> -----------------------------------[code]
> if test -s "$dotest"/rewritten; then
>     git notes copy --for-rewrite=3Drebase < "$dotest"/rewritten
>     if test -x "$GIT_DIR"/hooks/post-rewrite; then
>         "$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
>     fi
> fi
>
> rm -fr "$dotest"
> git gc --auto
> git rev-parse HEAD
>
> ret=3D$?
> test 0 !=3D $ret -a -d "$state_dir" && write_basic_state
> exit $ret
> -----------------------------------[/code]
>
>
>> It'd also be interesting to see if "rebase -i" will also workaround =
the
>> issue.
>
> rebase -i fails with different error:
>
> =BB git rebase -i master rebase_debug
> fatal: Out of memory, malloc failed (tried to allocate 458753 bytes)
>
> Do you need verbose log for it as well?
>
> -- Alexander
>
>
> On Thu, Oct 4, 2012 at 8:13 AM, Andrew Wong <andrew.kw.w.lists@gmail.=
com> wrote:
>> On 10/03/2012 06:35 PM, Alexander Kostikov wrote:
>>>>
>>>> That allows you can go back to the pre-rebase state by
>>>> "rebase --abort".
>>>
>>> rebase --abort command were not available. I guess rebase file was =
not
>>> created.
>>
>> I meant "rebase --abort" would be available *if* the error was caugh=
t by
>> "rebase". But in your case, "rebase" is probably dying somewhere and=
 the
>> error was not caught, causing "rebase" to think that everything comp=
leted
>> successfully, and go ahead to update the branch.
>>
>>
>>> Is there a way to include some log verbose mode to detect where
>>> exactly error happens?
>>
>> There isn't any built-in to git itself. But one way to get more info=
 is
>> running the rebase command this way:
>>     env SHELLOPTS=3D"verbose" git rebase <your arguments>
>>
>> That should print out every shell command that rebase executes. Havi=
ng the
>> last page of that output should give us enough context as to where i=
t's
>> failing.
>>
>> Just a wild guess: rebase is probably failing at the "format-patch" =
command.
>> It'd also be interesting to see if "rebase -i" will also workaround =
the
>> issue. But like you said, there's no way set "-i" or "-m" as the def=
ault.
>
>
>
> --
> Alexander Kostikov



--=20
Alexander Kostikov
