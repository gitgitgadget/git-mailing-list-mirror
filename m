Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDA3D3AB
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd3b34a58dso793879b6e.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 11:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704829261; x=1705434061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7PDAS8e8FXKn+ufDc0ld1cSRc0B2KUHnkKwdbM5nnU=;
        b=gc3l6jL34lVasYWgVJffXFxnHryJrivnXen+s/DFLHFbk1KpWuRFZaZqN1ICCBZtzz
         pK/QxV5QDEFLmmk4Utsptuh0uO7g303GmWpACaT+dHTGLfKwpMdN5DQnjfVF9XGN8cZm
         IhrnNGcQEDTLSPcmg+am3MVL5nNl1MIaO+GgpB31JosGswSHVMeNupmnS5HabGpftAvj
         8yW0rZ9BkEJOMuoTKNMzDCpgIwbQmgiAjN2yXsGDlAMoEMxCx8fQzaMuDMRCdRYpF60d
         EPAJRk4uW5+0HErYlR0rrRF57bJjcFBj/BD9lxJCezQi7slSKSdb86Efsge3MCJrm5a5
         k/eg==
X-Gm-Message-State: AOJu0YzRBImvEa50BYnz2yxfXMJSB7k78KAeUSSdO7I6E/jIUOmt5bSu
	vcyH9rtiSUdAfQegNL3rULBoJBfHHJvHPM7o2ivszEd2+iw=
X-Google-Smtp-Source: AGHT+IG4dT4YxTY7cf5kdFgWDJMr8XNfP3MZ5A2KtXWz8PBZzdr8CPjwabzgsKFzx+TF0JSnOuz8I51P4jxfx98OapY=
X-Received: by 2002:a05:6808:1415:b0:3bb:cd41:9c78 with SMTP id
 w21-20020a056808141500b003bbcd419c78mr6758306oiv.60.1704829261499; Tue, 09
 Jan 2024 11:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704802213.git.ps@pks.im> <d7c6b8b2a7b3b4d776f06ce577bdbdbaff66f225.1704802213.git.ps@pks.im>
In-Reply-To: <d7c6b8b2a7b3b4d776f06ce577bdbdbaff66f225.1704802213.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 9 Jan 2024 14:40:50 -0500
Message-ID: <CAPig+cTAiEFu9p1nRe9LC3mxyPmfQ9m4r7aQUj_9OC8pSbwbig@mail.gmail.com>
Subject: Re: [PATCH 4/6] t1419: mark test suite as files-backend specific
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> With 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
> excluded pattern(s), 2023-07-10) we have implemented logic to handle
> excluded refs more efficiently in the "packed" ref backend. This logic
> allows us to skip emitting refs completely which we know to not be of
> any interest to the caller, which can avoid quite some allocaitons and
> object lookups.

s/allocaitons/allocations/

> This was wired up via a new `exclude_patterns` parameter passed to the
> backend's ref iterator. The backend only needs to handle them on a best
> effort basis though, and in fact we only handle it for the "packed-refs"
> file, but not for loose references. Consequentially, all callers must
> still filter emitted refs with those exclude patterns.

s/Consequentially/Consequently/

> The result is that handling exclude patterns is completely optional in
> the ref backend, and any future backends may or may not implement it.
> Let's thus mark the test for t1419 to depend on the REFFILES prereq.

This change seems to be abusing the meaning of the REFFILES
prerequisite. Instead the above description argues for introduction of
a new prerequisite which indicates whether or not the backend honors
the exclude patterns. Or, am I misunderstanding this?
