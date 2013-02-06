From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCH 2/4] Git.pm: Allow pipes to be closed prior to calling command_close_bidi_pipe
Date: Wed,  6 Feb 2013 21:47:04 +0100
Message-ID: <c0966644278b0addbef6a03289ef9c553addf573.1360183427.git.mina86@mina86.com>
References: <cover.1360183427.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:47:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3BuM-0005mO-Tm
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758628Ab3BFUrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 15:47:25 -0500
Received: from mail-ea0-f177.google.com ([209.85.215.177]:63034 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758551Ab3BFUrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:47:22 -0500
Received: by mail-ea0-f177.google.com with SMTP id n13so742743eaa.36
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 12:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=fVpouB5yJs1EDVdWZCDr6ZCDhWu7XQZJnZM1jDMThZM=;
        b=FKlSec1GtrfEcirNeZwcuw/xU9SrZJNDiQUhLhNN5K47Ow9c55V6mYGqiMebHTVUfn
         AY/TrrbfvG5u5KTvR2kd6y+JjF5OVnXhqnmyoiC6BUTFL98FncTC/l1mhaCuo69s1zVM
         C61qiPKFYeLbZGoV4Tl06URpL3WB2lk5vuYwKI0nC7CPD7ltuNsEF6/eH/Q1VMUqrqtr
         7duIS0tV4ozTXtiUxUlTpYns9JPXd+SMu1Bnof7Kf2i8UKyjZLmBSoxrI1ZPZnDlTQmg
         nvCajKcG7eXNnqIP+t9GdAQTAUHnz+TTOwmYSQQmwCrc3qZ9lc8N8IQbrMgFTh0LB+Ts
         0oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=fVpouB5yJs1EDVdWZCDr6ZCDhWu7XQZJnZM1jDMThZM=;
        b=KDmI9TPzcrAoEs2YYe+TGTYqzp9IwZuthTXQVCgdiXVoL8l4gGW6LtkpcPNAqL4tQx
         HSU16PjMmw66RVVwxHMhAWjaqgmNnUDiETnB5Sn8nUxrrnhKglFCVp0yfhFPvVcr9v7K
         pU+GbebkIEhOCUQwbVVjZLNMNhSqJgCFAAt7PemyCHXZ1IUtMADExvKtMHOaQCgX6TSO
         AGodvjNR5nDes4M4JAHkqtk9kYLP5OSHcnlnv+idWllSd7RMpr9d4MvMMrhDYArc63qZ
         ducqEGuVvf4oyNGE3wC9fwys/4Qt+6eVVfr6YQ5bLArJuRviMldcod9/sXWsW9IyC4kQ
         U+ew==
X-Received: by 10.14.2.5 with SMTP id 5mr102452433eee.30.1360183641486;
        Wed, 06 Feb 2013 12:47:21 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:e809:df2d:46af:f661])
        by mx.google.com with ESMTPS id z5sm294639eep.16.2013.02.06.12.47.20
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 12:47:20 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.549.g1d13f9f
In-Reply-To: <cover.1360183427.git.mina86@mina86.com>
In-Reply-To: <cover.1360183427.git.mina86@mina86.com>
References: <cover.1360183427.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQlGv4akQt89qyvMfwb3/nVoDI7yTa0dhA4+v2D201DzMWTACmNlLzGl2iR5tgf84gC+bq11hX5nk4QL/uMX4MMdd4LFp7yzMJZWbk5EX6t+W6zL0DylJoUZ3IbkznT7B+ZJIbO2NtZW32B0ybCnvk2z3eK+6he9DehCUbEGiHl6EoB37s66sR+GXd1YUKbkaEHzd2gN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215637>

From: Michal Nazarewicz <mina86@mina86.com>

The command_close_bidi_pipe() function will insist on closing both
input and output pipes returned by command_bidi_pipe().  With this
change it is possible to close one of the pipes in advance and
pass undef as an argument.

This allows for something like:

  my ($pid, $in, $out, $ctx) = command_bidi_pipe(...);
  print $out "write data";
  close $out;
  # ... do stuff with $in
  command_close_bidi_pipe($pid, $in, undef, $ctx);

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index bbb753a..6a2d52d 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -432,7 +432,7 @@ sub command_close_bidi_pipe {
 	local $?;
 	my ($self, $pid, $in, $out, $ctx) = _maybe_self(@_);
 	foreach my $fh ($in, $out) {
-		unless (close $fh) {
+		if (defined $fh && !close $fh) {
 			if ($!) {
 				carp "error closing pipe: $!";
 			} elsif ($? >> 8) {
-- 
1.8.1.2.549.g4fa355e
