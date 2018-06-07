Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64DA21F517
	for <e@80x24.org>; Thu,  7 Jun 2018 05:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeFGFUK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:20:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55925 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeFGFUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:20:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85676F168E;
        Thu,  7 Jun 2018 01:20:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Z7Mk
        BlflmsL7k+SiaFqjtSW+XUU=; b=LyEv3EkgEX2HUlSJT5SYPO/YqgW2RcOrbkCa
        sWpuZxI/jpzBNzjZoKhkKneTuZoHxWTYgonH4ub6R28r2SjF7mwR/8GY2NB4He2s
        QPZg3ec7HAnBMGPdxdnzRYENfYWgcT0s22efgODLGgYyl4qgxpuHAjJ2xk1BnBmn
        lp9Zn60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        OUc+NByX/CZ7WtypOYHvDMfDE1bDuka/A51lQBd6Q0O42IZtzSZ39UkbwrsIOgsJ
        WzEUG/gtmHXZMDl4B612l+Qpk4GKnGBmMr0byjkfdePINAZndf6KpmUK+vxokZ+K
        eK6h4gXIprnGE03P51DEc3dKfYjH7c3DlQ26HeuK3jo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6815AF168D;
        Thu,  7 Jun 2018 01:20:05 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9215F1684;
        Thu,  7 Jun 2018 01:20:02 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/2] git-credential-netrc: use in-tree Git.pm for tests
Date:   Thu,  7 Jun 2018 01:19:58 -0400
Message-Id: <20180607051958.759-3-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607051958.759-1-tmz@pobox.com>
References: <20180607051958.759-1-tmz@pobox.com>
X-Pobox-Relay-ID: 6F1CDFE2-6A12-11E8-943C-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The netrc test.pl script calls git-credential-netrc which imports the
Git module.  Pass GITPERLLIB to git-credential-netrc via PERL5LIB to
ensure the in-tree Git module is used for testing.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/credential/netrc/test.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
index 1e1001030e..5e26b4d190 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -27,6 +27,9 @@ BEGIN
                       ? $ENV{PATH}
                       : ();
 
+# use in-tree Git.pm
+local $ENV{PERL5LIB} = $ENV{GITPERLLIB};
+
 diag "Testing insecure file, nothing should be found\n";
 chmod 0644, $netrc;
 my $cred = run_credential(['-f', $netrc, 'get'],
-- 
2.18.0.rc1

