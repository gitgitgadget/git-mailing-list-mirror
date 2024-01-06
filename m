Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FD10787
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67f95d69115so7600706d6.1
        for <git@vger.kernel.org>; Sat, 06 Jan 2024 15:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704583988; x=1705188788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc3+CAIJ5uk3lgdLrax/gQAb4TNQFUWMCbvHYTU7Dp4=;
        b=S00GLbCbvLIRjKjMSAUSWT1vm56GM3uo1erw7R8XwkifG28Q6ayuNOFS6xSGmG/IFJ
         hqcttMd7aoFSasG9R2T7VnBLfZtAP8nf9EU3jztp9qWylRiyulykfW1MYbOjU3429hV1
         A1Me/EIECmB6VrOH3CcQKrQpowhx7FpgWhTg2Y1wQfnOnCfML7h+6QkOlNKUK0ryXNCF
         C2pM3LicWbUFv+9Azpoa/rXZjZboQjl0P6fai87lFs09owFz1bcCzhN9YbCxhudHkKRg
         X79JHRQN2bUf28LwVFG9KEmaxMvBu8UXC9AbvlcXy5r6f6nGQi8dckJ2yleTOqRJoWos
         jATA==
X-Gm-Message-State: AOJu0YyPtpfGkojzSuVoWr0bS5qDa+irfsZZmXu+rwKGA17CBHN2wKV1
	qng9kLgDGp5I/Bq34KB8OTSLWy/tYVtDQwGKeSafX/7K
X-Google-Smtp-Source: AGHT+IE3p0OcSL42RF3dkwAqphKjHjP4kzBRkK11PryBLvdyvgz+544RMUFmi4VkSoM8W+EF3K7ofA7fc4CvisLvdLs=
X-Received: by 2002:a05:6214:20ca:b0:680:98d1:13ad with SMTP id
 10-20020a05621420ca00b0068098d113admr2390308qve.67.1704583988579; Sat, 06 Jan
 2024 15:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa5pjpxm6.fsf@gitster.g> <20240106202352.7253-2-dev@tb6.eu>
In-Reply-To: <20240106202352.7253-2-dev@tb6.eu>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Jan 2024 18:32:57 -0500
Message-ID: <CAPig+cQ3y7rGbrNjMZB_HpMAWYOhDg8qKSoR5EF=T5+jc6rgvA@mail.gmail.com>
Subject: Re: [PATCH v3] fetch: add new config option fetch.all
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 3:25=E2=80=AFPM Tamino Bauknecht <dev@tb6.eu> wrote:
> This commit introduces the new boolean configuration option fetch.all
> which allows to fetch all available remotes by default. The config
> option can be overridden by explicitly specifying a remote or by using
> --no-all.
> The behavior for --all is unchanged and calling git-fetch with --all and
> a remote will still result in an error.
>
> The config option was also added to the config documentation and new
> tests cover the expected behavior.
> Additionally, --no-all was added to the command-line documentation of
> git-fetch.
>
> Signed-off-by: Tamino Bauknecht <dev@tb6.eu>
> ---
> diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
> @@ -209,4 +218,156 @@ test_expect_success 'git fetch --multiple --jobs=3D=
0 picks a default' '
> +create_fetch_all_expect () {
> +       cat >expect <<-\EOF || return 1
> +         ...
> +       EOF
> +}

This is really minor, but the `|| return 1` is superfluous. The `cat`
command itself will exit with success or failure, and since it's the
last command in the function, its return value will be the value
returned by the function. Thus, there is no need to use `|| return 1`
to signal failure when the `cat` command itself will do so anyhow.

For such a minor issue, I would typically say "not worth a reroll",
however, this sort of unnecessary code may confuse future readers into
thinking that something unusual and non-obvious is going on. As such,
it might be worth a reroll after all, but if you do choose to reroll,
wait until others have chimed in since they might have more to add
(either about this or other parts of the patch).
