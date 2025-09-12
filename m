Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE317BA3
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695626; cv=none; b=MKkWbqg3IP9TunT/BMUrqKDI8b3XPgfI5ocHCUdOOHMOmSz+ERqDXpLLdonqYBnnTiwA+B6frmTiJ+AfgG/utwDwToJVouVhxfhL2xVGbKv+ykxX+utR7/2L12jHJc/poImdSTOLuTjJ074M1tjeAp2a2aeFJLZ5NNgCrfdg0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695626; c=relaxed/simple;
	bh=uQ87NF3N6ZGKU9V99FVNy30TDXXGGYFJWRSBRQ8x0yE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bokb+NrXadpj1cD/dsNA6DlJdKZZj5YSSkeDJrKYfxGxg2MiHC1tofN/MVqoMvPqvKhHwP3drqav1QIC+p1+XsDxQxNbpKgaXxq1XyHtGgs5yEidscmHyiFzpVVAS3OXck72+ZXDvNuORsJfV4RTJDku8fIA05Zl2jA4OOU77do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0wRg6VTn; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0wRg6VTn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1757695619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g9glQNb6Af5sCiBEKV0BpCkf4NWqwF9bof2zNKF0mso=;
	b=0wRg6VTnYXkWKUWvttetjcgJRp5mP5p6Uc47AqcsgrhkMUbDMN+QJcY9IrOcs4miYAQw5r
	AL157JQTuqbMH5EhNKQnwU+hXuH3E7aCrpGA20k7SAtIOBcRM+EzJmagNNacu4rrOEBH6V
	7+YgFWDfpKV5pzUG0Il/UhCYKZhZZFc=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/2] Make git-clone(1) more resilient when using bundle-URI
Date: Fri, 12 Sep 2025 18:46:31 +0200
Message-Id: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdOxGgC/x2MuwqAMAwAf0UyG4iPDvVXxMHaqAFJpVURxH+3O
 B033D2QOAon6IoHIl+SJGiWqixgWkddGMVnh5pqQ5YsuhaPEBTdqX5jPKOghh9+dJVxPDcTEeR
 +jzzL/b/74X0/6xdfMWsAAAA=
X-Change-ID: 20250909-b4-toon-bundle-uri-no-uri-dab15bef3c00
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

I've found a few scenarios where the server can make git-clone(1) abort
in case it sends bogus responses to the bundle-uri command. Because the
use of bundle URI is optional, make git-clone(1) handle these cases
better and enable it to continue the clone.

Greets,
Toon

---
Toon Claes (2):
      bundle-uri: ignore bundles without uri
      bundle-uri: do not abort on invalid packet line

 bundle-uri.c                |  3 +++
 connect.c                   |  4 ++--
 t/t5558-clone-bundle-uri.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)
---
base-commit: ab427cd991100e94792fce124b0934135abdea4b
change-id: 20250909-b4-toon-bundle-uri-no-uri-dab15bef3c00

Best regards,
--  
Toon Claes <toon@iotcl.com>

