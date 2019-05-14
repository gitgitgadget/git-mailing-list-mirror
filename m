Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C8C11F461
	for <e@80x24.org>; Tue, 14 May 2019 02:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfENCF3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 22:05:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62522 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfENCF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 22:05:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBA705FC44
        for <git@vger.kernel.org>; Mon, 13 May 2019 22:05:26 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :subject:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=im7tPyYVhgYHvPaQysxbQghYM
        x8=; b=eGzbPt8m3I5ywsYG89+DWrVcZx7QPANjcgw0yUcBOUz1W9Ht/P+V70IpF
        mhIDBJVo1VGJXXRRX349uHlNLONDWwHmoG4vf/xMGCjruzOsOrMbRaSR7dG5sUs7
        jpJheZz+igpl+QghN25JIBklcnzO2gbtiwsOdpEMUVn3ETyGJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to
        :subject:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=VFevveTp99KCrRw5Yqb
        OhqGgVzfC7PS6X2KBpfW9CHdr9CPLn8dM1/w9mZlYJ/J4lLcL6X0CVs0SIBvIk3P
        voCX7IMOsRrPINTS8mGAFMvEHi7GfkX4VSfngabs5E5S29sPdcYySg1XaPoAhtyq
        FSWPgXgPNF0Zjxg7fXjKJZxg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3E3B5FC43
        for <git@vger.kernel.org>; Mon, 13 May 2019 22:05:26 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF9495FC42
        for <git@vger.kernel.org>; Mon, 13 May 2019 22:05:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Mon, 13 May 2019 22:05:20 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] test-lib: try harder to ensure a working jgit
Message-ID: <20190514020520.GI3654@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: BBFA8634-75EC-11E9-B63B-8D86F504CC47-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The JGIT prereq uses 'type jgit' to determine whether jgit is present.
While this should be sufficient, if the jgit found is broken we'll waste
time running tests which fail due to no fault of our own.

Use 'jgit --version' instead, to catch some badly broken jgit
installations.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
I ran into such a broken jgit on Fedora >=3D 30=B9.  This is clearly a
problem in the Fedora jgit package which will hopefully be resolved
soon.  But it may be good to avoid wasting time debugging tests which
fail due to a broken tool outside of our control.

=B9 https://bugzilla.redhat.com/1709624

 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 908ddb9c46..599fd70e14 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1522,7 +1522,7 @@ test_lazy_prereq NOT_ROOT '
 '
=20
 test_lazy_prereq JGIT '
-	type jgit
+	jgit --version
 '
=20
 # SANITY is about "can you correctly predict what the filesystem would
--=20
Todd
