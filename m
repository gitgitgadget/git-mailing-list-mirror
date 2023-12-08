Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ajYCxMbg"
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415A01995
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 14:24:39 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-42588e94019so21557131cf.0
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 14:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702074278; x=1702679078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rP8/KhYzKIeD4YiX+s0A2/IAFml4yQZY4P0nnydxpXY=;
        b=ajYCxMbg0xCYvUKI252BmMvjyn31C+0KEdRhf0VifXX6NjhHDoKiXtTWBw6r2+BC60
         h8RCI1YJDNas0IhFKXHjjjV2qOudbKxf+N4DyoDc0gveA92Q7o00trq4zOhFfqqEpfxS
         PX/xDN8YTcQ2+1XLvajdYT0ezkDGgZf0dDyHdymnEaASZ7xIrqs+TN1Qg/ZCAPxSY+yi
         ZHoqYpcnAVNKoLhO7l+4GvNeNTeqIUidL8EKZWEZ9Vk0KPY8l3iqzuIg98ddeprRW+OV
         B0AFuI8Is76g4m8qpaujcH9YRTRgSZBJ2ZgF6NBrp7hqE81p+zVrx+woUrtnNl9xlkaG
         dwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074278; x=1702679078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP8/KhYzKIeD4YiX+s0A2/IAFml4yQZY4P0nnydxpXY=;
        b=O7Fob+2++2eUwAgBaXaOxPNY1VEJiT786PqyleF4FrE2KybHODNRHj9Ewb9nAlFBl0
         i8vQtws6tcwOhqMFT5LbopWauOuisBft0sFdXnQ0c6dW8eaAduMJKciYwxoOB0NIEG1z
         o6Vn5tjuUqpUMulLnsDTjASeuFoR+OfOv0BH4zFZKl1prMHr8GOiXXVpSulgtx9gDt+K
         ODyKrVP5WwNJSj+1EGEfdRv8Ne+efbJNin7vAoiY180pYrMiDZKR9kKlmBg8NsOeA9bW
         bMO9Ls8YxmuMjrLT/W1r+GLGsmO7FY90GzCH5KilGGB70J/YlZUDyy0UTBnaHfQiVPk7
         JaMw==
X-Gm-Message-State: AOJu0YzW+icxmzYlfKtXwbL11EUcDP9BaiLxWrC9lNXj1UHykvUrpkiP
	gXNBOoedmGoZezs+kSubn7tq6uv8ilr7cQFuboM=
X-Google-Smtp-Source: AGHT+IFogg6wUnT3Soaw/WNXuKHUQXN5ADB+kdpfU0/hrrWDccj4dYKSptJ3QgBgj0Jh7AGroNRokg==
X-Received: by 2002:a05:622a:307:b0:423:78de:56ba with SMTP id q7-20020a05622a030700b0042378de56bamr1463076qtw.5.1702074278318;
        Fri, 08 Dec 2023 14:24:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r15-20020ac8520f000000b0042542160fd0sm1128595qtn.20.2023.12.08.14.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:24:37 -0800 (PST)
Date: Fri, 8 Dec 2023 17:24:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 07/11] reftable/stack: fix stale lock when dying
Message-ID: <ZXOXpQstse8CdI7J@nand.local>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <e82a68aecd0a1179df3a59755864c71995e979d3.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e82a68aecd0a1179df3a59755864c71995e979d3.1702047081.git.ps@pks.im>

On Fri, Dec 08, 2023 at 03:53:23PM +0100, Patrick Steinhardt wrote:
> When starting a transaction via `reftable_stack_init_addition()`, we
> create a lockfile for the reftable stack itself which we'll write the
> new list of tables to. But if we terminate abnormally e.g. via a call to
> `die()`, then we do not remove the lockfile. Subsequent executions of
> Git which try to modify references will thus fail with an out-of-date
> error.
>
> Fix this bug by registering the lock as a `struct tempfile`, which
> ensures automatic cleanup for us.

Makes sense.

> @@ -475,7 +471,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  		goto done;
>  	}
>  	if (st->config.default_permissions) {
> -		if (chmod(add->lock_file_name.buf, st->config.default_permissions) < 0) {
> +		if (chmod(lock_file_name.buf, st->config.default_permissions) < 0) {

Hmm. Would we want to use add->lock_file->filename.buf here instead? I
don't think that it matters (other than that the lockfile's pathname is
absolute). But it arguably makes it clearer to readers that we're
touching calling chmod() on the lockfile here, and hardens us against
the contents of the temporary strbuf changing.

Thanks,
Taylor
