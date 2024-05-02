Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270465D903
	for <git@vger.kernel.org>; Thu,  2 May 2024 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647843; cv=none; b=lFIdsO8ipJVx86eStSedK5gKXADBFCEVAaG5w6ySuAIltXanAc8d2hA06/WZIMDGrU3jyicK6U2AGSqFc55KqWwfgCaOZ56QU5wXHQWQY+hmWXcat79D6/ANu+7OaLfGjIMzqLP0KfieDlvOy5n5rBYVm7mqzfaeUrrQtxuRl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647843; c=relaxed/simple;
	bh=l6HD9nuPeX94JStM+dJCRwaJDGm2gkTcBTJ+j7uR5tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uxo9UPfBJSsHynufbDxwuybnRjlrYBWeybc0MMm6S/vCernfX49rLyvNkCS6byO3Z8j5fFfc0nLV3wAafPZXO6DNZMcd+dCWHH3JzHhhuDIwMywhJlcNdfS0WZgWDbQ6o6fnhhc7HImqSsW4o3tlRRm0CmVtCVGTe3dKZe6tVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1s2UE9-0000000025O-2ATC
	for git@vger.kernel.org;
	Thu, 02 May 2024 13:03:50 +0200
Received: from [10.20.10.231] (port=14662 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1s2UE8-00EbD8-1H;
	Thu, 02 May 2024 13:03:48 +0200
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id E4367180088;
	Thu,  2 May 2024 13:03:46 +0200 (CEST)
Received: by minibeat.bolli (sSMTP sendmail emulation); Thu, 02 May 2024 13:03:46 +0200
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 0/3] color: add support for 12-bit RGB colors
Date: Thu,  2 May 2024 13:03:28 +0200
Message-ID: <20240502110331.6347-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429164849.78509-1-dev+git@drbeat.li>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

 * The color parsing code learned to handle 12-bit RGB colors.

The first commit fixes a typo, the second one adds some test coverage
for invalid RGB colors, and the final one extends the RGB color parser
to recognize 12-bit colors, as in #f0f.
---

Changes against v1:
- add test coverage for invalid RGB color lengths

1:  25da18f71e2c = 1:  25da18f71e2c t/t4026-color: remove an extra double quote character
2:  fb9a6ed05279 ! 2:  352fa4c91aa0 t/t4026-color: add test coverage for invalid RGB colors
    @@ Metadata
      ## Commit message ##
         t/t4026-color: add test coverage for invalid RGB colors
     
    -    Make sure that the RGB color parser rejects invalid characters.
    +    Make sure that the RGB color parser rejects invalid characters and
    +    invalid lengths.
     
      ## t/t4026-color.sh ##
     @@ t/t4026-color.sh: test_expect_success 'extra character after attribute' '
    @@ t/t4026-color.sh: test_expect_success 'extra character after attribute' '
     +	invalid_color "#1234x6" &&
     +	invalid_color "#12345x"
     +'
    ++
    ++test_expect_success 'wrong number of letters in RGB color' '
    ++	invalid_color "#1" &&
    ++	invalid_color "#23" &&
    ++	invalid_color "#456" &&
    ++	invalid_color "#789a" &&
    ++	invalid_color "#bcdef" &&
    ++	invalid_color "#1234567"
    ++'
     +
      test_expect_success 'unknown color slots are ignored (diff)' '
      	git config color.diff.nosuchslotwilleverbedefined white &&
3:  9d109fadcdb1 ! 3:  9147902f698f color: add support for 12-bit RGB colors
    @@ t/t4026-color.sh: test_expect_success 'non-hex character in RGB color' '
     +	invalid_color "#12x"
      '
      
    - test_expect_success 'unknown color slots are ignored (diff)' '
    + test_expect_success 'wrong number of letters in RGB color' '
    + 	invalid_color "#1" &&
    + 	invalid_color "#23" &&
    +-	invalid_color "#456" &&
    + 	invalid_color "#789a" &&
    + 	invalid_color "#bcdef" &&
    + 	invalid_color "#1234567"


Beat Bolli (3):
  t/t4026-color: remove an extra double quote character
  t/t4026-color: add test coverage for invalid RGB colors
  color: add support for 12-bit RGB colors

 Documentation/config.txt |  3 ++-
 color.c                  | 21 ++++++++++++++-------
 color.h                  |  3 ++-
 t/t4026-color.sh         | 26 +++++++++++++++++++++++---
 4 files changed, 41 insertions(+), 12 deletions(-)

-- 
2.44.0

