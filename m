Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B512EBDF2
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111616; cv=pass; b=iX7XvcTynjzCdf17aQcnguT4sSLQ5q8jBztRy8MtxwVN87R6I9XUcEEC3IKpJuGY2XJ/vUwws24GiTPUjDqpU1tAzLrSXg9KkQqha3C7oLIZGGI50/xuMPtWuO3weOdCiG2+H8UqDCCZfe5uMgbDxpICxELRkOpgIjKTm1ZfwdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111616; c=relaxed/simple;
	bh=XCZhtxS8MBSc5lLRnZiaKoqtnKLnIJcJmCF+u7m14CY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S82yqvLO947Q6D+mNHNoSA6Ycbz7co6BqDROjTgTbGt1isSeYPVTu/xgCMRhZHilP8hdyO5AViDE3s/pT410ZEPjnCwzJTcH7zVQgT1a3eeTsEvPC/95QwKEqQDsqBm7Vo3V4YIk9KyzS6ntej49OF+WMNs/EFMAvgetfYu1azM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=jKaT/Dn/; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="jKaT/Dn/"
ARC-Seal: i=1; a=rsa-sha256; t=1761111599; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h1R6Vq9uatCF0CrXwuGU4N/63Cqz4rsXdw84c4cHjLjQCRFt8vFAqyibnisruAHifUWEYqdWcYly4D99bNem1Dl1PfOXmZHNCg1u2VJsMwp+ouyfnjBHkoiP040kom0t8iMCgS+sZ1ty4HcaC0ZlHXJScQTwJzhT5P2UpBuAmhc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111599; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=NIesJyCGBLp/5CZtBvx4dqK45CrOlE1yw0qnmbGz3Wg=; 
	b=aDVrGyNpbeK3zbn3NEWYVKctsYqozU2w0dGLH4BGuBne0LhQr7926wdjx8am7rR/Kb5eHs/9OCP08HRKO+/9MjHZFV+cBE8RApJ4ujqfQnl+fuHssxmPCLinDrjo2aXrmbU3kz5mDrcW/j1EVryZa/qcdE2WcxpuERHFsskWgrg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111599;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=NIesJyCGBLp/5CZtBvx4dqK45CrOlE1yw0qnmbGz3Wg=;
	b=jKaT/Dn/D42Qzx1FuN70kD2BeC0TcpDJUtIxKQR0jSrJFJK3luKj1wmLGJRO94Gz
	uvfbPYWjuKbya+badEwNOIti2hJ2HkHV97zxZk7DgdWKwG2pESslikUE+rjFvfaSsvC
	gbS8QGW3M/n09UhEkqUINckKYaRs9fFUrrkj3vbw=
Received: by mx.zohomail.com with SMTPS id 1761111596342635.5128803407417;
	Tue, 21 Oct 2025 22:39:56 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 00/29] rebase: support --trailer
Date: Wed, 22 Oct 2025 13:39:20 +0800
Message-ID: <20251022053951.602605-1-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

This patch series teaches git rebase a new
--trailer <text> option and, as a prerequisite, moves all trailer
handling out of the external interpret-trailers helper and into the
builtin code path, as suggested by Phillip Wood.

Patch 0 switches trailer.c to an in-memory implementation
(amend_strbuf_with_trailers()). It removes every fork/exec.

Patch 1~8 fix all reviewer comments from v3 for patch 0. 

Patch 9 builds on that helper to implement
git rebase --trailer. When the option is given we:
force the merge backend (apply/am backend lacks a message filter),
automatically enable --force-rebase so that fast-forwarded
commits are rewritten, and append the requested trailer(s) to every
rewritten commit.
State is stored in $state_dir/trailer so an interrupted rebase can
resume safely. A dedicated test-suite (t3440) exercises plain,
conflict, --root, invalid-input scenarios and etc.

The rest patches address all reviewer comments from v3 for patch 9. 

All t/*.sh testcases have run successfully.

v5: fix all Kristoffer's review comments form v4[3] in place and without new patches. 
v4: fix all reviewer comments in v3. [2], and add patch 1~8 & 10~29 to fix review comments.
v3: merges the remaining trailer paths into one in-process helper, dropping the
    duplicate code, as pointed by Junio and Phillip [1]
v2: fix issues pointed by Phillip 
RFC link: https://lore.kernel.org/git/196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty/

Comments welcome!

[1]: https://lore.kernel.org/git/xmqq8qlzkukw.fsf@gitster.g/
[2]: https://lore.kernel.org/git/20250803150059.402017-1-me@linux.beauty/
[3]: https://lore.kernel.org/git/20251014122452.1851103-1-me@linux.beauty/

Li Chen (29):
  trailer: append trailers in-process and drop the fork to
    `interpret-trailers`
  trailer: restore interpret_trailers helper
  trailer: drop --trailer prefix handling in amend helper
  trailer: move config_head and arg_head to if storage
  trailer: use bool for had_trailer_before
  interpret-trailers: buffer stdout output
  trailer: mirror interpret-trailers output flow
  trailer: handle trailer append failures gently
  rebase: support --trailer
  rebase: inline trailer state paths
  rebase: reuse buffer for trailer args
  rebase: drop redundant strbuf_release call
  rebase: skip stripping of --trailer option prefix
  rebase: die on invalid trailer args
  rebase: validate trailers with configured separators
  sequencer: add trailers to message before writing file
  t3440: create expect files at point of use
  t3440: check apply backend error includes option
  t3440: use test_commit_message for trailer checks
  t3440: drop redundant resets and pass branch to rebase where needed
  t3440: assert trailer on HEAD after conflict rebase
  rebase: persist --trailer options across restarts
  t3440: remove redundant --keep-empty
  t3440: use helper for trailer checks
  t3440: test --trailer without values
  t3440: convert ex.com to example.com
  t3440: ensure trailers persist after rebase continue
  t3440: exercise trailer config mapping
  sequencer: honor --trailer with fixup -C

 Documentation/git-rebase.adoc |   9 ++-
 builtin/commit.c              |   2 +-
 builtin/interpret-trailers.c  |  94 +++++-------------------
 builtin/rebase.c              |  50 +++++++++++++
 builtin/tag.c                 |   3 +-
 sequencer.c                   |  34 +++++++++
 sequencer.h                   |   4 +-
 t/meson.build                 |   1 +
 t/t3440-rebase-trailer.sh     | 134 ++++++++++++++++++++++++++++++++++
 trailer.c                     | 130 ++++++++++++++++++++++++++++++---
 trailer.h                     |  23 +++++-
 wrapper.c                     |  16 ++++
 wrapper.h                     |   6 ++
 13 files changed, 412 insertions(+), 94 deletions(-)
 create mode 100755 t/t3440-rebase-trailer.sh

-- 
2.51.0

