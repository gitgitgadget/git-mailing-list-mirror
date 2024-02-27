Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB178135A6A
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025461; cv=none; b=FnmRvN8eLjtBScm+Kgt/JUDnBO5NnQpJUgVwg1rmeAxcy+hORdzzdgUNSojylTtFh3U059K8bGuioSvNGFOPl/2cnppN06WbynhfutJBcRie0RNkREqxbmfpo/ZCJD1eBbvdBWgMxAeNUNFSmTfBb61SEqcS6ON9SBqMx4+H1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025461; c=relaxed/simple;
	bh=gJzYYURtOPWrw4NO2nGwgewlQXqmE4MmIfLPpJykbaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlcLtPzLz6pc4MT2dVjsSfOBvJ5/fb+Bkru1+Xwk3z04KnLjv1RPD9OtBkC2LYgwufr+xb6T44ETdPVBy9BkSX132886hcn8LljxzYyKcfO7EvfaQJO89BlklDGxcwNl16SQnKsMJqbbr0oJKPKGLvmrQRoiF3TjGqUDTT5q1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=eQtk91p5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aznaYZh2; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="eQtk91p5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aznaYZh2"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 118DC5C00BC;
	Tue, 27 Feb 2024 04:17:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 27 Feb 2024 04:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709025458;
	 x=1709111858; bh=temUcWyBzm3OjpdyHumKRCKV8CPbF7DI39UrSJPSQpA=; b=
	eQtk91p530f58Fic8HP/8PdbY9BR9S8PgP//IdGnRZkazEVy96cSQubPoMIQgbGv
	0qgUpQZORN9n0144kSHL2ZnxYJQ0L3ujz8eH66GEjqoYyCEM/DwDJsQAkiLlMO4I
	wT9RLi+YA2SbJ34z2VT5WgsC1jUwswhjRbCwT7UMVwk/iYTC0YKxHiB5NQBC1gmM
	GC2G3pEQziuYLGyvxKgrA2KamGW3nidhS8qxNVhLXUDm5lhgneRn/wFD75BiFrga
	BLPjtqgUoTb1u//nLVLlyeED6E+H7n8WQf8zjzjtlkb+R9iETqAv87xFaxTt/K99
	WsibSlO6IlOTZ67/qPd2ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709025458; x=1709111858; bh=temUcWyBzm3OjpdyHumKRCKV8CPb
	F7DI39UrSJPSQpA=; b=aznaYZh2RClmtpB6Z0ZCJ/suV0nM7I6XBm9MemDqrFds
	gxtgkoDrIWKZZ8ZjqN39yqbQmOeEI6ZW8ir1emrgHozEXXb5Vpajt7FVTTWEd7kf
	YJW9rt9vk2XF2FJxzXHU3RYU01hT5annaxwGMh6UeJZ1RI8uVpYoTZ28+8Mwj9fB
	r3tqhBpW1s7RAkir8W3Ac6lPm4K1SA5yzlYpR8XkIoNsiXqARRd1PWC4XioEopii
	BuQCWMZ6tqYBrHqs8RnS7Rvhq8ip2bgXV7Eud21Kuf47uBog7BxS4txLiAbLg0a5
	KquOyIduvh211gSo7w1PEpesFemhAM/L6XWNHCI9bw==
X-ME-Sender: <xms:sajdZbsx29hFb_9zrW8FS0jwqEI0axVGYGSz0QjByv7j0mc_TvaMew>
    <xme:sajdZcdKXI557Dz4IcJHMeGSCqJcI2IpYwVMmn0YNCUwsH2QRoiLS0xY0iIuhTrev
    UCKEVgJ9XXvpawHseE>
X-ME-Received: <xmr:sajdZez4TgHQ1REbeIre8GvNIYFWZIkh3JYmdyBi2Ki39cZOgj3uSl0h2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhh
    thhrihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeduieegheeijeeuvdetud
    efvedtjeefgeeufefghfekgfelfeetteelvddtffetgfenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvth
    htrdhorhhg
X-ME-Proxy: <xmx:sajdZaNwt-idl0Xk9QJr28YAS-EbeHM-KYgOf1rnofH9pdg3P_hoOg>
    <xmx:sajdZb8r1VHrgu0RorbVk2TcxyDx369zfduMmKCw5tkOEpIXZ38TGQ>
    <xmx:sajdZaXWC9RIgpMENxEN3foYtPMj0lfwtucPJJDrxD84YLUQVj_Khw>
    <xmx:sqjdZVnNgI7XmC8tvT2rkI09MzGlfUm-cr7kwXY24Fdwm-kJhtTOow>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 04:17:37 -0500 (EST)
Date: Tue, 27 Feb 2024 01:17:36 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] commit: Unify logic to avoid multiple scissors lines
 when merging
Message-ID: <553c8692e9f0f0159bfba5b15e0abb3190a6f5f3.1709025354.git.josh@joshtriplett.org>
References: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
 <xmqqbk83nlw5.fsf@gitster.g>
 <Zd2eLxPelxvP8FDk@localhost>
 <4f97933f173220544a5be2bf05c2bee2b044d2b1.1709024540.git.josh@joshtriplett.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f97933f173220544a5be2bf05c2bee2b044d2b1.1709024540.git.josh@joshtriplett.org>

prepare_to_commit has some logic to figure out whether merge already
added a scissors line, and therefore it shouldn't add another. Now that
wt_status_add_cut_line has built-in state for whether it has
already added a previous line, just set that state instead, and then
remove that condition from subsequent calls to wt_status_add_cut_line.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
v2: New patch.

 builtin/commit.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e0a6d43179..142f54ea7c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -737,7 +737,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
-	int merge_contains_scissors = 0;
 	int invoked_hook;
 
 	/* This checks and barfs if author is badly specified */
@@ -841,7 +840,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		    wt_status_locate_end(sb.buf + merge_msg_start,
 					 sb.len - merge_msg_start) <
 				sb.len - merge_msg_start)
-			merge_contains_scissors = 1;
+			s->added_cut_line = 1;
 	} else if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
@@ -924,8 +923,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			  " yourself if you want to.\n"
 			  "An empty message aborts the commit.\n");
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
-				!merge_contains_scissors)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
 				wt_status_add_cut_line(s);
 			status_printf_ln(
 				s, GIT_COLOR_NORMAL,
@@ -946,7 +944,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL)
 			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_all, comment_line_char);
 		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
-			if (whence == FROM_COMMIT && !merge_contains_scissors)
+			if (whence == FROM_COMMIT)
 				wt_status_add_cut_line(s);
 		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_space, comment_line_char);
-- 
2.43.0
