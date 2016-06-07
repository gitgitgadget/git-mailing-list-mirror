From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 23/38] refs: make peel_ref() virtual
Date: Tue, 07 Jun 2016 10:36:42 -0700
Message-ID: <xmqqtwh4rjdh.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<316f0fed796fd2ed17ea5df4c264a98028d6b98a.1464983301.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:36:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAKvp-0006aC-Hw
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 19:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbcFGRgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 13:36:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753988AbcFGRgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 13:36:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 432012112F;
	Tue,  7 Jun 2016 13:36:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UdnsnVN+MYX0l+ifhuqUqkVSozk=; b=iv1iLD
	CL6rtcizwlUkZtSeYs8fR8aoEMIU44DspjKL5aUveXufs6MCD+bRmKmDt18M+2uj
	kZ6KXrvDuD2ZAAvS2rxv+sTdZ092EPogjTMpKNdxFvX5hmOlrT6wu9u5b79nj+4l
	lm0hTxIM0xY/+hTnNxzSqLdU3LIEQo5FBtY3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgLAUHyIN8p8nH25ar8CkTJ9cYBamQ3n
	cYq9c2alsip5X9U+KdKemf8N6oVGH6kItPk5pCleQ88HhtXwqS5KgAAN/HICcnCN
	z4vcQxLwGK6tGpLLLKWMidnvzuHS3jzDF1JFiuTAlg+tYiX3yGHNr8sKJvNcYsDM
	ZNz10RdAwCE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B03B2112E;
	Tue,  7 Jun 2016 13:36:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8B4F2112D;
	Tue,  7 Jun 2016 13:36:43 -0400 (EDT)
In-Reply-To: <316f0fed796fd2ed17ea5df4c264a98028d6b98a.1464983301.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Fri, 3 Jun 2016 23:03:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66A86050-2CD6-11E6-A7A8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296702>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> For now it only supports the main reference store.

Isn't this comment applicable to a handful of recent changes that
made other things virtual, too?  Just wondering if I am missing
something very special with the peel_ref() thing to single it out.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c               | 7 +++++++
>  refs/files-backend.c | 6 ++++--
>  refs/refs-internal.h | 3 +++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 22837f4..2d84c5c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1425,6 +1425,13 @@ int pack_refs(unsigned int flags)
>  	return refs->be->pack_refs(refs, flags);
>  }
>  
> +int peel_ref(const char *refname, unsigned char *sha1)
> +{
> +	struct ref_store *refs = get_ref_store(NULL);
> +
> +	return refs->be->peel_ref(refs, refname, sha1);
> +}
> +
>  int create_symref(const char *ref_target, const char *refs_heads_master,
>  		  const char *logmsg)
>  {
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f82a1be..91dcfcb 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1763,9 +1763,10 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
>  	return status;
>  }
>  
> -int peel_ref(const char *refname, unsigned char *sha1)
> +static int files_peel_ref(struct ref_store *ref_store,
> +			  const char *refname, unsigned char *sha1)
>  {
> -	struct files_ref_store *refs = get_files_ref_store(NULL, "peel_ref");
> +	struct files_ref_store *refs = files_downcast(ref_store, 0, "peel_ref");
>  	int flag;
>  	unsigned char base[20];
>  
> @@ -4031,6 +4032,7 @@ struct ref_storage_be refs_be_files = {
>  	files_transaction_commit,
>  
>  	files_pack_refs,
> +	files_peel_ref,
>  	files_create_symref,
>  
>  	files_read_raw_ref,
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index c342e57..ae67b49 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -496,6 +496,8 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
>  				      struct strbuf *err);
>  
>  typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
> +typedef int peel_ref_fn(struct ref_store *ref_store,
> +			const char *refname, unsigned char *sha1);
>  typedef int create_symref_fn(struct ref_store *ref_store,
>  			     const char *ref_target,
>  			     const char *refs_heads_master,
> @@ -556,6 +558,7 @@ struct ref_storage_be {
>  	ref_transaction_commit_fn *transaction_commit;
>  
>  	pack_refs_fn *pack_refs;
> +	peel_ref_fn *peel_ref;
>  	create_symref_fn *create_symref;
>  
>  	read_raw_ref_fn *read_raw_ref;
