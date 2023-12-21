Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BD1A591
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3AovlBY"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d7395ab92cso372482b3a.2
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 02:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703154603; x=1703759403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndsWDjdbfYSih2AZVzWoNFmc5LHuGS+TPvf2KH0nsKA=;
        b=d3AovlBYZDcJO3k457tv3Ua4yOhIgyoKJy5gMqvOwM9EnCNtoB1JgFvnf1vJlzjhDR
         OJdr3y+ENLFY4/A4aC59RZMgdar/LPX198kJuWHAVq5uH0qwCVbj/Sr2H8ln1tW0+SuD
         +Rif8NA1a8zKqLUGh7ou9VL/R7ApJwiPpWPC+AmlUZy1aaLPVwQkNd3MgfApxXr20qXX
         IclwU+XoZy2wMKazSMeH69GHjgyNGYRd/J6FFXT0d8MAuLERz7KfZ9f4t0LvnaWS4y+V
         jwazCOTQHPZ7WKdYkjW5vdiUgTvJzlbqmMSWUYX843IbHq/DGN1ULQDW0khMgsx+o8Iu
         CP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703154603; x=1703759403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndsWDjdbfYSih2AZVzWoNFmc5LHuGS+TPvf2KH0nsKA=;
        b=R9xT58hWIuQjcTAnl0bqtmnovgrqG0MsFXgiuikGyJ00PUyOw7uGROYNcBzTNcGQ+R
         3kzKpy3LLdYA+UP7VEfuAEzxYEMXRFi4kInAEtorv9DoyC8dypDep3u+yEthIlS696vi
         6Nti0UmXJ88CCOsdZ21uDM2uFhgSkvFkOLBcghT4jfAMSUa4/c91Eh8EEP9bSqq+5UWa
         5+aDqWjoygDjgopkG81lxlLqLY3ys9VyL3MH/WQrTP/GGrYiH6+esOyqpP+iOpx0GBAT
         GuhbsRN5mbmAKHqVYKG9xph7nkYsZa4/X1se50QXgwjnxH83Q/BTffaHzwiiRefYyAg7
         9ahQ==
X-Gm-Message-State: AOJu0Yx125nqX43ikx8emG1VMcKNH2nWs6ZN30MUe/nUg/nSCxx1eP5/
	gwfcbFc9H538EP6b/FfQe+DREhqJss6ZDhIP9PA=
X-Google-Smtp-Source: AGHT+IHMSEZiQFmFdSZCQ+Oo3wn1rjnJEvUqrVCwG58bIq38Fp5y3IaCmqsYnaHznQHzNROdbXtXII0BhdIcoPao9Ig=
X-Received: by 2002:aa7:8b12:0:b0:6d2:65bd:a16a with SMTP id
 f18-20020aa78b12000000b006d265bda16amr6036596pfd.18.1703154603506; Thu, 21
 Dec 2023 02:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700549493.git.ps@pks.im> <25522b042cdc5986972cc7b62e6b88be0569d3cb.1700549493.git.ps@pks.im>
In-Reply-To: <25522b042cdc5986972cc7b62e6b88be0569d3cb.1700549493.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 21 Dec 2023 11:29:52 +0100
Message-ID: <CAOw_e7Yfdt_Wqm-9XDJknaN-iH=haP0R4K-S4c_E3EFDzvG5aA@mail.gmail.com>
Subject: Re: [PATCH 5/8] reftable/stack: perform auto-compaction with
 transactional interface
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 8:07=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Whenever updating references or reflog entries in the reftable stack, we
> need to add a new table to the stack, thus growing the stack's length by
..

bug is correctly identified, but can't the fix remove the

         if (!st->disable_auto_compact)
                return reftable_stack_auto_compact(st);

fragment from reftable_stack_add? reftable_addition_commit eventually
calls reftable_addition_commit.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
