Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA422D4DC
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017692; cv=pass; b=CzUAz2ve8PAyVYnENiI0NsS2G9dWigbTSLBENapqRHhwF8FXa1K/MFI4GSOdl3i28uTQJiJgm0rsRVK1r9mKgXF2fTYyKbHnLAB/uSn513M/2DzzCr6oxPyWNQ/yCr5C4uzOCH95sEhb9YWTcGRpL/h1L8oWPMARE13McNdCqFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017692; c=relaxed/simple;
	bh=W7vu1Yor8HNpw1jJeQwhYXd4MPMEq8KazGGU+WMaAyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/qwsj8n5NpyRRdKKRxSEFpFAokh17AYkA3Pv6mpX+oCfyUOB92T99FYDY08FrYCDQ3UErehO3FMuuy9Eqj7y162bK3AtR1+sLYdCKTJPNSexjKde0B35961EE7/OSkFhD5h2A2HIrC4W/UgotmeHPBgZE2xqgqyX1pPnkJ80iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=X0nQF/eA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="X0nQF/eA"
ARC-Seal: i=1; a=rsa-sha256; t=1773017679; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KpCfcBQ/m6XN4l8+jf3z6+uYU49uWMABzHE0DjzT51cwumAjAr3nYzYfi032YMXyMUP2kO41kW5kcEzYNMomXnpTYJDJOKN20Mrep6RPOKhbY+Q7D00P7nVX1qvDRS7avILSoYfxAChbkC+Z5squuAcScAgCOFtHgQOfLc1cc+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773017679; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3LdwycHwIP6gu2YnbPSMWci67UfUBTmaQxKMYJemrys=; 
	b=kjBonT72iQM1g1IgG85lV8+mcpZxS8ymy7otrttM8sPX7eJmjyO1ezIrq08griQu6/YhP8CB08UvhHJpurvwBBx8md54NzFSeI9oliZIzKPIbMwr9RdD5X97thdgv8jj3m4ykWc3PObJhPXe2np5gq05Ei0x3eLGvB8vqQr73Cw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773017679;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3LdwycHwIP6gu2YnbPSMWci67UfUBTmaQxKMYJemrys=;
	b=X0nQF/eA+rxhTb0UdAETtrqDM5FCFiTr2MU66DkO24acLE6HIp6NU9WskH9uRfL0
	T1V8zJ7Ty//JYqqyE4f/i/EJavVlafrQ8cViFLsDPB7sdG0eaY0hlAd3IS7YbwLEl1M
	ND0y93hKonrIeSlv7V/0w5dzOEAOBdZv+Xuqpbxg=
Received: by mx.zohomail.com with SMTPS id 1773017677770154.00984722953945;
	Sun, 8 Mar 2026 17:54:37 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 01/10] hook: move unsorted_string_list_remove() to string-list.[ch]
Date: Mon,  9 Mar 2026 02:54:07 +0200
Message-ID: <20260309005416.2760030-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Move the convenience wrapper from hook to string-list since
it's a more suitable place. Add a doc comment to the header.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c        | 8 --------
 string-list.c | 9 +++++++++
 string-list.h | 8 ++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/hook.c b/hook.c
index 2c8252b2c4..313a6b9937 100644
--- a/hook.c
+++ b/hook.c
@@ -110,14 +110,6 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 	string_list_append(hook_list, hook_path)->util = h;
 }
 
-static void unsorted_string_list_remove(struct string_list *list,
-					const char *str)
-{
-	struct string_list_item *item = unsorted_string_list_lookup(list, str);
-	if (item)
-		unsorted_string_list_delete_item(list, item - list->items, 0);
-}
-
 /*
  * Callback struct to collect all hook.* keys in a single config pass.
  * commands: friendly-name to command map.
diff --git a/string-list.c b/string-list.c
index fffa2ad4b6..d260b873c8 100644
--- a/string-list.c
+++ b/string-list.c
@@ -281,6 +281,15 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
 	list->nr--;
 }
 
+void unsorted_string_list_remove(struct string_list *list, const char *str,
+				 int free_util)
+{
+	struct string_list_item *item = unsorted_string_list_lookup(list, str);
+	if (item)
+		unsorted_string_list_delete_item(list, item - list->items,
+						 free_util);
+}
+
 /*
  * append a substring [p..end] to list; return number of things it
  * appended to the list.
diff --git a/string-list.h b/string-list.h
index 3ad862a187..b86ee7c099 100644
--- a/string-list.h
+++ b/string-list.h
@@ -265,6 +265,14 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
  */
 void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
 
+/**
+ * Remove the first item matching `str` from an unsorted string_list.
+ * No-op if `str` is not found. If `free_util` is non-zero, the `util`
+ * pointer of the removed item is freed before deletion.
+ */
+void unsorted_string_list_remove(struct string_list *list, const char *str,
+				 int free_util);
+
 /**
  * Split string into substrings on characters in `delim` and append the
  * substrings to `list`.  The input string is not modified.
-- 
2.52.0.732.gb351b5166d.dirty

