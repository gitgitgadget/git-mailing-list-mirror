Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2D20CCDF
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524263; cv=none; b=TlzyBGPaGuDXIh5HC7f6yfw62sNz/1vI0KYL3/oV//owHMEqRH30TXBZa1Cur8EFUKVl0E/RhtthMZ8obZec0/ZlyeO0Bxm2xlABN81RymQKFyaT0Tu65s4mkTScKOzC3+auq8+B/7n1hEFM8FcaNepC3HVKFsM4SmIEKM8h4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524263; c=relaxed/simple;
	bh=wV1SFyZ3e9XWhH0PT+6SODQatd8mwAsn7SHQR4f5IgY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GM/FUo5h6spUDVsKkhpSTHqT6/y8xd+z1GH8DOWPn8AiDzfNBFH9d3sUcjWdCxMH53N6OGWqif2jF358Hp66CAO3zeCPxrZctSnSTdbiVW94JsJhFOOQrJZ+NXOQzBNtxirra2U4uGeFOd7j3dcQxd5RBfhE0OxPsJFQq1UcZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Sga2luRs; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Sga2luRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743524255; x=1744129055;
	i=johannes.schindelin@gmx.de;
	bh=l3JWHMESDr381JQWKQJVfkUlwjO1tGCLeOKNrGiwq/c=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sga2luRs9dOo0aU/Ds8D6Mdbx1ZbGzRZxiHoUIcu5d2M4+foAhitO2GUVCZlC1Q3
	 OFHY2wL3YfHgXXQQgC5b2Dr0LqVasKbG5OhASG7omaLXY8qqoG5IMHjNRI5HzIFoq
	 uFeb8UXwABF3tKEJGCUpR3IOsR28z/gTie9V2r+ZPRGf7zKwJSaqXpO92o7GAtrY6
	 HcM7b7kd8SrvqMM00y3ObuGNEv0jaFgVvn/Q08GXzB353VWGFw2DAB7cx0IrB1oPW
	 H7D5Ex7G8l3ey31ooAQ9f4gN8ons1fLRwxkOeK9nhzPaH0t4ZaI43NlwBbC6Pvvqy
	 +yl74m9mL6yGNtv9iQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1tUQY52e8M-00cO14; Tue, 01
 Apr 2025 18:17:35 +0200
Date: Tue, 1 Apr 2025 18:17:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
    Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/3] rebase -r: do create merge commit after empty
 resolution
In-Reply-To: <CAPig+cThwsBdumXB3m2ZA-_tmDVTMojkYx7_YxNp49eK6a2HMg@mail.gmail.com>
Message-ID: <417b8ff4-475b-6f00-0753-d3f9e3a528b5@gmx.de>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com> <6c8f77cb71c7e0c820704b1725331f4601d8876e.1743181401.git.gitgitgadget@gmail.com> <CAPig+cS92W_gYuNsaTvQxiP3xBK7Wpg0__uVkgAU1x0OFJUZgQ@mail.gmail.com>
 <CAPig+cThwsBdumXB3m2ZA-_tmDVTMojkYx7_YxNp49eK6a2HMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1324712925-1743524255=:31313"
