From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/28] shallow.c: extend setup_*_shallow() to accept extra shallow points
Date: Mon, 25 Nov 2013 14:25:15 -0800
Message-ID: <xmqqhab0w244.fsf@gitster.dls.corp.google.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 23:25:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl4at-0002p8-PD
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 23:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab3KYWZX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 17:25:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab3KYWZW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 17:25:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8870C53351;
	Mon, 25 Nov 2013 17:25:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MoESp1eeRVX/
	AmYJSHqrrrf3WH4=; b=hazANxIP2hkM4Detpd9mb4L6SR2YLIDw5e1J8VT4huVe
	9EX4CuSESE9xPxUz3q5v7LWRxxgzhC+q/7vMey4hwbndCnj//ibuZLElMb/hEz4F
	UZicR+0lZ2EmA2J0DdVMKtTeKLHW9uhzgqlt0CL4HBPo7UtYUj7LYFAMJVtgmkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NH2nHs
	STv5thl7zQKWQLZZEhkRz2UQ7HccOVmdKZwSf1RAWP+WFUFfY3HcHQdxhwQGvqnv
	0uSNu4ly/P7Sx9oRgwP5P372yV6Gb93iS6OAjRb3drKyNssfUUYqkzbgsd+hwUme
	VenVUmp3C20oqKPYeNciuQaeOZR8jAsMB1ru8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79F2253350;
	Mon, 25 Nov 2013 17:25:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 737C25334F;
	Mon, 25 Nov 2013 17:25:18 -0500 (EST)
In-Reply-To: <1385351754-9954-10-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 25
 Nov 2013 10:55:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 76E37ACA-5620-11E3-98B0-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238362>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  commit.h      |  8 +++++---
>  fetch-pack.c  |  5 +++--
>  shallow.c     | 20 +++++++++++++++-----
>  upload-pack.c |  2 +-
>  4 files changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/commit.h b/commit.h
> index e1fd587..3af4699 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -203,10 +203,12 @@ extern struct commit_list *get_shallow_commits(=
struct object_array *heads,
>  		int depth, int shallow_flag, int not_shallow_flag);
>  extern void check_shallow_file_for_update(void);
>  extern void set_alternate_shallow_file(const char *path);
> -extern int write_shallow_commits(struct strbuf *out, int use_pack_pr=
otocol);
> +extern int write_shallow_commits(struct strbuf *out, int use_pack_pr=
otocol,
> +				 const struct extra_have_objects *extra);

Confusing.

Sounds as if you got the extra ".have" and storing them in the
=2Egit/shallow file (which of course would not make much sense), which
is not what is going on.

Also it is unclear how the sanity check the previous step seems to
make and the new list of shallow commit names this patch adds to
existing functions are designed to interact. I think the whole
design needs a better explanation of the flow at the higher level.
