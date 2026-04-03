Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3036920D
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196144; cv=none; b=Co/c72Mni8KIvs7Hjv6rNU/XDHbYrPSLCGRuFRo17dSD48hcLl4Uux3unQVenv9/doVunwiq9QUe5TFDx0vVYD9RfhUXlPlTmBTNShE0YeB1uRNNNVXvX+UPQwbaCJAOBYuL/Z221BB1oK0NRcyZjkU3m3taQyNnyJqH5DaetCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196144; c=relaxed/simple;
	bh=tRAgf5USrsnfdF44FaEnN5af+uJ5IEHCTsE3WhHj+rk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vF3FHc0spRCpfRo2AG3k0aszvZYCEsY+ERS37ZdyAt5cIWNfaUbxF39QMrlTJTJxa88a6kptyT37CwPhjegSvh7L0dIBw6C2Dl9je66X0kqGbYF6VKXp7zbXdLTgRCH2DJkr4p6/iltq31OGZDpCOJNOKHCZeTSOWv4B5T0OacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qKcmuT8G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VmlHCuOd; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qKcmuT8G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmlHCuOd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 00A511D00173
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 03 Apr 2026 02:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1775196135; x=1775282535; bh=9jo1fJk2qc
	oJU7DV2iUeCeCupKo4P3U3+qORzgOnJSU=; b=qKcmuT8G8LFshEVQH3+3JRG4uG
	wNE97iHUZAZkNklcpMnc4ndsjma9SLuM9vjVPjXmueKEmPF8b47gFwwOa/Am6bE1
	kqxBipySZQqfm0ieA6vF2HIVUpw3Ewx/7RprRSN0MAPh9/2R2EfF8eozgSJMpKM7
	9FF3ZR3KyS/1gkmeZPDNL3APBR2vUp97Kgf6Itg/uWGY63brGrGDFheEgGuH8Hqg
	l+n8KkbeXfXP+XDp3kmLxGfkxpLWxsgq6aYkpp6nSrWl41l18+8Wc3pvpH5+QxOL
	uOSp/U6agqOW/WSioxLjVpTtPGlqol2SruvZ0CYxsjH48U+fn9gsuQoC9Dog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1775196135; x=1775282535; bh=9jo1fJk2qcoJU7DV2iUeCeCupKo4
	P3U3+qORzgOnJSU=; b=VmlHCuOd5+QFURXzl+1hpCu6d2uGdbNNF5eB1+LKYArT
	M9hQI73vEyv2arU/FR/lJPCJHmHg9R0KCqARP/iS0mV8BxatEDlRMxTqJ/S1SJ0M
	q9r3KRPjq5cGyZjsCuldS8PIfc72dkqig/gHCse53hw6Hoepj0SEGDCOFiJBCqcX
	+ThxjsaQHjo1ktud2RKTW/PWL3yVMKy9AQ+IQwe5yYfnslGW0mjCC6Fvwp4cxsW9
	+0ANAotmQpBtP5EmEUJ08tQgxsQ0DQCcbJ5a96bzd7vcjXf2JhxxzgUqBej9BOmr
	1nGuDBER/mVG/+hBxIL5xIK9zvFBeB45mAc3iqk26A==
X-ME-Sender: <xms:51fPaQ0wweiuwwognGvAnxtcGp7V101UoE7yE3kDprmKCc-ssqbelg>
    <xme:51fPaSA4CeTtcjyS2IJ83qV0PWd2pmbUrBcRcB6uRb5toPGhjCW-iRIxWTnzZBbxI
    Bzbd27J-WXosrEaG-XCusjZVbS12JU-6dwiFR_nO65Ms93vH0MA>
