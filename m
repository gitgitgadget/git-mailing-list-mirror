Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D706313551
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444726; cv=pass; b=IPMWeyNUDAVKvUAQI0Ej8FJskM2dNtoDcrTR1ctTLyKYEcmjauMuqXj+lAIbbG3zkHTTyPtPtezBdR49ykSKAJr+K/lpl2WCeDw9ygaAMIbMZU4xF4JASQbZM0QiYF52WwUH446T8Y1rZ/9yYafGw+BWnm20XRLBMiniNnpmv2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444726; c=relaxed/simple;
	bh=hTMV0USABsMwNgJdCnhSfMODp4FrmQfnhtanJETDSYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A0lCAW/K0fL2OybG/hVRO8KE3pk3xE5yEEKoHZtyuoCDagXMOUdc+EciNYmre0aaEjDy9TkKKNmJWJrFVX38p0JiBrgHbiKDCUDwtKeXXLajIIJt5f3aYNR/gmHnNeykArP5GNPvTzGTU/b+jm9FkpyRKW7czkPUd41KtVjhdYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=F1ssOGQF; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="F1ssOGQF"
ARC-Seal: i=1; a=rsa-sha256; t=1760444712; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R+c5fs1jqm1UKVQXWrR9u9maQDKv7v8o92S5NxYBKXClcFRqrgkCmwmiCCh+CO/BcP2TpbBAylFTIZkw1x0O4mk5jZbj0OIdP3CyKReESyApTKEcQjFaXDQUrgdyJae802FImPcIho91055gT0JFWS5jXQuWilekVlfH/G96xXw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444712; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=I58GOaEpjTcBe5Ob77di0RXuHj0rwuV5plZLRzc0OU8=; 
	b=klteki5YjN7mUxiE3rf9gLkqEPP+9aKNOHzFTlSuLE267zML/cXwfcb3lf6Xn0N/DLFE93y1Mw7h4tsgweDWTbG1VvL7MQKCYXtYfDgx1cDc3+Oa7Z1aYleANoEBmPAWN7q66HoU73FN97kZn2N6ieYAS5RGH3QOxJPK2PMh7tk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444712;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=I58GOaEpjTcBe5Ob77di0RXuHj0rwuV5plZLRzc0OU8=;
	b=F1ssOGQF1xdwMhOzBnJA2ouAXIt24vj+R+gI/0sgdtcrvJwXT4Q4w5XZdFx/SOYd
	FwIHmw/WBhiRZkxZF8euECI7hoQn1Ao7XycQHoBKB2CwJSYSMCPfLWzOSHPoGEtO/16
	0Y65yivgheIKo9jHge8ni669If4aBG3BsVQH1o6Y=
Received: by mx.zohomail.com with SMTPS id 1760444705236556.0275101354315;
	Tue, 14 Oct 2025 05:25:05 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 00/29] rebase: support --trailer
Date: Tue, 14 Oct 2025 20:24:13 +0800
Message-ID: <20251014122452.1851103-1-me@linux.beauty>
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

v4: fix all reviewer comments in v3. [2]
v3: merges the remaining trailer paths into one in-process helper, dropping the
    duplicate code, as pointed by Junio and Phillip [1]
v2: fix issues pointed by Phillip 
RFC link: https://lore.kernel.org/git/196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty/

Comments welcome!

[1]: https://lore.kernel.org/git/xmqq8qlzkukw.fsf@gitster.g/
[2]: https://lore.kernel.org/git/20250803150059.402017-1-me@linux.beauty/

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
  tests: t3440: create expect files at point of use
  tests: t3440: check apply backend error includes option
  tests: t3440: use test_commit_message for trailer checks
  tests: t3440: drop redundant resets and pass branch to rebase where
    needed
  tests: t3440: assert trailer on HEAD after conflict rebase
  rebase: persist --trailer options across restarts
  tests: t3440: remove redundant --keep-empty
  tests: t3440: use helper for trailer checks
  tests: t3440: test --trailer without values
  tests: t3440: convert ex.com to example.com
  tests: t3440: ensure trailers persist after rebase continue
  tests: t3440: exercise trailer config mapping
  sequencer: honor --trailer with fixup -C

 Documentation/git-rebase.adoc |   7 ++
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
 13 files changed, 411 insertions(+), 93 deletions(-)
 create mode 100755 t/t3440-rebase-trailer.sh

-- 
2.51.0

