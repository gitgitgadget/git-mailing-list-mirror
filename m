From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/20] t5505: use "for-each-ref" to test for the non-existence of references
Date: Tue, 16 Feb 2016 14:22:29 +0100
Message-ID: <33d6637c989fb6007f98708e1736ef6f51e05cb3.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiR-0003Og-Po
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbcBPNax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:30:53 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58883 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932384AbcBPNat (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:49 -0500
X-AuditID: 1207440c-c0bff70000002d40-1a-56c322c04f76
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 90.F5.11584.0C223C65; Tue, 16 Feb 2016 08:23:12 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOc028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:23:11 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqHtA6XCYwd2HJhbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8atC1eZCuayV1ycU9DA2MLWxcjJISFgIvGiuYMd
	xBYS2Moo8f9FfRcjF5B9gkmiZ+MmFpAEm4CuxKKeZiYQW0RATWJi2yEWkCJmgUeMEl37tzOC
	JIQFYiR+TvnGDGKzCKhKPP2yECzOKxAlcbx5EzvENjmJlh+7WUFsTgELiZMtvSwQm80l7nzZ
	wzSBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJAA49nB+G2dzCFG
	AQ5GJR7eDa6HwoRYE8uKK3MPMUpyMCmJ8vJwHw4T4kvKT6nMSCzOiC8qzUktPsQowcGsJML7
	7xVQOW9KYmVValE+TEqag0VJnFd1ibqfkEB6YklqdmpqQWoRTFaGg0NJgveTItBQwaLU9NSK
	tMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAExBcDYwAkxQO0Nw2knbe4IDEXKArReopRl2PB
	j9trmYRY8vLzUqXEefeDFAmAFGWU5sGtgKWTV4ziQB8L8waAVPEAUxHcpFdAS5iAluRcAnmu
	uCQRISXVwDhhv+mnaat6JtvEFwu8670ze/JbtrLzk06YJ7rPtGSOX3rF7afk3rYA2XvXFdaI
	K1mv2XxA0PTSv/rwyB0lO4I6fu9d+X/nXMXPaw91dGy4aeFRpfoz4af8mnNt07Mt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286385>

Instead of looking on the filesystem inside ".git/refs/remotes/origin",
use "git for-each-ref" to check for leftover references under the
remote's old name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5505-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 1a8e3b8..d2ac346 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -687,7 +687,7 @@ test_expect_success 'rename a remote' '
 	(
 		cd four &&
 		git remote rename origin upstream &&
-		rmdir .git/refs/remotes/origin &&
+		test -z "$(git for-each-ref refs/remotes/origin)" &&
 		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
 		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
-- 
2.7.0
