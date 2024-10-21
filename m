Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69B145FE8
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540066; cv=none; b=KC+TFI4Wb0/VgCr2mwPL5owUiZV8JwRz0tNSIElOGLMEH+7Mk02FDB8N+8aJsOIzfVyWJ4QsqLAl7btJXpcUIAt7xRq71+w+fsvXiCAYUbgDwcMRHDL9uREKhpJGk1qTyoDuDEBf5hLHs/P9e5JesOdN9z0LvjMNQQkgMhsHp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540066; c=relaxed/simple;
	bh=28d8z+X6y49BRk3NhOIIYqj6cNpQrKM1aCHzgLk0zAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoNYIPqmUxs8PXkXxJ0qtlx09E0XMAA827WcxHkHhDp+t2U8pS29kEkkAkEr6XJmTpI+xt9OL63Ulbibd3xYchnkopmSI4t8ly41tS9nDNTpYi+bPa21XIZSrPBZ1+EFrR78AUwUMY6NMmbzSDJ+sCpygVahZw0YCM/EKdBjqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HK4Kjxg/; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HK4Kjxg/"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e330b7752cso41222277b3.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729540064; x=1730144864; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=28d8z+X6y49BRk3NhOIIYqj6cNpQrKM1aCHzgLk0zAc=;
        b=HK4Kjxg/jbUpQnCvUUDda15dsyPNYcLuANUESL+XzFkrvZXhehAtQIQeeFaELv1lIP
         v3pzGHewOq34GjPV/LhKVULqygcDkVv5nhAdr9sJDZPlrYHqkaG7ryGhb/ARsI3QSijU
         Bl6nZkUUM37gyB1osm6DS8eGvJCoMqnEu9TaDhoEJpzi+dhfN+kKVrXpVnjoNZNQNuwQ
         vtnKXHOytWnMCJJbPSHUhXfFJyh44YoXwlE1m0rFa9YfVDYwHQWLa/a5hE1T4nl1VyNp
         10CoUYrAwU7QvK8jlm/H+V31uKG6NN0kx6N0efqOlf84oLj4hk4wmFb9f1HezBH/NN9y
         WApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540064; x=1730144864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28d8z+X6y49BRk3NhOIIYqj6cNpQrKM1aCHzgLk0zAc=;
        b=e4x3wEtTp6J9/eGmWgy7zPeHjAag+v3u/ltoD8t8Kf8wDeEQzsdRQ2hQbG3FgLJBiw
         0NcnbzuvEV2Erc8aymt5EHgRkaeoYfNBle5FCB6BbjGJwZKBzN3S3aiBXAEXkiWXvc7y
         Wydb3v1EkUvNHU0yvMV2ZJMeCEAWLHoZINxqW2NN8ncRTkq2sgVXvX22TICrJzcrDBOa
         IfddkV5YubgnAihMTHz8KgCE5KtydwyOE1cwn4ChglIrKYhDKf2lf8TN4ZvRSYjOOcgt
         eQeHncuZGElSiu5LaFd+MeNxNTJLv7t2zq6A94jx0P5bEBq1rBRwvTPtAmkUU9viy93t
         ybTA==
X-Forwarded-Encrypted: i=1; AJvYcCVCtoXgHvUK2Ae60KKFurZGrShj5HCagth+RnYEgS15uQOha2N7xt6sCaaZYSwyA4TX2/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrZ7dM5CH+9J2vZ2AlbVkqp+h9ko25tZRSfwUTYV/USsfKCH4
	qX6hKGldukjOqTNDEai+70AnFHtU36SuaPfFo9SHOyQV8UGQAjlaTHea+GOEOFc=
X-Google-Smtp-Source: AGHT+IG9shVEhSUJTM2juhYiONcO3wc39XQUEUIgt0AhlqRhpAqINOs7EBHkrio8eOP4906PnJqR3Q==
X-Received: by 2002:a05:690c:7243:b0:6dd:b8ff:c29c with SMTP id 00721157ae682-6e7d48f7011mr7681457b3.17.1729540063725;
        Mon, 21 Oct 2024 12:47:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d5c702sm7892097b3.133.2024.10.21.12.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:47:43 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:47:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Piotr Szlazak <piotr.szlazak@gmail.com>,
	Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] doc: document how uploadpack.allowAnySHA1InWant
 impact other allow options
Message-ID: <Zxav3sIyupyjTuCi@nand.local>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <pull.1814.v2.git.git.1729355997353.gitgitgadget@gmail.com>
 <72184384-07ff-4f74-91d7-280ca78407b5@gmail.com>
 <fd5fab45-1363-41c8-915a-5578a35d219d@gmail.com>
 <20241021190309.GC1219228@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241021190309.GC1219228@coredump.intra.peff.net>

On Mon, Oct 21, 2024 at 03:03:09PM -0400, Jeff King wrote:
> On Mon, Oct 21, 2024 at 07:55:06AM +0200, Piotr Szlazak wrote:
>
> > On the second look code changes will be needed, as at the moment final
> > result will differ between:
> > [uploadpack]
> >         allowTipSHA1InWant = true
> >         allowReachableSHA1InWant = true
> >         allowAnySHAInWant = false
> >
> > and:
> >
> > [uploadpack]
> >         allowAnySHAInWant = false
> >         allowTipSHA1InWant = true
> >         allowReachableSHA1InWant = true
>
> I'd expect them to differ. The config is read in order with a "last one
> wins" rule. The thing that the documentation should be making clear is
> that the three overlap in what they are affecting, and so "last one" is
> not just a single key, but these three inter-related keys.

Agreed. I think the "last one wins" policy is well understood throughout
Git's rules for how configuration layers are parsed, and not worth
repeating purely for the purposes of this specific piece of the
documentation.

Thanks,
Taylor
