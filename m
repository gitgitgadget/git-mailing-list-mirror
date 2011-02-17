From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] Teach commit about CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 19:05:59 -0500
Message-ID: <AANLkTinUec=HJVpGL_3v=4tvkGiMiNT1QLzWsChF411Z@mail.gmail.com>
References: <1297850903-65038-1-git-send-email-jaysoffian@gmail.com>
 <1297850903-65038-3-git-send-email-jaysoffian@gmail.com> <20110216224349.GE2615@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 01:06:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PprOG-0003Uw-GG
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 01:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612Ab1BQAGb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 19:06:31 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55164 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432Ab1BQAGa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 19:06:30 -0500
Received: by iwn9 with SMTP id 9so1903436iwn.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 16:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=lZqyM6SyUbebjTcHk3om/41BYAyh/LQPfPJ6GmQnx0s=;
        b=P4QMeO6QBA3Mzpf2oXIgzY0utlnVz2em2Hj4Ri+B/gbGDl8/4EL/fhSwBQAAjMhCbL
         NqzJHapL4c1GU8ZD3eKjiFNinOPJhQwJvHFiRFsNTb8+FrXsCfjS+BefN4MZYVyHYwmJ
         SgirZ+KDvGlRTSBsSqsLaK3kGkpziXG0/9cOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kxx5UUflBjY69hGDOyJU4rAgeuctfSru7qdn0ie0HTkIDEHdzIce1OHwZ2Z5FIC8zc
         hCUUfil3219ZWBhazsuU9S0oAMGR5SdMxmsPrQRayb41gWi5EuhOIpawantZMUukQk6v
         wDLPPcT6RcHfx50apx/8yiTURSrHNvWE2RPmg=
Received: by 10.231.38.2 with SMTP id z2mr1014413ibd.142.1297901190349; Wed,
 16 Feb 2011 16:06:30 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 16 Feb 2011 16:05:59 -0800 (PST)
In-Reply-To: <20110216224349.GE2615@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167023>

On Wed, Feb 16, 2011 at 5:43 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Might also be worth mentioning that it makes --amend fail in such a
> situation (a change worth celebrating).

Never made that particular mistake myself, but okay.

>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -56,8 +56,10 @@ static const char empty_amend_advice[] =3D
>>
>> =C2=A0static unsigned char head_sha1[20];
>>
>> -static char *use_message_buffer;
>> +static const char *use_message_buffer;
>> =C2=A0static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
>> +static const char cherry_pick_head[] =3D "CHERRY_PICK_HEAD";
>> +static const char merge_head[] =3D "MERGE_HEAD";
>
> Hmm, these variables but not MERGE_MSG, MERGE_MODE, and SQUASH_MSG?

I cleaned up the ones my patch touched. Cleaning up the rest of
commit.c was out of my purview. :-)

I'll clean them up to be consistent, but I'll do it as a separate
patch (before this one).

>> @@ -68,6 +70,7 @@ static enum {
>>
>> =C2=A0static const char *logfile, *force_author;
>> =C2=A0static const char *template_file;
>> +static const char *author_message, *author_message_buffer;
>
> That's not a message at all, is it? =C2=A0On first reading I thought =
it
> would be a message about the author. =C2=A0Maybe a comment can help.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* name and content of commit from which t=
o copy authorship */

The name is consistent with the other similar purpose variables:
use_message, edit_message, squash_message, fixup_message, which all
take a committish and aren't actually messages. None of those others
have comments, but it's obvious in context how they are used.

>> @@ -88,7 +91,8 @@ static enum {
>> =C2=A0} cleanup_mode;
>> =C2=A0static char *cleanup_arg;
>>
>> -static int use_editor =3D 1, initial_commit, in_merge, include_stat=
us =3D 1;
>> +static enum commit_whence whence;
>> +static int use_editor =3D 1, initial_commit, include_status =3D 1;
>
> The name "whence" is not so self-explanatory but I don't have any
> better ideas (I probably would have written "merge_or_cherry_pick"; w=
e
> can be glad you came up with something better).

Respectfully disagree. Whence means "from where something came" as in
"from where did this commit we're about to make originate?" and I
intentionally didn't use _ORIGIN as "origin" has another meaning
already in git context.

>> @@ -163,6 +167,36 @@ static struct option builtin_commit_options[] =3D=
 {
>> =C2=A0 =C2=A0 =C2=A0 OPT_END()
>> =C2=A0};
>>
>> +static void determine_whence(struct wt_status *s)
>> +{
>> + =C2=A0 =C2=A0 if (file_exists(git_path(merge_head)))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 whence =3D FROM_MERGE;
>
> Micronit: maybe COMMITTING_A_MERGE or COMMIT_DURING_MERGE to avoid
> using valuable namespace?

Respectfully disagree.

> Perhaps:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (whence =3D=3D CHERRY_PICK) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hook_arg1 =3D =
"commit";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hook_arg2 =3D =
author_message;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

Perhaps.

> Ok. =C2=A0We probably should move away from having to suggest
> "rm -f .git/whatever" in the future (maybe
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git update-ref -d %s
>
> is simpler advice? =C2=A0I dunno).

Out of scope for this patch. :-)

> Nice. =C2=A0Opening '{' should be in the first column.

Good catch.

> Isn't the advice of using "git reset -- <paths>" still good in the
> CHERRY_PICK case?

I don't know. I couldn't make up my mind. If it's a conflicted path
you've edited in the working copy, then the advice should be "checkout
--merge". I think. Maybe. I don't find wt-status.c to be very much
fun, so I punted.

>> - =C2=A0 =C2=A0 if (s->in_merge)
>> + =C2=A0 =C2=A0 if (s->whence !=3D FROM_COMMIT)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ; /* NEEDSWORK: use=
 "git reset --unresolve"??? */
>
> Likewise here.

Checkout that NEEDSWORK. Someone should get on that. :-)

> Style: please use tabs to indent.

Who ate my tabs?

> Might benefit from a comment.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* whether a merge or cherry-pick is in pr=
ogress */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum commit_whence whence;

Agreed.

> Thanks, very readable.

Good feedback.

j.
