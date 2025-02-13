Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E1280A4B
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486852; cv=none; b=hYPM7e3J+g/P6R0KAJplP6omHUW3YpHIRdm01iU3ZS60LgYVFwnFLpYA6HGipThGEeZHgTjluvWswMfNXZQdtq/yvwYatGp3zsJsqQXE1XmF8h4IVi+V8+0ODE+Y3B9ZmkO0yz4wMxa3yQY0D1vVt1sZyVgIm9CffvQG21E8DVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486852; c=relaxed/simple;
	bh=d3DeJPucJcYNDXnZ5BBx5/jt7PdSFNKeCPhJG6ZoQ0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ubThfghlA9ugv54Rfj0c5i69D6WbETWK6AnyRjhyUFxKQDpIOUDK0YSadWvJPRFn9DHqk/P1FWQiHrUrrS08uU5jzMohOjVG5Jy/kqySEih2b51GFl2NLb+vqI5ORFF7sIejZ5Zg7vNrSXZ9s9qOtcDg7Ss7JUPR9s3jPJLIjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkSqomlv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkSqomlv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739486851; x=1771022851;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=d3DeJPucJcYNDXnZ5BBx5/jt7PdSFNKeCPhJG6ZoQ0I=;
  b=ZkSqomlv3g2WjKQr3huJ2Q8BaYfprwi1bXGiz6Wt82yjnrmCtv2vSl7l
   6re9TCQ1L/AkUerZE28WTxtBjmBZ6uVKJeP3UAe62yFWNPYMkXafQh3KH
   X5YZu7tRORWknQPP+l/HgPD+FPltGgKmmgR7ZNry3HPy50ZVnXm1H2MHn
   BCL2j2GoEIUrsRAaW0BlC3BBRKFD+64hLPSe7D5K9ayWpyaBej2ii0FO5
   H3t0CsQxFlqxfi7fYp4ty9Awx4ucx6yEQ72/5PdURrAb7G6UQIhiGd7K6
   N7+VNxArg/8YYQzNv202v1noMsTUdpL0T+14cjr7BEdjKavlPPuqJhGVL
   g==;
X-CSE-ConnectionGUID: lwmJk5JURLSXIMc5ED6jHA==
X-CSE-MsgGUID: Keg6ShB5QY28aOr7KNXujw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40092439"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40092439"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:47:30 -0800
X-CSE-ConnectionGUID: 7z3sbMxXSHmcxWit0rk7VQ==
X-CSE-MsgGUID: zl6QCxx0QO6W7XrL0Q7G3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136516050"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:47:30 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 13 Feb 2025 14:47:22 -0800
Subject: [PATCH RFC] mailmap: fix check-mailmap with full mailmap line
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-jk-fix-sendemail-mailinfo-v1-1-c0b06c215f21@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHl2rmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0Nj3axs3bTMCt3i1LyU1NzEzBxdEJGZl5ava2yUZmBknmSYZJlqrgT
 UX1CUClQJNjtaKcjNWSm2thYA3S+iR3AAAAA=
X-Change-ID: 20250213-jk-fix-sendemail-mailinfo-32f027b1b9e7
To: git <git@vger.kernel.org>
Cc: Jacob Keller <jacob.keller@gmail.com>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

I recently had reported to me a crash from a coworker using the recently
added sendemail mailmap support:

  3724814 Segmentation fault      (core dumped) git check-mailmap "bugs@company.xx"

This appears to happen because of the NULL pointer name passed into
map_user(). Fixing this, by assigning the name to be the empty string I
still saw somewhat unexpected results.

With a mailmap file containing:

A <a@domain.com> B <b@domain.com>

I get the following unexpected result:

$ git check-mailmap b@domain.com
<b@domain.com>

Based on my interpretation of the mailmap documentation, I would have
expected this to translate to "A <a@domain.com>".

I checked the map_user implementation, and noticed that it has a block
to perform a name lookup with lookup_prefix on the subitems under the
email. This appears to fail when given the empty string, as it somehow
doesn't consider the empty string as a valid prefix for any of the
names. It then defaults to using the "simple" entry of the map.

This doesn't make sense, because "full" mailmap entries (those with both
an email and an old name) don't store anything in the
mailmap_entry->name and mailmap_entry->email. At least, not without a
shortform entry filling that in.

This results in the item having a NULL name and email, which triggers
the early return and results in failure to update the return parameters.

I tried my hand at fixing this with a new check to select the only entry
in a mailmap entry with a single subitem. This fixed my test case, but
resulted in a different test case failure, which I don't quite
understand. The whitespace syntax test now seems to fail expectations by
translating a previously untranslated name.

I suspect this isn't the most elegant solution to the situation, and I
don't fully grasp the mailmap code, so help would be appreciated in
finding a good solution.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/check-mailmap.c |  2 +-
 mailmap.c               |  9 ++++++++-
 t/t4203-mailmap.sh      | 12 ++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index df00b5ee13adb87881b8c1e92cac256e6ad319d1..be2cebe12152e38d3bb8cf12948823c8d710bdda 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -35,7 +35,7 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
 		mail = ident.mail_begin;
 		maillen = ident.mail_end - ident.mail_begin;
 	} else {
-		name = NULL;
+		name = "";
 		namelen = 0;
 		mail = contact;
 		maillen = strlen(contact);
diff --git a/mailmap.c b/mailmap.c
index f35d20ed7fd1ef251e65419805fec49a3c30bcbb..7237ceef8a32a66183e4bbbe4ea01c4ea0264cd4 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -297,7 +297,7 @@ int map_user(struct string_list *map,
 	item = lookup_prefix(map, *email, *emaillen);
 	if (item) {
 		me = (struct mailmap_entry *)item->util;
-		if (me->namemap.nr) {
+		if (me->namemap.nr > 1) {
 			/*
 			 * The item has multiple items, so we'll look up on
 			 * name too. If the name is not found, we choose the
@@ -307,6 +307,13 @@ int map_user(struct string_list *map,
 			subitem = lookup_prefix(&me->namemap, *name, *namelen);
 			if (subitem)
 				item = subitem;
+		} else if (me->name == NULL && me->email == NULL &&
+			   me->namemap.nr == 1) {
+			/*
+			 * The item has one subitem, but no simple entry. Use
+			 * the full entry.
+			 */
+			item = &me->namemap.items[0];
 		}
 	}
 	if (item) {
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 24214919312777b76e4d3b2b784bcb953583750a..2aab735d2b326caf0d904cb6eee3d602fad96997 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -113,6 +113,18 @@ test_expect_success 'check-mailmap --stdin simple address: no mapping' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check-mailmap name and address: mapping' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	Bug Reports <bugs-new@company.xx> Bugs <bugs@company.xx>
+	EOF
+	cat >expect <<-EOF &&
+	Bug Reports <bugs-new@company.xx>
+	EOF
+	git check-mailmap "bugs@company.xx" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'No mailmap' '
 	cat >expect <<-EOF &&
 	$GIT_AUTHOR_NAME (1):

---
base-commit: 5ffbd7fcf84b313bb07e91246eb9419ebd94a7e7
change-id: 20250213-jk-fix-sendemail-mailinfo-32f027b1b9e7

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

