Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C35B201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 21:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdBSVyT (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 16:54:19 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36504 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdBSVyS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 16:54:18 -0500
Received: by mail-pg0-f68.google.com with SMTP id a123so7538716pgc.3
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=72JyZ/s2TaxbWefZbHh7JpQ+0HcqFdTJ+0PtXFi8CtA=;
        b=jSJCIfIuI7kIXnNnK2gPToMb1hW4viSH80QAthxyDmyXW/Evty0IFNNV+VMjwmkpGL
         uwozb268eQ03haFOk0TsUuzJ7tkGJGExEf+B+4KDIMPFNEbEPntKfFsvVfMOz1HGvXcH
         OblCqWcZog505eVbxaSR59aGoGb370ypX63+gzegTHRux+DzICgz/KMeCZQWNYJ07Vy9
         32eAmnmjMttYsYJB3831E2Qiczl1gY0SXcAAh8LxsWfzUbJC8thw2Rt00CT6OL+Ziq8O
         7tvPywDNYki0/nBxHNZCmmOxubHzUS7cJJnd+AAmwTj8io5DsoMlW8KrvrYfTspld8IV
         gHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=72JyZ/s2TaxbWefZbHh7JpQ+0HcqFdTJ+0PtXFi8CtA=;
        b=D+uVdG1710Z2BaboesKRaq+YdSe/DYzo8Pp0cK986VZEtUzLa6NecA1ZVQgX85119E
         PdzB6KAYgtZzfF4Ss3dOn6/Q25DzYNuAdeXgWmiMOYUpV4nVJiqbGeq2u3JPwR9LjK8T
         UFvBn25PYKspw1zo5Js3pSmKGTsd0xbon7YKy2+eeNstRT4aMNnL8ghU2EWT/XUa2On3
         /yNgCh1n6d+oLMxiziGnalyEybKQ+yyUujlXjQSIBkVziABNOBTEg/Y1O+NVek8339+u
         cNmoKJW5slGKi2XK8xA6IN9rWyBTRxQidYUbYg6K0PXqV8vHpWsaZF7qKWp1mfwyCMIf
         Wung==
X-Gm-Message-State: AMke39nWiUG1JvBgWJWQkYu3lojzS9NwqDAaqZDNOYgnknkuaRaIlwkry84UYxI0j3+cUQ==
X-Received: by 10.84.197.72 with SMTP id m66mr26531011pld.83.1487540722689;
        Sun, 19 Feb 2017 13:45:22 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:110e:6fae:3b03:324a])
        by smtp.gmail.com with ESMTPSA id e4sm31006060pgc.45.2017.02.19.13.45.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 19 Feb 2017 13:45:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <Jeff.Hostetler@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/5] name-hash: precompute hash values during preload-index
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <8621305c69898e012720d4fe66d42b096f053073.1487071883.git.johannes.schindelin@gmx.de>
        <xmqq37fcnj7v.fsf@gitster.mtv.corp.google.com>
        <MWHPR03MB295845950BB87BA9479E973E8A5F0@MWHPR03MB2958.namprd03.prod.outlook.com>
Date:   Sun, 19 Feb 2017 13:45:20 -0800
In-Reply-To: <MWHPR03MB295845950BB87BA9479E973E8A5F0@MWHPR03MB2958.namprd03.prod.outlook.com>
        (Jeff Hostetler's message of "Sun, 19 Feb 2017 00:19:58 +0000")
Message-ID: <xmqq1sutn9cf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <Jeff.Hostetler@microsoft.com> writes:

> I looked at doing this, but I didn't think the complexity and overhead to
> forward search for peers at the current level didn't warrant the limited gains.

It seems that I wasn't clear what I meant.  I didn't mean anything
complex like what you said.

Just something simple, like this on top of yours, that passes and
compares with only the previous one.  I do not know if that gives
any gain, though ;-).

 cache.h         |  2 +-
 name-hash.c     | 11 +++++++++--
 preload-index.c |  4 +++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 390aa803df..bd2980f6e3 100644
--- a/cache.h
+++ b/cache.h
@@ -233,7 +233,7 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
 
-void precompute_istate_hashes(struct cache_entry *ce);
+void precompute_istate_hashes(struct cache_entry *ce, struct cache_entry *prev);
 
 /* Forward structure decls */
 struct pathspec;
diff --git a/name-hash.c b/name-hash.c
index f95054f44c..5e09b79170 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -300,7 +300,7 @@ void free_name_hash(struct index_state *istate)
  * non-skip-worktree items (since status should not observe skipped items), but
  * because lazy_init_name_hash() hashes everything, we force it here.
  */
-void precompute_istate_hashes(struct cache_entry *ce)
+void precompute_istate_hashes(struct cache_entry *ce, struct cache_entry *prev)
 {
 	int namelen = ce_namelen(ce);
 
@@ -312,7 +312,14 @@ void precompute_istate_hashes(struct cache_entry *ce)
 		ce->precomputed_hash.root_entry = 1;
 	} else {
 		namelen--;
-		ce->precomputed_hash.dir = memihash(ce->name, namelen);
+
+		if (prev && 
+		    prev->precomputed_hash.initialized &&
+		    namelen <= ce_namelen(prev) &&
+		    !memcmp(ce->name, prev->name, namelen))
+			ce->precomputed_hash.dir = prev->precomputed_hash.dir;
+		else
+			ce->precomputed_hash.dir = memihash(ce->name, namelen);
 		ce->precomputed_hash.name = memihash_continue(
 			ce->precomputed_hash.dir, ce->name + namelen,
 			ce_namelen(ce) - namelen);
diff --git a/preload-index.c b/preload-index.c
index 602737f9d0..784378ffac 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -37,6 +37,7 @@ static void *preload_thread(void *_data)
 	struct thread_data *p = _data;
 	struct index_state *index = p->index;
 	struct cache_entry **cep = index->cache + p->offset;
+	struct cache_entry *previous = NULL;
 	struct cache_def cache = CACHE_DEF_INIT;
 
 	nr = p->nr;
@@ -47,7 +48,8 @@ static void *preload_thread(void *_data)
 		struct cache_entry *ce = *cep++;
 		struct stat st;
 
-		precompute_istate_hashes(ce);
+		precompute_istate_hashes(ce, previous);
+		previous = ce;
 
 		if (ce_stage(ce))
 			continue;




> (I was just looking at the complexity of clear_ce_flags_1() in unpack-trees.c
> and how hard it has to look to find the end of the current directory and the
> effect that that has on the recursion and it felt like too much work for the
> potential gain.)
>
> Whereas remembering the previous one was basically free.  Granted, it only
> helps us for adjacent files in the index, so it's not perfect, but gives us the
> best bang for the buck.
>
> Jeff
