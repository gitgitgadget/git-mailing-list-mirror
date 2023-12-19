Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF311700
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5c85e8fdd2dso34256027b3.2
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 23:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702972517; x=1703577317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYyyr4lZWOHdXTmy/k1eN6PII6V80104S9A6lGaVE64=;
        b=KmYFqJERRQPW1N9/D6FzhHgiux9Z1Bi0E9LkMTuCfG2Fb93zU/iPZPcDDKYkEu4Yq8
         1XQ0M4AFl/DpQJ4jU+X5TqG7B8JnByq3p1kiSeO+Q6ZWdElucEMYJNsgSxLZzST/dKE8
         jkSxKohis/5MxQHBMU1X7OUrXytDPEUWJ9XIJqvmzwVhSdvBDhGlha6Yy92C9qdATbHo
         /g7dui21SkdxinA8A+/pJWG5P5IvYc97MvqaT/+GFqjmbszXgBcdmE29sJmih2vPFrNc
         vO+LRI8AnOIdk8aJ+GnCgtF6pSEj91ECWgsXlYK43EC318yW4slfYRzmFm4fH0WmwOI7
         SjBw==
X-Gm-Message-State: AOJu0Yxcdn8ira8PnTcquq6J2eqAddvSQkXD8pSWg60Z63Mh+8Q9RKwE
	EgpfUID5aU3iXmpetzJPU8RE8LuBzSTCIkttg/Sdts+Q
X-Google-Smtp-Source: AGHT+IEJ47m93ZGDG4FI4hARNFFsrBT+X+tzT2yyOLO6bUJ3eJKAKJfIqleLNd+C5eGRljBH18aYHqK5aXhbmrj/4Hk=
X-Received: by 2002:a25:9b08:0:b0:dbc:c592:5a3c with SMTP id
 y8-20020a259b08000000b00dbcc5925a3cmr6966876ybn.2.1702972516656; Mon, 18 Dec
 2023 23:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR12MB604488A775E3390E9B7E56BEB891A@IA1PR12MB6044.namprd12.prod.outlook.com>
 <CAPig+cTEmiQzD7D7qEKDsyGf+08AtNQzy=GfPZDrRtM2ytKnUw@mail.gmail.com> <IA1PR12MB60445F50DD0F844B2B779BA8B890A@IA1PR12MB6044.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB60445F50DD0F844B2B779BA8B890A@IA1PR12MB6044.namprd12.prod.outlook.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 19 Dec 2023 02:55:05 -0500
Message-ID: <CAPig+cQgTNq8rKiXm_dDha+Rz-=Z9O4_gvWLWdcPJe1yp=hQ8Q@mail.gmail.com>
Subject: Re: Unable to install git-2.43.0 from source on macOS Big Sur 11.7.10
To: Jonathan Abrams <jonathansabrams@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:03=E2=80=AFAM Jonathan Abrams
<jonathansabrams@outlook.com> wrote:
> The contents of "config.mak.autogen" are as follows:
> --
> CURL_LDFLAGS=3D-L/Users/jonathana/opt/anaconda3/lib -lcurl
> CHARSET_LIB=3D-liconv

So, 'configure' found a "libiconv". Okay.

> The last output of make V=3D1 all is as follows.
> --
> gcc   -g -O2 -I. -o git-daemon daemon.o common-main.o libgit.a xdiff/lib.=
a reftable/libreftable.a libgit.a -lz  -liconv  -liconv

And it's linking against "libiconv" (the "-iconv" part). Good.

> Undefined symbols for architecture x86_64:
>   "_libiconv", referenced from:
>       _precompose_utf8_readdir in libgit.a(precompose_utf8.o)
>       _reencode_string_iconv in libgit.a(utf8.o)

But it doesn't seem to like your "libiconv" for some reason.

I notice that you seem to have an Anaconda environment active. Do you
know if this "libiconv" happens to reside within the Anaconda
environment? If so, what version is it and from where was it installed
("conda-forge", "anaconda", some other)?

Have you tried deactivating the Anaconda environment ("conda
deactivate") before building Git? Also, I would suggest trying without
even running the configure script at all. So, for instance:

  % cd git
  % conda deactivate
  % make distclean
  % make all
