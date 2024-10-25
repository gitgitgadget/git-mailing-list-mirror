Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4E20BB5B
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890441; cv=none; b=TfZuxLDC1kTvnseonCxMbm8nfZEd7CYGOBmhf0TEYj2VT4KPcv0SB3vnuB6sAikFAfIW33sj3tOQMyEAo6DbzQxR6LwH+1pg04f9YadXQ+uKOJbByUI3gvuIZsplRxZaLGNG2+jaAuwTrxZ0uHtAgZnct5Jir9O4kOruKTv0qgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890441; c=relaxed/simple;
	bh=l8n1oSBUmQrVT+ItO9xgzyMMdnFf2EIwJlOh+jiE+8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XW42q9LyCYS6q9rEbVHTzRsku0yq7Qs8jn+JzqC5s2p9J7UOK7QqqlZxH7kN+56KjRufOAaOER+HOkNOZFYlZkJ4oIAnGGCZ8S4li7mMKC2lv4ZoeM+Sw+cCOELBp1u1ILiSemwrMW0TidkfgYKGP2tBFKMu1skpDHby4lw4N50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=K6m2cYpk; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="K6m2cYpk"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso2510795276.3
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729890438; x=1730495238; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8n1oSBUmQrVT+ItO9xgzyMMdnFf2EIwJlOh+jiE+8c=;
        b=K6m2cYpkL+6lj8x/SIAqltHe7ZqndNWmIYrS7Afz9yQKEKeXGukUdmO9QNDxntbirv
         Cgvoonnp1p1628eqeufUgQMiDsgoUNNJAmx9VU3LuqT56+2zJE+w2FWL7QqhFgZwkmAm
         CJD2jV7bQn7mOKO1Bc+MjMNls1gRV5dxHsgQO5nyVJCB0H3cloPfCmqW7rHmpL8lMjO1
         ryNHWTWVAUsBQ81H5wjMvyv+OLUEfpBjD/qc2yvjjlp7D+lrUboluftWSQ0oQ1yhbxAS
         nD3dACmEyLJtO/hucfZA7H8alcmqW12nsW5DdcFsyhXsj8ODRVKir6dqMsdUUq0tn2kl
         f6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729890438; x=1730495238;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8n1oSBUmQrVT+ItO9xgzyMMdnFf2EIwJlOh+jiE+8c=;
        b=dhaCdnkKkQSIdFGcClH61Wyrvx65YF9FBZd9gfnz0e2jPLrvVq77W2lgPsxD6qS6Bg
         VzYJ8NQYmzkNKvFtupqYUcE0RWY9wY2UhS+DOSgn17u8Y0ygUiMPfkOsQmGn7m6kmg9K
         tiuEQj04G4Sf1VDrUelgswZ7z+mrJWbGotRVTzeH6DB3hHnWtbSCKJSEoxlXpRg1LsCJ
         EUcKXeurzreZMZHJX7dXqq4sRNZYkeUKM4lKxGUz5Q5zpsbwJfys0GJLB80kBFgL0DUD
         Gpe2yAGmucAHK0ZExC9t5Seyn9JCucQPyBPu7LR6yLKrjVaKh61UjQtIOpYzMzld1k7B
         CYcA==
X-Forwarded-Encrypted: i=1; AJvYcCUYCHhBP1sEV+0A1Gr9lVHh3bwRVMUadkQ0slvx3g3B3BVBbmMmoWlF88FEgpl8kZIMu0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVAWSXVI8v/xahBjfkA0LftCVnvSWDE3b3SzbS0xTtigEo9xGS
	X1yIc1KUJw5XkQ8qEGCAIaMowpGIEEAIcLgdTZ8CQs6w0HK3qpuKuf8xsTFVrsA=
X-Google-Smtp-Source: AGHT+IGyRCi8f/FQSS5nB6EMOqjBdNQ/o6Yct6ABPokazwbWH5Dn/z8KCHdFgc25Og1WHOdXYI11jw==
X-Received: by 2002:a05:690c:46c6:b0:6e5:a431:af41 with SMTP id 00721157ae682-6e9d8ad6cf4mr11974067b3.38.1729890438088;
        Fri, 25 Oct 2024 14:07:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bafdfdsm4352377b3.24.2024.10.25.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:07:17 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:07:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
	calvinwan@google.com
Subject: Re: [External] [PATCH 0/5] When fetching from a promisor remote,
 repack local objects referenced
Message-ID: <ZxwIhDsM+19nAZkT@nand.local>
References: <cover.1729792911.git.jonathantanmy@google.com>
 <CAG1j3zHXThL_JXP=9xqvg=wg0R1wZYnA-okfFxqmcUQ9w0M36g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG1j3zHXThL_JXP=9xqvg=wg0R1wZYnA-okfFxqmcUQ9w0M36g@mail.gmail.com>

On Fri, Oct 25, 2024 at 02:04:21PM +0800, Han Young wrote:
> On Fri, Oct 25, 2024 at 2:09 AM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > This is a polished version of [1], also with all the test failures
> > debugged and addressed.
>
> Thanks! I think I can drop my "repack all" patches now. :)

Thanks for saying so, I dropped the 'hy/partial-repack-fix' branch from
my tree.

Thanks,
Taylor