X-ME-Received: <xmr:51fPaegQ_Fko6yCdKqxzeWke1UbxRL5gzC-HOJkf1Jn_GnPM-fm0ysQZnzlvbw13XVGEZvuk8FjCY1SyAgwr-qaSyuoBlVQWPGLeVdJLgEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtredtje
    enucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhi
    mheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevheeuhe
    fgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:51fPae8j2fUD_RqYgwTrcSzMQ-IaDT8V6E4v5WhKFx2ugSZyBkA86A>
    <xmx:51fPaS_8Ncd_QCKv2-rVF-C14nfQUIw-qlV4o1EETENj7AM9WytiYA>
    <xmx:51fPafCGjVEqa8X35sRaJLp8dhNgDioN76ZWbG7_32bVUsysUH8qKw>
    <xmx:51fPaawdvXS5fIrKpdSXIwtTzUJuQzQ8MJrOluVGa7gQOQ-OmW1l-A>
    <xmx:51fPaSFNqmifGmFcmdYOX7NL_4Bt_wV0wYUAIU_O7cTIxvDrj6pNBI0i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc61ed75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/16] odb: introduce "inmemory" source
Date: Fri, 03 Apr 2026 08:01:47 +0200
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMtXz2kC/yXMQQ6CMBBA0auQWTtJC42oVzEsaDvgaGjJDBgN4
 e5WXb7k52+gJEwKl2oDoScr51RgDxWEW59GQo7FUJv6aJyx6B3OD8UcPWpeJZQgTTRleWPrbRt
 OTTyTa6AMZqGBX7/5tftbV3+nsHyPsO8f8MHYXH4AAAA=
X-Change-ID: 20260401-b4-pks-odb-source-inmemory-7b17c83d9e43
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Hi,

this patch series introduces the second object database source type,
which is the "inmemory" source.

This source may seem somewhat odd at first: it always starts out empty,
and any object written into it will only exist in memory until the
process exits. But the source already serves a purpose in our codebase,
where some commands, for example git-blame(1), write an in-memory
worktree commit.

Furthermore, I think that going forward it can serve more purposes as we
now have an easy way to write and read objects that will not get
persisted. I could see that this may be useful when for example
re-merging diffs. But eventually, once we have the object storage format
extension wired up, callers might even want to manually set up an
in-memory database as the primary ODB for write operations so that no
data will be persisted in an arbitrary write.

Last but not least, this patch series also serves the purpose of
eventually getting rid of the `struct object_info::whence` member.
Instead, we'll simply yield the ODB source a specific object has been
read from, together with some backend-specific data, which gives
strictly more information compared to the status quo.

The series is based on cf2139f8e1 (The 24th batch, 2026-04-01) with
ps/odb-cleanup at 109bcb7d1d (odb: drop unneeded headers and forward
decls, 2026-04-01) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (16):
      odb: introduce "inmemory" source
      odb/source-inmemory: implement `free()` callback
      odb: fix unnecessary call to `find_cached_object()`
      odb/source-inmemory: implement `read_object_info()` callback
      odb/source-inmemory: implement `read_object_stream()` callback
      odb/source-inmemory: implement `write_object()` callback
      odb/source-inmemory: implement `write_object_stream()` callback
      cbtree: allow using arbitrary wrapper structures for nodes
      oidtree: add ability to store data
      odb/source-inmemory: convert to use oidtree
      odb/source-inmemory: implement `for_each_object()` callback
      odb/source-inmemory: implement `find_abbrev_len()` callback
      odb/source-inmemory: implement `count_objects()` callback
      odb/source-inmemory: implement `freshen_object()` callback
      odb/source-inmemory: stub out remaining functions
      odb: generic inmemory source

 Makefile                 |   1 +
 cbtree.c                 |  25 +++-
 cbtree.h                 |  11 +-
 loose.c                  |   2 +-
 meson.build              |   1 +
 object-file.c            |   3 +-
 odb.c                    |  82 ++---------
 odb.h                    |   4 +-
 odb/source-inmemory.c    | 375 +++++++++++++++++++++++++++++++++++++++++++++++
 odb/source-inmemory.h    |  33 +++++
 odb/source.h             |   3 +
 oidtree.c                |  66 ++++++---
 oidtree.h                |  12 +-
 t/unit-tests/u-oidtree.c |  26 +++-
 14 files changed, 529 insertions(+), 115 deletions(-)


---
base-commit: 3d05c3e2906489caa9f12f0af18dc233a6b8032c
change-id: 20260401-b4-pks-odb-source-inmemory-7b17c83d9e43

