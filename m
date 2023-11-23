Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR+4HJeO"
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3751B2
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 11:08:24 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a98517f3so1541681e87.0
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700766503; x=1701371303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kUe9w5jJalihZhpK0AK+gM/mfJC45KwjYbXpplrWY0=;
        b=CR+4HJeO000MNToS2Fgzs0TBGiWcLHxtmMAjDKwvV3XrrMOfz7k/S7U1Z9L2xkESXj
         BBNb+7KZXYuHuuywge59ERGZyGB8M5TEXK/oV7w39VzKfW9GyALchkT5C423uljoQ024
         1BWPY15JeRwVGGeGixRxFhUDJGE/JWSSEADFfAPPkxjnnTOl5X1ZWggOWmyQwT7OFmNF
         zv0VgqMJR58dFwJNTCQP0pb9hZdHlCWNWarPEvMk1UUDwYWZaHKwObe61l3IonTUYvn6
         RTMaCPiZZ53c4Belu4d6ZDh64HyIc9CJMAKtHR0KgX8UdanZQWt2NnOdmsjf3lVGKVER
         trzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700766503; x=1701371303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kUe9w5jJalihZhpK0AK+gM/mfJC45KwjYbXpplrWY0=;
        b=J1uiZgt6nQNz14oGgmrEWeRemgjsz0zF4hZrfN2hdrqJZeBOnT29iBUsf6WA2AxTtc
         IuyH2vX3SRoqe0yiplfs9pDE+m35w3uBniwTH3ggFwkLQLDRdP0XZQh1n6rwRzsvuLnA
         1bO8KN9T4gGFIKVOL7SBsJKlW5GNe8zUYXL60vXt+NhGtcXE1W84oqvsgDDvmIZYGFJM
         zD7eE/P6vaj+BauovLOIbfASxElUBxopKGQK/bhQz2r6hz6u/0fn0q4kf5uL2e7YeXUV
         V6p+swHxvIJuEcQ2E0kEcVo4/XfzU1P+YJjkw3OcNf9LVhPkGT5TweMTF1SGkiDXtpLO
         NQiA==
X-Gm-Message-State: AOJu0YxUNsP3HRQZTc8CSLYPMPOER9kRA640SfpBlM1PoKklHmbW9kUS
	CoZRM8moCTj4gPwiBqp/OIAKYfHV7PyFErBBIwTqyfv+rGw=
X-Google-Smtp-Source: AGHT+IGJBdtmPcjIzh7ZBsNy4JwPsgIINUCBBjfdoelCescid1C2MeFyIArgZ+CY54jyTWebPHzF27EFmts2UGDSQgA=
X-Received: by 2002:a05:6512:1283:b0:50a:9f35:4fc7 with SMTP id
 u3-20020a056512128300b0050a9f354fc7mr141843lfs.2.1700766502563; Thu, 23 Nov
 2023 11:08:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
In-Reply-To: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Nov 2023 11:08:10 -0800
Message-ID: <CABPp-BHsWRPPdHzvZO+Wp01fB6yqo2fnqYsrSvk6_m932YkoeA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Redact unsafe URLs in the Trace2 output
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:18=E2=80=AFAM Johannes Schindelin via GitGitGadg=
et
<gitgitgadget@gmail.com> wrote:
>
> The Trace2 output can contain secrets when a user issues a Git command wi=
th
> sensitive information in the command-line. A typical (if highly discourag=
ed)
> example is: git clone https://user:password@host.com/.
>
> With this PR, the Trace2 output redacts passwords in such URLs by default=
.
>
> This series also includes a commit to temporarily disable leak checking o=
n
> t0210,t0211 because the tests uncover other unrelated bugs in Git.
>
> These patches were integrated into Microsoft's fork of Git, as
> https://github.com/microsoft/git/pull/616, and have been cooking there ev=
er
> since.

Thanks for making these changes.  Makes me wonder, back when we were
logging trace2 data, if we had some of these leaks.  Eek.

As I commented in patch 2, I think this is a good start, but I'm
curious if others would be willing to turn clone/fetch of such bad
URLs into warnings for now and errors later.  The prevalence of
AI-assist add-ons for various IDEs and the number of developers opting
to use those IDEs and add-ons, and the fact that these tools sometimes
include repository URLs in what they send off to third parties, makes
me wonder if our recent infosec fire drill is soon going to be a
widely shared experience by lots of other companies and individuals.
Training users to not do bad things is hard, and it might be worth
saving them from themselves.  Thoughts?
