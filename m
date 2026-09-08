Received: from mail-qk2-f5.google.com (mail-qk2-f5.google.com [74.125.230.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB7D5921EF
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891410; cv=none; b=DdMdCHKcsJb/7/PhJ9FhB2wq3Pz9CjTiS7J9knoQFJniC8WKDKXnZtRhfBtkvNPxVnfXInAtrmsAKRrzx3e0hWMxeZKNvXTJBI3quvq/sxw6cuPp8hHCwZbJMeiRGXFEQwxWDtfoaStQZ33ktAFOFTDIfTUk9vcaORZFNuCcDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891410; c=relaxed/simple;
	bh=KMPltRydC2icAbKDBwabLsN7Q/am2tEkojW1NZkK5/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cLgt0cO+wP09N3nWb9IsZVJOklFf9u1jYVGTEUZZLMyZ/A01y+fEjNRVwEHjUA4kAU3QIXnBG88RtxPB1guGQewb9lpJt32jFeLbATY9bBm30yj2nL/WTs4hoclf1RmKfa+35M8A0rqPKwsCe4FPEPMoJdlC9yS1dznlhAEKTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ezu+tSN+; arc=none smtp.client-ip=74.125.230.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ezu+tSN+"
Received: by mail-qk2-f5.google.com with SMTP id d75a77b69052e-52ff498cf90so30532921cf.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1788891408; x=1789496208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XqcAwkbAv1lHx33l+hpOJy4osE9a/0j4K0CxMawdYcQ=;
        b=ezu+tSN+N/mEihZtjW3FOj4fthu9R0tzXW0llRjfU22v4YRj6wCx33WW4sv4bnK4sR
         VciGnPU7Gh78owNFH2L7IwsFNtgB0xKQDSmiyGdg6Lm0WxA7MECWCm8ABmTZR56knb+q
         0Um+Cu3eTyytBWBC6eJUsodENKBmXiEqrey8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788891408; x=1789496208;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XqcAwkbAv1lHx33l+hpOJy4osE9a/0j4K0CxMawdYcQ=;
        b=sb8KoFgIL47dQOVJIoODacbNvqMp+a6qROagOCNxLf+FTo+dhEN0olSfuvRioZodUS
         9kgyAcdyOQpFyt5Rddw1wIZMLFdkxUw3aZXjizlYB4sdnwrql/IS9wr/re/B/vt3ts8q
         gmT38kyVckGlN5nNoAdozq05w5rheEqxwiIPESQ9Uz1ZnR/wWlDqayxuZgQU4DXeb4dA
         5XAX/1Sz0XAbI02NHTfqZgakkzeCND2hQKBkwROfxDYlhvuOF0VFI+vdtHUQVNnQOn+O
         WTIqTDR+lagxubNEvX7iRzL1j35K3Lu9Gk6tjtEq6t1pYvuvMZmX39tp7wnQmd+zgtRq
         f/SQ==
X-Gm-Message-State: AFuF++nfVRESzHc5zKiUBrbMENiXr87+SO7Z5Uv7JcgqxbN2DD9/W6AG
	2KLzoNTZgLWF0KQRtEGcqSNAQp5E0MbPl27iWUh+IAY4D57bzvNTWDnMmFALWDPX0T6jmY9tbfk
	OucHBgWkrcBkG
X-Gm-Gg: AYBFou355nvha2/+R3JYFzpsZDNOfhtCmGDntgEL6P7GzKyHXZ9hknuPUN5eg+ZMrvp
	hd2Bae6Q6jUuloQEX/2XgKLuDMLubv/QP/qQ+NDKbcdGXxfKBXuK2Ji9XzCKUOF4UG1gOiTgTSi
	b91yNEO/USRI2+Y+v9y1ZYFEpuyDWcDNw1Xm+K2JsGIiDWUjhcDHDMTfKL6kb6zsVT1anpel9Ju
	eFQdlrj3/ujlILX3g4FtSvBpIKRxNqwqITXJg99DZoJxVMuTiEIHXB86t36Nsp7urp/Oy8oN73x
	Kl3dm1nyh5bqYshOuKTxLV65An9c/NqD1TS3qa5MaZCfyscTWjaxu7lWffPbZJCXlRVuDrPlFLs
	taMZ4Ov23QA5v1xcmv49cE9S31R4I7jDTq3C3xRFw1bOyVRNFlwfQG3cvRFn+QJB0NfEhPnx5iA
	RzLiUnJ/bwTa7HIWhCSez1qwdKr+yVcqX28KU2C7kryxYGjXDn5aEqtPAhQGVFthyKtI1Jrg6Lr
	K32ihla0cOuimJ3C7QFAIffZhGDgy6AwPxmKy5/BkcMOgv99FjqBNLb
X-Received: by 2002:a05:622a:1113:b0:52c:ce3:6428 with SMTP id d75a77b69052e-530548106demr344602221cf.16.1788891407707;
        Tue, 08 Sep 2026 11:16:47 -0700 (PDT)
Received: from com-79390 ([40.76.104.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104049d30asm123919016d6.0.2026.09.08.11.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:16:47 -0700 (PDT)
Date: Tue, 8 Sep 2026 13:16:45 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>
Subject: [ANNOUNCE] Git Contributor's Summit 2026
Message-ID: <aqBRDSkgC4wrUUL4@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi everyone,

With Git Merge coming up next week, here are the details for this year's
Contributor's Summit:

  When:  Friday, September 18th, 10am–4pm (UTC+1)
  Where: Audrey's, Santiago de Alfama, Lisbon (private room)
  What:  Contributor's Summit
  Who:   Git (& related projects) contributors[^1]

(If you're not able to attend in person, but wish to join remotely,
please let me know off-list. Our room has AV capabilities, and I'll send
remote attendees the details as we get a bit closer.)

We'll meet alongside the unconference, with lunch from 1:30–2:45pm. The
full Git Merge schedule is available here:

    https://git-merge.com/#Schedule

As in previous years, we'll use the summit to discuss topics of interest
to people working on Git. If there's something you'd like to discuss,
please add it to the topic sheet:

    https://docs.google.com/spreadsheets/d/1ianyjHMV8EHVfHvwFfNa3SAFu5NIIBLyKyD-pU8LArQ/edit

Please include your name and a short description, along with any
relevant details. There's no need to prepare a formal presentation; an
open question or something you'd like feedback on is plenty.

We can leave the voting and note-taker columns blank for now. We'll vote
on and prioritize topics together when we meet.

Safe travels, and looking forward to seeing folks in Lisbon!

Thanks,
Taylor

[^1]: if you're not sure whether that includes you, please ask!

