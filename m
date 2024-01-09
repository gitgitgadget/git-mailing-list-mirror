Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A33D39F
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6808c3938afso24792146d6.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 11:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828940; x=1705433740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw2yCuQD680+zknMxBfz6/k1H9mh+RDLT6uhLXDEDNs=;
        b=PvxRp7GxlYUvufm1Y+LGt/7Q+tB/B17BuMlqLSye6LwlTj6W/A33+agDSLQbKvtgzA
         6+asLxg1IJsP2KkRSjMHsqmuc9C5mmwVJlCxYy6YBFvRoJm4LIGL9Blnhf83tziCLJTm
         HmGTOYdvqkaVyDZnr7MNGjb/xZ6tKhgJZ5vpt6PTTAWzZ+vVasi6ambBVzP04fg1xmqO
         Z6SbA2nByE/Gwt9TSR05CJ/2mv7H2ldE/ybR+Ih8L1a8HqH3K/eft0ynA79dDki4NEeY
         NR+kg6wFbcZiKuwSf3sIlBDSn6KOcAdwqf0M0GQQmbKNIbRVl3jVdlfX2vbu9va+ipe+
         rJUA==
X-Gm-Message-State: AOJu0YzYGDWzGrBgaIS/mUbXAWxgRMfDIHOqSOiWn/+noAxVhXNeNmYk
	P2un1ndMpQiqhMoG1EgL/ZKl1wlqzEiXNjjwt5x4X32n
X-Google-Smtp-Source: AGHT+IGt3KwkB2BU9ILb1CHurzyM3W8P6VGFoZWye0yjtX1HiXDw+4jXyNUf2PQFKLLwzBpzNz2LDjNZRhYt2u7ZRrU=
X-Received: by 2002:a05:6214:5017:b0:67f:592b:d5da with SMTP id
 jo23-20020a056214501700b0067f592bd5damr7164507qvb.11.1704828940147; Tue, 09
 Jan 2024 11:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704802213.git.ps@pks.im> <ec1b5bdd176e6a3f093b76b732fd9e960a7880ca.1704802213.git.ps@pks.im>
In-Reply-To: <ec1b5bdd176e6a3f093b76b732fd9e960a7880ca.1704802213.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 9 Jan 2024 14:35:29 -0500
Message-ID: <CAPig+cRdDSMACzB6mEfwbijLHHSJuQ_Tk8ggNkvFxEd1aSqw2A@mail.gmail.com>
Subject: Re: [PATCH 1/6] t1300: mark tests to require default repo format
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> The t1300 test suite exercises the git-config(1) tool. To do so we
> overwrite ".git/config" to contain custom contents. While this is easy
> enough to do, it may create problems when using a non-default repository
> format because we also overwrite the repository format version as well
> as any potential extensions.
>
> Mark these tests with the DEFAULT_REPO_FORMAT prerequisite to avoid the
> problem. An alternative would be to carry over mandatory config keys
> into the rewritten config file. But the effort does not seem worth it
> given that the system under test is git-config(1), which is at a lower
> level than the repository format.

If I'm understanding correctly, with the approach taken by this patch,
won't we undesirably lose some git-config test coverage if the
file-based backend is ever retired, or if tests specific to it are
ever disabled by default? As such, it seems like the alternative "fix"
you mention above would be preferable to ensure that coverage of
git-config doesn't get diluted.

Or am I misunderstanding something?
