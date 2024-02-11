Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1887F1E506
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707667090; cv=none; b=Dh3VNjU5+GExpzE6o5lAQS9haMcBxk08Y5JJbKpQynAoMP3mmPsdRXz/X7CeIrbxosWX+kRbFEw4CohuQcWjDpgY94lq3gLCmu2E2Myz8atCgbbxaFClEReRXscG40mVCqCmam+qlNoQd8Zsmv35wLEI+MKS2yUlSg7Jt19g9X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707667090; c=relaxed/simple;
	bh=ob9DSTvK9MQB4Tt37LViNibOKpyPROa2ZAEA5E/Nnuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qh0G6XbsVul1cff6Qgd/fHlM4Sgg21WRXgCgwET9G141uXe822BTBsq9x695OLgrKmdSC/PqEDq33dDeyL6oJ4AIrAZDDL8qaFXkJifodj8gYJQEE0j7HTcLwjpW9whg0M34OqicXvzgL/VcI6iZ+2c34kRpkHxX4G2z7PXkY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ig7C69Ty; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ig7C69Ty"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CB951D50EE;
	Sun, 11 Feb 2024 10:58:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ob9DSTvK9MQB4Tt37LViNibOKpyPROa2ZAEA5E
	/Nnuk=; b=ig7C69TyszSD97lw7cdqHs4xhgR4TgQh4UF+raOhkFiII7ahX+REIu
	9PpIg5Hq12yDnep769KS+AR337byM8/dcGTGO17XlRd+bwHq+Y/3tYuq2ecMWeCs
	V0B8WtMAeDszxZ5zTwWf390dpZNNf4iUy6d+4/T59jx915fUS/3qU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64A281D50ED;
	Sun, 11 Feb 2024 10:58:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCAC91D50EC;
	Sun, 11 Feb 2024 10:58:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2] unit-tests: do show relative file paths on non-Windows, too
In-Reply-To: <6872b42d-8763-44dc-9502-2362d1ed80a7@gmail.com> (Phillip Wood's
	message of "Sun, 11 Feb 2024 11:03:55 +0000")
References: <xmqqttmf9y46.fsf@gitster.g>
	<6872b42d-8763-44dc-9502-2362d1ed80a7@gmail.com>
Date: Sun, 11 Feb 2024 07:58:04 -0800
Message-ID: <xmqqle7r9enn.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 57F054FE-C8F6-11EE-9A29-25B3960A682E-77302942!pb-smtp2.pobox.com

>
> We know which separator we're expecting so we could replace  the last
> two comparisons with
>
> 		prefix[prefix_len -1] != needle[1]
>
> but as I say I'm not sure that is worth re-rolling for

There is a larger clean-up opportunity to drop the need for making a
copy, which probably is worth doing, so I folded the above into this
version.

------- >8 ------------- >8 ------------- >8 ------------- >8 -------

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

  * I found that the diff relative to the result of applying v1 was
    easier to follow than the range-diff, so here it is.

  diff --git c/t/unit-tests/test-lib.c w/t/unit-tests/test-lib.c
  index 83c9eb8c59..66d6980ffb 100644
  --- c/t/unit-tests/test-lib.c
  +++ w/t/unit-tests/test-lib.c
  @@ -64,34 +64,33 @@ static const char *make_relative(const char *location)
   		 * prefix_len == 0 if the compiler gives paths relative
   		 * to the root of the working tree.  Otherwise, we want
   		 * to see that we did find the needle[] at a directory
  -		 * boundary.
  +		 * boundary.  Again we rely on that needle[] begins with
  +		 * "t" followed by the directory separator.
   		 */
   		if (fspathcmp(needle, prefix + prefix_len) ||
  -		    (prefix_len &&
  -		     prefix[prefix_len - 1] != '/' &&
  -		     prefix[prefix_len - 1] != '\\'))
  +		    (prefix_len && prefix[prefix_len - 1] != needle[1]))
   			die("unexpected suffix of '%s'", prefix);
  -
   	}
   
   	/*
  -	 * If our compiler gives relative paths and we do not need
  -	 * to munge directory separator, we can return location as-is.
  +	 * Does it not start with the expected prefix?
  +	 * Return it as-is without making it worse.
   	 */
  -	if (!prefix_len && !need_bs_to_fs)
  +	if (prefix_len && fspathncmp(location, prefix, prefix_len))
   		return location;
   
  -	/* Does it not start with the expected prefix? */
  -	if (fspathncmp(location, prefix, prefix_len))
  -		return location;
  +	/*
  +	 * If we do not need to munge directory separator, we can return
  +	 * the substring at the tail of the location.
  +	 */
  +	if (!need_bs_to_fs)
  +		return location + prefix_len;
   
  -	strlcpy(buf, location + prefix_len, sizeof(buf));
   	/* convert backslashes to forward slashes */
  -	if (need_bs_to_fs) {
  -		for (p = buf; *p; p++)
  -			if (*p == '\\')
  -				*p = '/';
  -	}
  +	strlcpy(buf, location + prefix_len, sizeof(buf));
  +	for (p = buf; *p; p++)
  +		if (*p == '\\')
  +			*p = '/';
   	return buf;
   }
   

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

