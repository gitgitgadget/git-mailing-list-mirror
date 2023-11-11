Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AB814A89
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc7FPMyv"
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638683860
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32f87b1c725so1977850f8f.3
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699709270; x=1700314070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWAE7RYGYd63gQDk2S2kgc1Uf3b6qh62Tz7ZDWWaMtY=;
        b=kc7FPMyvwMh+UqwBL2UE7VdJkAKoLRkaLl2kOb0bR5sT1D74HRWEDx41pbI12ph0wU
         8LE23xzNosuZTux8xDXQy3NfOEBuPoxVSx8sqiDiNukURlyXlbkvr4SbZh1LpqwCmRmm
         iH6Xw42tFCCkYPUeNQha0x/LdmtKlpvnkOl2uC1PT6qOhL4Y/bHRMYLvkb41xTyeGfMZ
         nOqgbd0UydlYf1Qh7NLr3yp7mbgrIUge5g2xUFPtLCDfc9vVsymAiLpS5GtG7dThWle1
         bjONTGaMrrpvH6dhh/oJWf4qSR4xcQzqnkYsCaUVzk87jDDTI1V+XXEafIR+GNEXLsOI
         TbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699709270; x=1700314070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWAE7RYGYd63gQDk2S2kgc1Uf3b6qh62Tz7ZDWWaMtY=;
        b=lTURbOHO9KLInuAUShGM+jdsL3vPYL1ub0RA0Lir7ct/1kKuxQ41/KA1JBEhmxRN2d
         eBLEPYQV/6PS5++Ra6d1Dfb2X7usqDj/97PuNLvdd4mUDJ8VaIIDVonaxyzBKw33gAan
         sGOdAFxjinyz2jN/tQhe7YmOSwOg8q/X+7Z1z8a0jfJplTG3ZNDYeyGmzNnbHSU7Nym5
         qZtcjhvkgFm6tHBDv/h00/iaREW+Od7gWgmd46mBqiEsqMvHYhIOC0LErG5NAd2S62p4
         wmCo6QeBOezAevu7UNMjhoZwnpCSpxSeex/82QJulFQy2rv7gwJ8GcejGOgoMMnP+eRW
         c1EQ==
X-Gm-Message-State: AOJu0YxrWDasGVdgU2y0i5Z+dR8kg5hTj+ZApCKNKKt3hECE7bQzVmms
	oRNl8PqhwhnPvmhKVPFnrRVBKI+0E2zptg==
X-Google-Smtp-Source: AGHT+IEaqHsLNWdY8/y3e3BPNALo8LiD8KKQQYRpLfj4MTkSomEqb1qMgtjqOee/MflpScJ7+39ybw==
X-Received: by 2002:a05:6000:4012:b0:32f:8181:7d39 with SMTP id cp18-20020a056000401200b0032f81817d39mr1987745wrb.9.1699709269610;
        Sat, 11 Nov 2023 05:27:49 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0031ad5fb5a0fsm1467102wrp.58.2023.11.11.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 05:27:49 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 0/4] rebase: support --autosquash without -i
Date: Sat, 11 Nov 2023 13:27:14 +0000
Message-ID: <20231111132720.78877-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc1
In-Reply-To: <20231105000808.10171-1-andy.koppe@gmail.com>
References: <20231105000808.10171-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make rebase --autosquash work without --interactive, but limit
rebase.autoSquash's effects to interactive mode, and improve testing
and documentation.

Changes from v3:
- Separate commits for rebase.autoSquash, --autosquash and testing.
- Go back to interpreting rebase.autoSquash as a boolean, but document
  it as only affecting interactive mode.
- In the --autosquash documentation, bring back partial matching as a
  fallback and show what todo list command each squash marker
  corresponds to.

Thanks very much to Junio and Phillip for their reviews. I made plenty
of use of non-interactive autosquash in preparing this version. :)

Andy Koppe (4):
  rebase: fully ignore rebase.autoSquash without -i
  rebase: support --autosquash without -i
  rebase: test autosquash with and without -i
  rebase: rewrite --(no-)autosquash documentation

 Documentation/config/rebase.txt        |  4 ++-
 Documentation/git-rebase.txt           | 34 +++++++++++++----------
 builtin/rebase.c                       | 17 +++++-------
 t/t3415-rebase-autosquash.sh           | 38 +++++++++++++++++++-------
 t/t3422-rebase-incompatible-options.sh | 12 --------
 5 files changed, 58 insertions(+), 47 deletions(-)

-- 
2.43.0-rc1

