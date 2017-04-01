Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D84120958
	for <e@80x24.org>; Sat,  1 Apr 2017 13:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdDANbb (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 09:31:31 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59754 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751574AbdDANba (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Apr 2017 09:31:30 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1C874280AD
        for <git@vger.kernel.org>; Sat,  1 Apr 2017 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1491053489;
        bh=EZG3fU9zbQhHwzekC+c4aC12EYKr1HJNobv+LDwwSU8=;
        h=From:To:Subject:Date:From;
        b=eEtZ2N7/jMH9GNAmwhKJyu2NVod3AtfNyGVt/W4U0CNLer3eunzHr1igXkY9O4oXW
         xKqZgY2L47GPuV4jF9ggylQZ+kL6jAwJR//ZerUArNR0lSegv/clVDGo+/ToSKAPNe
         /MN2OAsYbEGojZhNAF5pb9Oqz7N1t3d0ldNwmwN5YJNw306Ixe4M1wBAeKb1PzxbtB
         vOdCD+dfkR0ZkWb0Et5LDO/qT7WVMcID+T2FaEW7E3C2W64dpWXlRKAtl+/BbevjUF
         Ur+CGMB3iTgzMMNFeVC7zoGLK8Ltw3nsUDRFIb6W2Uqh46B7yAn7z2btYjHx7bx8f/
         xhaQZqC/doG27PY461p7H0KUTJoEFsxBetYQMjk5zoKjc3z9ViTvpqOH4LXwVSwutO
         UrQOyculD9gIL0l+8ApnNNiQqr8YHKoNcifUu9h0b9uV0eZHDDY2pp02WZb15lJloJ
         sUl+GrcUeYpQr8wokAg2TFxULZ4AH+AsyNsfNa8WzRxZml3lJeT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [PATCH] Documentation: make 3-way merge warning more generic
Date:   Sat,  1 Apr 2017 13:31:24 +0000
Message-Id: <20170401133124.10479-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.564.g063fe858b8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for merge strategies noted that if a change was
reverted on only one branch of a merge, the resultant merge would
contain the change.  However, similar surprising behavior can occur
where cherry-picking only one commit from a series to the other branch
can cause conflicts.

Adjust the text to state in the first sentence that only the heads and
the merge base are considered for three-way merge, instead of hiding
this in the second sentence after introducing a scenario which might not
apply to the user.  This makes it easier for users to understand by
first introducing the general rule (which applies to many scenarios),
and only then providing a specific example.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---

I ran into this scenario with a co-worker who is a fairly advanced Git
user.  He created a series of five commits that modified a file on our
development branch and requested the cherry-pick of one of those onto
our maintenance branch.  When we merged the maintenance branch into the
development branch, he was surprised that there were conflicts.  He
expected Git to realize that the commit was already present and ignore
it.

I pointed out the documentation to him, but realized that it didn't
cover this case well, so I decided to reword it such that it covers this
case a little better, as well as addressing the original issue.

Feedback on how I did in that regard would be welcome.

 Documentation/merge-strategies.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 2eb92b9327..54da2ffa33 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -123,9 +123,9 @@ subtree::
 	ancestor tree.
 
 With the strategies that use 3-way merge (including the default, 'recursive'),
-if a change is made on both branches, but later reverted on one of the
-branches, that change will be present in the merged result; some people find
-this behavior confusing.  It occurs because only the heads and the merge base
-are considered when performing a merge, not the individual commits.  The merge
-algorithm therefore considers the reverted change as no change at all, and
-substitutes the changed version instead.
+only the heads and the merge base are considered when performing a merge, not
+the individual commits.  This means that if a change is made on both branches,
+but later reverted on one of the branches, that change will be present in the
+merged result; some people find this behavior confusing.  The merge algorithm
+considers the reverted change as no change at all, and substitutes the changed
+version instead.
-- 
2.12.2.564.g063fe858b8

