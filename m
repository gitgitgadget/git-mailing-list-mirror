Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C051C2420
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148237; cv=none; b=syaxze5F03Bqdy0m1bfSAyhxThgGoVtjXcsduJsNtiIn6b4CBlZZssjpZmhc5n1TbY1KEmtJfgcIxdkG+vfsoUE/w7c6Lazdgi8EuFhj8BMN0clrvx2Rpg7QBDoV8bvPT8tz+GP2avpufIq5JNwYNqlHITx6HKMzd6JlX9tjofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148237; c=relaxed/simple;
	bh=SoWmKE9Etk1pm9aAMe89C14n1JzztfUInN9vWK5s3ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asTBGILJYDT09+U5ouGA8KpPI4Uq1YDmEPioWQ03pjJHG6mt85khrcDyQ+z2aBNWmHXxqoyyafaYhmoGZSKJrYoN7v01Fd/sjg8eYE2NL7bqvirCGD5XD60324CDSzGiYzgYhWC/SUhF2MDTTIm1FFV1nA26iTSOvExvxrzA+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b13e266047so12674885a.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 23:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148234; x=1729753034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoWmKE9Etk1pm9aAMe89C14n1JzztfUInN9vWK5s3ao=;
        b=nnH64S/BTMe9RvMzP2r1Yv54n639fK1L3kC0/QcYfTDoVylpY3/gUVF4Z0RW6YAkt/
         tjsIVvDByzl5Tmo1J1HnjPhHZsRzNOhOse43Lqjrc+ltnXhYp6Wmf6hk0I/fpgq2P5pV
         VlI+TcMbUcaNP9dF7AUDJq6O1q96VqX2g0IKKQgPbLFPyloEyI49h4T90Cl7Pl66Wf4f
         +PTVRX2uaJ88HXxAcEffal4MES6IRenbv9bqPtX4KZr4m4uZM+Pr7Q2+mWuPdZs51JEA
         cEuYwDKeNXB2ckIluIgwNW59XuizXTKvgva++RoSxa0LVfIZnsY07lJpLPiFnn2cInoU
         BkGg==
X-Gm-Message-State: AOJu0YyooJ+kkbTN8cLEQRCfFEilCIFKd1sy5s3YpWYWpQhuEOQyQZG2
	3HADYgfaDpDSQQ0gb4hI8YJeum67Zcpe7YOo5g02TwgaZcyLdQSwJZ4+PgVVgtdocd+TwyFPomq
	dEemL1OM9SrVwkT5in9FgxTlRinA=
X-Google-Smtp-Source: AGHT+IHixTlLGU8KX4jkNDuNkXlTVNTR63NrIcVBDcejXVtWG1GNi+dnF0e9/HHZVO8eTAh2cM1sZ27UwiUSngSF1Mg=
X-Received: by 2002:a05:6214:20a3:b0:6cc:2295:8724 with SMTP id
 6a1803df08f44-6cc379b48d0mr15094946d6.5.1729148233971; Wed, 16 Oct 2024
 23:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGGBzXLN6eFZmgEE=KBp9vbcgYGGEbDJDUrfyVeYjuCrRiYcXA@mail.gmail.com>
In-Reply-To: <CAGGBzXLN6eFZmgEE=KBp9vbcgYGGEbDJDUrfyVeYjuCrRiYcXA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 17 Oct 2024 02:57:02 -0400
Message-ID: <CAPig+cTNUNCftpr28F6USxVDm-2UZt+x9NxHJ+zbX3Daf5thBg@mail.gmail.com>
Subject: Re: Unitialised pointer free in is_crontab_available
To: Dima Tisnek <dimaqq@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:48=E2=80=AFAM Dima Tisnek <dimaqq@gmail.com> wrot=
e:
> This code will try to `free(cmd)` even if get_schedule_cmd returned 0,
> when it's safe to assume that &cmd was not allocated.
>
> If I read this right, as long as the special env var is not set, this
> function returns 0 and does not populate *out.
>
> Reproduce:
> run `git maintenance start` on a mac in some git repo

Does [1] resolve the problem for you?

[1]: https://lore.kernel.org/git/a5b1433abfd84cb627efc17f52e0d644ee207bb0.1=
728538282.git.ps@pks.im/
