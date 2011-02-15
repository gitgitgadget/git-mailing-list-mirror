From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH 2/2] Teach commit to handle CHERRY_HEAD automatically
Date: Tue, 15 Feb 2011 18:21:54 -0500
Message-ID: <AANLkTinZ0ewJy01rV66xMMCKLon=7qz=hoJ3DbtXmtXL@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-3-git-send-email-jaysoffian@gmail.com> <20110215230015.GA17812@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 00:22:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUE3-0007tV-Sm
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756477Ab1BOXW1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 18:22:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63496 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106Ab1BOXWZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 18:22:25 -0500
Received: by iyj8 with SMTP id 8so608130iyj.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=mYcaxgZtOsnfdKcx21HRcSvFJsQ2OjFmw6tiCKWewNo=;
        b=xfGU18rfUW4iquJR1sivJz55GuQyb9RTP8Ie493WYRMmJndk72tjcXsgRaTqg3lYPu
         Ovl/gPEwowR1v7yK4CfWRRBRDend7dWzW/HV8jn2WWJW1syWbusutZzrlnUjRIA+fWPv
         i7vmAQoeoso82t+j+eL1FzEuvGpcUyH8fv5Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=upPuiF4Eyg6Njl2jdT/urlukTFOitm+/LsiTTo9KwL4KFPH2nbJjfwR/svQIuCqsH2
         u42dYrFCIWZyoAPSsPgVlCBYFpQBjTkNILqzjf48sLPMr9MABH5D8xLBrfy1Tw3lwywj
         zhAEAhP4l61A32secbkLVlbZ2qMkZWKQgoJ7M=
Received: by 10.231.36.69 with SMTP id s5mr4341741ibd.167.1297812145053; Tue,
 15 Feb 2011 15:22:25 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 15 Feb 2011 15:21:54 -0800 (PST)
In-Reply-To: <20110215230015.GA17812@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166899>

On Tue, Feb 15, 2011 at 6:00 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> =C2=A0- "git commit --amend" to say "I'm done fixing the broken thing=
".
>
> =C2=A0- "git commit --fixup=3DHEAD/--squash=3DHEAD" to say "done fixi=
ng;
> =C2=A0 let's look at this again later and squash it when I am less
> =C2=A0 confused".
>
> Both are mistakes if HEAD is the previous and good commit rather than
> the broken one. =C2=A0Maybe there is some simple safety that could pr=
otect
> against them?

As you see below, this is already protected against.

>> =C2=A0--reset-author::
>> - =C2=A0 =C2=A0 When used with -C/-c/--amend options, declare that t=
he
>> - =C2=A0 =C2=A0 authorship of the resulting commit now belongs of th=
e committer.
>> - =C2=A0 =C2=A0 This also renews the author timestamp.
>> + =C2=A0 =C2=A0 When used with -C/-c/--amend options, or when commit=
ting after a
>> + =C2=A0 =C2=A0 a conflicting cherry-pick,
>
> or when committing after a conflicted merge, no?

No. The person committing a merge is already the author of the merge,
why would they use --reset-author?

>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0declare that the autho=
rship of the
>> + =C2=A0 =C2=A0 resulting commit now belongs of the committer. This =
also renews
>> + =C2=A0 =C2=A0 the author timestamp.
>
> How does it interact with --author?

No change from before, --author forces the author of the new commit.

>> +++ b/builtin/commit.c
> [...]
>> @@ -609,7 +609,7 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die_errno("could not read log file '%s'",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logfile);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hook_arg1 =3D "mess=
age";
>> - =C2=A0 =C2=A0 } else if (use_message) {
>> + =C2=A0 =C2=A0 } else if (use_message && !cherry_pick) {
>
> Wouldn't this make
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -C foo
>
> after a failed cherry-pick use MERGE_MSG instead of the message the
> user requested?

No, because the -C will force the cherry_pick flag to 0 in
parse_and_validate_options:

		/* Let message-specifying options override CHERRY_HEAD */

I'll make this logic clearer though as I need to address Junio's
earlier message.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cherry_pick)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 fprintf(fp,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#\n"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "# It looks like you may be committing =
a cherry-pick.\n"
>
> Aside: shouldn't we suggest some porcelain-ish command (git merge
> --clear? =C2=A0git commit --no-merge?) to remove .git/MERGE_HEAD inst=
ead of
> asking the committer to do it?

We have git merge --reset as an alias for reset --merge. Since reset
--merge takes care of this case too (I think, I'll check) we can
suggest that for both.

> This section is used to give a preview and sanity check for the
> commit.
>
> =C2=A0- if we are on the wrong branch, that might be a mistake.
> =C2=A0- if the author is someone else, that might be a mistake.
> =C2=A0- if there are multiple parents, that might be a mistake.
> =C2=A0- if there are changes included, some might be mistakes.
> =C2=A0- if there are changes excluded, some might be mistakes,
> =C2=A0- if there are untracked files, some might be mistakes.
>
> Where does committing a cherry-pick fall into that picture? =C2=A0May=
be
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Author: =C2=A0 =C2=A0A U Thor <author@ex=
ample.com>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Date: =C2=A0 =C2=A0 =C2=A0Tue Beb 9 01:2=
3:45 1911 -0500
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# If this is not correct, please try again=
 using the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# --author and --date or --reset-author op=
tions.

Okay.

>> @@ -898,6 +907,7 @@ static void handle_untracked_files_arg(struct wt=
_status *s)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Invalid untrac=
ked files mode '%s'", untracked_files_arg);
>> =C2=A0}
>>
>> +
>
> Stray whitespace change?

Indeed.

> How can I get out of this state if I really do want to amend?

git reset, same as it ever was?

>> @@ -943,11 +955,19 @@ static int parse_and_validate_options(int argc=
, const char *argv[],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Only one of -c=
/-C/-F/--fixup can be used.");
>> =C2=A0 =C2=A0 =C2=A0 if (message.len && f > 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Option -m cann=
ot be combined with -c/-C/-F/--fixup.");
>> + =C2=A0 =C2=A0 if (cherry_pick) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Let message-specifyin=
g options override CHERRY_HEAD */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (f > 0 || message.len=
)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cherry_pick =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* used for authorship side-effect only */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 use_message =3D "CHERRY_HEAD";
>> + =C2=A0 =C2=A0 }
>
> Hmm, what if I have commits F and F' and after trying to cherry-pick =
=46
> I decide I want the message from F'?

I don't think I understand. commit -c F', or just commit (w/o options)
and you get MERGE_MSG generated by cherry-pick.

>> @@ -1118,6 +1138,7 @@ int cmd_status(int argc, const char **argv, co=
nst char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 gitmodules_config();
>> =C2=A0 =C2=A0 =C2=A0 git_config(git_status_config, &s);
>> =C2=A0 =C2=A0 =C2=A0 in_merge =3D file_exists(git_path("MERGE_HEAD")=
);
>> + =C2=A0 =C2=A0 cherry_pick =3D file_exists(git_path("CHERRY_HEAD"))=
;
>
> Is it possible to be both in_merge and cherry_pick?

No, I need to rework this into an enum, maybe enum { CONFLICT_NONE,
CONFLICT_MERGE, CONFLICT_CHERRY_PICK } conflict_type.

>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 reflog_msg =3D "commit";
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 reflog_msg =3D cherry_pick ? "commit (cherry-pick)"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0: "commit";
>
> Nice. =C2=A0Probably worth mentioning in the commit message.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 elif [ -f "$g/CHERRY_HEAD" ]; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=3D"|CHERRY-PICKING"
>
> Likewise.

Right.

Thanks for the feedback!

j.
