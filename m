From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v4] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 18:44:40 -0500
Message-ID: <1235691880-9806-1-git-send-email-jaysoffian@gmail.com>
References: <7v4oygrd3w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 00:46:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcpvh-0006Yd-M2
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 00:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbZBZXop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 18:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659AbZBZXop
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 18:44:45 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:9195 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbZBZXoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 18:44:44 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1396346qwi.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 15:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/zx6dBTUA76gE3u6bDEmmLX93ekFEy9mV2TRFP6R45g=;
        b=UBlLw7MTsrXh3rFrwUMki6FDR7LHr90C3ntfcHRKHC93JH/tOCd+SZkgvtVxNOpX/J
         c5Sua+fFPeEx1O6n0+bJ3dWVPHWSAFhgFImLfqApXvTo1NlJ0uycKysNqwAMID5G9Qj2
         ix/2t+po6/j6QFK/YwhAT+z2JwxgdkKYZO8Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kNHTvm90aNgrqlFD7AFwObMeAvKpb/GFloa1RXhBA+pb/Nqksn2HQK+y/XXFLRWo7N
         934S8oW6bwfeuXTQCAfYE+k3H0PPmyer+AF2iNWCTMslMw0e1asryCzvKhOUksfofJrw
         uXIVOXz9S6oJgOjOjGW8+jHAUYyGOXP3re5jg=
Received: by 10.224.73.143 with SMTP id q15mr3184273qaj.189.1235691882642;
        Thu, 26 Feb 2009 15:44:42 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 4sm977454qwe.55.2009.02.26.15.44.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Feb 2009 15:44:42 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
In-Reply-To: <7v4oygrd3w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111615>

OS X's GNU grep does not support -P/--perl-regexp.

We use a basic RE instead, and simplify the pattern slightly by
replacing '+' with '*' so it can be more easily expressed using a basic
RE. The important part of pattern, checking for a SHA-1 has suffix in
the successful PUT/MOVE operations, remains the same. Also, a-z instead
of a-f was an obvious mistake in the original RE. Here are samples of
what we want to match:

127.0.0.1 - - [26/Feb/2009:22:38:13 +0000] "PUT /test_repo.git/objects/3e/a4fbb9e18a401a6463c595d08118fcb9fb7426_fab55116904c665a95438bcc78521444a7db6096 HTTP/1.1" 201 277
127.0.0.1 - - [26/Feb/2009:22:38:13 +0000] "MOVE /test_repo.git/objects/3e/a4fbb9e18a401a6463c595d08118fcb9fb7426_fab55116904c665a95438bcc78521444a7db6096 HTTP/1.1" 201 277

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
On Thu, Feb 26, 2009 at 6:29 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Heh, at least with /a-z/a-f/, I think it is usable.
>
> Or is there a reason I am missing that we want to allow g-z there?

I can't believe I didn't notice that. This is really really my last
send. I noticed gmail line wrapped my squash, so I'm resending properly.
Updated the commit note as well to mention the change from a-z to a-f is
on purpose.

j.

 t/t5540-http-push.sh |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 11b3432..bd45203 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -94,10 +94,15 @@ test_expect_success 'MKCOL sends directory names with trailing slashes' '
 
 '
 
-test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
+x1="[0-9a-f]"
+x2="$x1$x1"
+x5="$x1$x1$x1$x1$x1"
+x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
+x40="$x38$x2"
 
-	grep -P "\"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d" \
-		< "$HTTPD_ROOT_PATH"/access.log
+test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
+	sed -e "s/PUT/OP/" -e "s/MOVE/OP/" < "$HTTPD_ROOT_PATH"/access.log \
+	| grep "\"OP .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*\" 20[0-9]"
 
 '
 
-- 
1.6.2.rc1.309.g5f417
