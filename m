From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH] fix show_entry() in tree-diff.c for TREE_IN_RECURSIVE
Date: Sun, 14 Jun 2009 14:01:20 +0200
Message-ID: <c77435a80906140501m1b63512fif5cc5e57f5d114c5@mail.gmail.com>
References: <op.uvhcoii8tdk399@sirnot.private>
	 <7v63ezvgyo.fsf@alter.siamese.dyndns.org>
	 <7vvdmzu1c8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 14:01:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFoOx-0002LU-U7
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 14:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730AbZFNMBU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jun 2009 08:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbZFNMBU
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 08:01:20 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:38474 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693AbZFNMBT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2009 08:01:19 -0400
Received: by ewy6 with SMTP id 6so4235579ewy.37
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CHufq5TwrBNWYeXRPf/SO8BOELJvTesZ3mVFF/1degU=;
        b=DavyOQwUJMOuj/jlZK2LBlgYhaN1R4s84ar2+d/uYqD7AjvRantYsVa0zaY5pKiUlY
         KZrIs/X2+0ny9hxxddewG+xwpxTEZolc0NIWbN6qC4QrfUy0LT0c4XEN4r3zTIdM+bMa
         j2ywAq6xFjm44OvCNB/StVgD+fYXkf08e+JrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mGXWPwrRYe4CA0o0fWlVU02yfhn/vSD8+hfnjEPtTgN15qwncDZdyOZ0uemiDJDz5J
         Meq4XY4nR1sUvPSE/k8BhvmWkMLjxJKlPXeYP9EGu9ajKfXAO17yQcr1dTDPyb4QQZ7V
         euAZvgwWADGlDUZhhS9Msl4r/W8HQ8YxH8Rzc=
Received: by 10.216.71.196 with SMTP id r46mr1964195wed.54.1244980880775; Sun, 
	14 Jun 2009 05:01:20 -0700 (PDT)
In-Reply-To: <7vvdmzu1c8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121549>

ah, right.  so next time I should add a test to demonstrate and verify
the external effect?  admittedly part of the reason I hadn't showed
any example output was because I changed this from an internal
perspective.  I'll definitely do that next time though.  thanks for
the example!  (btw, what is the numerical naming convention for
tests?)

you know if no one really liked it as an output we could keep this
change for internal consistency's sake, and filter our added/removed
dirs in the outputing, or even diff_addremove.  seems a bit hackish
though...

(also, do you want me to resubmit?  because you seem to have taken care=
 of it)

 - Nick

On Sun, Jun 14, 2009 at 2:05 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Nick Edelen" <sirnot@gmail.com> writes:
>> ...
>>> this seems like how it should act: trees are shown under this optio=
n for
>>> changes,...
>>
>> Please show a sample input, the output you expect and the output fro=
m the
>> current code, to illustrate the alleged breakage better.
>> ...
>> I think the output from the code after your change is more consisten=
t, but
>> I somehow suspect that this might break people's script, like gitweb=
,
>> rather badly, if they depended on the existing behaviour.
>
> That is, something like the attached patch.
>
> I cannot afford to do this to everybody, but you seem to be new to th=
e
> community, and every once in a while teaching by showing example is t=
he
> best way to do things, so...
>
> -- >8 --
> From: Nick Edelen <sirnot@gmail.com>
> Subject: [PATCH] diff-tree -r -t: include added/removed directories i=
n the output
>
> We used to include only the modified and typechanged directories
> in the ouptut, but for consistency's sake, we should also include
> added and removed ones as well.
>
> This makes the output more consistent, but it may break existing scri=
pts
> that expect to see the current output which has long been the establi=
shed
> behaviour.
>
> Signed-off-by: Nick Edelen <sirnot@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> =A0* This should apply at least down to 1.6.0 series, if not earlier.
>
> =A0t/t4037-diff-r-t-dirs.sh | =A0 53 ++++++++++++++++++++++++++++++++=
++++++++++++++
> =A0tree-diff.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 +++++
> =A02 files changed, 59 insertions(+), 0 deletions(-)
>
> diff --git a/t/t4037-diff-r-t-dirs.sh b/t/t4037-diff-r-t-dirs.sh
> new file mode 100755
> index 0000000..f5ce3b2
> --- /dev/null
> +++ b/t/t4037-diff-r-t-dirs.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +
> +test_description=3D'diff -r -t shows directory additions and deletio=
ns'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> + =A0 =A0 =A0 mkdir dc dr dt &&
> + =A0 =A0 =A0 >dc/1 &&
> + =A0 =A0 =A0 >dr/2 &&
> + =A0 =A0 =A0 >dt/3 &&
> + =A0 =A0 =A0 >fc &&
> + =A0 =A0 =A0 >fr &&
> + =A0 =A0 =A0 >ft &&
> + =A0 =A0 =A0 git add . &&
> + =A0 =A0 =A0 test_tick &&
> + =A0 =A0 =A0 git commit -m initial &&
> +
> + =A0 =A0 =A0 rm -fr dt dr ft fr &&
> + =A0 =A0 =A0 mkdir da ft &&
> + =A0 =A0 =A0 for p in dc/1 da/4 dt ft/5 fc
> + =A0 =A0 =A0 do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo hello >$p || exit
> + =A0 =A0 =A0 done &&
> + =A0 =A0 =A0 git add -u &&
> + =A0 =A0 =A0 git add . &&
> + =A0 =A0 =A0 test_tick &&
> + =A0 =A0 =A0 git commit -m second
> +'
> +
> +cat >expect <<\EOF
> +A =A0 =A0 =A0da
> +A =A0 =A0 =A0da/4
> +M =A0 =A0 =A0dc
> +M =A0 =A0 =A0dc/1
> +D =A0 =A0 =A0dr
> +D =A0 =A0 =A0dr/2
> +A =A0 =A0 =A0dt
> +D =A0 =A0 =A0dt
> +D =A0 =A0 =A0dt/3
> +M =A0 =A0 =A0fc
> +D =A0 =A0 =A0fr
> +D =A0 =A0 =A0ft
> +A =A0 =A0 =A0ft
> +A =A0 =A0 =A0ft/5
> +EOF
> +
> +test_expect_success verify '
> + =A0 =A0 =A0 git diff-tree -r -t --name-status HEAD^ HEAD >actual &&
> + =A0 =A0 =A0 test_cmp expect actual
> +'
> +
> +test_done
> diff --git a/tree-diff.c b/tree-diff.c
> index 9f67af6..c83a8da 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -233,6 +233,12 @@ static void show_entry(struct diff_options *opt,=
 const char *prefix, struct tree
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!tree || type !=3D OBJ_TREE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("corrupt tree sha =
%s", sha1_to_hex(sha1));
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE=
)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 newbase[baselen + pathl=
en] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opt->add_remove(opt, *p=
refix, mode, sha1, newbase);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 newbase[baselen + pathl=
en] =3D '/';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0init_tree_desc(&inner, tree, size);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0show_tree(opt, prefix, &inner, newbase=
, baselen + 1 + pathlen);
>
>
