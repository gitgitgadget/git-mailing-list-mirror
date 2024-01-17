Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63063D5
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469837; cv=none; b=PvxOfsew5zZv8bBhyhoMjSefoweVw5ig9TasvhCQCrndJzXMTrpr5btl6vAd4b83Krlz2a86NT/o1PUxQwGervQrMR3BiHriOcOsgX9WHRAssiXG31Gu6z+5+otsoKcPfmkERRDJ5Pf+qu93nGK4o/6lJ5nMSDlvJv5Yb3/+F60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469837; c=relaxed/simple;
	bh=acGTyKQGDz1gPUCyNYSFKPikihM1kheVErubuXxvjzg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=QrrW+nEAH/jy21m7V6WdwwN5jD0wzBOlv7bcPwlYIk7UQf9TXM12byYWjTsLV888lLrz1ypfAoqwqA7jM09dLY5WT82jZXa2LfCUqlfpqz3lWKO8d1DCfCsnSaxjAitziTl+pdxwcKfwSJcyIvEN81bMALrMJ3VcWSZa4YGwdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1vHMI9z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1vHMI9z"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6db0c49e93eso7818836b3a.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 21:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705469835; x=1706074635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HV0aSexok6q0B6DpnQS4VE6ZdbarSoEshZmrPzQ43fc=;
        b=J1vHMI9zbyKlXUCXlOtSe86d5HBWo/hC0fGnuk1uGSR93KTAuUmUDbYnFl1rT1hMvs
         zcOl37U6yi+ItwEIaemQrI+gNgnFQgV/4n4ILoPsDUt+Bun+n+wbpycrsEDiRlqK1E4o
         MfVeOJD2r972VVJseMIAGUv1ohk3GR1pdZf+oLCLKjbmVwaJ4ZkQheBPHve/2TQ4UJf2
         xbsb46wVeBpZnZTw8RQCsQWgJBQ6gfSvH8ePeI646onfGw3Vk/bA9zEBf8YOD0v3oga+
         gTQrVG0ES1QvVAzIB7j01vhvXtoTwvB6cDfVBBGUGmkLE19LOT+QSMsijj5Q454J0pPz
         n+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705469835; x=1706074635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HV0aSexok6q0B6DpnQS4VE6ZdbarSoEshZmrPzQ43fc=;
        b=JBVszxwm4cPJr/6zSpPTmb8/XPD5WBkuXsm2IEcdoyrzY0okg4adC/8Qy+cxikl/q4
         Ltk8T38hwbL6nwtftFqaOIq/ohQdKQQR9ntYQgiaqa4EY7BZht56f7fEr1cpslKDIsmq
         fKlQLk4zhIRs4fB+hnO3r+2Ee1B2zIp66MAimfiromz2YrLZyG1lA4L2FV52Uu92+j/Z
         ED7q6ym+HWJ8bn6yfNuqDmxOKCt3EgzqV6Fdl3Sv5iolZMnPsDYuoCY3XwDLamN7IGHX
         7aEee1eZLPmI+ZgGLg09sKSWtrLevYVLn1EQMt2ox5DXkQt3zZXJQpoNUqhlzU6rB/2+
         UTKA==
X-Gm-Message-State: AOJu0YzgxDRgSSBmNXog6GKzjz0DBJtIx4zniieYEZ21VY8dnCKRFBXc
	2k/8wHtrSPwMcdfw/8N52XEPCvzuBSsV
X-Google-Smtp-Source: AGHT+IEKxGYUbmD5txbE3UqGNFDtK2H93CYQOvHYT8FbkxEDa7aLA5ge3+EmG3NiQE238Ltzk+PlWw==
X-Received: by 2002:a05:6a21:6805:b0:19a:d4e9:d3ce with SMTP id wr5-20020a056a21680500b0019ad4e9d3cemr6114400pzb.120.1705469834929;
        Tue, 16 Jan 2024 21:37:14 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:a6f6:5624:1895:86a4])
        by smtp.gmail.com with ESMTPSA id si1-20020a17090b528100b0028d8fa0171asm13114316pjb.35.2024.01.16.21.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 21:37:14 -0800 (PST)
Date: Tue, 16 Jan 2024 21:37:09 -0800
From: Josh Steadmon <steadmon@google.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, christian.couder@gmail.com,
	me@ttaylorr.com, phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy][PATCH v5] Port helper/test-ctype.c to
 unit-tests/t-ctype.c
Message-ID: <ZadnhRtYfrFeMCbX@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, christian.couder@gmail.com,
	me@ttaylorr.com, phillip.wood@dunelm.org.uk
References: <20240105161413.10422-1-ach.lumap@gmail.com>
 <20240112102743.1440-1-ach.lumap@gmail.com>
 <0d18a95a-543a-41de-8441-c8894d46d380@gmail.com>
 <xmqqply147bj.fsf@gitster.g>
 <41cf1944-2456-4115-a934-aff2306a26e5@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41cf1944-2456-4115-a934-aff2306a26e5@web.de>

On 2024.01.16 20:27, René Scharfe wrote:
> Am 16.01.24 um 16:38 schrieb Junio C Hamano:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> >> Thanks for adding back the test for EOF, this version looks good to me.
> >
> > Thanks.  Let's merge it to 'next'.
> 
> OK.  I'm still interested in replies to my question in
> https://lore.kernel.org/git/a087f57c-ce72-45c7-8182-f38d0aca9030@web.de/,
> i.e. whether we should have one TEST per class or one per class and
> character -- or in a broader sense: What's the ideal scope of a TEST?
> But I can ask it again in the form of a follow-up patch.
> 
> René

I think that the scope of a TEST() should tend small: we want the
minimal amount of setup required to test the invariants that we're
interested in. For this particular unit test, since we're just testing
simple predicates on static sets of characters, I would be OK seeing one
TEST() per class/character. That would certainly make this unit test an
outlier in the number of checks, but I'm less worried about that since
this is testing system-provided functions that we don't expect to change
regularly.

Additionally, the elimination of a level of macro indirection makes this
more readable IMO.
