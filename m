From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] fast-export: output reset command for commandline revs
Date: Sun, 6 Nov 2011 20:48:02 +0100
Message-ID: <CAGdFq_gkSxvw9Di_mUqS5N0bgCWh-dygMe_DWcR+ENAo=A-3=A@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-4-git-send-email-srabbelier@gmail.com> <20111106050126.GO27272@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 20:48:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN8i0-0005tH-O1
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 20:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab1KFTso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 14:48:44 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57785 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab1KFTsn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 14:48:43 -0500
Received: by ywf7 with SMTP id 7so4484625ywf.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 11:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xHXRRzTid9elgauXkwS74wBwRR6K11vgkwJFUOzA5MI=;
        b=qasf4Z1C1ilH5aFVimcjx0XAs4JXqS6aq2yMvvvRzrjgq0tazj0056Ujh87VVQPRTb
         89jU4LawiQwDcJlDmcwa5r2BaoKBCD9GdOm1A7dFgyPgIVp8jOk0OLodZNqyPENBCshL
         JCZYgn52SLJ90ffOl/fG+U8jDYbwdZ3ujs+SU=
Received: by 10.182.227.7 with SMTP id rw7mr6360486obc.70.1320608923095; Sun,
 06 Nov 2011 11:48:43 -0800 (PST)
Received: by 10.182.52.3 with HTTP; Sun, 6 Nov 2011 11:48:02 -0800 (PST)
In-Reply-To: <20111106050126.GO27272@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184928>

Heya,

On Sun, Nov 6, 2011 at 06:01, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Thanks. =C2=A0I'd suggest squashing in the test from patch 1/3 for ea=
sy
> reference (since each patch makes the other easier to understand).

Yes, agreed. The initial series was 5 patches in total, but splitting
it out for such a small series (and small patch at that) makes less
sense.


> These details seem like good details for the commit message, so the
> next puzzled person looking at the code can see what behavior is
> deliberate and what are the incidental side-effects.

All of it? I wasn't sure what part should go in the commit message.

> The "git fast-export a..$(git rev-parse HEAD^{commit})" case sounds
> worth a test.

A test_must_fail?

>> +#define REF_HANDLED (ALL_REV_FLAGS + 1)
>
> Could TMP_MARK be used for this?

I don't know its usage, is it?

> -static void handle_tags_and_duplicates(struct string_list *extra_ref=
s)
>> +static void handle_tags_and_duplicates(struct rev_info *revs, struc=
t string_list *extra_refs)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int i;
>>
>> + =C2=A0 =C2=A0 /* even if no commits were exported, we need to expo=
rt the ref */
>> + =C2=A0 =C2=A0 for (i =3D 0; i < revs->cmdline.nr; i++) {
>
> Might be clearer in a new function.

Yes, probably. handle_cmdline_refs?

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rev_cmdline_entry=
 *elem =3D &revs->cmdline.rev[i];
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (elem->flags & UNINTE=
RESTING)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (elem->whence !=3D RE=
V_CMD_REV && elem->whence !=3D REV_CMD_RIGHT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>
> Oh, neat.

Yes, I must admit that this bit was easier than I dreaded it would be
(I must admit that's been a large reason that I haven't taken the time
to work on this till now). With the fast-export and remote-helper
tests to guide me, I was able to code-by-accident the right conditions
here :).

>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *full_name;
>
> declaration-after-statement

Ah, yes.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dwim_ref(elem->name, str=
len(elem->name), elem->item->sha1, &full_name);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(full_name=
, "refs/tags/") &&
>
> What happens if dwim_ref fails, perhaps because a ref was deleted in
> the meantime?

That would be bad. I assumed that we have a lock on the refs, should I
add back the die check that's done by the other dwim_ref caller?

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (tag_of_filtered_mode !=3D REWRITE ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 !get_object_mark(elem->item)))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>
> Style nit: this would be easier to read if the "if" condition doesn't
> line up with the code below it:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!prefixcmp=
(full_name, "refs/tags/")) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (tag_of_filtered_mode !=3D REWRITE ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0!get_object_mark(elem->item))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}

Yeah, that does look better :).

> If tag_of_filtered_mode =3D=3D ABORT, we are going to die() soon, rig=
ht?

I don't know to be honest, perhaps we would have already died by now?
I don't know the details of how the tag_of_filtered_mode part is
implemented.

> So this seems to be about tag_of_filtered_mode =3D=3D DROP --- makes
> sense.
>
> When does the !get_object_mark() case come up?

Eh, it has something to do with it being a replacement (rather than
the same), maybe? This is mostly just taken from Dscho's original
patch.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(elem->flags & REF_=
HANDLED)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 handle_reset(full_name, elem->item);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 elem->flags |=3D REF_HANDLED;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> Just curious: is the REF_HANDLED handling actually needed? =C2=A0What
> would happen if fast-export included the redundant resets?

That would just be sloppy :). I don't think anything particularly bad
would happen.

> Thanks for a pleasant read.

Thanks for the review.

--=20
Cheers,

Sverre Rabbelier
