Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCC520954
	for <e@80x24.org>; Tue, 28 Nov 2017 14:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbdK1OhX (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 09:37:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56748 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752446AbdK1OhW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 09:37:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E66496E4A;
        Tue, 28 Nov 2017 09:37:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=V3QD
        8vcP2Ei2TNvWut5tvKFQg3g=; b=Hic5XBHIW5at4m8JIqW982T/kZjl8y3hmfUB
        46WX+O52rDwqyk4dcYzjgwNmrJ46+CYUkc31tuY0nN2YaH8xnLU6t7WGEH96hxcq
        LUfdRp6NB76GT/7YNX8eKe7j1iWOfAl3edDAAa/4QKTpwE4Cwb/NHlIovSj/LJaL
        BAnlZ2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        nxYtaEv4D4YXwNdpQ4ze0ZuVuI3HvWbxmE3qI566bJPjSMfhEZDCotchtiBRncL+
        OpYISlhMZeCplSuuWRecvbrunW69kG2xCqtGHJTaRlttENPcqHRsWmnKG2iwGguH
        zjTVgqLcqxcIMuMBrzwhJs7y0ISodsvEqtNVYuGSs9M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26C7296E49;
        Tue, 28 Nov 2017 09:37:21 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 185FC96E44;
        Tue, 28 Nov 2017 09:37:20 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: [PATCH] travis-ci: avoid new tcl/tk build requirement
Date:   Tue, 28 Nov 2017 09:37:18 -0500
Message-Id: <20171128143718.3748-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <xmqqlgir6mwk.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgir6mwk.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: A3D95364-D449-11E7-A9CE-8EF31968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A build requirement on tcl/tk was added in 01c54284f1 (Makefile: check
that tcl/tk is installed, 2017-11-20).  For building and running the
tests, we don't need tcl/tk installed.  Bypass the requirement.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Junio C Hamano wrote:
> It seems that TravisCI objects ;-)
>
>    https://travis-ci.org/git/git/jobs/307745929

Interesting that the main builds passed.  I don't know what the default
64-bit linuxinstall looks like in travis, so I presume it includes
tcl/tk or something.

In any case, perhaps something like this is what we want?  We could use
NO_TCLTK or ensure that tcl/tk is installed in all environments.  I used
the BYPASS_TCLTK_CHECK option since the tests have been running without
tcl/tk previously.  If they become required for the tests, this can be
adjusted.

I have a travis job running with this change here:

    https://travis-ci.org/tmzullinger/git/builds/308452464

So far the only failure is (what looks like) an unrelated one in the
GETTEXT_POISON build.

 .travis.yml              | 1 +
 ci/run-linux32-docker.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 281f101f31..9e57caa83d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -23,6 +23,7 @@ addons:
 
 env:
   global:
+    - BYPASS_TCLTK_CHECK=1
     - DEVELOPER=1
     # The Linux build installs the defined dependency versions below.
     # The OS X build installs the latest available versions. Keep that
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 0edf63acfa..8c2b32f7b3 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -13,6 +13,7 @@ docker pull daald/ubuntu32:xenial
 
 docker run \
 	--interactive \
+	--env BYPASS_TCLTK_CHECK \
 	--env DEVELOPER \
 	--env DEFAULT_TEST_TARGET \
 	--env GIT_PROVE_OPTS \
-- 
2.15.0

