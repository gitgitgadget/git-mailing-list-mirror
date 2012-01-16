From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] tree_entry_interesting: make recursive mode
 default
Date: Mon, 16 Jan 2012 14:15:59 -0800
Message-ID: <7v1uqzwaxs.fsf@alter.siamese.dyndns.org>
References: <1326341371-16628-1-git-send-email-pclouds@gmail.com>
 <1326533003-19686-1-git-send-email-pclouds@gmail.com>
 <1326533003-19686-2-git-send-email-pclouds@gmail.com>
 <7v8vl9wtfg.fsf@alter.siamese.dyndns.org> <20120115100327.GA10735@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 23:16:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmuqX-0005ul-MZ
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 23:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784Ab2APWQE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 17:16:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab2APWQD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 17:16:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 987BB7502;
	Mon, 16 Jan 2012 17:16:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9U4EMo+qlBIw
	4zGDdOw3P+yh8vI=; b=oJLDaqHh5GsB/sMeaT4cE0DC3Rxa29XkOfmIODgU79L/
	7qqde/qLHsslRPU6Mh0Q1Nd4VWT0/c8lHK7oZpGaCDdGpSFXdiTa/SZq7xLk1Tek
	4lYmxct4YkIqiVt02oW82tNt74Qq8bpDmqvbrPUeE9owBitnD98GMXntEzg47R8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AVmwCM
	3zUAn0UENA1xnDkpUAdacRPjlenYxYHD4ecyjQ1OcoTIql46E7/XRgx++fzqfAmT
	WBaxR82KndnEB5UrsM7KgwLrNqU1vAFhZPWz7E64lX8KDr896rxkzNtm9Rokte0j
	FSb7kFjB6qig1gWYKRpn7f+eCUOzp8dj2WSV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F6E57501;
	Mon, 16 Jan 2012 17:16:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05D3274FF; Mon, 16 Jan 2012
 17:16:00 -0500 (EST)
In-Reply-To: <20120115100327.GA10735@do> (Nguyen Thai Ngoc Duy's message of
 "Sun, 15 Jan 2012 17:03:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC23DEF8-408F-11E1-8FBC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188660>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Jan 14, 2012 at 07:12:03PM -0800, Junio C Hamano wrote:
>> That makes my head hurt and makes me suspect there is something
>> fundamentally wrong in the patch.  Sigh...
>
> I'll need to think about it. In the meantime perhaps the following
> bandage patch would suffice, rather than revert 2f88c19 (diff-index:
> pass pathspec down to unpack-trees machinery)

Yeah, the logic of this correction is very clear. Because diff_cache is
about walking a flat index, the "recursive pathspec" that allows us to
look into deeper levels in directory hierarchy should be set, and also =
we
should not be limiting the depth of the match in any way by setting the
max_depth to "unlimited".

Thanks.

> -- 8< --
> Subject: [PATCH] diff-index: enable recursive pathspec matching in un=
pack_trees
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  diff-lib.c               |    2 ++
>  t/t4010-diff-pathspec.sh |    8 ++++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index 62f4cd9..fc0dff3 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -469,6 +469,8 @@ static int diff_cache(struct rev_info *revs,
>  	opts.src_index =3D &the_index;
>  	opts.dst_index =3D NULL;
>  	opts.pathspec =3D &revs->diffopt.pathspec;
> +	opts.pathspec->recursive =3D 1;
> +	opts.pathspec->max_depth =3D -1;
> =20
>  	init_tree_desc(&t, tree->buffer, tree->size);
>  	return unpack_trees(1, &t, &opts);
> diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
> index fbc8cd8..af5134b 100755
> --- a/t/t4010-diff-pathspec.sh
> +++ b/t/t4010-diff-pathspec.sh
> @@ -48,6 +48,14 @@ test_expect_success \
>       compare_diff_raw current expected'
> =20
>  cat >expected <<\EOF
> +:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61=
be0328a19b29f18cdcb49338d516 M	path1/file1
> +EOF
> +test_expect_success \
> +    '"*file1" should show path1/file1' \
> +    'git diff-index --cached $tree -- "*file1" >current &&
> +     compare_diff_raw current expected'
> +
> +cat >expected <<\EOF
>  :100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61=
be0328a19b29f18cdcb49338d516 M	file0
>  EOF
>  test_expect_success \
> --=20
> 1.7.8.36.g69ee2
>
> -- 8< --
