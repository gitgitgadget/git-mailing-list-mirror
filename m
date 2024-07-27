Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1417BDC
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722058623; cv=none; b=q4AcdenxoK4kJJvtBkdtq3GyEfmyw/gWm88eMP+zRd4X+lAp1z6/5dbwGCkiJCoOZBgup2vOr8zjhosfacvoyC6ky0irRlH3x1/cbX2Egxk1VYFTy+pJWWHOfKDbVfJJSAD9hL7E2bIYVlNNmTrc8DFiXAavnbDwUsg6wLueAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722058623; c=relaxed/simple;
	bh=rfNkB2xPoiwWDuDaQRxogk9uOBG+CHtAGnBdN40R2SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZFSJKNksj1vpzEJ/zYvf+pXgKI8Kg7R1DAd1uYQjINDP+D+x/U3KlOweUPugfki6biZI8OTB2cdOII6Yn6cpOrR1BKGQgLjHhl4YRMjf8wesvcuXFusO0DtA9+5nRjmrG2YnXH87tI2d30ace3nSCamN5xMj68bBbomN9DgGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=YNpG/Xud; arc=none smtp.client-ip=47.43.20.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="YNpG/Xud"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Xa5PsVwc3l0ATXa5Tszqvq; Sat, 27 Jul 2024 05:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1722058524;
	bh=rfNkB2xPoiwWDuDaQRxogk9uOBG+CHtAGnBdN40R2SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YNpG/XudMRjU56trVu+eoHXi+40ovm7QV/R/5cNEl+XhfShlhHcoYfd7vl1L4Egp3
	 7gPoWx1qUJklGBxVErbxacQT3grnVN9U+chqJ+dS3cmK9hVP/CXZ8fmi5oucbuP7kP
	 Xz7/KSacQwFRarQGOElzvfFJqj9bQKgE9BUoGC0ZO+HGdKVUPSwYKAjAAzO0rjqCyN
	 QQmo/8LaRDJSgzhOLRdVfoziRiMyu02u3jiKpuaqvwSDoi5VD6ZyEmRdsklTzsTBRn
	 QhBcUIK6gSZRPjC53mAcM5jC1ucV3hDh/YjAkXiI2PjWxNQpWu8JZ+KLu5G2X76qU5
	 qxjRe87hmup3w==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=b6u04MGx c=1 sm=1 tr=0 ts=66a4871c
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=hOpmn2quAAAA:8 a=fbvTAGsvrIyK5-adCksA:9
 a=jYKBPJSq9nmHKCndOPe9:22 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/5] improve one-shot variable detection with shell function
Date: Sat, 27 Jul 2024 01:35:04 -0400
Message-ID: <20240727053509.34339-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726081522.28015-1-ericsunshine@charter.net>
References: <20240726081522.28015-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfALL2qgYNgcLJosD6UCSqRCVA0MXWSKU88g9ZFCCy0U3KxxMiCQuBsQPcaBSpsUf8PW3W9SdhrKnizOrPWrOrtV5NdJEakER+lTzg5a5f5LjT/FVBiAz
 X739psTUNcixZaG+XvH4wI3bBLa3PNVfcOnNNDgnc+z5ZyvD/98ePS8Y5BjTkV0WFfTsn1UudtEqc4Ynh9TYhAtpyUyb9hBzZEAeJAtJALR2f2PxkcT5c/EI
 Z7lJXB6OTaV442cOUOuYezd/Jnie6xCuOE1fcYzwoCV3FK7k7gbIeXh/kPf0DS2qH1t+NcN8VntP6SUqqXCGPOt3RaFh0/SwRxMEiLbr8P6D3gEXVEbgyJv0
 CLgGwdP2

From: Eric Sunshine <sunshine@sunshineco.com>

This is a reroll of [1] which improves check-non-portable-shell's
detection of one-shot environment variable assignment with shell
functions.

The only difference from v2 is that the commit messages have been
adjusted to use more accurate terminology[2]. In particular, they now
say that the behavior of one-shot variable assignment with a
shell-function is _unspecified_, not _undefined_.

