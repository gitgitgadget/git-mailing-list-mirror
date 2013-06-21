From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] t6003: add --author-date-order test
Date: Fri, 21 Jun 2013 11:49:39 -0700
Message-ID: <1371840579-20161-6-git-send-email-gitster@pobox.com>
References: <1371840579-20161-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 20:50:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6PH-0002QS-9K
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423715Ab3FUStz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:49:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423711Ab3FUStw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:49:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF1342A0DA;
	Fri, 21 Jun 2013 18:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Ohu6
	cyvMX7uZ5pNQ2EYwXaGpdH8=; b=uR4qjSmIwzR5cm06igmggkJ3Ou+pd4z+1KZc
	QPB9L4/ENXxTFk5Yrks414hnAGGTfhLWd33xYbgJj1OktXAx2m0dgn3qqJbfWsOO
	XTf9nL2gpQWUtNDbviND02TMwYfssW6Vvhh3db5zyl2OBZLxPwTfZDBXqIh7qJ01
	A5+eAD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	v8Aa2n5Jwm46+ll4Kca3R1TY8Y83pzGPDBe+sN8bY7PSzbUIwOx90ozTcTaTiN6F
	BEidud2AAGdMePuT4KnnNDdZKS2Sz0te6xZP5wgWgZ8/Al4vMXz+j/vWxjbg4cPx
	xQdCm5cBfN8FpKiRMvqyEoUAT7DJDXzGy+ZrtCYumNs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C446D2A0D9;
	Fri, 21 Jun 2013 18:49:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 335132A0D8;
	Fri, 21 Jun 2013 18:49:51 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-691-gcbc83f4
In-Reply-To: <1371840579-20161-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5AC8DCFC-DAA3-11E2-B5ED-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228648>

Tweak the --topo/date-order test vector a bit and mark the author
dates of two commits (a2 and a3) earlier than their own committer
dates, making them much older than other commits that are made on
parallel branches to simulate the case where a long running topic
was rebased recently.

They will show up as recent in the --date-order output due to their
timestamps, but they appear a lot later in the --author-date-order
output, even though their committer timestamp says otherwise.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6003-rev-list-topo-order.sh | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index 77bf2ca..24d1836 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -28,8 +28,8 @@ on_dates "00:08" "00:08" as_author foobar@example.com save_tag b2 unique_commit
 on_dates "00:09" "00:09" save_tag b3 unique_commit b3 tree -p b2
 on_dates "00:10" "00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
 on_dates "00:11" "00:11" save_tag c3 unique_commit c3 tree -p c2
-on_dates "00:12" "00:12" save_tag a2 unique_commit a2 tree -p a1
-on_dates "00:13" "00:13" save_tag a3 unique_commit a3 tree -p a2
+on_dates "00:12" "00:00" save_tag a2 unique_commit a2 tree -p a1
+on_dates "00:13" "00:01" save_tag a3 unique_commit a3 tree -p a2
 on_dates "00:14" "00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
 on_dates "00:15" "00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
 on_dates "00:16" "00:16" save_tag l3 unique_commit l3 tree -p a4
@@ -122,6 +122,28 @@ l0
 root
 EOF
 
+test_output_expect_success 'simple author-date order' 'git rev-list --author-date-order  HEAD' <<EOF
+l5
+l4
+l3
+a4
+b4
+c3
+c2
+b3
+b2
+c1
+b1
+a3
+a2
+a1
+a0
+l2
+l1
+l0
+root
+EOF
+
 test_output_expect_success 'two diamonds topo order (g6)' 'git rev-list --topo-order  g4' <<EOF
 g4
 h2
-- 
1.8.3.1-682-g924db96
