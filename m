From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Mon, 03 Mar 2014 11:51:06 -0800
Message-ID: <xmqqeh2joyc5.fsf@gitster.dls.corp.google.com>
References: <20140224082459.GA32594@sigill.intra.peff.net>
	<xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
	<20140226101353.GA25711@sigill.intra.peff.net>
	<xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
	<20140227112734.GC29668@sigill.intra.peff.net>
	<xmqqy50wzb2b.fsf@gitster.dls.corp.google.com>
	<20140228085546.GA11709@sigill.intra.peff.net>
	<xmqqob1ruld8.fsf@gitster.dls.corp.google.com>
	<20140301054350.GA20397@sigill.intra.peff.net>
	<xmqqeh2jrvz8.fsf@gitster.dls.corp.google.com>
	<20140303181558.GA16523@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:51:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKYtg-0007cw-Uj
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbaCCTvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 14:51:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741AbaCCTvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 14:51:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 513D76F5AF;
	Mon,  3 Mar 2014 14:51:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V6YFOwQOl1s0yoGuBLKkvT0EV+A=; b=Xw7fDt
	3/wZfYB3gHJMdDIcy4TOPMNu6DjXqfvD0yIxsEqtAW0sfysu9e38sLsJXC5sNRDE
	bhvktLbk3M+H0GIfnXm3wUyuiryAPHNt0cDdjElsFRzHnyzEOj1ApL86XQX6n2qL
	fNM4V4yyQM13Rz+upaXqHaLPslOtp8aj/YpRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TQ3NcIvKSFWkWo/ZKNckrbu96VZKjmR6
	iIH56JQ5w6jD+5Q86XgIvho7rhvPYH08YOhHO+4iKQHAK1n7pkEUSXKAVXLedPg1
	mTpPd0/o4wi++14GD4z32TTiApgoEvqggN7AKZaJwQ8JWHn7IAr+8Ca3aUQU9T2o
	ljKBJyUjSMw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0110C6F5AD;
	Mon,  3 Mar 2014 14:51:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDDC16F5A7;
	Mon,  3 Mar 2014 14:51:20 -0500 (EST)
In-Reply-To: <20140303181558.GA16523@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 3 Mar 2014 13:15:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3150A93A-A30D-11E3-BD1E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243261>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 03, 2014 at 10:13:47AM -0800, Junio C Hamano wrote:
>
>> > Or the flip side: if the user wants to use .keep, we should drop
>> > bitmaps. My point is that we do not know which way the user wants to
>> > go, so we should not tie the options together.
>> 
>> Hmph.  I think the short of your later explanation is "global config
>> may tell us to use bitmap, in which case we would need a way to
>> defeat that and have existing .keep honored, and it makes it easier
>> to do so if these two are kept separate, because you do not want to
>> run around and selectively disable bitmaps in these repositories.
>> We can instead do so with repack.packKeptObjects in the global
>> configuration." and I tend to agree with the reasoning.
>
> Yes. Do you need a re-roll from me? I think the last version I sent +
> the squash to tie the default to bitmap-writing makes the most sense.

I have 9e20b390 (repack: add `repack.packKeptObjects` config var,
2014-02-26); I do not recall I've squashed anything into it, though.

Do you mean this one?

Here's the interdiff for doing the fallback:

---
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3a3d84f..a8ddc7f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2139,7 +2139,9 @@ repack.usedeltabaseoffset::
 repack.packKeptObjects::
 	If set to true, makes `git repack` act as if
 	`--pack-kept-objects` was passed. See linkgit:git-repack[1] for
-	details. Defaults to false.
+	details. Defaults to `false` normally, but `true` if a bitmap
+	index is being written (either via `--write-bitmap-index` or
+	`pack.writeBitmaps`).
 
 rerere.autoupdate::
 	When set to true, `git-rerere` updates the index with the
diff --git a/builtin/repack.c b/builtin/repack.c
index 49947b2..6b0b62d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -9,7 +9,7 @@
 #include "argv-array.h"
 
 static int delta_base_offset = 1;
-static int pack_kept_objects;
+static int pack_kept_objects = -1;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -190,6 +190,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
 
+	if (pack_kept_objects < 0)
+		pack_kept_objects = write_bitmap;
+
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index f8431a8..b1eed5c 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -21,7 +21,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
 		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
-	git repack -A -d -l &&
+	git repack --no-pack-kept-objects -A -d -l &&
 	git prune-packed &&
 	for p in .git/objects/pack/*.idx; do
 		idx=$(basename $p)
@@ -35,9 +35,9 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	test -z "$found_duplicate_object"
 '
 
-test_expect_success '--pack-kept-objects duplicates objects' '
+test_expect_success 'writing bitmaps duplicates .keep objects' '
 	# build on $objsha1, $packsha1, and .keep state from previous
-	git repack -Adl --pack-kept-objects &&
+	git repack -Adl &&
 	test_when_finished "found_duplicate_object=" &&
 	for p in .git/objects/pack/*.idx; do
 		idx=$(basename $p)
