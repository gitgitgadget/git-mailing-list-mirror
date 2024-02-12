Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379E45973
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764531; cv=none; b=UZaEREP0tLP1eQ2ifLLg/vU/aRsvuSQpfPOcTxTUDUE5qkMGLWEUdfqCDbqLkl2o1L8lepL/tjv1JyaE6dsCQnYFYeCa5b55QaNFuqqciyocxsrQw84m+lQFM4x0H6itU8namLhhZ/76QRjEDsvq9JsxanpVxvigJdqHHCE5lBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764531; c=relaxed/simple;
	bh=LBdzt/YOnmHSk87WwpWydZAMLINwZEeDasaEyfNGr+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDN+tZzABdSaj8xwkbpfbi3lZKsAlQujywYE6cIvmJrBqoPt7ljAyPnPj5yfnKz6su1aWqgeSVmgWHQ/IixLdocyULaiSiBTF36SKJgHuvqrkEfpqdQ3KTxzfUCLtD6+JUrOmbGvzEg/PdizmA6BORXnL6nxl5QRe5kzfJrcTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jYHB+Swp; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jYHB+Swp"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E91D92CE41;
	Mon, 12 Feb 2024 14:02:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LBdzt/YOnmHSk87WwpWydZAMLINwZEeDasaEyf
	NGr+o=; b=jYHB+Swp1kXVQU4uz+e62iB4KwQ9vAf0dr6CJXuWR+a0JFSENxLgLI
	oVoMImHP3phKjzrdzDJUAYkNMI/KHJ3v9OOAWhtbP1w7F5Nq7mWbUyhjKwUyEZ2+
	7+q+fv13yBiyMCRcxQsIydPTtqVdhPK8XNdFSvhgIDePGFr/AKUto=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E16912CE40;
	Mon, 12 Feb 2024 14:02:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86E3B2CE3C;
	Mon, 12 Feb 2024 14:02:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [BUG] git 2.44.0-rc0 t0080.1 Breaks on NonStop x86 and ia64
In-Reply-To: <010601da5ddd$3dec41a0$b9c4c4e0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 12 Feb 2024 12:59:31
	-0500")
References: <000401da5c4c$fd4ad260$f7e07720$@nexbridge.com>
	<xmqqbk8nbvqy.fsf@gitster.g>
	<002a01da5c94$a1bc5340$e534f9c0$@nexbridge.com>
	<00fa01da5dcd$5b060150$111203f0$@nexbridge.com>
	<xmqqzfw57hw0.fsf@gitster.g>
	<010601da5ddd$3dec41a0$b9c4c4e0$@nexbridge.com>
Date: Mon, 12 Feb 2024 11:02:03 -0800
Message-ID: <xmqqil2t5wwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3691ECD0-C9D9-11EE-B7CD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

<rsbecker@nexbridge.com> writes:

> On Monday, February 12, 2024 11:43 AM, Junio C Hamano wrote:
>><rsbecker@nexbridge.com> writes:
>>
>>>>This looks like a good plan.
>>>
>>> This might be trivial, but I cannot tell. The #ifndef should be changed
> as
>>> follows:
>>
>>https://lore.kernel.org/git/xmqqttmf9y46.fsf@gitster.g/
>
> I applied this fix but there is no improvement in the result from the last
> report. actual just has two lines. expect looks reasonable. I still had to
> modify the #ifndef.
>
> I have tried cherry-picking the change (no effect), building on master,
> next... am lost.

We seem to be looking at something totally different.  The later
patch in question (not the "looks like a good plan" outline) does
not have any #ifndef and applies the make_relative() logic
everywhere.

I would suspect that cherry-picking f6628636 (unit-tests: do show
relative file paths on non-Windows, too, 2024-02-11) would be the
simplest.

--- >8 ---
Subject: [PATCH] unit-tests: do show relative file paths on non-Windows, too

