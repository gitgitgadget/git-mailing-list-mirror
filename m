Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CE937E31F
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530463; cv=none; b=pdRgkeY+OI4rfQRKxfl+4XvsyU7YEKB8f6rCJWtb6DFG8LTu8jC2Kb5suedDYTZzeliEGr2HKI/Pjm2krwE/c/+Sl2ByXE5EX4zvHir9BhCp3B1XGWSaat9Fbj7Ii9yAuh+8RzG+KEPY8XHxCe5VtuZCibtuR4YKs3ZuDsNosLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530463; c=relaxed/simple;
	bh=VXZM3zToH+yar9A9vzuPX9GZYeN37wO7PebMY7Na8Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2tjLHhB5OC7Tp5j7dbBMC2a7HJZmY2kTbkEIxDfCxjTdBAPPQNFRuteNepfMBBi8kYGJMA04gn3U0Nh/MemMnlEmlUEyi0XfRAj0TDQVdcAxHkxeT0us0UkuI9pVdxD+qinjPZTj7g/PvhyGeQJhcnHvbSYp6Cv+yeOySAb+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=cU+JsrZ7; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="cU+JsrZ7"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773530454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlUFSM5Ax4F05wzKSFOwuvYlRpbu69tdiF/9u4VaSwg=;
	b=cU+JsrZ7zzZEidrIlrsy6tZzH3xNn7U7dX59vQ6WoJqwl7oS9EZk07iKyGbXcey9FlSGWb
	2SdxG/LSmZV/t6jbGPw+Nw5xDydxMRlqJ7m69FE+ryj9+0JN/ln9inaGfi4OstWt0dfuiR
	74uTZW6zYo2v+RWbjWmesoNsgRj4WXf/zayq9cor9AvIoP2N7CkLoq4zvyg6IKZCKt2VM1
	2NQyGcbhH3tcY7Naobd4bCdDR9Ljp+n04ZVMfolpZezuPfRPosZ1hZcblJhY70DTgjlKcr
	iuyAEgi9XsQR72WpZZdNsC9hso2bOni2Kl3nAqjIHTzvtc+LXGHdsYCr9Ayopw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH 4/7] format.commitListFormat: strip meaning from empty
Date: Sun, 15 Mar 2026 00:20:47 +0100
Message-ID: <1eb2b76eebe8aa7b876c8aaceba4241ccd81ba4f.1773530191.git.mroik@delayed.space>
In-Reply-To: <cover.1773530191.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294; i=mroik@delayed.space; h=from:subject:message-id; bh=VXZM3zToH+yar9A9vzuPX9GZYeN37wO7PebMY7Na8Aw=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBptezDkRReeTbiEMbEXS/RMISmi25t/SFYNNvn3 noslakr53yJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCabXswwAKCRBIeX6hnBm+ 0YpFD/4qjnNgQUwUG7M0idFxXtbOs2MW2HUz+IEemIGbFLklSWVRMPXvXzcVuO7wqTHNDmGnQXj JuQDgGeq2pV3zMxPx1tW2o5NmqmuDNseFhuNxZe1/c8eNkkQrGz4gOEjTmc4+sEE4A6zmSP+tdB hemOaziTd2cFQUSYZu05yblEd9tZ4lcKRgKOMioy+Axs9Bnq6j9DqBnpulv8XLret0wTpjqZltZ kcKlGXPNO7Oy+2r140nmPPYCtzkyimzG+/0as+t+jkoMMsvJ70JU+QXF8nicUn/Xy6l900agvJ8 uBn2GGSFIohOTPhxYTGahtmoCDOnyjjNZxlzkmLCzzWrp5UALcuOHfBHMPLkrUS2CyTe9vqt0KR QJ7wuSzQpMGwJh2KSF9PZ+NgJKJXw1FmYx31UPQck2IAYpYIlS5+wk30zdAa+as9m+jyfPgcxO0 wkvOx0LPI8l43S1MeqHuaXsQwXInXIxj4Qdfr5YjfYu8111W8DFJNNgol5wUKHGhq8TpXS0PVsT RYOFGiv3TSH7SAf19s+Hgif7u/nYeCflrSt/QPNr/EBT96TabI9pmiZKmlmahqfANzwsX+kWYn2 gQQm6VwGyfUT2V+HKZe3pkHGSGTe4KdLoNv00NkGKq8te7jq7tUNrHnT7+i7qcYqK2zJQOVoyZe v4w4PPpB6
 S1yeow==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

The configuration variable format.commitListFormat allows for an empty
value. This is unusual and can create issues when interacting with this
configuration variable through the cli interface.

Strip meaning to format.commitListFormat with an empty value.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c           | 11 +----------
 t/t4014-format-patch.sh | 11 -----------
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a7f129d583..47126f9064 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1055,17 +1055,8 @@ static int git_format_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "format.commitlistformat")) {
-		struct strbuf tmp = STRBUF_INIT;
-		strbuf_init(&tmp, 0);
-		if (value)
-			strbuf_addstr(&tmp, value);
-		else
-			strbuf_addstr(&tmp, "log:[%(count)/%(total)] %s");
-
 		FREE_AND_NULL(cfg->fmt_cover_letter_commit_list);
-		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);
-		strbuf_release(&tmp);
-		return 0;
+		return git_config_string(&cfg->fmt_cover_letter_commit_list, var, value);
 	}
 	if (!strcmp(var, "format.outputdirectory")) {
 		FREE_AND_NULL(cfg->config_output_directory);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index d2a775f78d..ca37f40a6a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -451,17 +451,6 @@ test_expect_success 'cover letter config with count and author' '
 	test_line_count = 2 result
 '
 
-test_expect_success 'cover letter config commitlistformat set but no format' '
-	test_when_finished "rm -rf patches result" &&
-	test_when_finished "git config unset format.coverletter" &&
-	test_when_finished "git config unset format.commitlistformat" &&
-	git config set format.coverletter true &&
-	printf "\tcommitlistformat" >> .git/config &&
-	git format-patch -o patches HEAD~2 &&
-	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*" patches/0000-cover-letter.patch >result &&
-	test_line_count = 2 result
-'
-
 test_expect_success 'cover letter config commitlistformat set to shortlog' '
 	test_when_finished "rm -rf patches result" &&
 	test_when_finished "git config unset format.coverletter" &&
-- 
2.53.0.959.g497ff81fa9

