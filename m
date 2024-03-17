Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8F3C30
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 03:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710647302; cv=none; b=l8M6mvjMBnHSCLdH8E2x1SeppX3wWD8DQb6JKbXtqu7/pYm99gmKyaopt6ThrS6FA9jWTTNrFRkubAHDL/oaCLpujbraJ30DNjQsfnIjoQ+VRVUMviQZUEYHyjQP22eIKcWgdtLflsjshm7mNNxBMHhEzX3nzvYbfQxIG7NyznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710647302; c=relaxed/simple;
	bh=xhdTlp0VNc8SS7e0+bI6hXE/eXi6qTmBDm2wkpAHh/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HOpJ6hSufmnT9amr4z8MgRNxVwlSFzKmo5pxMezQdqY6nHxeZIisv13R4fOFTGyssL95G8tya2dIdZVjntATUW3zbqLmoDr5c1cDCCj1UC9a6oI/u/L1kgFUki78soeXpqBscXgSPB3xLbeHEEsaEPYPfeccAXHzNXyvOzZCyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=engj3x+s; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="engj3x+s"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710647290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OuMPX9ZWQ7TdPAZ9+3SxFgTdV066UMlQvG15NevZog0=;
	b=engj3x+sarKBcVGmVsNOWP4uRd4XiNz0+GmWzJoR9m/zNcSk+nFol1I3DDqWd7dwSDjT8y
	+JdXjk4fP6JXlB6yGyR81gRSoSrR52gE0vjvO7rCnofsmQ76A/SIQiAMTCw2NlVhpG/eIV
	Oum/xp4SGWamPLEt8UNuwx91PZv2Q3prhjcv0m/5t+tyu5TdIZUfRc4cbI0XVwjtCmusaq
	Mc7bLTM1vvZgAYlKH2H11HG0aMTKMj1lx7+7M466crTwPElwnEPLUSwunlhgv17D04Ndcp
	VEWerTecnJm5bPL0CzJLzLyHYwhGn/HhN5PBchpsnqqYjrVk37KETaEB6QeG4w==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v2 0/5] Fix a bug in configuration parsing, and improve tests and documentation
Date: Sun, 17 Mar 2024 04:48:00 +0100
Message-Id: <cover.1710646998.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This series is an evolvement from another recent series, [1] as a result
of a decision to fix a longstanding bug in the parsing of configuration
option values, instead of documenting the status quo. [2][3]

The bufgix introduced in this series _should_ have no hidden negative
effects.  All of the configuration-related tests, both the old and the
new ones, pass with the patches applied.

Changes in v2 are described in each of the patches.

[1] https://lore.kernel.org/git/cover.1710258538.git.dsimic@manjaro.org/T/#u
[2] https://lore.kernel.org/git/ff7b0a2ead90ad9a9456141da5e4df4a@manjaro.org/
[3] https://lore.kernel.org/git/11be11f231f3bf41d0245c780c20693f@manjaro.org/

Dragan Simic (5):
  config: minor addition of whitespace
  config: really keep value-internal whitespace verbatim
  test: introduce new x_to_tab() helper function
  t1300: add more tests for whitespace and inline comments
  config.txt: describe handling of whitespace further

 Documentation/config.txt |  19 ++++---
 config.c                 |  15 ++++--
 t/t1300-config.sh        | 114 +++++++++++++++++++++++++++++++++++++--
 t/test-lib-functions.sh  |   4 ++
 4 files changed, 135 insertions(+), 17 deletions(-)

