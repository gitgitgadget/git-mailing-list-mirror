From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch -v: align even when branch names are in UTF-8
Date: Sun, 26 Aug 2012 11:04:51 -0700
Message-ID: <7vlih1v8ak.fsf@alter.siamese.dyndns.org>
References: <7vvcg8yzgx.fsf@alter.siamese.dyndns.org>
 <1345918632-17756-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 20:05:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5hCp-0008GW-By
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 20:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab2HZSE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Aug 2012 14:04:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42961 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab2HZSE4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Aug 2012 14:04:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D3EF89CC;
	Sun, 26 Aug 2012 14:04:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5h4kVBcttEcs
	XwE2Fz7Qmje+XD8=; b=x3YJ0e/vuthY+l6TfB9IwQ8qgn/y3BhWEtROXdyupX6V
	ClIUelPhSSFrkyDL/S4X/7NVjMOWLhucdJ9Ey0QBWGu1FYYMmJSH/7UVrD8YH7SX
	Mv+4jSI2s3G3rQA4UXlUxBUj+DLi78SBivxob5OyBeRyyWrJWl59NQxJPIE9KEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=g3y60y
	10TEU2GfHRUsSWjoAxN9Q5dHOPh5h6TlvKiaEg34uZF8ToT/ac6SKPSjE5J+Q6Iz
	fYjn/L4IpZ5ukutFm4+gLEDHoQSyER2+o3sQgoq7WMsTcbthBvlDf2iove70oUsb
	vkJvpKkH8eLjc0HXb0iQrsk55QiWFFcS2hLvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89E8389CB;
	Sun, 26 Aug 2012 14:04:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6CF989C9; Sun, 26 Aug 2012
 14:04:52 -0400 (EDT)
In-Reply-To: <1345918632-17756-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 26 Aug
 2012 01:17:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88D30712-EFA8-11E1-B5D7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204303>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Branch names are usually in ASCII so they are not the problem. The
> problem most likely comes from "(no branch)" translation, which is in
> UTF-8 and makes length calculation just wrong.
>
> Update document to mention the fact that we may want ref names in
> UTF-8. Encodings that produce invalid UTF-8 are safe as utf8_strwidth=
()
> falls back to strlen(). The ones that incidentally produce valid UTF-=
8
> sequences will cause misalignment.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> ...
> @@ -533,7 +535,7 @@ static void show_detached(struct ref_list *ref_li=
st)
>  	if (head_commit && is_descendant_of(head_commit, ref_list->with_com=
mit)) {
>  		struct ref_item item;
>  		item.name =3D xstrdup(_("(no branch)"));
> -		item.len =3D strlen(item.name);
> +		item.len =3D utf8_strwidth(item.name);
>  		item.kind =3D REF_LOCAL_BRANCH;
>  		item.dest =3D NULL;
>  		item.commit =3D head_commit;

We should probably rename the "len" field, as it is no longer about
the length (i.e. that which strlen() returns); it is the display
width, and is better called "cols", "width" or somesuch.

I'll squash-in the following.

Thanks.

 builtin/branch.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git c/builtin/branch.c w/builtin/branch.c
index 73ff7e7..4ec556f 100644
--- c/builtin/branch.c
+++ w/builtin/branch.c
@@ -250,7 +250,7 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds,
 struct ref_item {
 	char *name;
 	char *dest;
-	unsigned int kind, len;
+	unsigned int kind, width;
 	struct commit *commit;
 };
=20
@@ -355,14 +355,14 @@ static int append_ref(const char *refname, const =
unsigned char *sha1, int flags,
 	newitem->name =3D xstrdup(refname);
 	newitem->kind =3D kind;
 	newitem->commit =3D commit;
-	newitem->len =3D utf8_strwidth(refname);
+	newitem->width =3D utf8_strwidth(refname);
 	newitem->dest =3D resolve_symref(orig_refname, prefix);
 	/* adjust for "remotes/" */
 	if (newitem->kind =3D=3D REF_REMOTE_BRANCH &&
 	    ref_list->kinds !=3D REF_REMOTE_BRANCH)
-		newitem->len +=3D 8;
-	if (newitem->len > ref_list->maxwidth)
-		ref_list->maxwidth =3D newitem->len;
+		newitem->width +=3D 8;
+	if (newitem->width > ref_list->maxwidth)
+		ref_list->maxwidth =3D newitem->width;
=20
 	return 0;
 }
@@ -521,8 +521,8 @@ static int calc_maxwidth(struct ref_list *refs)
 	for (i =3D 0; i < refs->index; i++) {
 		if (!matches_merge_filter(refs->list[i].commit))
 			continue;
-		if (refs->list[i].len > w)
-			w =3D refs->list[i].len;
+		if (refs->list[i].width > w)
+			w =3D refs->list[i].width;
 	}
 	return w;
 }
@@ -535,12 +535,12 @@ static void show_detached(struct ref_list *ref_li=
st)
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commi=
t)) {
 		struct ref_item item;
 		item.name =3D xstrdup(_("(no branch)"));
-		item.len =3D utf8_strwidth(item.name);
+		item.width =3D utf8_strwidth(item.name);
 		item.kind =3D REF_LOCAL_BRANCH;
 		item.dest =3D NULL;
 		item.commit =3D head_commit;
-		if (item.len > ref_list->maxwidth)
-			ref_list->maxwidth =3D item.len;
+		if (item.width > ref_list->maxwidth)
+			ref_list->maxwidth =3D item.width;
 		print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_lis=
t->abbrev, 1, "");
 		free(item.name);
 	}
