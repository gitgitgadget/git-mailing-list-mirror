Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40190155744
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817217; cv=none; b=UHtWPDYnWO3EWu0o48NfkFdsm9FojDr8TbKRmim4z0nTOkwYPjBQb7Zqi/t31n5xQUwGVhLUnzF5Fbdyh6i35S9U2UOm7M6sMH2VB/rpu/hmUdckK4QF5Ack2/Zvv5R4gQ8j6S5Sv3K+VzlasaBdT5CVae9WQBZHhMX9vGE6PA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817217; c=relaxed/simple;
	bh=JzBEFEUnR8As3RhIvcBB4ZvUgueYTN/7Xwr+alSwOMI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jPLrZixnoC7FBYWARmukdwO6/QER/yLmXsCOX+VMAqvbCQ7oCXJSh2CpxX3TvAAiEFszRuyChVYVmCIqskw/Nev3E+3w3pb/lDUeVQQMZZgH0cT5oxYGL7MD3r6cM40tkdHYbvkXExXgGxPt6w5LLHPPqG94FhBWGhWl5/FYhDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=CRyxv4F9; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="CRyxv4F9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718817200; x=1719422000; i=l.s.r@web.de;
	bh=GdZMsX8Mg5zgDf5BYdU0wibjZaV17STZPzNsEuIoJuk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CRyxv4F9DcsMrXTGaz2YCKccFWf3pTXFjVZpamQH5Cm6PQH5XCsf1phgtEj7Z2/W
	 q0IEPlDmubTubwHIU6xheXloc2s+AT0B7PAn8cTzApPz4vGc/454x/pfYHX328Qan
	 vH700AHcLSIgryRBwxndtYRvxvmyNYTQgC2ivIShFgF2fryo7QX+FCa/qCTMK0gCN
	 S1ss3j0pjDSo6Zo0P2ipfYKZbRFT4X+W5cZ1Whc18qEq2Wn9UHBSMSiH6Xgam2Qlu
	 L/6H0TCZquQWxxT5Rhpm4wDFDrkWLVl+vploGq3pismDUn0Ma3mtjFjF+Vp6cczpH
	 /RShYrNPsjtA7ycdVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Igv-1sXeJ63lkF-013nzH; Wed, 19
 Jun 2024 19:13:19 +0200
Message-ID: <0d85712c-5beb-4a64-a7f4-797782c26694@web.de>
Date: Wed, 19 Jun 2024 19:13:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/2] commit: remove find_header_mem()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>, Jeff King <peff@peff.net>,
 Kyle Lippincott <spectral@google.com>, John Cai <johncai86@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de>
 <8b350cae-2180-4ac7-a911-d40043576445@web.de>
