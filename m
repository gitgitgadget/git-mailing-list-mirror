From: Ruben Laguna <ruben.laguna@gmail.com>
Subject: Re: why is my repo size ten times bigger than what I expected?
Date: Sat, 5 Mar 2011 12:41:22 +0100
Message-ID: <AANLkTinwHMULqPZSguYtJztuA4Oy6-s6Ah3_tcVVO7D9@mail.gmail.com>
References: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com>
	<AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
	<AANLkTimp8B5Lv15qhGOwOzh+kqOS0g3Xwvgib8vyk+m+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 12:41:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvprV-0005Ux-OU
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 12:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab1CELlY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2011 06:41:24 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52295 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab1CELlY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2011 06:41:24 -0500
Received: by pvg12 with SMTP id 12so465412pvg.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 03:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2ga1GW/Q0oRfNYQSfPXSVaW2czX8HfF4dQoKK+NPAfY=;
        b=DVRgCRMcaD0O0/iHtdQg4ri/GLXP3wY4OkdZ9/0p/WpcxiIutV0FOwoToEgrn5l+Wc
         jFNErckk3WEuBMVQW9yducNfzde1pw8Zy0VjDYcp0lgXBpinITUjABW1EnMY7mrPrcRn
         sdd3vZFsOJ9vCEUyqNKthgFBHUF2LC/WoehR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BUHwN9GbhaB1/gar9QcfGZdJ7zeCnAJHXoIfBrvbhbVuXvdtg8cJoT4tv2YhMdwD0O
         J83rm8Xdw29E173Xl8BWhL/8ogQI7x32FV1ZwD4ooPV7cr5ROBnqRX39gCQYYN1dkzV4
         vnU9gsR0x6AJVmeXgxYV5x4NkDa0XDC98yRjA=
Received: by 10.143.21.27 with SMTP id y27mr1430656wfi.115.1299325282347; Sat,
 05 Mar 2011 03:41:22 -0800 (PST)
Received: by 10.143.162.21 with HTTP; Sat, 5 Mar 2011 03:41:22 -0800 (PST)
In-Reply-To: <AANLkTimp8B5Lv15qhGOwOzh+kqOS0g3Xwvgib8vyk+m+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168489>

well, the git-remove-history script does

rm -rf .git/refs/original/
git reflog expire --expire=3Dnow --all
git fsck --unreachable
git gc --prune=3Dnow
git gc --aggressive --prune=3Dnow


after filter-branch so I don't think it's that.

also cloning the repo doesn't change a thing

$ git clone en4j en4j_xx
Cloning into en4j_xx...
done.
$ cd en4j_xx
$ du -sh .git
 87M    .git

any other idea?

On Sat, Mar 5, 2011 at 11:49 AM, Jonathan del Strother
<maillist@steelskies.com> wrote:
> On 5 March 2011 10:05, Ruben Laguna <ruben.laguna@gmail.com> wrote:
>> Hi,
>>
>> I had a repo which was big 143MB because it contained a bunch of jar
>> files. So I decided to remove those completely from the history.
>>
>> In short I used the git-large-blob [1] to find all the jars and used
>> the git-remove-history script [2] which does the filter-branch thing=
,
>> prune, etc.
>>
>> I did this on all branches (that I know of) and now I can see that t=
he
>> jars are gone because I can't find them with git-large-blob. =C2=A0a=
nd the
>> repo size has dropped from 143Mb to 87Mb.
>>
>> My concern is that 87Mb is still really big taking into account he
>> size of the project. =C2=A0in fact if I run "git diff-tree -r -p $co=
mmit
>> |wc -c" for each commit and sum all I get 5.5Mb.
>>
>>
>> I also ran the git-rev-size [3] script that I found in this mailing
>> list and I only see that the size grows steadly from commit to commi=
t
>> up to 1482731 bytes. So again how come the .git directory is 87MB?
>>
>>
>> So, Can anybody tell me if this repository size is "normal" for a
>> project with 1.4MB source and 352 commits?
>> Is there a better way to calculate the size (in bytes) of each commi=
t?
>>
>> Is there any other thing I could do to reduce and audit =C2=A0the re=
pository size?
>>
>>
>> Thanks in advance!
>> Rub=C3=A9n
>>
>> ---
>> [1]=C2=A0http://stackoverflow.com/questions/298314/find-files-in-git=
-repo-over-x-megabytes-that-dont-exist-in-head
>> [2]=C2=A0http://dound.com/2009/04/git-forever-remove-files-or-folder=
s-from-history/
>> [3] http://markmail.org/message/762zzg5zckbiq2i7
>
> What happens if you clone that repo?
> git-gc will only pruned unused objects that're older than 2 weeks by
> default, so it's possible that your repo size will suddenly shrink in
> 2 weeks time (or sooner, if you run git-gc with the appropriate
> options)
>



--=20
/Rub=C3=A9n
