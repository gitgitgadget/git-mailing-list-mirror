From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] mv: unindent one level for directory move code
Date: Mon, 11 Aug 2014 11:47:49 -0700
Message-ID: <xmqq61hy7tii.fsf@gitster.dls.corp.google.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
	<1407637776-19794-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:48:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGudZ-0002n4-UP
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 20:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbaHKSsB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2014 14:48:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55207 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754128AbaHKSsA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2014 14:48:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BE482FCC5;
	Mon, 11 Aug 2014 14:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=RaZ+vhp7AReCMwM9LyRaHLiWw
	Ls=; b=LeQ9haMIb1KLHp4P9WRu9uSKkbeJzzcIBXyl7hsXTeppvt62jW+CbUfZn
	eA60qR5WI/edhEsnn3ckoVePBGCoYmyKSxn3kBeBx2S+/cEU0sl0iEtBs83YmPYb
	9w4L3gxIOSRkGoE8cLESasb2YA1VRv8WBrGnBKa+OAJWWl4JOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=t12vPNdkdGF2y/C2R/O
	Jew/b4NTj60GJ+Q2lBqh3pjWNgGsKx5iZOLZk53rTTqMi+QK5Y+vZJGDLBdNim1G
	C490+/fj2mico9gwgPDIUxe7+OfaoWHOKsb3cFppkqqSlJROb2MnLM4yrOwWeMUA
	Mx3GBqpg1J8F/FZNW3nh+9DQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91BE12FCC4;
	Mon, 11 Aug 2014 14:47:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0A06D2FCB2;
	Mon, 11 Aug 2014 14:47:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FF99910A-2187-11E4-95F1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255130>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/mv.c | 47 +++++++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 26 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index dcfcb11..988945c 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -171,42 +171,37 @@ int cmd_mv(int argc, const char **argv, const c=
har *prefix)
>  				&& lstat(dst, &st) =3D=3D 0)
>  			bad =3D _("cannot move directory over file");
>  		else if (src_is_dir) {
> +			int first =3D cache_name_pos(src, length), last;
>  			if (first >=3D 0)
>  				prepare_move_submodule(src, first,
>  						       submodule_gitfile + i);
> +			else if (index_range_of_same_dir(src, length,
> +							 &first, &last) < 1) {

The function returns (last - first), so (last - first) < 1 holds
inside this block, right?

>  				modes[i] =3D WORKING_DIRECTORY;
>  				if (last - first < 1)
>  					bad =3D _("source directory is empty");

Then do you need this conditional, or it is always bad here?

If it is always bad, then modes[i] do not need to be assigned to,
either, I think.

Am I missing something?

> +			} else { /* last - first >=3D 1 */
> +				int j, dst_len, n;

> +				modes[i] =3D WORKING_DIRECTORY;
> +				n =3D argc + last - first;
> ...

Otherwise, perhaps squash this in?

diff --git a/builtin/mv.c b/builtin/mv.c
index bf513e0..bf784cb 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -172,15 +172,14 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 			bad =3D _("cannot move directory over file");
 		else if (src_is_dir) {
 			int first =3D cache_name_pos(src, length), last;
+
 			if (first >=3D 0)
 				prepare_move_submodule(src, first,
 						       submodule_gitfile + i);
 			else if (index_range_of_same_dir(src, length,
-							 &first, &last) < 1) {
-				modes[i] =3D WORKING_DIRECTORY;
-				if (last - first < 1)
-					bad =3D _("source directory is empty");
-			} else { /* last - first >=3D 1 */
+							 &first, &last) < 1)
+				bad =3D _("source directory is empty");
+			else { /* last - first >=3D 1 */
 				int j, dst_len, n;
=20
 				modes[i] =3D WORKING_DIRECTORY;