X-Provags-ID: V03:K1:vu9wwfD4VacBnsRcOrgmSel2ZWm0bdBFKUyqwsSGHFC0BMMD0T3
 IGLYhrB2LOWq4WHvRkO25KUuOZ9Chwx4JeRje8cf49j3/TZo9DYx0mJ2iO8NCdApPW+JCUd
 EdtP1E5YT0OLMc+fK9NIfIeKFwU9oHssIdUOkr/cgZY+9gYZnCblKrZ+obq15FUC6cxzWse
 kc0RCsXft0BGBi3fIQnlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TpLFu2q8Zfo=;7YRwm4WJP6Ecyubvs+IO0m+C5wE
 NewQWHjV04LDbc+Yc1Ey6Iz+Iddv3Cfv+G71S9EG1kSy9FpAEDYOL2FJ7rYG26f41v7IxGWbO
 6ecqIwteNVty/f3yTFlK6Et87Y2Pc4NI5Xh4oZ4X+7iwIGQo9dBesvYFTJT2mGfLAxX8tUF99
 MgmekEl9bSaCNeMhPIXW+jJvyednnC6IRLwJzOPsIeLC5DPby/Ue76CaevtQHJVoGf2sEmUaW
 xQMX0YYTM+QGPYNPmK/1+DlTpgKZQ4zvf3GNSuGaV9cKXxrr7Ka2JkQR7WbVyhb9X2srw6K5J
 Aehi72xE2yU9w2bx/CH8KC5jZf/qK9vIL8nCz0VS3vvyUpdTZ7+UxPf3l3tGnHSt/RGYigEo6
 Sk8ygK69RQzig1KBkAChZ3e3rbIvEOMU2MpqQa49Jwczm6JBL63EaCoUaR+DZ4pkHCF1nJplv
 MUDFJfyLgdCNkOQjlLEL6xrzSMvE6byK4DbIwuqA9M0ItuZ5BLuRXPwH1IaAI+ndGgW7W/X1S
 s9TDffXbY6rk9UnxUpelaJjUyqaDVj8QzFb6YFwR8fyHl73yvj0LinRPjyneELqiQ0m1zkYjh
 UHs6SATCrzSbo8DryOOssN3r1bF2S1IPElKsn/rp46W2VUoYDp06LtPid/dMMfE5fmzWZN4HQ
 ibugYLDz8CGnrE13JHlzX5LDs4lQfdiA4ENe6P+3ul6V7XRB72OlMTHTNWYsLlIxF6a/l7fSq
 SA9QnxY9/xzkHN37o4X6NGtmiC94/nYunQIl8TK4yNM6xnZiz3tfiPSlAf5TtaUY0vrOArQCj
 IPg0wF1Sg1s3q/n91x05r2dp0mY3ICyslF1FF0/C5+GN2AQXOwHZpH96f63lYAQQ6fS2oa+ue
 JzXTWgTZAMXuCIW/8BDYs3SBo9yZO3CZN0Y1N+R3dY0gziZKctSBT64+isZZQtR9rz18m982E
 j/MooRtUZfWLfXI25XjBw+wrw+fawnMGW+OSCOOuTqXVlnFCJK3hQEUjJnP1sNINw+yoT35Ea
 q1Ag15buDvsuggOwG0cS+uaDjx8EeoqeotKJOzaYNrYYynGvWYbXh/yjj0qwlhZj+5dHrp5Kx
 m7GiMIqSB2mTK9n+TtB3HU3EB8U6BVXYzLiwwjuwV966zA/lLxUbIw1iPvLg69DdO2WBrze7a
 D0BWQ4wDBvV051eVzw+pjD5QZbY5H/vNmoSiPvAI3I2mtoJgagp9GNm53suICWM7LRI21AMpb
 YztrLahldr3BRf/40kahUbNykKfpFf5xMOclSBJ9uUZFdy6CU8TdY38IBitsKg6i1oihql6dI
 wTTyAxy1lSevl13/nx19HyISowkXx7m6v4Riw2xFiIPuCbeEXuN9CwqtMljk4X2HAHzwFgP/y
 Dx0bcAuCrwwySbUHs77muF7stbRt9NxxqKknEnsOKCOb3ASxnAghYD3lFAFMfOMZFWjPQauwV
 Mx3CDdyzSxJo+ZQ8c4KREUs5mWm7Bxw+gf0/lbrI1gSibzU8g

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1324712925-1743524255=:31313
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Fri, 28 Mar 2025, Eric Sunshine wrote:

> On Fri, Mar 28, 2025 at 1:14=E2=80=AFPM Eric Sunshine <sunshine@sunshine=
co.com> wrote:
> > On Fri, Mar 28, 2025 at 1:03=E2=80=AFPM Philippe Blain via GitGitGadge=
t
> > <gitgitgadget@gmail.com> wrote:
> > > diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> > > +test_expect_success '--continue creates merge commit after empty re=
solution' '
> > > +       [...]
> > > +       git commit --no-edit &&
> > > +       FAKE_LINES=3D"1 2 3 5 6 7 8 9 10 11" &&
> > > +       export FAKE_LINES &&
> > > +       test_must_fail git rebase -ir main &&
> >
> > I don't think you want to be setting FAKE_LINES like this since doing
> > so will pollute the environment for all tests following this one. You
> > can find existing precedent in this script which demonstrates the
> > correct way to handle this case. Specifically, you'd want:
> >
> >     test_must_fail env FAKE_LINES=3D"1 2 3 5 6 7 8 9 10 11" \
> >         git rebase -ir main &&
>
> To clarify, by "pollute", I mean that it can impact subsequent tests
> which don't take care to override FAKE_LINES as necessary. There
> certainly are test scripts which use the:
>
>     FAKE_LINES=3D... &&
>     export FAKE_LINES &&
>
> form successfully, but such scripts are careful to override/set
> FAKE_LINES in every test. This particular script (t3418), on the other
> hand, does not otherwise employ the form in which the variable is
> exported, so introducing it in a test which is inserted into the
> middle of the script feels dangerous.

The entire `FAKE_LINES` paradigm is broken, and since I suspect that it
was me who introduced it, I apologize.

A much better way to have done this would have been to write the string to
a certain file, say, $(git rev-parse --git-path sequencer.pick-lines), and
in the `fake-editor.sh`:

- test for the existence of that file, and if it exists
  - use its contents
  - delete that file

Ciao,
Johannes

--8323328-1324712925-1743524255=:31313--
