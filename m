Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F773B8120
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734019; cv=none; b=gDIkoW2dzMPhyfIem+p20lgPGoLspLh3gb2LQyUWqsLUHFwgWlw8Pco8f558iGBv8iudhdHo0A7ERFSdSYCX6koJHR8kKtPYsTLK+YA/BT00+V1d5AVEtSfaHHPKG1rxhxe1SSFS68VojjM4oRAuGq1T/iPon7VTz0NSbRm2+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734019; c=relaxed/simple;
	bh=hePMm03X5WAL+XoIEfyDita1gOrZEfh8pySAgHaI0Mw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhjRutKCqN7I5PHZpKgb2vKZuAjuoz+Inr5aOWUyCD0XEl9z49BrB6rF8DyglzYkVOSjmjp35ZZvi/41NeG2AMbj5a624QaYp42OhQBSDIYcVINZeMCxGKqLrHYSJrhH4qG5Tj57MjXvvkgiZtNJjF2ZL/+Ducd/q/TcWl2yFNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=ZYuBXrnb; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="ZYuBXrnb"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 67Q8kgS7005428-67Q8kgS9005428
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 26 Aug 2026 11:46:42 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wz9HO-00GLnJ-OT;
	Wed, 26 Aug 2026 11:46:42 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 26 Aug
 2026 11:46:42 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id ed368bfc;
	Wed, 26 Aug 2026 08:46:41 +0000 (UTC)
Date: Wed, 26 Aug 2026 11:46:41 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Harald Nordgren <haraldnordgren@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>, Harald Nordgren via GitGitGadget
	<gitgitgadget@gmail.com>, <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] branch: protect local upstreams from -d
Message-ID: <20260826084641.tb2NX%taahol@utu.fi>
In-Reply-To: <CAHwyqnXjO6Cv50BVjJjW939A06-bQtcA2uf0Cwk+xuoc2Gh_LA@mail.gmail.com>
References: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com>
 <d3d7a06e3d6f0c7adf9739ca496ed4012e261ac1.1787693117.git.gitgitgadget@gmail.com>
 <xmqq33w1lv4j.fsf@gitster.g>
 <CAHwyqnXjO6Cv50BVjJjW939A06-bQtcA2uf0Cwk+xuoc2Gh_LA@mail.gmail.com>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-12.utu.fi (130.232.247.52) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaXEgACRoJBAwGBxoMDxoNBigP
 BQkBBEYLBwVIWEhaSFlcSFlbWEZaW1pGWlhfRlxfSFBIWEhYSFtIWEhYSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFpaSA8BHA8BHA8JDA8NHCgPBQkBBEYLBwVI
 WEhZX0gPARwbHA0aKBgHCgcQRgsHBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=kY0Kji1WP5L4lDJTr7azStLtZyLgfaLzZHRQQ5wmGpU=;
 b=ZYuBXrnb+xW1T8LCqBZTxt4EibXehV7zqQATAw2cTjNPg69a8JrnjPBW/FfUf5TpcxSjg0+jRl3Y
	fwFEqgZ0cMo5H6MPcLLPvtrqD02jPnNM6u/ir5SowT84Ff22z9peg0L5wHfzp7dnndt2i//+A7vw
	t13+LbVJ1gm24ok7xEulrrBXXev1Xh9tMxFtPs5OQLkfVDXqLoQAVGmRWM6NXMFwTQheWFV5oFPv
	Nx0qg+2Lx7Gb/IUpeacOUhwi0ASwJ3baN85DN6YzVtq6sX6+g9opQb+IIeP5oygBsB534otD8beJ
	Ni/Cm5cABZMh9wJDi36FDgNxSOy3AED9Uuvrbw==

Harald Nordgren <haraldnordgren@gmail.com> wrote:

> Hmm, it makes sense what you are saying, but I could have sworn that
> you asked for this (likely some very different version from this) when
> I was working on delete-merged, i.e. to extend branch protections to
> '-d' as well. Phillip brought it up recently as well. Maybe I
> misunderstood.
> 
> 
> Harald

In <xmqq33yimsdp.fsf@gitster.g> Junio wrote:

} [...]
} 
} Do we also need the same safety around "git branch -d feature1" by
} the way?  The "-d" option with safety checks the same "is feature1
} already merged (to its upstream)?" condition, so it can protect the
} feature2 branch the same way, by saying either "oops, you cannot
} delete feature1 because you still have other branches like feature2
} that depend on it", or "ok, featur2 used to depend on feature1, but
} because we are deleting feature1 based on it being in origin/master,
} we will make feature2 depend on origin/master from now on".
} 

Harald, perhaps that's the passage you thought of?

-- 
Tuomas
