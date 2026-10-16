Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F54CF47D
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179286; cv=none; b=o4gaGSFPG5Sz5MXveycbICrryM/OaRAhqA10w4zI4YKVrOf7us9FyRy59S2eGDwxjMVwhyjDFOpKs7ha9MtZtslfYyJkb54MGLWCz5S6glqRM62br18aaKGjJY2ixmz5ongQ26t6zbEQC/nsdHnsp5GQJAC/yOVBpATFD4EnjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179286; c=relaxed/simple;
	bh=8W1wL16+j42Vd7hL16DHWExHdd/eTEUX3qorX2uk7UQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzLPtA67q7dkUSBm1p5cqmvoOmSHLMgElb/bPrwtmBzE14jLT8HgDVtD3rVhoQ6GssbFv+4BTHGK7HvZM9+m9fTLlN4Y1p36/omAKc55Nf1aiV4XYht/12DUJtI7gEE0oYg1Cj5STptTdRNuTfvF2P56v0LlGwPPrzceEYCtIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=aw3xvEgs; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="aw3xvEgs"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 69GJYVMX010750-69GJYVMZ010750
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 16 Oct 2026 22:34:31 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xHnhH-009me5-Ag;
	Fri, 16 Oct 2026 22:34:31 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 22:34:31 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 92f9df04;
	Fri, 16 Oct 2026 19:34:30 +0000 (UTC)
Date: Fri, 16 Oct 2026 22:34:30 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
	<git@vger.kernel.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH] sideband: skip unrecognized allowControlCharacters
 keywords
Message-ID: <20261016193430.JZhfl%taahol@utu.fi>
In-Reply-To: <xmqq8q3xh98n.fsf@gitster.g>
References: <pull.2261.git.1792154374653.gitgitgadget@gmail.com>
 <20261016142515.T1gr4%taahol@utu.fi> <xmqq8q3xh98n.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-03.utu.fi (130.232.247.43) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaXkgiBwAJBgYNG0Y7CwABBgwN
 BAEGKA8FEEYMDUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXUhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWlpIDwEcDwEcDwkMDw0cKA8FCQEERgsH
 BUhYSFlfSA8BHBscDRooGAcKBxBGCwcFSFhIWl5IIgcACQYGDRtGOwsAAQYMDQQBBigPBRBGDA1IWEhaWUgFCQEEKBwABwUJGwoJCwANBUYLBwVIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=1yxT9uQ858QFVIya7CmiKhXDqFmW8Xj7L4bMuMkR1E4=;
 b=aw3xvEgsFKUilP+zoS30awLx484zFvWihYC5mDYn2CTg+Z6jtb9C71LT19VvVLqcb3O0fjyaymrG
	t02ItsAADCMdEx988ldQ7TNWlqJQmazWIIw7EOXeiETRXQV3qUxgUqhJjdUMMPxwKNhuxnBV1OBe
	O9eqfBYrlINOzIfL/mFyfYJFohc3o9jhOw9fyPeu44ImHlMP+rPSv5kp7HTAObAODmR57jXPahav
	fKQY3nGoJ4t+2c670KUubS465yROkhg4U+mBgLtWQAAi1M17+xvgc36hrZiMTplqZUfXNkEAnuMs
	MVu0yzPiIpJ3qRabMuxWlT0DNJESUy7LkW7dDA==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> >
> >> +			warning(_("unrecognized value for '%s': '%.*s'"),
> >> +				var, (int)(end - value), value);
> >> +			value = end + !!*end;
> >> +		}
> >
> > Reading CodingGuidelines, it seems that `!!` is a construct we would
> > like to avoid:
> >
> >  - Some clever tricks, like using the !! operator with arithmetic
> >    constructs, can be extremely confusing to others.  Avoid them,
> >    unless there is a compelling reason to use them.
> >
> > --Tuomas
> 
> But here it is compelling.  You want to normalize random byte into 0
> or 1, depending on "is it 0 or non-zero?" criteria, and it certainly
> is easier to read than (*end ? 1 : 0).
> 

Uh, of course.  Sorry for my mental short-circuit.

> Quite honestly, I do not think !! qualifies as "clever trick that is
> confusing" anymore.  Perhaps putting the rule there is misguided.
> 
> Thanks.

Okay.  I'll consider writing a patch to drop that from CodingGuidelines.
