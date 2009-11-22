From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --format: document %w
Date: Sun, 22 Nov 2009 09:10:14 -0800
Message-ID: <7vzl6eiiyx.fsf@alter.siamese.dyndns.org>
References: <4B0963A3.4060804@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Nov 22 18:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCFxK-000315-H0
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 18:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbZKVRKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 12:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbZKVRKW
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 12:10:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755395AbZKVRKV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2009 12:10:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D3E482B9C;
	Sun, 22 Nov 2009 12:10:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o81XL9ibFV9A
	XM1Xj5IaBklCuhg=; b=E5njMPHZbjUbrr7aAR4UtRC94Hu+tRct81gM6oBVYN+V
	xJ727hQvc5cTPYSlsMbBP12IJTkoy1xSAWSCsGBzbT5LphM8czgFBFB5dAsAdlJe
	CgtSSOMs49/afaogRQNGgC5y/SP3xeaNqwqrFooT5fUPDqXi4cuYXAkOkznOy7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=M1DBc6
	H0NsREd89n745Bn3LL0PslgmsjeEG3YJ8mrBsPP464FJRfcWzq5aoJHzXaKdxafG
	fzE4FJ3D8cvwcBKgYqK5m2zrRDzu8i6Dan8Pvb+HgRydKrTA/xnb1ArUxw9h+6Wm
	F1P6Pj665BNrkl5MtVndj6zwR+kiZz2IZjQgg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AA3982B9A;
	Sun, 22 Nov 2009 12:10:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3347582B99; Sun, 22 Nov
 2009 12:10:16 -0500 (EST)
In-Reply-To: <4B0963A3.4060804@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun\, 22 Nov 2009 17\:15\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EB1D6B54-D789-11DE-9C2F-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133444>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> I'm not especially proud of the triple negative in that note.  How to=
 say it
> better, yet concise?
> +- '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w optio=
n of
> +  linkgit:git-shortlog[1].  NOTE: Color placeholders (`%C*`) are not
> +  recognized as having no width, so they should not be put into wrap=
ped
> +  sections.

"The code miscounts the width of '%C*' color placeholders"?

Perhaps somebody in the codepath leading to pick_one_utf8_char() in utf=
8.c
can be made aware of them?

utf8_width() is called from many places (has one caller outside utf8.c =
as
well).  It is given a pointer to a pointer that points at the current
position in a string, and is responsible for picking up one logical let=
ter
advancing the given pointer to skip over that letter, and returning the
display width of that one letter.  The function wants the string to be
encoded in utf-8 and signals by putting NULL in the pointer when it
detects the input string is not.

Picking up one logical letter is done by pick_one_utf8_char(), which is=
 a
nicely written generic "We are at the character boundary of a potential=
ly
multi-byte utf-8 string; pick the first character" implementation, and =
we
wouldn't want to contaminate that with escape sequence logic---we might
want to reuse it in other codepaths where we have no reason to expect a=
ny
escape sequences.

So perhaps we can introduce is_esc_sequence(s, r, w) that

 - returns true if we are at the beginning of an esc-sequence;
 - skips the sequence just like utf8_width() does with s and r; and
 - counts the width of the sequence and returns it in *w

The implementation of the is_esc_sequence() could be to only detect the
color sequence (if the sequence has things like cursor-position control
then we are already lost, as calling "utf8_width()" on such a string do=
es
not make much sense anyway) and report zero-width.

I dunno.

diff --git a/utf8.c b/utf8.c
index 5c18f0c..d45e75f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -241,7 +241,12 @@ invalid:
  */
 int utf8_width(const char **start, size_t *remainder_p)
 {
-	ucs_char_t ch =3D pick_one_utf8_char(start, remainder_p);
+	ucs_char_t ch;
+	int w;
+
+	if (is_esc_sequence(start, remainder_p, &w))
+		return w;
+	ch =3D pick_one_utf8_char(start, remainder_p);
 	if (!*start)
 		return 0;
 	return git_wcwidth(ch);
