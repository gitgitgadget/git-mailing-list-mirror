Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873541803A
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZUAdxeF"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dbc32051a9so358147a34.2
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 04:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703248711; x=1703853511; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pB/5cW/+SPCX+X0RQJMV+MYDxKiNEQ8rZ5nu76Z80Po=;
        b=CZUAdxeFFE0RueYCTiw/vu3hlLoIHx4R/LNQIzI+ff4TVg6lzxkNs0GIP1O7SJIjSW
         9WYURI+jRreU9g6l7YjeMvz2UQDq2ul4eHdcyZJ+YLBsUF4gCDsVrpw4/wgnua582r5N
         G9l93NLweOZZ5DMQSCg/Wj/e5TwOOroKn7gj7sIvsHeF3miRNONXblBOpEpIjWPKryVL
         Y28r+cssJRA9busE0XCJu9rGn7vQUC2Yq8VGqvytkZNLkmJ1o1whSIK2+msGWuQdBbMl
         BkBFNOCO6ts/PoJa8oM2tGDOcGq/uJV+M6DnxDqMtDUR7XTFudpDD7HhFEJqIZFfYhMU
         LDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703248711; x=1703853511;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pB/5cW/+SPCX+X0RQJMV+MYDxKiNEQ8rZ5nu76Z80Po=;
        b=rfbh/Ntw5J4pD38wK7Lw1xIWrjx4LEPAlQqyTCK3o9pbB4Fcys+tdujkEInjbx2Tjw
         KL4afkNfgIJ5UNrBAeLYJPfcXs6Do0/D8sMkGoD+FmJeqOAyF5GXujgXozJB1LUbKL5w
         TaelCB+22claI+p49lTQ6Fj8AS70Nl0M7LcGktl58xhUmYkCKF0tQIkhU3jLgyiOa5MI
         HUrjvzQRldi1Mk3AV/D8PVbVf4LG7swzNrg9xBWwM0TKclX7eQ2u/xYIHJWY4T66y+Hc
         ExsxJNiO7NKFKM4VtSaXpOfQbG6tDlt30LaSV5Cm6HvlzaFCSFasXGGuBlxWcmO+OVGc
         Ey7A==
X-Gm-Message-State: AOJu0Yxlsb80Ewvi+NSzGQd2xmlF5F6/O3Ii3QCgCcYJ4MDCsu3aa0qB
	mwglt8Tedmks6GUEU7hJVGC7qYaNqiTX/XnIuSk=
X-Google-Smtp-Source: AGHT+IGLGLRE8+HJiwEKg6IbGcwU6vL4tFCELsKUyNas1D5AruvTy/9TprUOPfdYdrJLnviG+QvattClGjFMABEPXjM=
X-Received: by 2002:a05:6870:d891:b0:204:1ae1:e538 with SMTP id
 oe17-20020a056870d89100b002041ae1e538mr1393084oac.6.1703248711472; Fri, 22
 Dec 2023 04:38:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Dec 2023 04:38:30 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <f712d5ef5bc5bed423cf50a0d0489095ba103df7.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im> <f712d5ef5bc5bed423cf50a0d0489095ba103df7.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Dec 2023 04:38:30 -0800
Message-ID: <CAOLa=ZR1Bc+Acwjma9OM0SvyLg4-HB-S3Pxr66VCKTb0d_tdnw@mail.gmail.com>
Subject: Re: [PATCH 03/12] refs: refactor logic to look up storage backends
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> +
> +const char *ref_storage_format_to_name(int ref_storage_format)
> +{
> +	const struct ref_storage_be *be = find_ref_storage_backend(ref_storage_format);
> +	if (!be)
> +		return "unknown";
> +	return be->name;
> +}
>

Would it make more sense to return NULL here?

> +
>  /*
>   * How to handle various characters in refnames:
>   * 0: An acceptable character for refs
> @@ -2029,12 +2045,12 @@ static struct ref_store *ref_store_init(struct repository *repo,
>  					const char *gitdir,
>  					unsigned int flags)
>  {
> -	const char *be_name = "files";
> -	struct ref_storage_be *be = find_ref_storage_backend(be_name);
> +	int format = REF_STORAGE_FORMAT_FILES;
> +	const struct ref_storage_be *be = find_ref_storage_backend(format);
>  	struct ref_store *refs;
>
>  	if (!be)
> -		BUG("reference backend %s is unknown", be_name);
> +		BUG("reference backend %s is unknown", ref_storage_format_to_name(format));
>

This doesn't really get us more information, since be == NULL, calling
`ref_storage_format_to_name` will again call `find_ref_storage_backend`,
which will be NULL. I wonder if its better to:

@@ -2029,12 +2045,12 @@ static struct ref_store *ref_store_init(struct
repository *repo,
                     const char *gitdir,
                     unsigned int flags)
  {
 -	const char *be_name = "files";
 -	struct ref_storage_be *be = find_ref_storage_backend(be_name);
 +	int format = REF_STORAGE_FORMAT_FILES;
 +	const struct ref_storage_be *be = find_ref_storage_backend(format);
     struct ref_store *refs;

     if (!be)
 -		BUG("reference backend %s is unknown", be_name);
 +		BUG("reference backend is unknown");
