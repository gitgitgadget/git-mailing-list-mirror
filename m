Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="RmERHZjy"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298E1AD
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 05:20:01 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cbccd8e35eso1073938b3a.1
        for <git@vger.kernel.org>; Mon, 27 Nov 2023 05:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1701091200; x=1701696000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM2An3uN3A1j8dAgzJRyrF2WDY6eOc5ZXTbj1WcZMmc=;
        b=RmERHZjyfNvNVxe1cn5b8mOah0iRs5lMIsj0yG2pXE/1A7nItpZXW69GPgX3luH24n
         MtuS3FNBAMcGdYis/We/gfgMnPEdO/pUFpNmIo0ugAo1j1DprFga+1MKFrNEfPozl8Ns
         EUWEyqP3LylThRlZ81mEIVmzAe7LzlK76PBPhklSEHgQVP5OPRP/DiZS5EcJMObKc7i7
         B0AIxwElZHE2hr4LV6NZG3+tQ5wkrt6YC6UHCs5ISihsQIGooNF+DqItlk0kmI8kTaEo
         5++EwcujGbdCHt85FI3Wf0Osxhrf49U/oH/hOrrQqpg0kutkjCA3vgfwM314BKqxWCgk
         tCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701091200; x=1701696000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM2An3uN3A1j8dAgzJRyrF2WDY6eOc5ZXTbj1WcZMmc=;
        b=PflznIh/BUenlJ3N/tyQfOn7QzhaMjnUYrgkKxezNPTXOqf1vMtp5MROmd4UtCL1u7
         +cohlHZ0py2+VWXdpgnrYUN9T31nfruR9p/rP3wudxlKY8y88L8WkXZaxdpckgvkIKg4
         xBoXlSw0S6h5zZcjPqmDVpILevrX3pQCA1SvGm3PZvW0kcod9Wn+iYRnCrJUDffBR/2r
         7w7JSfbgE2jiyIjiKyqVyiCmGn2B02OFJY0Wh/Q6ZRUAneLgyc/q/tATG6s4HRME1Qkk
         cufczUow7IYjnznfmSV9avuK8tdvd7dMZKkd0K5Vcb+2rUASnBuuNFVf6I166Yss5hgR
         o8kQ==
X-Gm-Message-State: AOJu0YxUikdT1t6UKYVPrUB0zuVgZf5PoxTxjXEDCmyhC7eWEG71kopM
	TEa1WrofI6wUVkJYJH+VyOQ4c3gW6djHjPMf/6xTYw==
X-Google-Smtp-Source: AGHT+IGAP3vxGSWf313EjpxzZzoTkIebNUu1aGRGzRHJHcj97SI/Yn5Fx9SkEVdS/jdS7IwOiehOd4S609RQoGJUhxg=
X-Received: by 2002:a17:90b:358f:b0:285:59aa:fceb with SMTP id
 mm15-20020a17090b358f00b0028559aafcebmr11283797pjb.4.1701091200503; Mon, 27
 Nov 2023 05:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113212243.1495815-1-jonathantanmy@google.com>
 <xmqqv8a515ge.fsf@gitster.g> <CAGE_+C7h6HOh+ptdhwJ3MNn5HWFoc1WF-foLRrew6FJEo_yupg@mail.gmail.com>
In-Reply-To: <CAGE_+C7h6HOh+ptdhwJ3MNn5HWFoc1WF-foLRrew6FJEo_yupg@mail.gmail.com>
From: =?UTF-8?B?SmnFmcOtIEhydcWha2E=?= <jirka@fud.cz>
Date: Mon, 27 Nov 2023 14:19:52 +0100
Message-ID: <CAGE_+C5u9H8m5faK1vXKk6QTyjcHgKHqxOZy5ptzsYbF_0yrCQ@mail.gmail.com>
Subject: Re: [PATCH] remote-curl: avoid hang if curl asks for more data after eof
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have discussed this with Daniel Stenberg himself in this thread:
https://curl.se/mail/lib-2023-11/0017.html

The summary is:

- It was never intended/expected that CURLOPT_READFUNCTION would be called
  more after already returning EOF once. libcurl has been modified to never
  do this anymore (in master, to be released in what comes after 8.4.0).

- The problem has been tracked down to a particular case that could reprodu=
ce
  only if using HTTP/2 and only in cURL versions 7.84.0 =E2=80=93 8.1.2 (in=
clusive,
  roughly between June 2022 and July 2023). The same misbehavior is still
  technically possible in newer versions, but not happening in practice.

Therefore, I believe nothing strongly _needs_ to be done on the Git side.
