Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440312BD580
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770880811; cv=none; b=FG6iK4xnQQXNk1CZv5Vd562AO30ot+TIh04dnZ6vRzpJzExq0X84EnJBxDt0f/Cv/fEXU3QXzCnTqgl+wY3TVwCGYq1iULasRtf3CVlIzRKpt1LQWY2QYYOHoxYscznxF7r2PpLEsc1+3VHC834uaTffTnyuGBBaVXa04NsFBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770880811; c=relaxed/simple;
	bh=tQUDTO9ScbVYKmBB03GRhKUTcqgSDagl1u+WyiCsumE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMmi4pEWLURfhd7HahUP1CjzGXTUTgDRgIuSMSkCR4EjaWbM0dkZxEDZ+QzK6c8mowapFBR8q2is7Xslw3pwJOEJYfyu6rDmgr1ihcaKepRiZM/7UXKVst0lRsctEHOYP2Qhg6nOGp8cDWTAm6DWRl5KL1f1UK3++WZ/eExdaG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jc6pLBal; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jc6pLBal"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824a829f9bbso682215b3a.0
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 23:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770880809; x=1771485609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEG3xV8K4bj5k6PmOjacmqxDdxHW9F3rQc/nrERdKB0=;
        b=jc6pLBal3LZ/0WmHCtGIUMp33w2bDnLDvnwvbZVpzIZ51e3Yj1RoaPbidDPJjOtxcL
         g8AVmfTCVtr1gbOHsrwSvesWLE5AVlsnnjBCY8hBf6Wu9lxJk/5Jy9GruVOO2P1oRp4u
         PbWKq4TLREKp7c2uYR1mAdQzSDGvYdIIn8FTxfb2d6CVG40k+dB9URxf9CNi/0AsbJQ/
         HIi0/Hv6qCcFqB7xCqbg9TRR0mTlQbPLxBHVELAtNOZYOMOakTO1vSDCD1YauSR4Guar
         gqGoyfXx4A3nxVdKhRU+vkcSEQqtRVfRmGs9n+iZS10WWdMM2oFCNTZU9q0ymCmvn0FS
         TpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770880809; x=1771485609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TEG3xV8K4bj5k6PmOjacmqxDdxHW9F3rQc/nrERdKB0=;
        b=chS8oi4DXEPve2XC8+lLyQM04SOJQ5Z1+gOdo2+0IStdIhcKZbZYpTPQnQXmintTsT
         F1Px0n3DX3GQFOLWlGSx8yIaTi3yvx9oa53PtgkHvN3h71Os88LKC3JT3Y8eFCmffixh
         aOl8sRpIWw6fEE0hcy/SuA4FrzTEdIU2tRvRRMqZPLIuv7qc+pksG/c00KgZE3E/WNF0
         UQLCI6lxzYA+wOcxZMcx7jDiZAqNsh8KMSNQlJO6i6NLxpaKifuGvT2K/3nebylCWtG1
         857yfRjNYWyEeygWITQV52iRXYI5+7UfSe/7u6nlZ4J2hh3Qo6ZDWyhiIffmb+/1eIEA
         DL6w==
X-Gm-Message-State: AOJu0YxVTHMbXzBMf1QyQ92LyPjxOtG/4Ma3vcl9HoKJ8V6rota9avXf
	uMGtre4Fllnyy1K/XGTH+nRUtz5gHNIZ2fskZ14B/P3xAsdUN1uZD6j50zw9OMP1jSlYIjY4ywi
	RgjqYtgo=
X-Gm-Gg: AZuq6aILe8S1fsPAuwPLiiaPhi6PQ6SVUoeFgTtGQM+fKkALmgbcOf3uCjrE2RyXxcH
	+LA46fp4tj4/QMZKygsPGD3wuNUNVhLqYWWmvpIJulVs9AgTnzDOTIKEcBf+98IMLfpS+ZpJyGg
	xIaJ/AlxkbezxlvpcFrcmJvYsdQuAH6DVqnX+32M/RaFY9QyVEkH1DxczX3Vq4CAv+Cv200OqYd
	sEERYUhp48Uk9JBuoS6Fu5UiQcxVDnKLd7WbEIxK1CH/4KgZHrKyI5jGEdaXzk7dmK7ZZoreVFc
	nIN0XoAc46OCkKm4BvgrFd6WvlOkpiWfS5Wu/VX7sqw9wShFkzpFpVB6N9WwbNHZsJuBGSQWLgY
	o49Mb56uWs75VcsnUg5eR7O0iIccUt/pviHtdtN6+NbWoeWbcf4u6jR9UuuUjOSknxbQ2yuObCa
	p9qVj5o0c5v33pRmKosDHS8XVydrXOplAGh1U+tlPeqI6/gXkwTg44dpEPe5GYYh0U
X-Received: by 2002:a05:6a00:bb0f:b0:7ff:885f:9c2a with SMTP id d2e1a72fcca58-824b03f9776mr1771014b3a.12.1770880809079;
        Wed, 11 Feb 2026 23:20:09 -0800 (PST)
Received: from LTY2K703JV.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e3bd8cbsm4311761b3a.24.2026.02.11.23.20.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Feb 2026 23:20:08 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2 0/1] diffcore-break: prevent dangling pointer
Date: Thu, 12 Feb 2026 15:20:01 +0800
Message-ID: <20260212072002.2347-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211041128.48412-1-hanyang.tony@bytedance.com>
References: <20260211041128.48412-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug is difficult to trigger, git-diff won't trigger the bug because
in git-diff, the prefetching happens before the break-rewrites.
The test uses git reset to trigger it.

Changes since v1:
* Added the test

Han Young (1):
  diffcore-break: prevent dangling pointer

 diffcore-break.c              |  1 +
 t/t4067-diff-partial-clone.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.52.0

