From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR"
Date: Tue, 22 Dec 2015 13:50:12 -0800
Message-ID: <xmqqk2o6cfvv.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
	<1450693372-6863-1-git-send-email-pclouds@gmail.com>
	<xmqqegefhftq.fsf@gitster.mtv.corp.google.com>
	<xmqqtwnbfybj.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DP7ugh1UAU=iGzzHTSwUm5ZPkQhS0fTvkOpQV6vP1Jxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 22:50:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBUp5-0005d6-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 22:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933853AbbLVVuR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Dec 2015 16:50:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933305AbbLVVuP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 16:50:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 66EFB36D04;
	Tue, 22 Dec 2015 16:50:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Lou/2eiG3nPW
	/8DWHGDbHhRT24I=; b=ejIAb/OdrKnlmLbV+NCADs+25obaicpsKue2fkQZna5j
	MdzD6xtIPO93ATq5Pya6cSZQh8zLeLsMc5hw3ksgZt31Tzo/0DVURGORsZPBdUUV
	NWtBrVr2qO7TvXlOLhfS8bM+biamxQV4n0jfpDHKpieiIIWLISGh/pKJF+2xxhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hU6w3t
	jN1wA20StznXM0G5BBnwb/reZbj38ZJuaXVW6fbWuJCUkh5cv+rY19z5zzwiRTDy
	qbOkj1UMqL+rFHo/e0XaGh645x7pN8YP4OkHiJP0aq/Rr6gT4f8Wjatli6szuG2E
	z+Xde4cN3iaTebsgL/pvcCX/B+Du4uUzb/COM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D7B536D03;
	Tue, 22 Dec 2015 16:50:14 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BF38836D01;
	Tue, 22 Dec 2015 16:50:13 -0500 (EST)
In-Reply-To: <CACsJy8DP7ugh1UAU=iGzzHTSwUm5ZPkQhS0fTvkOpQV6vP1Jxg@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 22 Dec 2015 08:06:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB1AC288-A8F5-11E5-8A08-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282911>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Dec 22, 2015 at 1:31 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writ=
es:
>>>
>>>> This commit has caused three regression reports so far. All of the=
m are
>>>> about spawning git subprocesses, where the new presence of GIT_WOR=
K_TREE
>>>> either changes command behaviour (git-init or git-clone), or how
>>>> repo/worktree is detected (from aliases), with or without $GIT_DIR=
=2E
>>>> The original bug will be re-fixed another way.
>>>>
>>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
>>>> ---
>>>>  On Thu, Dec 3, 2015 at 12:09 AM, Junio C Hamano <gitster@pobox.co=
m> wrote:
>>>>  > OK, when/if you decide that our first step should be a revert o=
f
>>>>  > d95138e please send in a patch to do so with a brief write-up o=
f a
>>>>  > follow-up plan.
>>>>
>>>>  Three reports to me are enough. And I obviously could not push th=
e
>>>>  fix out fast enough. So if you want to revert it, here's the patc=
h on
>>>>  maint.
>>
>> Also, can you reference these three reports for future reference?
>
> http://article.gmane.org/gmane.comp.version-control.git/281608
> http://article.gmane.org/gmane.comp.version-control.git/281979
> http://article.gmane.org/gmane.comp.version-control.git/282691
>
> The last one is not confirmed by the reporter yet. But I'm pretty sur=
e
> i'll trigger the special case "when GIT_WORK_TREE is set but GIT_DIR
> is not" in setup code

Thanks, I'll leave these breadcrumbs in the log message for future
reference.

I think the last sentence of the original commit is telling how this
bug came about.  "It does not harm if $GIT_WORK_TREE is set while
$GIT_DIR is not." forgets to consider the possibility that scripts
may be relying on the "Go to the top of the working tree and setting
GIT_DIR would give you a reasonable environment".  That is true if
GIT_WORK_TREE is not set, and these scripts weren't getting the
environment exported [*1*].  These scripts now have to unset
GIT_WORK_TREE themselves (or set it to their $cwd if they are indeed
at the top), just in case the process that calls them exports it
X-<.

Thanks.


[Footnote]

*1* If the end user has GIT_WORK_TREE in the environment, even if
    Git stops exporting it by reverting d95138e, such a script may
    break.  So in that sense, d95138e did not quite change the rule
    of the game for these scripts, but made it more obvious when
    these scripts were written sloppily.
