Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C117F8
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="nb+a5hTV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703618341; x=1704223141; i=johannes.schindelin@gmx.de;
	bh=6hETFZnP1ZjoUYi3QJLYw8xR7z1WpHhgwSLLzKU/2iU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=nb+a5hTV8hmdSpncNrz55MD7CiPcAp9PBUbpVX4bHI66meWiVgHlQop8tHLK2/Ju
	 2LJGIkRR/PZ3C7/Yn/MZyGPiTVce+BpzabJViD/gYu9Jfm/G8gUbPJ5G4HHx0mLwp
	 0FOmG9opdigVEUiZQv57ED4s0YnC2qtzES9gGIRy0Z1xw7vB8TzfDRXICjIDjVQUO
	 V+jNP3XTgG28VMV0xyBmWCHrBPKlcwoSia0HNJ/z5AuS/1SkiyRDrEkc/eph2WvLs
	 2Tpiv2ihlIgDp82uQpjZMikUfJpuxw2YF1o+NKjy6537/58ZCBB7R6RIGoeBnxuv9
	 35oaKq/sLa50a31htA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([92.157.3.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9yc-1rZK8F0ipu-00IGdK; Tue, 26
 Dec 2023 20:19:01 +0100
Date: Tue, 26 Dec 2023 20:18:58 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
    Chandra Pratap <chandrapratap376@gmail.com>, 
    Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v3] Teach git apply to respect core.fileMode settings
In-Reply-To: <xmqq4jg4j28z.fsf@gitster.g>
Message-ID: <fb022e3c-adb5-e341-9fd0-9c5311abe908@gmx.de>
References: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com> <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com> <82dadb69-5016-dec6-3699-4d994ea7929d@gmx.de> <xmqq4jg4j28z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F7Vp9IJdppGW1/Ada1OOe+4fcHdCu4l0/GyV3ZXVzmtoCGLC85v
 rldmLX7CIq6r2Af6aU2rbpd9xvdnnmrE+95jV6XKehrOhcqTfZyg/dYNWxIsh04y47rVoVA
 EIp437CywFMoysaghc9IBvrBlEOAbeh41DTEpZgOYMO4kexP+Iw5fL3l5mDGysAewG8Vwi9
 WEPHXcN5q5BeNWfu5egDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+cKnTV1V7+Q=;wOit8vQKEj8NTLS7pC9H8k7bcKg
 L45zNx/nXX3n25JgZdHPTkEZpDwXMYd14rYthK5iyuKHIforu7NJfCjxO60UiwZ+XCn+MyKP6
 oEikJFFCdHUWSyOGHRtvSB8vmatSciS6JabMItF4A99k8/AtGv2D3ArdAvDotv69tMZsQ/+jA
 mMINq6zomzN82XFBrSoC9Fm5DwnLxLmziUmnYQTIdqjVUIbqGMIQklMyO2jmiZ4MLYlyvLY7b
 T1ptXTfy/uZL4OaFlQVEgNfX5lgvS0M6thLvrbnTna0UTgv+COdzgJcveBG2TaGclYnnJyzva
 tzAPtS8r4aD7tSj14Ua6aSFnFbL+o7Qwfnb/ZOKNmWks8CtcDOI5hYbLomqowuq+kcEp6nhdk
 H4dPYaEZSNtsK8zMW0UbWcLo+bKZ2hZcqept/lCh2UVYLaTJzVQZUMw1+vYLzQbNjaXf6Tq1H
 nOAmPDOQHm1cJjMQg0uCVcwHkRGdDJLDHh4/988sVP20BegaFsk2KMERJ1qn7AjdmYP0hU6fL
 wnZOLWq4CTlVTDPcaVgSZnPa2Jyp0uGRq0zFqCX7ue/0iJYch7+U0Z6Zmf7lXzUPt/CScq0Fx
 O/xqh812IuPIn05Ujokutlt/bLouXx58fHFQlJqMJZcENfJlZevR7/TDn4A9gBOl3fTdZz0qZ
 FXumKwG5Ob++xn44U4hG5xtJJiA9sAPbdjTDm4HWMQfjm+mb9QQgQIxaKASMSYRhzzDUxkNvg
 wKKEulEc57wBnQiqOC/A+S3BjI380SA9MJrOjnn3Uy8HI69fQCQjXilVdovzjtzZFR1fSaxkv
 RIuw5oJTjZ/ZnV2g2sB6EjPfdlL9xuCjvZqpAKr+7c1ed6Lc4dyLyxFKsBT859yW8SysaUGD/
 WStSzzcHcLiWlYsXr+aRYUaNaq3urdyFyN2ExMFAy7wCsY/o6fFVfAKb5O/R2+dNnhUJQLmJY
 Xe5j8Q==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 26 Dec 2023, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > While at it, add some defensive code to ignore `ce_mode` should it be =
0.
>
> Is it defensive or is it hiding a problematic index under the rug?

I wrote this defensive code only out of habit, not because I saw a
`ce_mode` that was 0.

> If there is an index entry whose ce_mode is 0, I suspect we would
> want to error out with a BUG(), unless it is an intent-to-add entry.
>
> Shouldn't it cause an error to apply a patch that mucks with
> "newfile" after you did
>
> 	$ git add -N newfile
>
> If we allow ce_mode=3D=3D0 to be propagated to st_mode, I suspect we
> will catch such a case with the "mode is different" warning code, at
> least.

Is `ce_mode =3D=3D 0` an indicator of a new file? In my tests, `git add -N=
`
will add the file with a non-zero mode...

Ciao,
Johannes
