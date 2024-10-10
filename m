Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE441E5715
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584711; cv=none; b=f4SB8pa05LlXk1OhRm6T4fWigIovGbqV2Ch0UOyCon8nujkRJd1IY+6IJqeCo0WmNmJ46MiPxR2pU0bI64uYlKv+WGVf866+SfBnE/zFlSGjH1ADYO6wwfr2pyTcLlLMhbSkwQnI8hOlnUmNNcYWHWz1iHNOD0sgHyVe+wGP8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584711; c=relaxed/simple;
	bh=o6ZPWqlABq3gpG40Gqq1IIaDfsH7GPj7V1HZ2TmPLuc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Q2XuG38ogetn8vdkoUN+VYjhoPusSfIMZIMMamdZPr2rUQeFAKYPyRYRRI8Z34FOl2ovuEz+OVXgEr8lvwAW+A7LIJb9vuvZ++0qKo7jbGaHzMlSrsGQGE5QrUZ6hdxjJtrlbARBO5EyE5p4YsaBkH7CRcU2BIC642QOf9aMMPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e29047bec8fso1563359276.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 11:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584708; x=1729189508;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5Ke9bh4kf4xLxxHeF6Yp6HYE/sPF4xYd+xcZH/M8NQ=;
        b=ZSCi3UTNmgEIEcgY1H6v9sv69rS4zbqLXa2iYNoOOYsZW2qpzvulvKSn7GBnXhiuWr
         xh9fGuZaSEfKB36+ufkblWzoKANTThCTZ0DylBPu16ErfwtpXghp3Svou4/q2kFXjRwC
         cIIJpV912GkcghTsh0wQJ/CtPmZ1fQk59alF46XX5sB/MGXoMTs7Yu0XbOiPp4FpWnqh
         0Sdbxhs9g/6hztBkSIKUHE59qZYtUkff1FDxjFo0EhRnvcjChR1kWbGdrjh3VCj5uwlS
         613k/12jXQNgv/+kQajh386lwl9wpW51pN0Q/wVeD/AzhjGTdrgf75yH4KTjqZUt/0b8
         w+Xg==
X-Gm-Message-State: AOJu0YxT+gCX9bH3/QSBMiR9x4cbo9fdRVcqnzwyS16E8MKr/Fpjvc9G
	XPKGmUTN+a9BjOjtYHd0ckUzh1wSuoFwGXU3yKg5oWZ2rf1Ee1E+vmSnUryoGyuboFd8S6HQAHN
	4gYibfSyjHgnvk6Nxe7MJbjxlg6OpB0YVVM0=
X-Google-Smtp-Source: AGHT+IHMa5jFZd9y1EDcpDfj1FfTQVqfEsTW3Z7KpNX+VEN2VtCaV6u9WUA301OvSds8743tI8tYvnfwYgSyN2PX0wg=
X-Received: by 2002:a05:6902:2311:b0:e1c:fa56:9b79 with SMTP id
 3f1490d57ef6-e29183513d9mr98807276.7.1728584708348; Thu, 10 Oct 2024 11:25:08
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date: Thu, 10 Oct 2024 14:24:52 -0400
Message-ID: <CAOO-Oz0NUA-YeyFT1MJ=XKyLWJvQoFH1b-F0EFOzvy8iWka3KA@mail.gmail.com>
Subject: minimum curl version effectively changed
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As of ad9bb6dfe6e598d87ffe6e2285b4b86dac3bc726, http.c depends on
symbols introduced curl 7.37.0, which is newer than the documented
minimum version of 7.21.3 in INSTALL.

```
In file included from /usr/include/curl/curl.h:2238:0,
                 from git-curl-compat.h:3,
                 from http.c:4:
http.c: In function =E2=80=98set_proxyauth_name_password=E2=80=99:
http.c:655:28: error: =E2=80=98CURLOPT_PROXYHEADER=E2=80=99 undeclared (fir=
st use in
this function)
   curl_easy_setopt(result, CURLOPT_PROXYHEADER,
                            ^
http.c:655:28: note: each undeclared identifier is reported only once
for each function it appears in
make: *** [http.o] Error 1
```

-Alejandro
