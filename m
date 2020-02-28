Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D12C3F2C6
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 00:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AF12087F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 00:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSfEN2eD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgB1AEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:04:20 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54138 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgB1AEU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 19:04:20 -0500
Received: by mail-pj1-f65.google.com with SMTP id i11so419353pju.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 16:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUEkt1eLd5jV7vBltG9yXcSwPPxj79+UTFDyL2ZOP+Y=;
        b=uSfEN2eDjuvIRqduOry+/6QRXQixh9MMNv/a8vZb0vGGVYqppk1WeO/LuDFF5MklOq
         6dHQXFpVD2BcDyBfbSv8OMwdL+1yJQKiu9+A0XvopL/ig7TdfZTCQ4AvWQVUWGoHaQ/f
         SytVlodcxlXMFf8jXSzXMRIQvX9+F3dZ3QQBWKKCqK49kYrNqZTSHmKlSpAxECQQGyO7
         6SwXaqZw+f/WJ+PN1UGtnCXzdnh47gyU8FpacRAZl2dEBPZ63gmPudccMtX0Gk5JjzG8
         OJIFOZDEpz8MgJI1E7b6EWlZsNwdfTow0Tb18dn+mIuszZPSDF3trIttlCH3ic3I0NxV
         +Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DUEkt1eLd5jV7vBltG9yXcSwPPxj79+UTFDyL2ZOP+Y=;
        b=Pt7UGyd5NFR/wqDhfocSHKRAcDBbm5ixX/SFLPVsWdF3Ipgd0WGjS8sG3zfYiSK8nZ
         CXOHl63K5kSnGVYsgRwT2Y2rEY1kcTB/Cz7g31IHHB9NXgtxfOj6yRzv7JKcLUXAEH7n
         2paUhft+mTwkrK9uSqlLNxnlxOqJ5CzGL53qX5KqNSIHgJdrmIYxvDfOiNBov60FXK+D
         odyTig4JA2h2UBJz63//QEB5nK0E1Sb/5BAPNa9z7Sv3OqLQa9XE2m/OygsyH8k0JQDE
         krlUzneF1D4toPFzLf12VeSs9OfbBFx4bfnABxCKmhecFTGSrX5vulcQx299YlRBFyHZ
         sRLQ==
X-Gm-Message-State: APjAAAVsQkfV9rRYt3fqUg6J8i4ZvaG39pmwjVNHC58xUW6p7ZcQELDf
        49VvbY9OaN3GNVRECQZX2Q0cGKbDlyA=
X-Google-Smtp-Source: APXvYqxxqS1Za9/W6bobRFCprPMBqw0rVLHY8i+CbDL7/PLgCK68eJGyyqDNjvS0DFHGKoK/GSxf7w==
X-Received: by 2002:a17:902:348:: with SMTP id 66mr1300679pld.137.1582848257823;
        Thu, 27 Feb 2020 16:04:17 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id t23sm8551684pfq.6.2020.02.27.16.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:04:17 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:04:12 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 3/7] index-pack: remove redundant parameter
Message-ID: <20200228000412.GC12115@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com, peff@peff.net
References: <cover.1570663470.git.jonathantanmy@google.com>
 <cover.1571343096.git.jonathantanmy@google.com>
 <f01f069a080d705ddb52e2353fa303b979a3cb78.1571343096.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f01f069a080d705ddb52e2353fa303b979a3cb78.1571343096.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.17 13:17, Jonathan Tan wrote:
> find_{ref,ofs}_delta_{,children} take an enum object_type parameter, but
> the object type is already present in the name of the function. Remove
> that parameter from these functions.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/index-pack.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index df6b3b8cf6..296804230c 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -614,7 +614,7 @@ static int compare_ofs_delta_bases(off_t offset1, off_t offset2,
>  	       0;
>  }
>  
> -static int find_ofs_delta(const off_t offset, enum object_type type)
> +static int find_ofs_delta(const off_t offset)
>  {
>  	int first = 0, last = nr_ofs_deltas;
>  
> @@ -624,7 +624,8 @@ static int find_ofs_delta(const off_t offset, enum object_type type)
>  		int cmp;
>  
>  		cmp = compare_ofs_delta_bases(offset, delta->offset,
> -					      type, objects[delta->obj_no].type);
> +					      OBJ_OFS_DELTA,
> +					      objects[delta->obj_no].type);
>  		if (!cmp)
>  			return next;
>  		if (cmp < 0) {

It looks like compare_ofs_delta_bases() could be similarly cleaned up
here? This seems to be the only caller.


> @@ -668,7 +668,7 @@ static int compare_ref_delta_bases(const struct object_id *oid1,
>  	return oidcmp(oid1, oid2);
>  }
>  
> -static int find_ref_delta(const struct object_id *oid, enum object_type type)
> +static int find_ref_delta(const struct object_id *oid)
>  {
>  	int first = 0, last = nr_ref_deltas;
>  
> @@ -678,7 +678,8 @@ static int find_ref_delta(const struct object_id *oid, enum object_type type)
>  		int cmp;
>  
>  		cmp = compare_ref_delta_bases(oid, &delta->oid,
> -					      type, objects[delta->obj_no].type);
> +					      OBJ_REF_DELTA,
> +					      objects[delta->obj_no].type);
>  		if (!cmp)
>  			return next;
>  		if (cmp < 0) {

And same with compare_ref_delta_bases here.


> @@ -691,10 +692,9 @@ static int find_ref_delta(const struct object_id *oid, enum object_type type)
>  }
>  
>  static void find_ref_delta_children(const struct object_id *oid,
> -				    int *first_index, int *last_index,
> -				    enum object_type type)
> +				    int *first_index, int *last_index)
>  {
> -	int first = find_ref_delta(oid, type);
> +	int first = find_ref_delta(oid);
>  	int last = first;
>  	int end = nr_ref_deltas - 1;
>  
> @@ -982,12 +982,10 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
>  {
>  	if (base->ref_last == -1 && base->ofs_last == -1) {
>  		find_ref_delta_children(&base->obj->idx.oid,
> -					&base->ref_first, &base->ref_last,
> -					OBJ_REF_DELTA);
> +					&base->ref_first, &base->ref_last);
>  
>  		find_ofs_delta_children(base->obj->idx.offset,
> -					&base->ofs_first, &base->ofs_last,
> -					OBJ_OFS_DELTA);
> +					&base->ofs_first, &base->ofs_last);
>  
>  		if (base->ref_last == -1 && base->ofs_last == -1) {
>  			free(base->data);
> -- 
> 2.23.0.866.gb869b98d4c-goog
> 
