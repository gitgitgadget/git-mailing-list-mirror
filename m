Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7142DF84
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001175; cv=none; b=WM4v74ZxW+fRj1HcmRXyZp6MKi8fQttnGGSZM5vS1IyPlA/1qA+2RF0H8lkgShOBOf1+KZANdH3zEDDv9o6o0H6zNJwNrSiXkpoE6LVTndBRUPITm8mhqZh4Ag+9kQO4HvRT3TJ2rBcSOF6oV5ZBTDDAn/b6n6f4JvTK+o8xus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001175; c=relaxed/simple;
	bh=X8tazkfndzLeIsevzG8jLO0BSn/r2UFPpg+c5ZIelKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lVPNFuurxn5EBbjYfB0noTrlLIsBRHi6czhAjnNTlUAcIzhMpKHBoMf69eMm6nypk+B/HyEAPkdNVzpQEkpDjI2/ceIt++w1mBIKEtFCmNyJwTqRuqcWk5LSSKs/oOwv/UdMaXqXpb+T8J8HkHb9s5nI/TtxGHBJJEYlaQYCl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=yiLyXHUo; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="yiLyXHUo"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711001171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GbLee93mZv3tseRnp+L+ksJFczjrda0jytaV2FSu7l8=;
	b=yiLyXHUon0BDxDM7504/bNl9uUISmkK0iBixIrb2JawHT9MQERX8+6Iau1WFpzDBswa5Bp
	0BkYxXlcj9rR2YhEvpZ18Kw9BdTwA9zSyKsnIE2/6xCUhSJ1XBlE3E6MQdqc1bLCPTpm9C
	HfFq3ZLq9qDIFvNF9XT3/uPUgw30bqkvqDYIEE8ssW+0y7rVZIJ/mH1vwMP2M4+18HwFY7
	L4SG2euGioPX6YCkye9CeLLTd4vKYd8oPZtgcNlDqbLPWErC2TmC9A2nonGkePtFeu9hyy
	EHCI8qjEI/iDVEvhIn2uPhiSWzWnEYjVcw15z4hDCvYKENtmdCzUTDiyAAQMnw==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v5 0/4] Fix a bug in configuration parsing, and improve tests and documentation
Date: Thu, 21 Mar 2024 07:06:04 +0100
Message-Id: <cover.1711001016.git.dsimic@manjaro.org>
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

Link to v1: https://lore.kernel.org/git/cover.1710508691.git.dsimic@manjaro.org/T/#u
Link to v2: https://lore.kernel.org/git/cover.1710646998.git.dsimic@manjaro.org/T/#u
Link to v3: https://lore.kernel.org/git/cover.1710800549.git.dsimic@manjaro.org/T/#u
Link to v4: https://lore.kernel.org/git/cover.1710994548.git.dsimic@manjaro.org/T/#u

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

 Documentation/config.txt |  28 +++++-----
 config.c                 |  15 ++++--
 t/t1300-config.sh        | 114 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 136 insertions(+), 21 deletions(-)

