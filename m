Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BF157E88
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822429; cv=none; b=dkWWAtF+SWbuND7bP1Unk2b27dr2Rj8l3GKrJrJ/SiaNBG9Rh3WaPn4Y/8CG4u625iUitWqDiBrORfs8GGxBFMT4ruKKBKHO9HXj+Y1EQDsDhmxKmTLrkHOGHAMdzv7UOum0VzJcRUjWqX4gdWCkwqMMFvfFDUYiBREEGRHCQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822429; c=relaxed/simple;
	bh=X+IL8x6qihGhtpPZnGFH6duyC3s3VxhZj5Bx+qu3afw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOAmfnhOdIORMXke3CDrXCpES3TNLwjepfw/jxzRCvyZNT00JYRrdgJOa20sZjADvqdMBvgDdmlBAv6hPingnWY0lefsj5Q3P1xSS1lnuvReUv1K0dpsoWzM/QXCuqssvTO6hRUxQRZAqhl6wo796T6+ZIfyxs2OHOQPizG/El4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b50c3aeb83so720356d6.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 11:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822426; x=1719427226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPmwZgC/WZWIAffHB+xIgEYbxfrjxbwzYBCFS018pNE=;
        b=dJe3oyPjWq5qCg9lZsM/u0hdnG7h4poGq+mkSCCFshQhtOCHdn4lF2wN38KveXYe8X
         p8GsN28iKr20xRkYxljdwXXAY+S7VY1hQLbct12ghEGSxwxvow6EQ+5nwYvjVOX+Kral
         gRXXa+loON1tn4xxZ48qIzvwIjiMEgm7wcGf1wrsTu8STIYh73KG+GzpIzzA0OtH4Wtd
         5a1bVuISvxyrmpdfsvJ+RYGqm6Uk8R/AyyT4I6Vx4MeAA3YAZ7CP6ucSb5yb9IOs+n8R
         OEY1GqUOo8S8KOWApXdM0W0neGTCxnf46dOH+Wm2ERKCtm92ucTZtTbynqTqM1W9d6hd
         z91A==
X-Gm-Message-State: AOJu0YwgCVGAoRQEs4J0mZdiuFLxaGGqb15nE2W5KlbC8tXrKSnUsQZa
	9+1pup2ii29HvXVCHyBiyFnxKiC2EE/s9Rsfz1W+aRe35mvTrCvNitDPtqKBnrlyMZhmWWC904E
	KAlDISyVJ4G/c2kW6o9/hAt95sgfIM3CW
X-Google-Smtp-Source: AGHT+IG5WbBJzv5K6SHJS3Pe6YDEoh7JgQxgHmUxtM6jHsneVfVsiti1pBJRkTGxgprJmviVNCMFtqVHEljBGZyiYZE=
X-Received: by 2002:ad4:58ad:0:b0:6b0:6711:851e with SMTP id
 6a1803df08f44-6b501e05d69mr28542316d6.7.1718822426372; Wed, 19 Jun 2024
 11:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125708.3719150-1-christian.couder@gmail.com> <20240619125708.3719150-2-christian.couder@gmail.com>
In-Reply-To: <20240619125708.3719150-2-christian.couder@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 19 Jun 2024 14:40:15 -0400
Message-ID: <CAPig+cT4PUUH5XCvmioYA-M=bOTed5jM08MpruScOZyvk8VVnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] version: refactor strbuf_sanitize()
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 8:57=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
> The git_user_agent_sanitized() function performs some sanitizing to
> avoid special characters being sent over the line and possibly messing
> up with the protocol or with the parsing on the other side.
>
> Let's extract this sanitizing into a new strbuf_sanitize() function, as
> we will want to reuse it in a following patch.
>
> For now the new strbuf_sanitize() function is still static as it's only
> needed locally.
>
> While at it, let's also make a few small improvements:
>   - use 'size_t' for 'i' instead of 'int',
>   - move the declaration of 'i' inside the 'for ( ... )',
>   - use strbuf_detach() to explicitely detach the string contained by
>     the 'buf' strbuf.

s/explicitely/explicitly/

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
