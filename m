From: Christopher Dunn <cdunn2001@gmail.com>
Subject: Re: format-patch and submodules
Date: Wed, 10 Jun 2015 17:41:51 -0500
Message-ID: <CAD2z=MD3+63jL3Qqm-sj-7VnSB8ayhK_NjZV-qf+nyfuPdUk3Q@mail.gmail.com>
References: <CAD2z=MAu1qrr9=wwBnOJZZ3JCJOsmFWi=gDgKMQKU3_P-01e3g@mail.gmail.com>
	<557735E6.8040906@web.de>
	<CAD2z=MBSAzENvj1-WUMzrXznvudjCc3vyvYQQ+wMnPC3G3Go2Q@mail.gmail.com>
	<5578A8AC.2090704@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 00:42:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2oh7-00045P-LH
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 00:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbbFJWly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 18:41:54 -0400
Received: from mail-vn0-f44.google.com ([209.85.216.44]:37341 "EHLO
	mail-vn0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbbFJWlw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 18:41:52 -0400
Received: by vnbg62 with SMTP id g62so10423037vnb.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 15:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ov977JzzmncuEzQlmSHuyAB9J1MoDu4JTes3MmoxPKg=;
        b=fzg5f9yf+cv4AG2dyx0Sx63Q+/qt5WfxVpBB50/LqdNJjEive8bJ3g899wrDk3ah81
         G9AOTXFs8old7kngHTp7UtfQIOONjY8RJyKrSFSQ8baHjJJrRJ9YhQVFk2JkaXAw5yJ7
         +BjeOitHcF0t7ZjPQUqOQH9nAMbJKbGAmIPpLKAsreO/5hlvwsztLty0ovKa1ion/0Ti
         SK7brrFETpPYICTIde/rfnQuCi9gpr0QIRJIn9L9sQIbYsKIVAOHgRIq13jfXuq47Cnv
         kvSk6EOjQdNE4XZVFs2sKsAJw04quavlsXf7KMMs2AJI0aVeeeoB1ZWR69Tz/URTa+iF
         Vvxg==
X-Received: by 10.52.169.136 with SMTP id ae8mr10703403vdc.2.1433976111155;
 Wed, 10 Jun 2015 15:41:51 -0700 (PDT)
Received: by 10.52.98.134 with HTTP; Wed, 10 Jun 2015 15:41:51 -0700 (PDT)
In-Reply-To: <5578A8AC.2090704@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271363>

Well, now it gets more complicated. I want git-p4 to ignore submodules
completely. But it fails only *only* the submodules changed. (At
least, my version fails. I'll try to diff against latest.)

But to debug this, I had to add a dry-run mode to git-p4. And I am
using a version of git-p4 which uses 'git-notes' rather than
re-writing history. If you want, you can try my version:

  https://github.com/pb-cdunn/git-p4

On Wed, Jun 10, 2015 at 4:14 PM, Luke Diamand <luke@diamand.org> wrote:
> On 10/06/15 18:04, Christopher Dunn wrote:
>>
>> Sorry. I thought empty patches were made to work in other cases.
>>
>> 'git-p4' needs to skip these. Wrong mailing list then.
>
>
> Possibly the right mailing list - can you explain what you mean here w.r.t
> git-p4 please?
>
> Thanks!
> Luke
>
>
>
>
>>
>> On Tue, Jun 9, 2015 at 1:52 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>
>>> Am 05.06.2015 um 01:20 schrieb Christopher Dunn:
>>>>
>>>>
>>>> (Seen in git versions: 2.1.0 and 1.9.3 et al.)
>>>>
>>>> $ git format-patch --stdout X^..X | git apply check -
>>>> fatal: unrecognized input
>>>>
>>>> This fails when the commit consists of nothing but a submodule change
>>>> (as in 'git add submodule foo'), but it passes when a file change is
>>>> added to the same commit.
>>>>
>>>> There used to be a similar problem for empty commits, but that was
>>>> fixed around git-1.8:
>>>>
>>>>
>>>>
>>>> http://stackoverflow.com/questions/20775132/cannot-apply-git-patch-replacing-a-file-with-a-link
>>>>
>>>> Now, 'git format-patch' outputs nothing for an empty commit. I suppose
>>>> that needs to be the behavior also when only submodules are changed,
>>>> since in that case there is no 'diff' section from 'format-patch'.
>>>>
>>>> Use-case: git-p4
>>>>
>>>> Of course, we do not plan to add the submodule into Perforce, but we
>>>> would like this particular command to behave the same whether there
>>>> are other diffs or not.
>>>
>>>
>>>
>>> Hmm, I'm not sure that this is a bug. It looks to me like doing a
>>>
>>> $ git format-patch --stdout X^..X | git apply check -
>>>
>>> when nothing is changed except submodules and expecting it to work
>>> is the cause of the problem.
>>>
>>> I get the same error when I do:
>>>
>>> $git format-patch --stdout master..master | git apply --check -
>>> fatal: unrecognized input
>>>
>>> No submodules involved, just an empty patch.
>>>
>>> I assume you want to ignore all submodule changes, so you should
>>> check if e.g. "git diff --ignore-submodules X^..X" returns anything
>>> before applying that? (From the command you ran I assume you might
>>> be able to drop the --ignore-submodules because you already did set
>>> "diff.ignoreSubmodules" to "all"?)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
