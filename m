From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v3 2/2] Ensure git ls-tree exits with a non-zero exit code
 if read_tree_recursive fails.
Date: Mon, 25 Jul 2011 18:45:35 +1000
Message-ID: <CAH3Anrrbj93briHKpxEjpoVTOnSikQYQyxa4R=C7QKt=punyVw@mail.gmail.com>
References: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com>
	<1311519554-16587-3-git-send-email-jon.seymour@gmail.com>
	<CACsJy8Aa_=BvZOt58sM4dknVzvihH9OtHAS1aRxqPwNLxh0fkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 10:45:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlGnF-0008Bp-Ok
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 10:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153Ab1GYIpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jul 2011 04:45:38 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50185 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab1GYIpg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 04:45:36 -0400
Received: by vws1 with SMTP id 1so2805019vws.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qu252l+7oj14NytLPiUVpLWGOTR9EizD4bM4Fu+w3HA=;
        b=uQrih5Dsb+sSOJXZVKOe5pc6afhhuz/WzEYzw7FkTQJXOcDEsllUwnUVSeH2j9E1mD
         mqXpBp+qJSalqoAa71Uvy5nfkzeEdSa7e0QNwtoaEx+Xj6Zlp0hzevruaegq+2s7FS2D
         4GLlEhENq6tM0q+q7GajazbnSF8/8AyxnxPE0=
Received: by 10.52.21.194 with SMTP id x2mr4091311vde.39.1311583535906; Mon,
 25 Jul 2011 01:45:35 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Mon, 25 Jul 2011 01:45:35 -0700 (PDT)
In-Reply-To: <CACsJy8Aa_=BvZOt58sM4dknVzvihH9OtHAS1aRxqPwNLxh0fkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177786>

=46air point.

Everyone ok with this revision? If so, I will re-roll v4.

Jens: I added the variable back because the return statement with a
ternary operator needed a line break. Let me know
if there is a better way to format it.

jon.

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index d96e9c4..990e1a3 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -120,7 +120,7 @@ int cmd_ls_tree(int argc, const char **argv, const
char *prefix)
 {
        unsigned char sha1[20];
        struct tree *tree;
-       int i, full_tree =3D 0;
+       int i, full_tree =3D 0, ret;
        const struct option ls_tree_options[] =3D {
                OPT_BIT('d', NULL, &ls_options, "only show trees",
                        LS_TREE_ONLY),
@@ -173,6 +173,7 @@ int cmd_ls_tree(int argc, const char **argv, const
char *prefix)
        tree =3D parse_tree_indirect(sha1);
        if (!tree)
                die("not a tree object");
-       return read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree=
, NULL);
+       ret =3D read_tree_recursive(tree, "", 0, 0, &pathspec, show_tre=
e, NULL);

+       return ret ? 1 : 0;
 }


On Mon, Jul 25, 2011 at 11:31 AM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On Sun, Jul 24, 2011 at 9:59 PM, Jon Seymour <jon.seymour@gmail.com> =
wrote:
>> @@ -173,7 +173,6 @@ int cmd_ls_tree(int argc, const char **argv, con=
st char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tree =3D parse_tree_indirect(sha1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tree)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("not a tr=
ee object");
>> - =C2=A0 =C2=A0 =C2=A0 read_tree_recursive(tree, "", 0, 0, &pathspec=
, show_tree, NULL);
>> + =C2=A0 =C2=A0 =C2=A0 return read_tree_recursive(tree, "", 0, 0, &p=
athspec, show_tree, NULL);
>>
>> - =C2=A0 =C2=A0 =C2=A0 return 0;
>
> Nit picking. Most programs return positive value (usually 1) for erro=
r
> cases here. read_tree_recursive may return -1 (which turns out to be
> 255). Also removing the last blank line in this function would be
> nice.
> --
> Duy
>
