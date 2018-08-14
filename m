Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7B9E1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbeHNVrx (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:47:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53604 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeHNVrx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:47:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so13312020wmh.3
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLXflvxPPpGkx1iGavyTuONUy5mYUla2JVtVYR8aexY=;
        b=JJPKCR192Sg7yELum7bOoX1bOB17UUklQdFrplltkA49nPCyQZGIeNhARhZkP3egsc
         z7OWSPVYnqOCKvsh0q2aH/Adqy+FauaAqRaqFfNP8JuVqj5nas3q9K6FbGVMMw5aHMTC
         uor77hOkqdlZ485anckild8qOdw9DGxI0swn39Lpc4KlmiX44j+WTpiH7fYM8gWolncE
         agWCgEL4na0poA6r7DUPf5PENyISc3ZCIC9eF6fQQuyXT1GDK6Mw3ginN5+2i/YO2j4C
         aAA8FknakasBd0ojnNbRrGJppQxxSLgCA6aTBAvKMlfwqv7daEHpyAo90xKE9MQgCIs6
         0wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLXflvxPPpGkx1iGavyTuONUy5mYUla2JVtVYR8aexY=;
        b=TYcs0uEsSS6wkctJ5ZgYsbkopK6rk0UQ/O4aCPO+yItMq+4ae8Y8Z2NFnBHMfhkU0A
         vcXx3x5RA/8Pz6cIiVHaLw3Z5v2r7mbqU9IC0H2CO4/+A0TsswJUy18iwF22fEc3fIlf
         zMHx1dG61ylmVTXY1OusNI5yz15uLY0eIVDcNZWaQnGSSp7OEba0cu23yirTCXfRsMxj
         2MHhCDhndfsf6iQ8OjcgXtpQ8L1HyTDZQi1knE1yOx0e6f7rBlm7GQU4ZC05TKIO9vKA
         A1oHeHc0pV3nbPwXLNMc4ezQG5y0v12tDAMUx7rSGV/Q1X2exVCPMXIadtem6hn3L1Sq
         ov4w==
X-Gm-Message-State: AOUpUlEntV/FiPQI/W9SuMcFGAbsw2osvsKJ87BZxEQrhbVHcc9pf1m7
        yJTE3HUcA1oiy3FrlytR1sbhRNcGwzM=
X-Google-Smtp-Source: AA+uWPxUZMotf++IddxVFN9hNL0a21hMeN9a/LQc6r9iWiB5ffhaUbvrohXy6a9Lf0lqPTs/F710gA==
X-Received: by 2002:a1c:ca0f:: with SMTP id a15-v6mr11191436wmg.102.1534273156874;
        Tue, 14 Aug 2018 11:59:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o3-v6sm20831593wrj.31.2018.08.14.11.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 11:59:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] submodule: add more exhaustive up-path testing
Date:   Tue, 14 Aug 2018 18:59:06 +0000
Message-Id: <20180814185906.2680-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests added in 63e95beb08 ("submodule: port resolve_relative_url
from shell to C", 2016-04-15) didn't do a good job of testing various
up-path invocations where the up-path would bring us beyond even the
URL in question without emitting an error.

These results look nonsensical, but it's worth exhaustively testing
them before fixing any of this code, so we can see which of these
cases were changed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

The reason I started to poke at this was because I wanted to add
support for relative URLs like //group/project.

This solves the problem of there being e.g. a myhost.com/group/project
which includes a ../submodule submodule pointing to
myhost.com/group/submodule , and me wanting to fork it to
myhost.com/myuser/project.

But of course with ../submodule the relative URL will point to
myhost.com/myuser/submodule, which won't exist.

So I was hoping to find some point in the relative URL code where we
were actually aware of what the host boundary was, so I could just cut
off everything after that if //group/project was provided, strip off
one slash to make it /group/project, and call it a day.

But as the tests below show the code isn't aware of that at all, and
will happily trample over the host(name) to produce nonsensical
results.

So I think these tests are worthwihle in themselves, but would like
some advice on how to proceed with that from someone more familiar
with submodules.

 t/t0060-path-utils.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 21a8b53132..cd74c0a471 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -330,6 +330,9 @@ test_submodule_relative_url "(null)" "../foo" "../submodule" "../submodule"
 test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo/submodule"
 test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule"
 test_submodule_relative_url "(null)" "//somewhere else/repo" "../subrepo" "//somewhere else/subrepo"
+test_submodule_relative_url "(null)" "//somewhere else/repo" "../../subrepo" "//subrepo"
+test_submodule_relative_url "(null)" "//somewhere else/repo" "../../../subrepo" "/subrepo"
+test_submodule_relative_url "(null)" "//somewhere else/repo" "../../../../subrepo" "subrepo"
 test_submodule_relative_url "(null)" "$(pwd)/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
 test_submodule_relative_url "(null)" "$(pwd)/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
 test_submodule_relative_url "(null)" "$(pwd)/." "../." "$(pwd)/."
@@ -344,10 +347,20 @@ test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo" "file:///tm
 test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/submodule"
 test_submodule_relative_url "(null)" "foo" "../submodule" "submodule"
 test_submodule_relative_url "(null)" "helper:://hostname/repo" "../subrepo" "helper:://hostname/subrepo"
+test_submodule_relative_url "(null)" "helper:://hostname/repo" "../../subrepo" "helper:://subrepo"
+test_submodule_relative_url "(null)" "helper:://hostname/repo" "../../../subrepo" "helper::/subrepo"
+test_submodule_relative_url "(null)" "helper:://hostname/repo" "../../../../subrepo" "helper::subrepo"
+test_submodule_relative_url "(null)" "helper:://hostname/repo" "../../../../../subrepo" "helper:subrepo"
+test_submodule_relative_url "(null)" "helper:://hostname/repo" "../../../../../../subrepo" ".:subrepo"
 test_submodule_relative_url "(null)" "ssh://hostname/repo" "../subrepo" "ssh://hostname/subrepo"
+test_submodule_relative_url "(null)" "ssh://hostname/repo" "../../subrepo" "ssh://subrepo"
+test_submodule_relative_url "(null)" "ssh://hostname/repo" "../../../subrepo" "ssh:/subrepo"
+test_submodule_relative_url "(null)" "ssh://hostname/repo" "../../../../subrepo" "ssh:subrepo"
+test_submodule_relative_url "(null)" "ssh://hostname/repo" "../../../../../subrepo" ".:subrepo"
 test_submodule_relative_url "(null)" "ssh://hostname:22/repo" "../subrepo" "ssh://hostname:22/subrepo"
 test_submodule_relative_url "(null)" "user@host:path/to/repo" "../subrepo" "user@host:path/to/subrepo"
 test_submodule_relative_url "(null)" "user@host:repo" "../subrepo" "user@host:subrepo"
+test_submodule_relative_url "(null)" "user@host:repo" "../../subrepo" ".:subrepo"
 
 test_expect_success 'match .gitmodules' '
 	test-tool path-utils is_dotgitmodules \
-- 
2.18.0.865.gffc8e1a3cd6

