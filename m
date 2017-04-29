Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A211FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 12:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1952014AbdD2M2d (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 08:28:33 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:45791 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166721AbdD2M2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 08:28:31 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 29 Apr 2017 14:28:56 +0200
  id 0000000000000044.0000000059048708.00005EE6
Date:   Sat, 29 Apr 2017 14:28:29 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     "=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] githooks.txt: clarify push hooks are always executed in
 $GIT_DIR
Message-ID: <20170429122829.lz56r7exh3ecynxb@ruderich.org>
References: <20170409130126.uqmjop25jidhblhd@ruderich.org>
 <CACBZZX4uBL99y=ZaKZ7dqyP9Ne-cx=kYkh8p51p3VYOr3PQGSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4uBL99y=ZaKZ7dqyP9Ne-cx=kYkh8p51p3VYOr3PQGSw@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Listing the specific hooks might feel verbose but without it the
reader is left to wonder which hooks are triggered during the
push. Something which is not immediately obvious when only trying
to find out where the hook is executed.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 Documentation/githooks.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

On Mon, Apr 10, 2017 at 01:13:15PM +0200, Ævar Arnfjörð Bjarmason wrote:
> [snip]
>
> Can we say as we do now that:
>
> * All hooks regardless of type in bare repos execute in the bare repo
> * If you have a working tree hooks use that
>
> But add:
>
> * Working trees are ignored by any hooks invoked on your behalf during a push.

Hello,

Maybe like this? I reordered the cases as it felt more natural
that the general case is first and followed by the one with the
exception.

> Some ad-hoc testing reveals that this rule also goes for the
> push-to-checkout hook. Should it? Wouldn't it be more useful if it
> broke the pattern, since it's dealing with the working tree on the
> other side? Junio?

I added push-to-checkout to the patch. Changing the behavior will
break backwards compatibility so I think that's a no-go.

Regards
Simon

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 32343ae29..706091a56 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -22,8 +22,10 @@ changed via the `core.hooksPath` configuration variable (see
 linkgit:git-config[1]).
 
 Before Git invokes a hook, it changes its working directory to either
-the root of the working tree in a non-bare repository, or to the
-$GIT_DIR in a bare repository.
+$GIT_DIR in a bare repository or the root of the working tree in a non-bare
+repository. An exception are hooks triggered during a push ('pre-receive',
+'update', 'post-receive', 'post-update', 'push-to-checkout') which are always
+executed in $GIT_DIR.
 
 Hooks can get their arguments via the environment, command-line
 arguments, and stdin. See the documentation for each hook below for
-- 
2.11.0

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
