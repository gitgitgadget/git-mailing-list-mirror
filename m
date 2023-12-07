Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mXZ6hsNG"
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2C91981
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 12:47:15 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1eb39505ba4so849364fac.0
        for <git@vger.kernel.org>; Thu, 07 Dec 2023 12:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701982034; x=1702586834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RgN8UkU9Mkz7vZvo87b6EPaE4XwulZ5Qsy3NCs4ZU3s=;
        b=mXZ6hsNGegsB3pR6a30grmOabQgewuIgVwD8kmMiYpIDV2TuaLEoQaTmCZVx/WHlRz
         luzWZq64XBnV1EC88xqnjbl/hhJQU6y1yZNFOWEt1csPCCLIZYjsxCmH7+A/72xeQJhb
         JKugMBuSGgJZ+pL+6cJbCD6ha7mCGBe2bVKhsjCjojiOJwa60vvr4EF/3IOqPb0mW8x/
         J81UL2vZduGxCUwM1X7Uv8XfOYME07V1tlL93K5rCOnFJ9pc4UFbvIKl9j4EejfmP0D+
         aRS/Dz8k3goCCzhsAY9n8rfVLfF1xNU5sSQC4MCyrBXNjQh/rLuSnCiIFOaZj1fa7OP+
         GfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701982034; x=1702586834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgN8UkU9Mkz7vZvo87b6EPaE4XwulZ5Qsy3NCs4ZU3s=;
        b=szzVxOUwrwiqN1F+o7ucgKzeaBSRjMCLZM/GOd5PD6/6SSJksS6VLO55+9DiJ6h6GD
         aEvK4hwAFX6s+qijXMX9zZ3HXSdPrszcEupKI0VlFOiJRHEZPUiPjhrCfSAJbidp3SNS
         absB+gviq9xUYb0TOsyPro3XxSqYn1dEzdGmN1gjE+VWCZCA2cEkBk4Re+xdGaiAZcTO
         v+L4/U0PXT019iTG1u/r3p6urVzkXF2fPFeLMMiipx4MBaL921wKhKb+sPzhN94VA/vO
         1QhkTmGIYr5sGzgzUre02ERq0XnCTmkBcodHg2gRJ5MMJJd2UykMQQUoqNWc+U93LShG
         fzug==
X-Gm-Message-State: AOJu0YzCIWOpq9YFxDHeHRFIskafnHP3Aoc+dCsXMsho+bdEFDUOBbFi
	t9gFYzO4sRHWVc71ydSmwmZFrw==
X-Google-Smtp-Source: AGHT+IFNCFI9lyYUSW7f3timBC0xllKj+B8sdiKVqSJ4jTCBut+abWHQ+UP+dpBwZZVEu789Ze/yXQ==
X-Received: by 2002:a05:6870:7027:b0:1fa:dfd7:dc38 with SMTP id u39-20020a056870702700b001fadfd7dc38mr3557921oae.41.1701982034397;
        Thu, 07 Dec 2023 12:47:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w7-20020a0cfc47000000b0067a55852c8esm189887qvp.104.2023.12.07.12.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:47:14 -0800 (PST)
Date: Thu, 7 Dec 2023 15:47:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/24] pack-objects: prepare `write_reused_pack()` for
 multi-pack reuse
Message-ID: <ZXIvUfRaXUxB+m7w@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <67a8196978244b56d4f60861f140b78c59d15e30.1701198172.git.me@ttaylorr.com>
 <ZXHE-cLrP7iRHWHY@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXHE-cLrP7iRHWHY@tanuki>

On Thu, Dec 07, 2023 at 02:13:29PM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 28, 2023 at 02:08:37PM -0500, Taylor Blau wrote:
> > The function `write_reused_pack()` within `builtin/pack-objects.c` is
> > responsible for performing pack-reuse on a single pack, and has two main
> > functions:
> >
> >   - it dispatches a call to `write_reused_pack_verbatim()` to see if we
> >     can reuse portions of the packfile in whole-word chunks
> >
> >   - for any remaining objects (that is, any objects that appear after
> >     the first "gap" in the bitmap), call write_reused_pack_one() on that
> >     object to record it for reuse.
> >
> > Prepare this function for multi-pack reuse by removing the assumption
> > that the bit position corresponding to the first object being reused
> > from a given pack may not be at bit position zero.
>
> Is this double-negation intended? We remove the assumption that we start
> reading at position zero, but the paragraph here states that we remove
> the assumption that we do _not_ start at bit zero.

Oops, great catch. I'll s/may not/must in the last paragraph to clarify.

> I'll stop reviewing here and will come back to this series somewhen next
> week.

Thanks as usual for your review -- I appreciate you digging through this
rather dense series.

Thanks,
Taylor
