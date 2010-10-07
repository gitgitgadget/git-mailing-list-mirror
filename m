From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] worktree: provide better prefix to go back to
 original cwd
Date: Thu, 7 Oct 2010 22:11:58 +0700
Message-ID: <AANLkTikoDMX17U77Y1+=Lq94AUAZ3mTEX7MG9aRjaEh6@mail.gmail.com>
References: <4cad50da.0e958e0a.40e3.5efd@mx.google.com> <7veic2y2c5.fsf@alter.siamese.dyndns.org>
 <AANLkTim8R2ZxJ1_KnxxRwTjf2mz=NtgQ9MyV_7iAqEpG@mail.gmail.com> <7vvd5evyo6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, judge.packham@gmail.co, Jens.Lehmann@web.de,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 17:12:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3s8z-0005Yj-4C
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 17:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760692Ab0JGPMV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 11:12:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44887 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758023Ab0JGPMU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 11:12:20 -0400
Received: by wyb28 with SMTP id 28so163232wyb.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3b9km9oOiPHI6A0BjVGaPR0xs0KY4Sblr31MOqJsg9U=;
        b=QiYjOMkVR0Q70b66YTMVhuFIESQhgR4LD0tOnZ4sD3DRiYK2eCNKH5CT21IH/FO9cM
         UDbgr8suGS4/CuR6UMfpOktDxusBDzKYgb/glfZjZPj040eT4XoDwUWXSJtrH6Q6gpsN
         OFIaWtL3Nvzo8b4pkdmt3fyTEEoDxSc1sbGaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZjbOAD69PXc6cuQJMb6oCxixyeWQMk9b/yLWnSyQ9xaGeX89hCj4+TWxwY0jcUbzjW
         MPI/3lmMiyGuLrDJwz51SpdkFNbo8/ANMCmDbb2z9ZGxA7TDD0FnhlrzEte7a4m9lGAm
         OV2gsFlHnY7L3PlOfgrLAzPYt0VZfNIHoPq5M=
Received: by 10.216.188.81 with SMTP id z59mr871671wem.106.1286464338582; Thu,
 07 Oct 2010 08:12:18 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Thu, 7 Oct 2010 08:11:58 -0700 (PDT)
In-Reply-To: <7vvd5evyo6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158407>

On Thu, Oct 7, 2010 at 9:56 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Thu, Oct 7, 2010 at 12:54 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> pclouds@gmail.com writes:
>>> ...
>>> If the original cwd is inside GIT_WORK_TREE, limiting ourselves ins=
ide
>>> prefix naturally limits the operation to the subdirectory we starte=
d from
>>> (if the original cwd is at GIT_WORK_TREE, that would make it a whol=
e-tree
>>> operation). =C2=A0A natural extension of this idea to limit the ope=
ration to
>>> the part of the subtree of the working tree we started from is to r=
efuse
>>> to work in the case where the original cwd is outside GIT_WORK_TREE=
 (the
>>> current implementation of GIT_WORK_TREE may or may not correctly im=
plement
>>> it, though---I never use it myself).
>>
>> I tend to think that as we go up to worktree's root, prefix is short=
en
>> and the operation area is widen. When cwd is at worktree's, we opera=
te
>> on full worktree. If it goes up one level higher, the operation area
>> remains full worktree (but not everything under cwd because cwd now
>> can have non-worktree directories).
>
> I have a feeling that you did not understand my /srv/git/git.git (no,=
 it
> is not a bare repository) vs /var/tmp example.
>
> I think it makes the new semantics much less yucky if the special cas=
e is
> limited to "the working tree is a subdirectory somewhere under cwd". =
=C2=A0But
> does your patch check and notice that /var/tmp is not above the worki=
ng
> tree and they are completely unrelated?
>

OK I see it now. I think my patch deals with completely unrelated
worktree/cwd just fine (both cwd-to-worktree and worktree-to-cwd
contain a few "../").

There is however a case where "git status" on separate cwd/worktree
might make sense. Suppose a master repo a/.git has two submodules
a/b/.git and a/c/.git. If user stands in a/c and want to do git-status
on all repos (let's skip how it finds out a/.git is the master repo),
it would make sense to display paths, including ones from a/b/.git,
relative to a/c (which is cwd and completely unrelated to a/b/.git).
--=20
Duy
