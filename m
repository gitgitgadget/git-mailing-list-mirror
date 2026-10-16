Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE0257845
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161642; cv=none; b=j5klVPakIt5kVpS54xa2pK/oL3VuTq0v+vej8O6/jwU2+hVe1OTQc69UnIryLMVQswod/Jst7/HjDnfT+Jtnxdwyhawf1hVCHw167Ip4HnXWSKwvhad9wRLZZxmtMbHKuPwGzzq7f1qTas2r/Vw37vDU+zq9r0ubwzTbXq4kLnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161642; c=relaxed/simple;
	bh=Rn1WF90kucoKBWN5r074ygFzc/xmHQrV/TdICPQn4lw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1Nj4qdgCQQ+xZKeHwkHh1xJXM1vFOsJ6Cn0aEIXcwlplMSH5MzWdjDgKxFp2D/tmt+bFnfVavOr9QXyZbi+cfOXIEGhtYbVGJ5+UJvVCh9hlX2z8hp6idToJYFWgvjzLVBv+vTbV4iZrslnbaE3/p4yyyJ/VGPjGgtgdMZE0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=OO0V+hVE; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="OO0V+hVE"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 69GEPG5w016451-69GEPG60016451
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 16 Oct 2026 17:25:16 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xHis0-009YGc-2x;
	Fri, 16 Oct 2026 17:25:16 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 17:25:15 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 6b446bbe;
	Fri, 16 Oct 2026 14:25:15 +0000 (UTC)
Date: Fri, 16 Oct 2026 17:25:15 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
CC: <git@vger.kernel.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH] sideband: skip unrecognized allowControlCharacters
 keywords
Message-ID: <20261016142515.T1gr4%taahol@utu.fi>
In-Reply-To: <pull.2261.git.1792154374653.gitgitgadget@gmail.com>
References: <pull.2261.git.1792154374653.gitgitgadget@gmail.com>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-04.utu.fi (130.232.247.44) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaWkgPARwPARwPCQwPDRwoDwUJ
 AQRGCwcFSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhaWkgPARwPARwPCQwPDRwoDwUJAQRGCwcFSFhI
 WV9IDwEcGxwNGigYBwoHEEYLBwVIWEhaXkgiBwAJBgYNG0Y7CwABBgwNBAEGKA8FEEYMDUhYSFpZSAUJAQQoHAAHBQkbCgkLAA0FRgsHBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=zGIyJ8uhmJEA6nHBU/hT9qVgfeSiY33CBnt4WmIXlhQ=;
 b=OO0V+hVEZlKAT0loUeYbipKULCNZMvppa/nT69/1kA+pj8eunUDQRIjjYbXOsMzNUIYAsxH16c9y
	mojMAWDesfBjwaZWZGElrdyNmjSiNw8RNjy/bdgb/C4ywYTkEZUC+62vh5wVTPTxSiQnE7XLzX9V
	RHTouSa0+0duuD2T56e4gdBMn1tilQXi30HSFgoL1G9SVJWWtl26aE0X/eMQ+Kr+iNhzScYAovY5
	Z0265gs1+OdA2mZuNeqtu+QcIoexg9lpKCicdQVRHegwNVrSQ3R6FdF/aPePbio5xv1EfG/OS2zS
	rFVJqcEXd9ISLP7f6qyEf2DGN2112LZoDzKHDw==

"Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> wrote:

> +			warning(_("unrecognized value for '%s': '%.*s'"),
> +				var, (int)(end - value), value);
> +			value = end + !!*end;
> +		}

Reading CodingGuidelines, it seems that `!!` is a construct we would
like to avoid:

 - Some clever tricks, like using the !! operator with arithmetic
   constructs, can be extremely confusing to others.  Avoid them,
   unless there is a compelling reason to use them.

--Tuomas
