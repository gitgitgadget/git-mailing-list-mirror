Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24B132FA37
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636410; cv=pass; b=C6GDir88Po8E8iPxxVOlqGR061qZ/tJtvOc/fk8XVD5daqiSdzJJ6AgzS9cOxyr7pGPReFpTI1QPCMCZG5zLg77qGavl+ZCNxoiJjbaGLcOQy5XNMNyqznDZqaUdgoBlBNTdRK7ogM6VcyNNBNnQd+1DvyZv8jtonvfrZid0zmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636410; c=relaxed/simple;
	bh=vs89yRHNgCEnE8EpsiWj+kb1jqH4wo5d1t8z9+SAmgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyfX6fpxjQGTDjnDMwNm8kmj9dY2fwWYqbb7xELEKVSXU2Y9aodmbU8nRIan4j9KkL/yBUbn5PQVAQmRAEL1KBK1QIlarpTNFgd1+VSwzlQD1uM+x6uUJQ+jTgvFiVYtDBlLmt6BxobzvnU6Q0MDoThf91SHOgu3uwjw61dEVTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=i+h9LSfk; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="i+h9LSfk"
ARC-Seal: i=1; a=rsa-sha256; t=1769636395; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mkQA7vYzzpOc3M9CUjN2S120/z77BxwIKs4N0baKqf4jeW+SYG60klKLox6iK8T+LpLR5KrqJVi41FdGzY/Ikmo6OaH9hAPIJc/UQIrmpVUBSvLTriDBX8W48rHAYXqyiEcCZEkjwRL5I3ZoZT797TRWuqI9u2I6ZJvBe6jRodc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769636395; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iiyOFKHCKYmRp131CgAbZIANvcG4h888TEs6QvTXasE=; 
	b=N2becXKVdhlt7gJ5D9xZgMH/RNMhdsXGhhunZ9PsAO1GHSbaI3QAJJZM4BRoLteD3gBrGY3lDF2wvlcSp4apNfUFbPuIaNLP1uPVeMZFCkQzo/jOu/0JW72BId8d+sFrs9Mpcz3EF5F6GihI7EruTR9AQ5AonnhmEqVFtYfIeC8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769636395;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iiyOFKHCKYmRp131CgAbZIANvcG4h888TEs6QvTXasE=;
	b=i+h9LSfkuXWTwRNVvfrEzREczmTD6ERUYD0z0hPqd7lcnJvN06q3mKUKvZ7lZkAb
	ogVWOCtN30Hvw7ZhlUQP3mAfbMRI34F+bTrW4GWo1pxewXXv3zwL2h+ooDyaI0vLbC8
	2xSUTIyHKbT3sxodDsBSDpGHpvGEkdJ3S22t8v4s=
Received: by mx.zohomail.com with SMTPS id 17696363934101000.0033557000909;
	Wed, 28 Jan 2026 13:39:53 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 02/12] run-command: add helper for pp child states
Date: Wed, 28 Jan 2026 23:39:17 +0200
Message-ID: <20260128213927.3026875-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260128213927.3026875-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260128213927.3026875-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

There is a recurring pattern of testing parallel process child states
and file descriptors to determine if a child is running, receiving any
input or if it's ready for cleanup.

Name the pp_child structure and introduce a helper to make the checks
more readable.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 run-command.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..3989673569 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1478,15 +1478,22 @@ enum child_state {
 	GIT_CP_WAIT_CLEANUP,
 };
 
+struct parallel_child {
+	enum child_state state;
+	struct child_process process;
+	struct strbuf err;
+	void *data;
+};
+
+static int child_is_working(const struct parallel_child *pp_child)
+{
+	return pp_child->state == GIT_CP_WORKING;
+}
+
 struct parallel_processes {
 	size_t nr_processes;
 
-	struct {
-		enum child_state state;
-		struct child_process process;
-		struct strbuf err;
-		void *data;
-	} *children;
+	struct parallel_child *children;
 	/*
 	 * The struct pollfd is logically part of *children,
 	 * but the system call expects it as its own array.
@@ -1509,7 +1516,7 @@ static void kill_children(const struct parallel_processes *pp,
 			  int signo)
 {
 	for (size_t i = 0; i < opts->processes; i++)
-		if (pp->children[i].state == GIT_CP_WORKING)
+		if (child_is_working(&pp->children[i]))
 			kill(pp->children[i].process.pid, signo);
 }
 
@@ -1665,7 +1672,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 
 	/* Buffer output from all pipes. */
 	for (size_t i = 0; i < opts->processes; i++) {
-		if (pp->children[i].state == GIT_CP_WORKING &&
+		if (child_is_working(&pp->children[i]) &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
 			int n = strbuf_read_once(&pp->children[i].err,
 						 pp->children[i].process.err, 0);
@@ -1683,7 +1690,7 @@ static void pp_output(const struct parallel_processes *pp)
 {
 	size_t i = pp->output_owner;
 
-	if (pp->children[i].state == GIT_CP_WORKING &&
+	if (child_is_working(&pp->children[i]) &&
 	    pp->children[i].err.len) {
 		strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
@@ -1748,7 +1755,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 			 * running process time.
 			 */
 			for (i = 0; i < n; i++)
-				if (pp->children[(pp->output_owner + i) % n].state == GIT_CP_WORKING)
+				if (child_is_working(&pp->children[(pp->output_owner + i) % n]))
 					break;
 			pp->output_owner = (pp->output_owner + i) % n;
 		}
-- 
2.52.0.732.gb351b5166d.dirty

