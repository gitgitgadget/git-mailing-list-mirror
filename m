From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3 1/4] Introduce CHERRY_PICK_HEAD
Date: Sat, 19 Feb 2011 21:29:28 -0500
Message-ID: <AANLkTik7cfihdu5-0pvgkq1u7kVShEqnjzh07T+5pU16@mail.gmail.com>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
 <1297916325-89688-2-git-send-email-jaysoffian@gmail.com> <7vipwibfc5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 03:30:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqz3j-0004GP-Nq
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 03:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab1BTC37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 21:29:59 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61766 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1BTC36 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 21:29:58 -0500
Received: by iyj8 with SMTP id 8so4807553iyj.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 18:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=TIrjZTab26Y7/mOA4VmsjFnp5ENGGGKaqxjZpj0fMm0=;
        b=esY2LIyTRA7NKPUvITWaFDNAXEmLO3x6dMBlVT7+xLCtAFlr8BM3MHFyUNj6TUEVW9
         8XcU8r5HAq+5ZSH/Y49DlSbEA9YmifCCns6pne2JJJCpxdEvAlhGdXNCHju4dMhggEtf
         1KaGtz6PerFTfePH3gBCNqaRvRSieKG0oi1pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CV6Bpd+5rZPGBsBlszE90qAH6uGcmegPVTYeUCVeXtyiDXILuIVkkxT72E9yP1Mtdm
         S1dgft+xf5C9Mc2Ma2lrVUTmex6Vi3CsPiYmmfcniLeWZ5cV6g5AqhVY7sma2MxF0yup
         CJQKMIfSIkpqTD2VtjIKfXIySPP5wq55gmZjY=
Received: by 10.42.226.69 with SMTP id iv5mr3120146icb.43.1298168998103; Sat,
 19 Feb 2011 18:29:58 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Sat, 19 Feb 2011 18:29:28 -0800 (PST)
In-Reply-To: <7vipwibfc5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167393>

On Thu, Feb 17, 2011 at 3:01 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index 9403747..454dad2 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -971,6 +971,13 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("You have not concluded your merge (MERGE_HEAD exists).");
>> =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (advice_resolve_confl=
ict)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exis=
ts).\n"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "Please, commit your changes before you can merge.");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exis=
ts).");
>> + =C2=A0 =C2=A0 }
>
> Micronit: "Please, commit your changes before you can merge."
>
> =C2=A0- We are not merging in this codepath to begin with;
>
> =C2=A0- I'd suggest rephrasing this (together with "MERGE_HEAD" codep=
ath) to
> =C2=A0 something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"Commit your changes first before retrying=
=2E"

This hunk is from Jonathan, so I'd like him to address your comment as
well, but I think the current message is correct. This hunk is inside
cmd_merge and the user is about to start a merge. IOW:

$ git cherry-pick   # fails, leave behinds CHERRY_PICK_HEAD
 [... time passes ...]
$ git merge
You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).
Please, commit your changes before you can merge.

> Getting tired of seeing these five lines repeated over and over. =C2=A0=
Perhaps
> it is time to introduce:

Okay. (Will roll in from Jonathan's later email.)

>> + =C2=A0 =C2=A0 git cherry-pick --no-commit base &&
>> +
>> + =C2=A0 =C2=A0 test_cmp_rev base CHERRY_PICK_HEAD
>
> If the next "git commit" would notice and use this information, that =
would
> introduce an unpleasant regression to one use case in my workflow, wh=
ich
> is to pick and consolidate one or more small pieces made on a private
> "misc" branch, possibly with a bit of further work, into a new commit=
 with
> a readable explanation that is unrelated to any of the original commi=
ts:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick --no-commit $some_commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick --no-commit $another_commi=
t ;# optional
> =C2=A0 =C2=A0 =C2=A0 =C2=A0edit ;# optional
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit
>
> I'd prefer to see a way to tell cherry-pick not to leave CHERRY_PICK_=
HEAD
> behind when "cherry-pick --no-commit" results in a successful cherry-=
pick
> to avoid a backward incompatibility surprise. =C2=A0Otherwise people =
need to
> retrain their fingers to say --reset-author when they run "git commit=
".

Okay. In that case, I think when using --no-commit, we shouldn't write
CHERRY_PICK_HEAD regardless of whether there is a conflict or not.

j.
