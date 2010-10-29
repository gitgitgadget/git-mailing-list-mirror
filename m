From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] diff: support --root --cached combination
Date: Fri, 29 Oct 2010 18:00:32 +0700
Message-ID: <AANLkTikDhABbnT-tV-5WnUk1HaTzOfEywM1C0gJZ=bhk@mail.gmail.com>
References: <1288346087-20263-1-git-send-email-pclouds@gmail.com> <20101029101959.GA27662@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 13:01:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBmhg-0001kg-CU
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 13:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761103Ab0J2LA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 07:00:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38318 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757103Ab0J2LAy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Oct 2010 07:00:54 -0400
Received: by wyf28 with SMTP id 28so3007575wyf.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mSSb86lLnsiyG0QAuqABHUE0yNmG9vizaO0sqO3YwKY=;
        b=KjGH7GTEnp3WIJ6qoUgaPTyzkkwQIDlhKGr1ZgzxhSPkDpkOWmHmQct/FX+2LJVOVu
         bIYTg97rrpItveH43VH7l2RzE8Z8ZX6ksegDxAhhZfzY9lTmV4nx8YUO4GnPzYLXQBbx
         ZHhIvSe0yEwC1gAxfoju1FL/RiDDp46kPJDOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R3vWM/VskrJy3Et3TboKh45635ISsY4qZF9H8ID7/4ZXwguAHWG2bm/lRdTCvLtHGw
         649zy1o6eScU1Q0PCep92IthqCh+fFUg6MQaIhL1x+OdN5EMjLVL0tS39eWUo4ZAdayq
         duaiDgvMr27DXmZecAXsWkUIFBzeCbsaJH5YU=
Received: by 10.227.156.148 with SMTP id x20mr3416418wbw.25.1288350052589;
 Fri, 29 Oct 2010 04:00:52 -0700 (PDT)
Received: by 10.216.135.77 with HTTP; Fri, 29 Oct 2010 04:00:32 -0700 (PDT)
In-Reply-To: <20101029101959.GA27662@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160328>

2010/10/29 Jonathan Nieder <jrnieder@gmail.com>:
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -330,8 +330,13 @@ int cmd_diff(int argc, const char **argv, const=
 char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 else if (!strcmp(arg, "--cached") ||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!strcmp(arg, "--staged")) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_head_to_pending(&rev);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!rev.pending.nr)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("No HEA=
D commit to compare with (yet)");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!rev.pending.nr) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct obje=
ct *obj;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!rev.sh=
ow_root_diff)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 die("No HEAD commit to compare with (yet)");
>
> How does this condition get tripped? =C2=A0The code allowing "[log]
> showroot" to be set to false is only invoked by the log family of
> commands.
>
> Using --root as the backward-compatibility option seems like
> an abuse of language, anyway.

Hmm.. I thought --root was supported by all diff command family. Now I
think of it, only "diff-tree --root" makes sense.

> =C2=A0"git diff --cached" has two meanings:
>
> =C2=A01. show changes to be committed
>
> =C2=A0 =C2=A01b. show what git show --format=3D" " would say after a =
commit
>
> =C2=A02. show differences between the index and the commit named by t=
he
> =C2=A0 =C2=A0(implicit) HEAD argument
>
> With interpretation (1b), --root should be respected, and the output
> should be empty (!), not an error, when "[log] showroot" is false.
>
> With interpretation (2), --root should not be respected, and an
> attempt to diff --cached in an unborn branch should be an error.

If you commit to an unborn branch, it would become the first commit of
that branch. So by (1a), it should show what is to be commited, isn't
it?

>
> (1a) and (1b) are the only useful interpretations. =C2=A0So for simpl=
icity,
> would it make sense to drop the "if ()" for --root and make
>
>> +test_expect_success 'diff --cached' '
>> + =C2=A0 =C2=A0 test_must_fail git diff --cached
>> +'
>
> fail?

All for simpler, yes.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D (st=
ruct object*)lookup_tree((unsigned char*)EMPTY_TREE_SHA1_BIN);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tree *tree =3D lookup_tree((const u=
nsigned char *) ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj =3D &tree->object;
>
> might be more clear (and robust against future layout changes).
>

OK

--=20
Duy