There are compilers other than Visual C that want to show absolute
paths.  Generalize the helper introduced by a2c5e294 (unit-tests: do
show relative file paths, 2023-09-25) so that it can also work with
a path that uses slash as the directory separator, and becomes
almost no-op once one-time preparation finds out that we are using a
compiler that already gives relative paths.  Incidentally, this also
should do the right thing on Windows with a compiler that shows
relative paths but with backslash as the directory separator (if
such a thing exists and is used to build git).

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/unit-tests/test-lib.c | 61 +++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 7bf9dfdb95..66d6980ffb 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -21,12 +21,11 @@ static struct {
 	.result = RESULT_NONE,
 };
 
-#ifndef _MSC_VER
-#define make_relative(location) location
-#else
 /*
  * Visual C interpolates the absolute Windows path for `__FILE__`,
  * but we want to see relative paths, as verified by t0080.
+ * There are other compilers that do the same, and are not for
+ * Windows.
  */
 #include "dir.h"
 
@@ -34,32 +33,66 @@ static const char *make_relative(const char *location)
 {
 	static char prefix[] = __FILE__, buf[PATH_MAX], *p;
 	static size_t prefix_len;
+	static int need_bs_to_fs = -1;
 
-	if (!prefix_len) {
+	/* one-time preparation */
+	if (need_bs_to_fs < 0) {
 		size_t len = strlen(prefix);
-		const char *needle = "\\t\\unit-tests\\test-lib.c";
+		char needle[] = "t\\unit-tests\\test-lib.c";
 		size_t needle_len = strlen(needle);
 
-		if (len < needle_len || strcmp(needle, prefix + len - needle_len))
-			die("unexpected suffix of '%s'", prefix);
+		if (len < needle_len)
+			die("unexpected prefix '%s'", prefix);
+
+		/*
+		 * The path could be relative (t/unit-tests/test-lib.c)
+		 * or full (/home/user/git/t/unit-tests/test-lib.c).
+		 * Check the slash between "t" and "unit-tests".
+		 */
+		prefix_len = len - needle_len;
+		if (prefix[prefix_len + 1] == '/') {
+			/* Oh, we're not Windows */
+			for (size_t i = 0; i < needle_len; i++)
+				if (needle[i] == '\\')
+					needle[i] = '/';
+			need_bs_to_fs = 0;
+		} else {
+			need_bs_to_fs = 1;
+		}
 
-		/* let it end in a directory separator */
-		prefix_len = len - needle_len + 1;
+		/*
+		 * prefix_len == 0 if the compiler gives paths relative
+		 * to the root of the working tree.  Otherwise, we want
+		 * to see that we did find the needle[] at a directory
+		 * boundary.  Again we rely on that needle[] begins with
+		 * "t" followed by the directory separator.
+		 */
+		if (fspathcmp(needle, prefix + prefix_len) ||
+		    (prefix_len && prefix[prefix_len - 1] != needle[1]))
+			die("unexpected suffix of '%s'", prefix);
 	}
 
-	/* Does it not start with the expected prefix? */
-	if (fspathncmp(location, prefix, prefix_len))
+	/*
+	 * Does it not start with the expected prefix?
+	 * Return it as-is without making it worse.
+	 */
+	if (prefix_len && fspathncmp(location, prefix, prefix_len))
 		return location;
 
-	strlcpy(buf, location + prefix_len, sizeof(buf));
+	/*
+	 * If we do not need to munge directory separator, we can return
+	 * the substring at the tail of the location.
+	 */
+	if (!need_bs_to_fs)
+		return location + prefix_len;
+
 	/* convert backslashes to forward slashes */
+	strlcpy(buf, location + prefix_len, sizeof(buf));
 	for (p = buf; *p; p++)
 		if (*p == '\\')
 			*p = '/';
-
 	return buf;
 }
-#endif
 
 static void msg_with_prefix(const char *prefix, const char *format, va_list ap)
 {
-- 
2.44.0-rc0


