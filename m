From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv4 4/6] Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
Date: Tue, 12 Feb 2013 15:02:31 +0100
Message-ID: <3bb6b7736eb4b0a958469be13d8c646faec1208a.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 12 15:03:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5GSS-0007nR-Ks
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 15:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933244Ab3BLODI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 09:03:08 -0500
Received: from mail-ea0-f180.google.com ([209.85.215.180]:51617 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933083Ab3BLODF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 09:03:05 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so42545eaa.39
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 06:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=nAZtm2FMK6j1jBumghQId0aTA2e40eT6x6SJnpsnY5Q=;
        b=XBCqZ8VZWr1NyOw6hrqn7LIGAfUmi/IRL+4ZLjkXE/b2HukwDA/Cf4EQ4F+ROu5uan
         GFCCG5L1LzcRhIRHUkZ9WQZx7rxflXa0+FkSaJQFfO1qU/z7ggpfSZLSdaFdzriq9fqN
         pfiaSxsK8QOj2KbEWDQSyzOT5henRPdIGDXOeyBkOsFkKHexAvUjvpBMPfA+yMGgoZk1
         JIJp/FKam6YtMImAtoq6Vxz2PI139Y4NTcxvXNikJ8GiUHzn1XTB0XkoYZyiw9/rQEuh
         DisS5Dv4slrvTrsiFBueMybrTJo4dSt4druDBLgTlP8LzIIAom5tzqzixhwnaRbxqU/L
         3Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=nAZtm2FMK6j1jBumghQId0aTA2e40eT6x6SJnpsnY5Q=;
        b=QWLPGh9kZEbvdWNfvP5vhSSjkIAJwTJqhyu/2BtBZnp5NNAkmpf/ovOkm3vGUpiURp
         QpFDkXIviyKrALBGrUgOgv06iIsjZoAETCLKtruQbiMEX34dFWizCX0/aji9LqrtrhiX
         GPQ8eG6/x/lirK+k7MMTY8WGu9YAhO5qlzR1B+TABFccfyl4iZQKi1gCLgvzv/REhbDJ
         yCrlqySIXHYOIXOOyV89KZSE9ObLQJIlmOLtSH6w1SAWT8lIUVbCc75+Di7kDFuNwWhZ
         izhUh+GDX84YbvdtfXS5rljsgk+UofEqWYnUYk1GqB91XiTSycwOElFTynqpaXnc5rb2
         UTaQ==
X-Received: by 10.14.214.67 with SMTP id b43mr62555180eep.33.1360677784245;
        Tue, 12 Feb 2013 06:03:04 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:6552:be17:7596:e60d])
        by mx.google.com with ESMTPS id 44sm68000941eek.5.2013.02.12.06.03.02
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 06:03:03 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.572.g32bae1f
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQnK92I66T+ky3+Y4BbvGUMdwlyHHj3YFpZSfn8gca0sZ4zFZ/gf1o3dq/FB4W1DlOvC8dDmzadhimhMaXcNa7UWHZQMWGKEtDOaWsaM/49DxUgy+Ll7nPEjNq4InpmYLEGT4CP+yy2Y0VILi/S30PgZVQX118mG7C0aBMu7VwQUTGbis2cRpbiUn5tHICxmHyeWnjTq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216151>

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
index 6bc9a3c..d6e6c9e 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -426,12 +426,25 @@ Note that you should not rely on whatever actually is in C<CTX>;
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
-	_cmd_close($ctx, $in, $out);
+	_cmd_close($ctx, grep defined, $in, $out);
 	waitpid $pid, 0;
 	if ($? >> 8) {
 		throw Git::Error::Command($ctx, $? >>8);
-- 
1.8.1.3.572.g32bae1f
