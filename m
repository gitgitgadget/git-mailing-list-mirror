Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C119C2E3
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994672; cv=none; b=gDHS6lpWQUQB8IxhihAdpVk/AzOoEVcvjOt3XhshUgnAI0gJsN3SX79pZwBOZD0Q3fAmq8v+7+8hBvPSeBGFEV33EfGTvkZ2BEoWRmzaAJcLmKNkh5c/IpPI9XD1gN+7euIGvry2QODO24H+PkQ+jQBHQ2wQqvpFNBnsn9+nN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994672; c=relaxed/simple;
	bh=KEx0PREU9+r+962JJivsQbx3JlmxqBw7QPRNRz20YpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rJQXc2j5JK4xo2gAL+VypVjYsFqbszStOa2O5IjfYqaRuvzniiyjtyGlr8e7/fxdh/ymfs+OLOjjgPAZQqNi5S/kXxsbEpU/CMPUAoXzzBlkAh8qAJZPwaOOoxMTD87E+MfF16YMZlGfgtc8iIUQYJTstS5tYtVHAUL42iu041Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tNuY5f/8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tNuY5f/8"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710994666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X0h/Yx1wq3UPGBEsydb90K/xvIS4JziW6xjc/gjGChw=;
	b=tNuY5f/84Ri4MksbnrLo/+fuM+59U3wgGHJlTEbfHzPYIJAVPTFljyUfQZlQNI56zNqKQB
	lF9LjlpX0xraE7enmIKYFGKZk3f9Er9Wg67nKPoUyI9jAWk44m75ZdMx9uDpTIw7OsRYLy
	L5ub6TPDXwFUcZBsaokHwZed0aGV3v1hhdGzBWi/lZD0tCFTZBumMxCRodYxK6Bl2g2dC8
	fbdo8tdCKdSvvsm5O7vrPiAM4HJ0OqYx1g2OKbOPXkko/CjLKwzVoTUdW5xUe7JLfrF68U
	ooesJgaFeX1f/POvIBtY471C5V8CI4OJkBh+Ykfnq0pcPZMUVbSJhmgK4eKJnQ==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v4 0/4] Fix a bug in configuration parsing, and improve tests and documentation
Date: Thu, 21 Mar 2024 05:17:39 +0100
Message-Id: <cover.1710994548.git.dsimic@manjaro.org>
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

In v2, this series had five patches in total, out of which the third patch
(i.e. patch 3/5) was dropped in v3. [4]  Other changes in each version are
described in each patch.

There will most probably be follow-up patches, to address the remaining
points raised during the review of this series. [5]

Link to v2: https://lore.kernel.org/git/cover.1710646998.git.dsimic@manjaro.org/T/#u
Link to v3: https://lore.kernel.org/git/cover.1710800549.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/git/cover.1710258538.git.dsimic@manjaro.org/T/#u
[2] https://lore.kernel.org/git/ff7b0a2ead90ad9a9456141da5e4df4a@manjaro.org/
[3] https://lore.kernel.org/git/11be11f231f3bf41d0245c780c20693f@manjaro.org/
[4] https://lore.kernel.org/git/514d832b0399ccdbc354675068477fea@manjaro.org/
[5] https://lore.kernel.org/git/f37d753485094a3ba66fde5e85d0e2dc@manjaro.org/

Dragan Simic (4):
  config: minor addition of whitespace
  config: really keep value-internal whitespace verbatim
  t1300: add more tests for whitespace and inline comments
  config.txt: describe handling of whitespace further

 Documentation/config.txt |  21 ++++----
 config.c                 |  15 ++++--
 t/t1300-config.sh        | 114 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 133 insertions(+), 17 deletions(-)

