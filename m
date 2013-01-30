From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
Subject: [PATCH 1/7] perl/Git.pm: test portably if a path is absolute
Date: Wed, 30 Jan 2013 15:22:57 -0200
Message-ID: <1359566583-19654-2-git-send-email-gnustavo@cpan.org>
References: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
Cc: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 18:30:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0bUZ-0001k8-Qa
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165Ab3A3RaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:30:10 -0500
Received: from mail-gg0-f181.google.com ([209.85.161.181]:61170 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935Ab3A3RaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:30:09 -0500
Received: by mail-gg0-f181.google.com with SMTP id e5so300830ggh.40
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 09:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:x-gm-message-state;
        bh=ZBEVCSCW6PmjDfBNjvPJmnjYUdTTdrycAlc2+Eqblbw=;
        b=lQwq8T+qmmCCX+HW3If0NKv1N7Ojdd91mgMnuREOHyRRzbTxI28p6mI1JXEWK2Lfh1
         SUEB7qTzV8Nv/d8JdwZo628hx4g0Gi7kRmCpch9xN7a8x+G5bWELzzxfmd6Zgm/6N+GC
         udk5h4u6qAufT7Z5nPta14wPz4T3gBjs3CC6AF1SYxEX2LNOyIHEoQVigHCzSKAKF1Tz
         H3TBATq9qhlbgk0b5JkCnHp7vBYqJ0Tratv3yLzTUIhe8B0tOCl0mnxs72u2Mzuqbxmk
         U1UW/cXWfWq2v3sHKJTpi0a31BoRKzXrtIltckOzdbLhi7C2+pRouD34yQmbRsf7Odil
         v6zA==
X-Received: by 10.236.91.228 with SMTP id h64mr6600882yhf.51.1359566589725;
        Wed, 30 Jan 2013 09:23:09 -0800 (PST)
Received: from gnu.cpqd.com.br (fw-cpqd.cpqd.com.br. [189.112.183.66])
        by mx.google.com with ESMTPS id q11sm1689802anp.13.2013.01.30.09.23.07
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 09:23:08 -0800 (PST)
X-Mailer: git-send-email 1.7.12.464.g83379df.dirty
In-Reply-To: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
X-Gm-Message-State: ALoCoQl+LkT0nCnOLpq2W4TEBU7rZmmeg+ZaEn7hygyw2smE0+do6Q3taps4lmntf6VydLBZyVkr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215040>

From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>

The code was testing if a path was absolute by checking if its first
character was a '/'. This does not work on Windows.

The portable way to do it is to use File::Spec::file_name_is_absolute.

Signed-off-by: Gustavo L. de M. Chaves <gnustavo@cpan.org>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 931047c..658b602 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -185,7 +185,7 @@ sub repository {
 		};
 
 		if ($dir) {
-			$dir =~ m#^/# or $dir = $opts{Directory} . '/' . $dir;
+			$dir = $opts{Directory} . '/' . $dir unless File::Spec->file_name_is_absolute($dir);
 			$opts{Repository} = abs_path($dir);
 
 			# If --git-dir went ok, this shouldn't die either.
-- 
1.7.12.464.g83379df.dirty
