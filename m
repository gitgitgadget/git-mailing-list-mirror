From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv3 3/5] Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
Date: Mon, 11 Feb 2013 17:23:37 +0100
Message-ID: <b35b9286463c47f95d4c5ee91ecd4ccf4d945cba.1360599712.git.mina86@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com>
Cc: git@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wBJ-0002EW-Tp
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757922Ab3BKQYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:24:05 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:46856 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab3BKQYC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:24:02 -0500
Received: by mail-ea0-f174.google.com with SMTP id 1so2798528eaa.33
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 08:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=6jgbqYekJn/OUMrkdQsjg4J6FbQURVKDUMDghieV1L8=;
        b=Zez64WRzayy1GkfRz6cFpDIVvce7wj/jH9qDoTicMWhcOVTntXYAtSKkKHJidFHWDY
         1LPtz1uBsmNAZVIAtMTANgzvoqHuyaEWYrtFyfgUoKumyEQAUD79BjWd4NAHLQoB0qby
         FZEAABXuMABSBMpQKlHXwk72cNSKw5Wp6IslwhFLGWJaZFMEQz1XVtwZuWjtrmk6aB/Z
         p9O7EaPblDH37uRuK0kcCR/lJPSECPO/Pj6GdiXXv4fDNhzZKDuIUdW/shwYO5tm/yDU
         Hds2U7Zg5lU/wHDar4BKE/JupH/9vErkCc18WJQZH9xQO8LLCjdDfP4wT3Ld7frJZsbl
         326A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=6jgbqYekJn/OUMrkdQsjg4J6FbQURVKDUMDghieV1L8=;
        b=QLJNoJExmZl/biNn9X6rvZOUysbK3mDjPeMGRM9mIjym9O6wzjWfiq7yc0z1XWSxOF
         A0IOs7aAdztU/xAd5i29NTaQYrZKdq2C+xCFgj9AfgUJD3ZUd4ZclS5hOxgg3Fyqhh8b
         dU56UwpJsi9AVCRR+ijYVMCdeDj13/ZM93RKrM5i3CDCGxcpDh0Ao/jAxUI/L0sztpz8
         juDVV3fAvOabKlSWp0x7BPZsT8g4kRNJc1fvl3TBgbwCDWgsIIpFtgT9ZmU451x/siEr
         m3YQRCX9EnWOcJJ31G1rMxEFYEpbVvM0RVcv5+OCT29CUoGBKnhc5PbwvVSFYC9tqzEa
         Xxlg==
X-Received: by 10.14.210.132 with SMTP id u4mr51291710eeo.19.1360599841208;
        Mon, 11 Feb 2013 08:24:01 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:1d0a:8048:51b4:44a9])
        by mx.google.com with ESMTPS id 3sm63347527eej.6.2013.02.11.08.23.59
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 08:24:00 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.571.g3f8bed7.dirty
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQlDHPCGSNneuhz7t2D5yg3W210Z8yG+pgx3aOnSURxnEcTllY312y3Hc3t27T2msddQLDuq+pnxSPQYsegy3/Sx0DkCIfTezHC8s2A2i2NCBnqhzUt60hM7upJEu7ba3ERWQS920mxZThcXqKOjYPTjrDXyjcSLAfwWTzr0zcMvbomQTpOELZ/dJcuxYK8uWi0ermMn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216043>

From: Michal Nazarewicz <mina86@mina86.com>

The command_close_bidi_pipe() function will insist on closing both
input and output pipes returned by command_bidi_pipe().  With this
change it is possible to close one of the pipes in advance and
pass undef as an argument.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 11f310a..9dded54 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -426,13 +426,26 @@ Note that you should not rely on whatever actually is in C<CTX>;
 currently it is simply the command name but in future the context might
 have more complicated structure.
 
+C<PIPE_IN> and C<PIPE_OUT> may be C<undef> if they have been closed prior to
+calling this function.  This may be useful in a query-response type of
+commands where caller first writes a query and later reads response, eg:
+
+	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe('cat-file --batch-check');
+	print $out "000000000\n";
+	close $out;
+	while (<$in>) { ... }
+	$r->command_close_bidi_pipe($pid, $in, undef, $ctx);
+
+This idiom may prevent potential dead locks caused by data sent to the output
+pipe not being flushed and thus not reaching the executed command.
+
 =cut
 
 sub command_close_bidi_pipe {
 	local $?;
 	my ($self, $pid, $in, $out, $ctx) = _maybe_self(@_);
 	foreach my $fh ($in, $out) {
-		unless (close $fh) {
+		if (defined $fh && !close $fh) {
 			if ($!) {
 				carp "error closing pipe: $!";
 			} elsif ($? >> 8) {
-- 
1.8.1.3.571.g3f8bed7.dirty
