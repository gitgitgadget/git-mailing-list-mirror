Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA281179AE
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFRX6knG"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2041064831bso1231219fac.3
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 04:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703247789; x=1703852589; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifKA5ZuLqUHAIJfJezwN5uT5CNVFdEwH930S3ByJNV4=;
        b=iFRX6knGLrTwtzcJ1DV0+ngXybQ2g9TIgG+P/W4QAK0NhFWYTQBaxaWSX9overCaRL
         Zf5nDZuMA+gPnQxB6gamx822fhUh4AtUGZGLiqS3AquQEiYdQgAwAfVUMxC/ChCY2IhW
         owCArXOig5KzfgI0Sn620rwEfzn1mzfOM/p9Tz6PDu0QNgXy7QIh1oOwhZe7y9vbg9xg
         acuegGy8flpZYHt6XladBfSydRsIyQshOJZdTw1uCDnzTqzK8Cmwv2hFSbP3MJ07myB3
         QfxKSyQKRLfokgHyAw77O0gbasZqFTr3qTz67IHZ4ciW0S9kHHi9t0SHa9wS6A0iE9e+
         oDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703247789; x=1703852589;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifKA5ZuLqUHAIJfJezwN5uT5CNVFdEwH930S3ByJNV4=;
        b=rayZRFYxCTNqpQ3te5K3f5MtlzzetbDqAlba2ISx8VgoPyCTFcelTKjJUDAdvJTylL
         HeKNDEuQvmkWfZsb+3/3H40h5sXQpV0xiSn4RgmAFLuGkb1ysfkK/KMesScX+Vepw/3s
         q1bVlM+2yP81dPxS/Wb9VFV2SXhSI8RtzXlfq4ymMNbQNv6+JyZt0negZ4+b0b+aR1GJ
         nnRWE0YMH1pUgP+vniDan25boOB6JCJR+Ac68AwqJ3Bx1pm/lhtpuIEarsWyvkg1vmkS
         94h7rxCLTsoqovZUjtTuIDkY5UKSdvsgGZAy9/V4GrvnfofwCHtlT+YOrEYR8orwOVWf
         Ae8Q==
X-Gm-Message-State: AOJu0Ywg+35WSB7wC3HB975c/tp/+PNmhqiZrvXgJUZoVaiQZgpDvNLL
	zL0xQ/4VYnhpSVp4ZdrL7eU2VS2aC1yK+ORlyFqH64fc8Ao=
X-Google-Smtp-Source: AGHT+IEzhHl1qcjnZA65FFAoX5Qd3V8PbMvVbfy6TRvmRW27TV55PDFRKpD55gFWb1IFPcWZtZK/sIUvIJgRuhzA8Dc=
X-Received: by 2002:a05:6870:41d1:b0:203:d297:a711 with SMTP id
 z17-20020a05687041d100b00203d297a711mr1607130oac.66.1703247789576; Fri, 22
 Dec 2023 04:23:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Dec 2023 04:23:08 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <e895091025e6786e0a831e4fb9b092eb74bd4379.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im> <e895091025e6786e0a831e4fb9b092eb74bd4379.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Dec 2023 04:23:08 -0800
Message-ID: <CAOLa=ZTfrgNq5bDqtetBURWOOy0GeyTKGnmRR30yaDs0_-ehzQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] worktree: skip reading HEAD when repairing worktrees
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When calling `git init --separate-git-dir=<new-path>` on a preexisting
> repository, then we move the Git directory of that repository to the new
> path specified by the user. If there are worktrees present in the Git
> repository, we need to repair the worktrees so that their gitlinks point
> to the new location of the repository.
>

Nit: s/then we/we
