Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631412D97A5
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725028; cv=none; b=KrpY/QWhMFSoHvSfgKzUSHxMyIyx/BELSc+JCkq4wFyMG4eOVUFs15+lS5E/7aHePTgfDKzUV2eZ7hoY0hGy+Mu80yrqrtuoO86sVZ4Vnwr55wGZbrVsMHoNfgGzDbvAuVx/ZCWhpxXjUqgu4AFExxw1n0/Syqxxy/4igxYR0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725028; c=relaxed/simple;
	bh=BcovSw/ZixsKJLCfVe/uBMwtyhjgaLV0t7nOMq5divM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0A+twDRATeNbuncsOMEkKiDo8/30IBrQSLrd+/irWya7BsTgesecIRoQJPkyykr5qIMx6UmEa4dQwv2S2KDZFJVHHNcecstFrtaUO1W8VFsQRkAHdEKaUm/BsEb1zy361/Fryo5vVfCWsDt3o+CDPJE3xWOyks5LoYjL9kzC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne (unknown [IPv6:2a01:e0a:d1:f360:76fa:3ccb:8c02:b888])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8B17F13F86A;
	Wed, 20 Aug 2025 23:23:39 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3] doc: fix asciidoc format compatibility in pretty-formats.adoc
Date: Wed, 20 Aug 2025 23:23:19 +0200
Message-ID: <20250820212319.41044-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aKJJs7OkBIg7Y9J0@szeder.dev>
References: <aKJJs7OkBIg7Y9J0@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Asciidoc.py and Asciidoctor do not process the '+' verbatim the same way. A
span is detected when the format sign (here '+')is preceded by a non-word
character. It seems that '{nbsp}' is considered a non-word sign by
Asciidoc.py, but not by Asciidoctor.

Using a double format-sign opens 'unconstrained' span, independent on the
preceding character in both engines.

The '+' sign is used instead of the backtick '`' because it is not processed
as synopsis in asciidoc.py. Unfortunately, the post-processing of verbatim
synopsis in asciidoctor cannot be bypassed and formatting of the parentheses
is forced in syntax sign instead of keywords, unless a proper grammar
analyzer is used.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/pretty-formats.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 9ed0417fc8..618ddc4a0c 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -233,11 +233,11 @@ colon and zero or more comma-separated options. Option values may contain
 literal formatting codes. These must be used for commas (`%x2C`) and closing
 parentheses (`%x29`), due to their role in the option syntax.
 +
-** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}+(+".
+** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}++(++".
 ** `suffix=<value>`: Shown after the list of ref names.  Defaults to "+)+".
 ** `separator=<value>`: Shown between ref names.  Defaults to "+,+{nbsp}".
 ** `pointer=<value>`: Shown between HEAD and the branch it points to, if any.
-		      Defaults to "{nbsp}+->+{nbsp}".
+		      Defaults to "{nbsp}++->++{nbsp}".
 ** `tag=<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
 
 +
-- 
2.51.0

