Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3964B5A8
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-680fdf7d52fso25168276d6.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704897416; x=1705502216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALgsbOwt/GsnaC3oWMhuSxMwjZKAILq2XKtjKpkvuPs=;
        b=CfGdtJte5o5owlX1qurHrr4fy7QmLbJ2TQm7avfSk4GhStO8XLI3LjLMMCfC9Nybq9
         ljM3L5bUahHQYZJ5VxDaLdEkt/c2uyDo00yZUboZmQl+HwLdJmawY4Bhhx09l+r320jP
         vPLXjATZh2ucfbUU1Zg3Dn8K4Iic+JBZF8Ga7nd2rbWD9ZTWA9RlDg1PU/ZiKtYPWdZ9
         aNo/N8FdezIKuCkl6CUv1rXQ/SKQppHgLvDvyydcj6WlYFXB1nyicV7WizXJF8tEC//y
         XcFW0OL5foRXcJ04qs8oc06ukM52xBY/LSJ0jHFKVdBsUDdyCQ35vW4x9DiFglmBSb8K
         jWjQ==
X-Gm-Message-State: AOJu0YzTOLwyOM3LMc1KAyvXJC7IjSHaFsYDSwmig53Ew30rJMD+fBqw
	JyQwb+SbpbNmXq4VYNvGAT2req5Yl0UD9YlazF7gQQfk
X-Google-Smtp-Source: AGHT+IHuGbI52MaHZ1n+t9gGDmy6dqAzijDjvo19/lY28i51Eh1Vh25mop5ZgT1vcdmLjoz33sPJnlJHYoo2Yfb9ikE=
X-Received: by 2002:a05:6214:27c2:b0:67f:8682:6d79 with SMTP id
 ge2-20020a05621427c200b0067f86826d79mr1367628qvb.2.1704897416116; Wed, 10 Jan
 2024 06:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110141559.387815-1-toon@iotcl.com> <20240110141559.387815-2-toon@iotcl.com>
In-Reply-To: <20240110141559.387815-2-toon@iotcl.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 10 Jan 2024 09:36:43 -0500
Message-ID: <CAPig+cTRHHJ3pzWJtVJf8rKhvAJFYqrO0JsyTRTi6T5s+gznDg@mail.gmail.com>
Subject: Re: [PATCH 1/1] builtin/show-ref: treat directory directory as
 non-existing in --exists
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 9:19=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
> Recently [1] the option --exists was added to git-show-ref(1). When you
> use this option against a ref that doesn't exist, but it is a parent
> directory of an existing ref, you're getting the following error:
>
>     $ git show-ref --exists refs/heads
>     error: failed to look up reference: Is a directory
>
> This error is confusing to the user. Instead, print the same error as
> when the ref was not found:
>
>     error: reference does not exist
>
> Signed-off-by: Toon Claes <toon@iotcl.com>

It may not be worth a reroll, but I found the explanation you gave in
the cover letter more illuminating than what is written above for
explaining why this change is desirable. In particular, the discussion
of the reftable backend was very helpful.
