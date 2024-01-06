Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B81078A
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-680d2ec3459so6722906d6.0
        for <git@vger.kernel.org>; Sat, 06 Jan 2024 15:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704584287; x=1705189087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDS2FfY9c0BfEIJTtpgTG5V6WugUtiCePQ07dO7SL3E=;
        b=fiDIzvxVSq5YgB32PvcRbH9VhoGhgjTZ+8qgTGcikbk+My5qsnDPoqxlvID0jeE8/F
         N98PBX8wjR+y1YCcvTQGqLta/G/dfPuI4z4BDSDMNwws76cJTOxzxpC/+gqkWhnZc6mp
         Dy5n71iGQ38N0d+Yl3deWDqaHiAEc8u5op20SRPfva5Xv4Tq9koeCoQpayKdkjCdFz8a
         XNkBzY6vuUCepR9dl1nqEdrPMrOIziIhMAHJBMAC1kipIqbd0H5BgF5L+XK1EzcfOka9
         S7u9MYckXWbDCyZ70D5f0gvBvotrY5NJsi47SGDS9QuRf6NqrlSMA4sbwl0xWn82/wew
         UtBg==
X-Gm-Message-State: AOJu0YyqA2myFCUKJueGDs7NG/e2gV2PjdWoVstkF8ZoB5bqk9Cs+3FC
	OQrfGx1Dff6/BI/eclZmdljv4Kwap/s+ChaUqLSz4fiAxlM=
X-Google-Smtp-Source: AGHT+IHWhAJySoYZ1hCR/2Zb8LDXn+/hhjNzEC22Krx7gMflD0NSQMTJv/AWYsAaflCY20XsE8wzLMvU+K7jJ9izEYA=
X-Received: by 2002:ad4:5aac:0:b0:680:c1ba:36d7 with SMTP id
 u12-20020ad45aac000000b00680c1ba36d7mr2604070qvg.23.1704584286870; Sat, 06
 Jan 2024 15:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa5pjpxm6.fsf@gitster.g> <20240106202352.7253-2-dev@tb6.eu> <CAPig+cQ3y7rGbrNjMZB_HpMAWYOhDg8qKSoR5EF=T5+jc6rgvA@mail.gmail.com>
In-Reply-To: <CAPig+cQ3y7rGbrNjMZB_HpMAWYOhDg8qKSoR5EF=T5+jc6rgvA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Jan 2024 18:37:56 -0500
Message-ID: <CAPig+cSe5QjbMq6aKqM1=0ZBQFize=WvrNtTnvy6GQ4mYKkn+g@mail.gmail.com>
Subject: Re: [PATCH v3] fetch: add new config option fetch.all
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 6:32=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
> On Sat, Jan 6, 2024 at 3:25=E2=80=AFPM Tamino Bauknecht <dev@tb6.eu> wrot=
e:
> > +create_fetch_all_expect () {
> > +       cat >expect <<-\EOF || return 1
> > +         ...
> > +       EOF
> > +}
>
> This is really minor, but the `|| return 1` is superfluous. The `cat`
> command itself will exit with success or failure, and since it's the
> last command in the function, its return value will be the value
> returned by the function. Thus, there is no need to use `|| return 1`
> to signal failure when the `cat` command itself will do so anyhow.

Just for completeness, the other `|| return 1` in your patch...

> > +       for r in one two three
> > +       do
> > +               git -C "$test_dir" remote add "$r" "../$r" || return 1
> > +       done

... is necessary, thus correct, since shell for-loops don't terminate
automatically when a command in the loop body fails; the loop
continues regardless. Thus, this `|| return 1` ensures that we
correctly abort (signalling a failure) as soon as the error is
discovered.