[1]: https://lore.kernel.org/git/20240726081522.28015-1-ericsunshine@charter.net/
[2]: https://lore.kernel.org/git/xmqqplr0t2bo.fsf@gitster.g/

Eric Sunshine (5):
  t3430: drop unnecessary one-shot "VAR=val shell-func" invocation
  t4034: fix use of one-shot variable assignment with shell function
  check-non-portable-shell: loosen one-shot assignment error message
  check-non-portable-shell: suggest alternative for `VAR=val shell-func`
  check-non-portable-shell: improve `VAR=val shell-func` detection

 t/check-non-portable-shell.pl | 4 ++--
 t/t3430-rebase-merges.sh      | 3 +--
 t/t4034-diff-words.sh         | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

Range-diff against v2:
1:  0d3c0593c9 ! 1:  3bf12762a5 t3430: drop unnecessary one-shot "VAR=val shell-func" invocation
    @@ Commit message
         t3430: drop unnecessary one-shot "VAR=val shell-func" invocation
     
         The behavior of a one-shot environment variable assignment of the form
    -    "VAR=val cmd" is undefined according to POSIX when "cmd" is a shell
    +    "VAR=val cmd" is unspecified according to POSIX when "cmd" is a shell
         function. Indeed the behavior differs between shell implementations and
    -    even different versions of the same shell. One such ill-defined behavior
    +    even different versions of the same shell. One such problematic behavior
         is that, with some shells, the assignment will outlive the invocation of
         the function, thus may potentially impact subsequent commands in the
         test, as well as subsequent tests. A common way to work around the
2:  19ee8295ef ! 2:  cb77c3dc66 t4034: fix use of one-shot variable assignment with shell function
    @@ Commit message
         t4034: fix use of one-shot variable assignment with shell function
     
         The behavior of a one-shot environment variable assignment of the form
    -    "VAR=val cmd" is undefined according to POSIX when "cmd" is a shell
    +    "VAR=val cmd" is unspecified according to POSIX when "cmd" is a shell
         function. Indeed the behavior differs between shell implementations and
         even different versions of the same shell, thus should be avoided.
     
3:  220ca26d4f ! 3:  0b3716cfb3 check-non-portable-shell: loosen one-shot assignment error message
    @@ Commit message
         potential problem with one-shot assignments and shell functions. Another
         problem is that some shells do not actually export the variable to
         commands which the function invokes[1]. More significantly, however, the
    -    behavior of one-shot assignments with shell functions is considered
    -    undefined by POSIX[2].
    +    behavior of one-shot assignments with shell functions is not specified
    +    by POSIX[2].
     
         Given this new understanding, the presented error message ("assignment
         extends beyond 'shell_func'") is too specific and potentially
         misleading. Address this by emitting a less specific error message.
     
         (Note that the wording "is not portable" is chosen over the more
    -    specific "has undefined behavior according to POSIX" for consistency
    -    with almost all other error message issued by this "lint" script.)
    +    specific "behavior not specified by POSIX" for consistency with almost
    +    all other error message issued by this "lint" script.)
     
         [1]: https://lore.kernel.org/git/xmqqbk2p9lwi.fsf_-_@gitster.g/
         [2]: https://lore.kernel.org/git/xmqq34o19jj1.fsf@gitster.g/
4:  4910756aab = 4:  24ae9be947 check-non-portable-shell: suggest alternative for `VAR=val shell-func`
5:  7a15553a5a ! 5:  38cd3556c5 check-non-portable-shell: improve `VAR=val shell-func` detection
    @@ Commit message
         check-non-portable-shell: improve `VAR=val shell-func` detection
     
         The behavior of a one-shot environment variable assignment of the form
    -    "VAR=val cmd" is undefined according to POSIX when "cmd" is a shell
    +    "VAR=val cmd" is unspecified according to POSIX when "cmd" is a shell
         function. Indeed the behavior differs between shell implementations and
         even different versions of the same shell, thus should be avoided.
     
-- 
2.45.2

