From: William Pursell <bill.pursell@gmail.com>
Subject: Re: summaries in git add --patch[PATCH 1/2]
Date: Wed, 03 Dec 2008 20:38:59 +0000
Message-ID: <4936EE63.209@gmail.com>
References: <492F0CAD.3010101@gmail.com> <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com> <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com> <7vskp6j95x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7yXj-00042d-02
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 21:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758540AbYLCUjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 15:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755496AbYLCUjI
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 15:39:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:13316 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbYLCUjF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 15:39:05 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1943931nfc.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 12:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=WIQmqAbST67yCG8GlR6arlPdm7NdOX6u4aU8SppLEA0=;
        b=lZXKFLNhRu0nnE8KvZnWBb0g4Frqy+L26Mdg0VksPksG9HtnEFYd2ZuXibb2ygKdac
         anAPElLP3CdD6IbePYVABCGXEnk5KtxwwRZTxoHTwps0MH32z9JhJ8j4tsXLSKKjxzA1
         EjO7G+OHiMPx0Dfa7nhYrLGE9hL9RTzdLd8hA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nCx5pKaU5T56NA1jd1IgLJWO90dQ4VjjSsA++YrtrWmbgPq1m6sD4y6pzlEC9BP/oh
         kQzPtnqGgaUwsGsMF6dgciVUDBvzyG6wedW/1yvfJIUqRrjOd15OsLmMa9EHst4/0G63
         wMGGBzpVguzhzRcuJCXFhcMY6m41doFm4iF0A=
Received: by 10.210.104.20 with SMTP id b20mr15833863ebc.29.1228336742933;
        Wed, 03 Dec 2008 12:39:02 -0800 (PST)
Received: from clam.local (5ace1311.bb.sky.com [90.206.19.17])
        by mx.google.com with ESMTPS id g9sm3786914gvc.31.2008.12.03.12.39.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 12:39:01 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <7vskp6j95x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102284>

Junio C Hamano wrote:

> One thing I will not do after such a discussion, unless I am really really
> interested in having the new feature personally myself, is to go back to
> the discussion thread and assemble the pieces together to make the final
> series of patches for inclusion.  The responsibility for doing that lies
> on the original contributor.
> 

That is a perfectly reasonable policy, and I did not intend
to suggest that you should do that work.  My apologies if
it seemed that way.  Here is the first of 2 patches to
implement the 'g' command.  I believe it is complete, but
I am not much for user interface.  It works for me, but it
could be improved upon.  (For example, I took your suggestion
and disallowed 'g' when there is only one hunk, but the
behavior feels clunky, although it is similar to an invalid
k/j entry.)

 From de169b0062ae21f085d1309b4dd7da369029ae7d Mon Sep 17 00:00:00 2001
From: William Pursell <bill.pursell@gmail.com>
Date: Wed, 3 Dec 2008 20:25:31 +0000
Subject: [PATCH 1/2] Add subroutine to display one-line summary of hunks.

This commit implements a rather simple-minded mechanism
to display a one-line summary of the hunks in an array ref.
The display consists of the line numbers and the first
changed line, truncated to 80 characters.  20 lines are
displayed at a time, and the index of the first undisplayed
line is returned, allowing the caller to display more if
desired.  (The 20 and 80 should be made configurable.)

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
  git-add--interactive.perl |   39 +++++++++++++++++++++++++++++++++++++++
  1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b0223c3..daf8d5d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -836,6 +836,45 @@ sub patch_update_cmd {
  	}
  }

+# Generate a one line summary of a hunk.
+sub summarize_hunk {
+	my $rhunk = shift;
+	my $summary = $rhunk->{TEXT}[0];
+
+	# Keep the line numbers, discard extra context.
+	$summary =~ s/(@@.*@@).*/$1 /s;
+
+	# Add some user context. (Just take first changed line.)
+	for my $line (@{$rhunk->{TEXT}}) {
+		if ($line =~ m/^[+-]/) {
+			$summary .= $line;
+			last;
+		}
+	}
+
+	return substr ($summary, 0, 80);
+}
+
+
+# Print a one-line summary of each hunk in the array ref in
+# the first argument, starting wih the index in the 2nd.
+sub display_hunks {
+	my ($hunks, $i) = @_;
+	my $ctr = 0;
+	$i = 0 if not $i;
+	for (; $i < @$hunks && $ctr < 20; $i++, $ctr++) {
+		my $status = " ";
+		if (defined $hunks->[$i]{USE}) {
+			$status = $hunks->[$i]{USE} ? "+" : "-";
+		}
+		printf "%s%2d: %s",
+			$status,
+			$i + 1,
+			summarize_hunk ($hunks->[$i]);
+	}
+	return $i;
+}
+
  sub patch_update_file {
  	my ($ix, $num);
  	my $path = shift;
-- 
1.6.1.rc1.37.g83daf.dirty



-- 
William Pursell
