From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Thu,  8 May 2014 19:58:30 -0500
Message-ID: <1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:11:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZLH-0001Jc-W7
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbaEIBLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:11:09 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:47005 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344AbaEIBLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:11:01 -0400
Received: by mail-yh0-f50.google.com with SMTP id 29so3140277yhl.23
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HCRJN9jSuzCiSD6tB455nMuQKJTXTxRFuYSwh8Vp4bk=;
        b=K0Nfg3Sa+ODqg/PYG42k3IvKv2CKE2ACKPFSOXNRdUBSabySJ9eUohXLORvVIO5HQD
         Wpq3Ron0RUZcAjFvmhdYlfU6B7kedjFC0qQVZAtz0u6RQYivORAQpD6R/ukuimP7hAAI
         BgKq6ZfPyK5StKijTmd+v6/BUqsOiFoEhYeq+1IFVQhooMGHOU687XTHLwYszQJxkVRR
         Pap3+Zrcw9TxjldT+I+bXQv8y2n9TgOrSlL69vKttOKTbIVmx2pD0daGUoZA4PbKOCIk
         PKfFbIBYlNC6rCioVehySmjK33FHLIVT3+1w40f2TVa6FUqv3YlhS47ioqY6c+pS5A7t
         D5hw==
X-Received: by 10.236.41.165 with SMTP id h25mr10254957yhb.126.1399597861004;
        Thu, 08 May 2014 18:11:01 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t6sm3912586yhc.45.2014.05.08.18.10.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:10:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248486>

No activity since 2012, no tests, no chance of ever graduating.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/diff-highlight/README         | 152 -----------------------------
 contrib/diff-highlight/diff-highlight | 173 ----------------------------------
 2 files changed, 325 deletions(-)
 delete mode 100644 contrib/diff-highlight/README
 delete mode 100755 contrib/diff-highlight/diff-highlight

diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
deleted file mode 100644
index 502e03b..0000000
--- a/contrib/diff-highlight/README
+++ /dev/null
@@ -1,152 +0,0 @@
-diff-highlight
-==============
-
-Line oriented diffs are great for reviewing code, because for most
-hunks, you want to see the old and the new segments of code next to each
-other. Sometimes, though, when an old line and a new line are very
-similar, it's hard to immediately see the difference.
-
-You can use "--color-words" to highlight only the changed portions of
-lines. However, this can often be hard to read for code, as it loses
-the line structure, and you end up with oddly formatted bits.
-
-Instead, this script post-processes the line-oriented diff, finds pairs
-of lines, and highlights the differing segments.  It's currently very
-simple and stupid about doing these tasks. In particular:
-
-  1. It will only highlight hunks in which the number of removed and
-     added lines is the same, and it will pair lines within the hunk by
-     position (so the first removed line is compared to the first added
-     line, and so forth). This is simple and tends to work well in
-     practice. More complex changes don't highlight well, so we tend to
-     exclude them due to the "same number of removed and added lines"
-     restriction. Or even if we do try to highlight them, they end up
-     not highlighting because of our "don't highlight if the whole line
-     would be highlighted" rule.
-
-  2. It will find the common prefix and suffix of two lines, and
-     consider everything in the middle to be "different". It could
-     instead do a real diff of the characters between the two lines and
-     find common subsequences. However, the point of the highlight is to
-     call attention to a certain area. Even if some small subset of the
-     highlighted area actually didn't change, that's OK. In practice it
-     ends up being more readable to just have a single blob on the line
-     showing the interesting bit.
-
-The goal of the script is therefore not to be exact about highlighting
-changes, but to call attention to areas of interest without being
-visually distracting.  Non-diff lines and existing diff coloration is
-preserved; the intent is that the output should look exactly the same as
-the input, except for the occasional highlight.
-
-Use
----
-
-You can try out the diff-highlight program with:
-
----------------------------------------------
-git log -p --color | /path/to/diff-highlight
----------------------------------------------
-
-If you want to use it all the time, drop it in your $PATH and put the
-following in your git configuration:
-
----------------------------------------------
-[pager]
-	log = diff-highlight | less
-	show = diff-highlight | less
-	diff = diff-highlight | less
----------------------------------------------
-
-Bugs
-----
-
-Because diff-highlight relies on heuristics to guess which parts of
-changes are important, there are some cases where the highlighting is
-more distracting than useful. Fortunately, these cases are rare in
-practice, and when they do occur, the worst case is simply a little
-extra highlighting. This section documents some cases known to be
-sub-optimal, in case somebody feels like working on improving the
-heuristics.
-
-1. Two changes on the same line get highlighted in a blob. For example,
-   highlighting:
-
-----------------------------------------------
--foo(buf, size);
-+foo(obj->buf, obj->size);
-----------------------------------------------
-
-   yields (where the inside of "+{}" would be highlighted):
-
-----------------------------------------------
--foo(buf, size);
-+foo(+{obj->buf, obj->}size);
-----------------------------------------------
-
-   whereas a more semantically meaningful output would be:
-
-----------------------------------------------
--foo(buf, size);
-+foo(+{obj->}buf, +{obj->}size);
-----------------------------------------------
-
-   Note that doing this right would probably involve a set of
-   content-specific boundary patterns, similar to word-diff. Otherwise
-   you get junk like:
-
------------------------------------------------------
--this line has some -{i}nt-{ere}sti-{ng} text on it
-+this line has some +{fa}nt+{a}sti+{c} text on it
------------------------------------------------------
-
-   which is less readable than the current output.
-
-2. The multi-line matching assumes that lines in the pre- and post-image
-   match by position. This is often the case, but can be fooled when a
-   line is removed from the top and a new one added at the bottom (or
-   vice versa). Unless the lines in the middle are also changed, diffs
-   will show this as two hunks, and it will not get highlighted at all
-   (which is good). But if the lines in the middle are changed, the
-   highlighting can be misleading. Here's a pathological case:
-
------------------------------------------------------
--one
--two
--three
--four
-+two 2
-+three 3
-+four 4
-+five 5
------------------------------------------------------
-
-   which gets highlighted as:
-
------------------------------------------------------
--one
--t-{wo}
--three
--f-{our}
-+two 2
-+t+{hree 3}
-+four 4
-+f+{ive 5}
------------------------------------------------------
-
-   because it matches "two" to "three 3", and so forth. It would be
-   nicer as:
-
------------------------------------------------------
--one
--two
--three
--four
-+two +{2}
-+three +{3}
-+four +{4}
-+five 5
------------------------------------------------------
-
-   which would probably involve pre-matching the lines into pairs
-   according to some heuristic.
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
deleted file mode 100755
index c4404d4..0000000
--- a/contrib/diff-highlight/diff-highlight
+++ /dev/null
@@ -1,173 +0,0 @@
-#!/usr/bin/perl
-
-use warnings FATAL => 'all';
-use strict;
-
-# Highlight by reversing foreground and background. You could do
-# other things like bold or underline if you prefer.
-my $HIGHLIGHT   = "\x1b[7m";
-my $UNHIGHLIGHT = "\x1b[27m";
-my $COLOR = qr/\x1b\[[0-9;]*m/;
-my $BORING = qr/$COLOR|\s/;
-
-my @removed;
-my @added;
-my $in_hunk;
-
-while (<>) {
-	if (!$in_hunk) {
-		print;
-		$in_hunk = /^$COLOR*\@/;
-	}
-	elsif (/^$COLOR*-/) {
-		push @removed, $_;
-	}
-	elsif (/^$COLOR*\+/) {
-		push @added, $_;
-	}
-	else {
-		show_hunk(\@removed, \@added);
-		@removed = ();
-		@added = ();
-
-		print;
-		$in_hunk = /^$COLOR*[\@ ]/;
-	}
-
-	# Most of the time there is enough output to keep things streaming,
-	# but for something like "git log -Sfoo", you can get one early
-	# commit and then many seconds of nothing. We want to show
-	# that one commit as soon as possible.
-	#
-	# Since we can receive arbitrary input, there's no optimal
-	# place to flush. Flushing on a blank line is a heuristic that
-	# happens to match git-log output.
-	if (!length) {
-		local $| = 1;
-	}
-}
-
-# Flush any queued hunk (this can happen when there is no trailing context in
-# the final diff of the input).
-show_hunk(\@removed, \@added);
-
-exit 0;
-
-sub show_hunk {
-	my ($a, $b) = @_;
-
-	# If one side is empty, then there is nothing to compare or highlight.
-	if (!@$a || !@$b) {
-		print @$a, @$b;
-		return;
-	}
-
-	# If we have mismatched numbers of lines on each side, we could try to
-	# be clever and match up similar lines. But for now we are simple and
-	# stupid, and only handle multi-line hunks that remove and add the same
-	# number of lines.
-	if (@$a != @$b) {
-		print @$a, @$b;
-		return;
-	}
-
-	my @queue;
-	for (my $i = 0; $i < @$a; $i++) {
-		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
-		print $rm;
-		push @queue, $add;
-	}
-	print @queue;
-}
-
-sub highlight_pair {
-	my @a = split_line(shift);
-	my @b = split_line(shift);
-
-	# Find common prefix, taking care to skip any ansi
-	# color codes.
-	my $seen_plusminus;
-	my ($pa, $pb) = (0, 0);
-	while ($pa < @a && $pb < @b) {
-		if ($a[$pa] =~ /$COLOR/) {
-			$pa++;
-		}
-		elsif ($b[$pb] =~ /$COLOR/) {
-			$pb++;
-		}
-		elsif ($a[$pa] eq $b[$pb]) {
-			$pa++;
-			$pb++;
-		}
-		elsif (!$seen_plusminus && $a[$pa] eq '-' && $b[$pb] eq '+') {
-			$seen_plusminus = 1;
-			$pa++;
-			$pb++;
-		}
-		else {
-			last;
-		}
-	}
-
-	# Find common suffix, ignoring colors.
-	my ($sa, $sb) = ($#a, $#b);
-	while ($sa >= $pa && $sb >= $pb) {
-		if ($a[$sa] =~ /$COLOR/) {
-			$sa--;
-		}
-		elsif ($b[$sb] =~ /$COLOR/) {
-			$sb--;
-		}
-		elsif ($a[$sa] eq $b[$sb]) {
-			$sa--;
-			$sb--;
-		}
-		else {
-			last;
-		}
-	}
-
-	if (is_pair_interesting(\@a, $pa, $sa, \@b, $pb, $sb)) {
-		return highlight_line(\@a, $pa, $sa),
-		       highlight_line(\@b, $pb, $sb);
-	}
-	else {
-		return join('', @a),
-		       join('', @b);
-	}
-}
-
-sub split_line {
-	local $_ = shift;
-	return map { /$COLOR/ ? $_ : (split //) }
-	       split /($COLOR*)/;
-}
-
-sub highlight_line {
-	my ($line, $prefix, $suffix) = @_;
-
-	return join('',
-		@{$line}[0..($prefix-1)],
-		$HIGHLIGHT,
-		@{$line}[$prefix..$suffix],
-		$UNHIGHLIGHT,
-		@{$line}[($suffix+1)..$#$line]
-	);
-}
-
-# Pairs are interesting to highlight only if we are going to end up
-# highlighting a subset (i.e., not the whole line). Otherwise, the highlighting
-# is just useless noise. We can detect this by finding either a matching prefix
-# or suffix (disregarding boring bits like whitespace and colorization).
-sub is_pair_interesting {
-	my ($a, $pa, $sa, $b, $pb, $sb) = @_;
-	my $prefix_a = join('', @$a[0..($pa-1)]);
-	my $prefix_b = join('', @$b[0..($pb-1)]);
-	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
-	my $suffix_b = join('', @$b[($sb+1)..$#$b]);
-
-	return $prefix_a !~ /^$COLOR*-$BORING*$/ ||
-	       $prefix_b !~ /^$COLOR*\+$BORING*$/ ||
-	       $suffix_a !~ /^$BORING*$/ ||
-	       $suffix_b !~ /^$BORING*$/;
-}
-- 
1.9.2+fc1.27.gbce2056
