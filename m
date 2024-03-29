Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577AC812
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753033; cv=none; b=rPXGNKoULrgL0hZXNBx6NXzdXWg71mt4AdwadradN2iHOlvv6+FlM80WjN+AUJmvLIGzOtO5Ju2u/JhlqJgRBSArw7c9zijpem1O2/jgB5N0Uzwf96nnVmXsMUQpsAc8OdzKlLosbOQeCOn6I6po/wqqqGppkve6e00sg9sCzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753033; c=relaxed/simple;
	bh=1B3Ls5McQzZ5XPL4zC9hhSt881dHiomUDgbjlMuzrdY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTK3I7RzvnQp1pSO3ldPnPkOEWoxTuk9EnBznJk9L4jInelAzVryE5GuFovoTwmWrSzMDc6ezNxgUrLbfJp6IQj8lVzqu+/G0haPlXzvfEbBNl4moUxN2Q77UK4E4QN5AbPDbCS6r0R7jmEu+PcJoLBZDaJ/Jdy9FKdMI2AT6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SZCkcbQe; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SZCkcbQe"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CCAEE285D1;
	Fri, 29 Mar 2024 18:57:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=1
	B3Ls5McQzZ5XPL4zC9hhSt881dHiomUDgbjlMuzrdY=; b=SZCkcbQemrqPLP5TR
	nxVyTJWd6JqmsLMsjQm0zCTOHxcLsUAqUy+I7mGtPhpQE0Sv3WowL+ijM6sN8jzE
	y86YU1Bbl88i10OLDX0mCosXXfXRGDJYSkCpOtXtLvFrEi2v77SPYodiipQOPc9g
	yXp49BYkQC3lSNl2U9uqu23lk8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C579E285D0;
	Fri, 29 Mar 2024 18:57:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54154285CF;
	Fri, 29 Mar 2024 18:57:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] advice: omit trailing whitespace
Date: Fri, 29 Mar 2024 15:57:06 -0700
Message-ID: <xmqq4jcooddp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AB7D8FEE-EE1F-11EE-809E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Git tools all consistently encourage users to avoid whitespaces at
the end of line by giving them features like "git diff --check" and
"git am --whitespace=fix".  Make sure that the advice messages we
give users avoid trailing whitespaces.  We shouldn't be wasting
vertical screen real estate by adding blank lines in advice messages
that are supposed to be concise hints, but as long as we write such
blank line in our "hints", we should do it right.

A test that expects the current behaviour of leaving trailing
whitespaces has been adjusted.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 advice.c          | 3 ++-
 t/t3200-branch.sh | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git c/advice.c w/advice.c
index d19648b7f8..75111191ad 100644
--- c/advice.c
+++ w/advice.c
@@ -105,8 +105,9 @@ static void vadvise(const char *advice, int display_instructions,
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
-		fprintf(stderr,	_("%shint: %.*s%s\n"),
+		fprintf(stderr,	_("%shint:%s%.*s%s\n"),
 			advise_get_color(ADVICE_COLOR_HINT),
+			(np == cp) ? "" : " ",
 			(int)(np - cp), cp,
 			advise_get_color(ADVICE_COLOR_RESET));
 		if (*np)
diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
index d3bbd00b81..ccfa6a720d 100755
--- c/t/t3200-branch.sh
+++ w/t/t3200-branch.sh
@@ -1154,9 +1154,9 @@ test_expect_success 'avoid ambiguous track and advise' '
 	hint: tracking ref '\''refs/heads/main'\'':
 	hint:   ambi1
 	hint:   ambi2
-	hint: ''
+	hint:
 	hint: This is typically a configuration error.
-	hint: ''
+	hint:
 	hint: To support setting up tracking branches, ensure that
 	hint: different remotes'\'' fetch refspecs map into different
 	hint: tracking namespaces.
