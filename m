Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE263A3
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-67f3f602bd5so5176566d6.3
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 17:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702861371; x=1703466171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4qLVJ0ouPESBqUj62Gwd9fVoTpX04I0PU/Fx4YJukg=;
        b=Z1PRHj9xA8ZIC1UDiCHGk7cZe4f8X+EgNtgUPTXXgeG902aBdW788t87eZ0iL5qBmY
         UTXY8FdBmNIpV2xrE7Ls7XXFx+82+ZLNWV0BW/paCzcVTkUd8+7Zediq0jMJqlYJeLek
         nQAS/ngtCXzzA2tQlRh3by/TYi7VooUc6Bpj0dmPbqlb4MZD4GuyGkIWbE4ULcRSt+uK
         ry+cVSIBdxywCm1NCwdAPG6meAmdWj5sprdq7BWbi8AR9aQBVRtNPw2RRyeSBF6OcY0P
         3R2wPlscOHR+vSiJWTEc1zMuyUxy+++cE7JiOfE9QYDKsme+1iniIiI18+rPTgCb9IO5
         vH8A==
X-Gm-Message-State: AOJu0Yx5TMAUofNdoWIeCnYjGZ5Rqxm9zYT9SIMxMfH8v1nPUVlPN1QM
	GyXrMxyFncbFZslYrRR4MF4byVBUIUpA4JiwdLmYVhthafg=
X-Google-Smtp-Source: AGHT+IGfFwTeVpaU4xPGRp7xnF38woaaKERoyKjPCRsQSopnnKMRNIrTo4m9ITjc/y1c4LDqFXDyPR/8S7gtE+6W628=
X-Received: by 2002:ad4:5aeb:0:b0:67f:763:1480 with SMTP id
 c11-20020ad45aeb000000b0067f07631480mr13915366qvh.51.1702861370782; Sun, 17
 Dec 2023 17:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR12MB604488A775E3390E9B7E56BEB891A@IA1PR12MB6044.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB604488A775E3390E9B7E56BEB891A@IA1PR12MB6044.namprd12.prod.outlook.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 17 Dec 2023 20:02:39 -0500
Message-ID: <CAPig+cTEmiQzD7D7qEKDsyGf+08AtNQzy=GfPZDrRtM2ytKnUw@mail.gmail.com>
Subject: Re: Unable to install git-2.43.0 from source on macOS Big Sur 11.7.10
To: Jonathan Abrams <jonathansabrams@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 5:54=E2=80=AFPM Jonathan Abrams
<jonathansabrams@outlook.com> wrote:
> I am trying to install git-2.43.0 from source on macOS Big Sur 11.7.10.  =
I have Xcode 13.2.1 installed.  I have read https://github.com/git/git/blob=
/master/INSTALL.
>
> The command that will not complete successfully is sudo make all doc.  Th=
e Terminal output before the error is as follows.

What steps did you take to build the project? Did you simply use `make
all` alone, or did you run `configure` first? Generally speaking,
running `configure` should be unnecessary on most platforms.

> Undefined symbols for architecture x86_64:
>   "_libiconv", referenced from:
>       _precompose_utf8_readdir in libgit.a(precompose_utf8.o)
>       _reencode_string_iconv in libgit.a(utf8.o)

It looks like it's not linking against `libiconv`. Aside from
answering the above question (and reporting the contents of
"config.mak.autogen" if you did run `configure`), you can also run
make as:

    make V=3D1 all

to see the actual command it's running at the point of failure. If you
paste that command, then we can find out whether or not it's trying to
link against `libiconv`.