Content-Language: en-US
In-Reply-To: <8b350cae-2180-4ac7-a911-d40043576445@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a1cE0dxix7oEXPbQDBJkl/xLSS/SvzJonp9/VqvWPhl0PqrMYhF
 MYZuZQ9kUC+TGkl9lAsjzuOw+2V6CDi+NiDJAVt6cora34f4X/qbh8tS7YjTpErsbrnNTB5
 6V28gUWU1wqsSUrCYhQMG9AGqr9BHhBZjELG94nnUMo4eM2cZPvFYA+eEl7XC7kcJYXGkdK
 Q9wQ7jweqIDoXLYhFM5pg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5KAdszFmKag=;gUaaC3v79i2pS7nQfR0oCQI2uYh
 F5sLanaUal0wt7jwR4IbSvpwEZcaLQqZxSUkiAc4I7SWIOI0PST9ILGyGO/6B36irq3ESebnq
 iNhN3AcaJWMu4LMco4/fMvSKG8pQI6Iq2VLCTAf6kl8vNuYMbQ+h4s7KgGu5gqIOUpV7PrAIw
 8S1Hax5WB49pg7/ndIlHPGv7NGH6Xk55EZzcU0wRQg3piYvlVmzzSLyurinK8/mC4y3cGG50/
 cm7gwL59+ZWN+6NIS5xhi8Sqyd8oEOW3/pYUWLodU/Xth+yGbp3YeQGpQWyRVoC3u873QtUqD
 zSKrxmYYircNM/seGRpOXK0+GJuixrPUmeBxV5KXBYVb6KlfMY5+Ij7LY0fMrNfM2mI2r5t64
 +peJEImyI2hajy3E8XzvvfGODKC6yQTAs2UudsAskw7fs8LT8TFFkutpn9WGCEooOSl3qMLVK
 yyG/ZkKhuaHZndUJapnB8CCXpA6qmKbDi1cHq2FBZsZdMYTVTUBd+OaPMzepj3WQvaJBLBJYb
 8EjiGCAGBqWWH97sn/extkDJuPZmrbZO0zP/z0Yry58QX/Kg9lNKPxNXXuIwX56dqI6T+vaTd
 /s5MDQbX7+b4ZLdwsH6YwOSGwrO0xFTUZ7TrqEwSpfqfE7BacweeQR9925ijp64nSw6wLmd/V
 SmPGv0eo2jsFp0iLi3V8Oj4WY0onjCsifnTRlKmtENsRYlb0jblNR9Xop+wr3YFNykQq7cbmF
 rMozIOe/PF/2HhCnCkTRSOBsT6QCxTlnFwRnRCVRbbjVHJZXg7d7wkCqNTlsIv8Xo94xfL1Ut
 0Z8sU5wXHctmjqQZwAsxbmWRXHGNC0162q18dL5Agpuaw=

cfc5cf428b (receive-pack.c: consolidate find header logic, 2022-01-06)
introduced find_header_mem() and turned find_commit_header() into a thin
wrapper.  Since then, the latter has become the last remaining caller of
the former.  Remove it to restore find_commit_header() to the state
before cfc5cf428b, get rid of a strlen(3) call and resolve a NEEDSWORK
note in the process.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c | 16 ++--------------
 commit.h |  5 -----
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/commit.c b/commit.c
index 1d08951007..aacc401e72 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -1870,20 +1870,12 @@ struct commit_list **commit_list_append(struct com=
mit *commit,
 	return &new_commit->next;
 }

-const char *find_header_mem(const char *msg, size_t len,
-			const char *key, size_t *out_len)
+const char *find_commit_header(const char *msg, const char *key, size_t *=
out_len)
 {
 	int key_len =3D strlen(key);
 	const char *line =3D msg;

-	/*
-	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
-	 * given by len. However, current callers are safe because they compute
-	 * len by scanning a NUL-terminated block of memory starting at msg.
-	 * Nonetheless, it would be better to ensure the function does not look
-	 * at msg beyond the len provided by the caller.
-	 */
-	while (line && line < msg + len) {
+	while (line) {
 		const char *eol =3D strchrnul(line, '\n');

 		if (line =3D=3D eol)
@@ -1900,10 +1892,6 @@ const char *find_header_mem(const char *msg, size_t=
 len,
 	return NULL;
 }

-const char *find_commit_header(const char *msg, const char *key, size_t *=
out_len)
-{
-	return find_header_mem(msg, strlen(msg), key, out_len);
-}
 /*
  * Inspect the given string and determine the true "end" of the log messa=
ge, in
  * order to find where to put a new Signed-off-by trailer.  Ignored are
diff --git a/commit.h b/commit.h
index 62fe0d77a7..3084f591fd 100644
=2D-- a/commit.h
+++ b/commit.h
@@ -280,17 +280,12 @@ void free_commit_extra_headers(struct commit_extra_h=
eader *extra);

 /*
  * Search the commit object contents given by "msg" for the header "key".
- * Reads up to "len" bytes of "msg".
  * Returns a pointer to the start of the header contents, or NULL. The le=
ngth
  * of the header, up to the first newline, is returned via out_len.
  *
  * Note that some headers (like mergetag) may be multi-line. It is the ca=
ller's
  * responsibility to parse further in this case!
  */
-const char *find_header_mem(const char *msg, size_t len,
-			const char *key,
-			size_t *out_len);
-
 const char *find_commit_header(const char *msg, const char *key,
 			       size_t *out_len);

=2D-
2.45.2
