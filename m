From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv2 3/5] Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
Date: Thu,  7 Feb 2013 15:01:19 +0100
Message-ID: <afa54fb5dd2d08759317099d10090b81adfb593f.1360242782.git.mina86@mina86.com>
References: <cover.1360242782.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 07 15:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3S3L-0005g7-UK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 15:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758733Ab3BGOBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 09:01:43 -0500
Received: from mail-ea0-f182.google.com ([209.85.215.182]:52002 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758690Ab3BGOBi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 09:01:38 -0500
Received: by mail-ea0-f182.google.com with SMTP id a12so1160239eaa.27
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 06:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=zwjE3Gy4Q43/GvMd/8vWc6YBASuocCENQL3SPpYvueU=;
        b=axC0ToeI3sNUH1OA5bmxOfeYTRaA+yxZ1ZGzcV9jrlbg/RIk1Jflxg2do0cpHZLAQw
         g0p8uYSYmvFBnB4yopLrQmOb4Qmg/4K+QVa1MMTxUR6kYvGvLtT/A1dUlMA6QyVdv7cw
         VJvOp8E1ZqCGzZm+KUZw1Bo0tqzcBkGmJJzmyGv6mk3ovfpP6A/hArFtO/p5sJ8OZjBa
         A4U0fUKJkXD+g2F/DduBYqJ4Ez6DpQRJwhmPLjX9GNTH/e9K4Dj9RJDxGwpuy+Ktqv91
         1gbCgTWqd4B+AkBop99Kxd4Nn4pqTOfarxKr+7ym1QzL6TN/AMEBoIQJPXEnul1gxPAG
         9WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=zwjE3Gy4Q43/GvMd/8vWc6YBASuocCENQL3SPpYvueU=;
        b=dJ6oF7yqKuSAvBm8m8YJEP9FzB4yhMS2CXNaIHL+IM/8N2+bbpkU0vMqW03F/3FYqP
         5fSBuiq3LHGJjm/a6b+IsI6UNdyCbxyHyx4a7j6fDE4nZy151iJ6En14puu5JzC3OBBN
         HF9WkUuEeaIB5EyCJZoQZq/QIIIWj+bPoxBsq2AIS0pCkwIhqIiB3GUURyv8zw9zbUi9
         wYvdMIGxTsob9xVkE10eJqnnSKWGCYY90nHly216q0wjK+/fjXYY5BLYpsIyZBqg/wml
         jrH2FI8uRaKlPvjeYho59CeD6f2qt0LaKBwwXG6+KFPh+UNuukuEUm+sSTyJcnK9sdWl
         6P6g==
X-Received: by 10.14.2.5 with SMTP id 5mr4348210eee.30.1360245696719;
        Thu, 07 Feb 2013 06:01:36 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:bdef:84b9:750e:31d0])
        by mx.google.com with ESMTPS id f6sm42214479eeo.7.2013.02.07.06.01.35
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 06:01:35 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.550.g0b3c9b6
In-Reply-To: <cover.1360242782.git.mina86@mina86.com>
In-Reply-To: <cover.1360242782.git.mina86@mina86.com>
References: <cover.1360242782.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQlR+tWbbxcHfmm2FowsTTsC5SIoE5NXCt6pBdEO5xE1RagHVUj+CyWfej9yb0RJprJFx1XNR93JDl9xB/fdiE/TtNDVHZUrfG/1jwqrPgVAxvEfsPGcChPxO4HmyRcIADzaWT7MAXH2oAMY/pJcOZMtEAxEU2b+OzTR92ZJXJxy0hGm/+aixDTFoS9PbN8Fd8O7+oth
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215696>

From: Michal Nazarewicz <mina86@mina86.com>

The command_close_bidi_pipe() function will insist on closing both
input and output pipes returned by command_bidi_pipe().  With this
change it is possible to close one of the pipes in advance and
pass undef as an argument.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

 > On Wed, Feb 06, 2013 at 09:47:04PM +0100, Michal Nazarewicz wrote:
 >> This allows for something like:
 >> 
 >>   my ($pid, $in, $out, $ctx) = command_bidi_pipe(...);
 >>   print $out "write data";
 >>   close $out;
 >>   # ... do stuff with $in
 >>   command_close_bidi_pipe($pid, $in, undef, $ctx);

 On Thu, Feb 07 2013, Jeff King <peff@peff.net> wrote:
 > Should this part go into the documentation for command_close_bidi_pipe
 > in Git.pm?

 Done.

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
1.8.1.2.549.g1d13f9f
