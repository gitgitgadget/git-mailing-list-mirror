Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B336084
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPaEZxUE"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e281b149aso1270061e87.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 09:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178439; x=1703783239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/Qb8Nd2vlHKe8zkSjZGvl20FgrI3zwEtZsq70gSbLg=;
        b=WPaEZxUE6drzW2l0IRcJ70LCauN2pjz6oY+OF/MGXiBLV7BcRi/29wO4S86dIvuTSt
         MOdQ+8UrgbUtRMWoZoPWBS4qSzgcpyamszU9CFQpCL9RctAzqtnn9uA/V3KKTraTU36S
         Q13mBc8k0eIbh2SiUkIVnJX6qpFErCDuBOqprJdPy2LT29bCfTLgG+XW75zBHUXZV7Ux
         m9XvOU0RSGgn8nJibnGQbKyFwGLNUT1/TLDWg2aK1IBEBJGnuS/7PfoTb+hkYc8LKOWL
         yGS+GjRC+cTDZaFCW5w7AiX+GMD7F0JdEZ42pjtUtzxBVNN5JBGgxoVQhtRmqrMKkHL0
         Qe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178439; x=1703783239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/Qb8Nd2vlHKe8zkSjZGvl20FgrI3zwEtZsq70gSbLg=;
        b=IeZZnr3QhbAB/rYhOsOVKHsMutvbIP5maOoKnh/86XVN0iM2orIrhyLOFPvUPtBXJ0
         pZt7qstgqSJLxzZdIzq7qc5mWWjpXkwbrPQLW9X/6g8qkyLfNT6EHAHGRNkn/VuheSez
         Y/YkYJj0akcmF7Xv6jyTF6iNDRqIXHVVC4Pi74FXk0GztrzFBXrzdU9j4txIzH2hJ7wx
         cO8lKh7LH/xpOSwaVLPNXjAmRJpnDI1gi5apt6e//vP9dSHfBRLEEhqIxQHLg2ldsKDo
         dWZgNwz3uE4WngoyIfQnsF1efRMN2tyIRcO8AlUASq3Q1vC4IG0wLKtSMhdN66GRD04r
         GhaQ==
X-Gm-Message-State: AOJu0Yy+e2p49ETZixgdHo8yxfdiwgApUIS33DfWRkReYFL9pBBbZsNf
	0FONLgtNIGO962lF+E49aMdPvFB3zI7a3w==
X-Google-Smtp-Source: AGHT+IHsOQPivVY7SgljDbg7yNlRLiFgYQL5Vlty7d0pszxbzEcq+Zxf7iz2xihpBZpOTuD1ghcNeA==
X-Received: by 2002:a19:e048:0:b0:50e:65f3:cb0b with SMTP id g8-20020a19e048000000b0050e65f3cb0bmr171769lfj.13.1703178438976;
        Thu, 21 Dec 2023 09:07:18 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id en6-20020a17090728c600b00a23577b265csm1163789ejc.173.2023.12.21.09.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:07:18 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	christian.couder@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC 0/2] Initial changes to support printing all refs
Date: Thu, 21 Dec 2023 18:07:13 +0100
Message-Id: <20231221170715.110565-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the upcoming introduction of the reftable backend, it becomes ever
so important to provide the necessary tooling for printing all refs
associated with a repository.

While regular refs stored within the "refs/" namespace are currently
supported by multiple commands like git-for-each-ref(1),
git-show-ref(1). Neither support printing all the operational refs
within the repository.

This is crucial because with the reftable backend, all these refs will
also move to reftable. It would be necessary to identify all the refs
that are stored within the reftable since there is no easy way to do so
otherwise. This is because the reftable itself is a binary format and
all access will be via git. Unlike the filesystem backend, which allows
access directly via the filesystem.

This patch series is an RFC to discuss the intent and direction to be
taken to implement tooling for printing all refs in a repository. The
patches in this series implement a rather simple way to do this, by
iterating over a static list of operational refs. The drawback of this
approach is that this could still miss refs in the reftable/files
backend which are not in "refs" namespace or part of the list. The
positive being that this is ref backend agnostic.

The alternate approach would be to patch this inside individual backends
respectively, in the reftable backend this is rather simple, since we
simply iterate over all refs and not filter for "refs" namespace. In the
files backend, this can be done in two ways:

1. static approach: similar to this patch series, the files backend
would iterate over a static list of operational refs apart from the
"refs" directory.

2. dynamic approach: iterate over all files in `.git` folder and print
any refs if encountered. This is rather tedious and error prone, since
any file could be mistaken for a reference if the content is reference
like.

Personally, I'm leaning towards implementing this functionality inside
individual backends respectively, because that would allow the reftable
backend to print all its refs while the current approach might miss some
refs. But with the files backend, it would be best to still use a static
list.

Over this, I'm also curious on what the mailing list thinks about
exposing this to the client side. Would an `--all` option for
git-for-each-ref(1) be sufficient?

Karthik Nayak (2):
  refs: introduce the `refs_single_ref` function
  ref-filter: support filtering of operational refs

 ref-filter.c | 12 ++++++++++++
 ref-filter.h |  4 +++-
 refs.c       | 26 +++++++++++++++++++++++---
 refs.h       |  5 +++++
 4 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.43.GIT

