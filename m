Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C37F1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 00:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfGCAka (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 20:40:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61453 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfGCAka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 20:40:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9103114B9A4;
        Tue,  2 Jul 2019 16:44:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W5fwflosQbH9C//8yeHJvZcuB6w=; b=OY3LUo
        524DQxMkejgzu9Y1GtjLiA067cFYENE4BPSEjKNePyEWo8wSd6ghMCJ4v2Nxzpfa
        nq1cqj5vaXC03CToYB/kCuzR9KQoZNtQZzHYUpQKgEQgKljYt4g8Gcry0rlL4cWq
        IwlDeZItQ7IKldep0Le5IPXnVSpLXDQ1+o0v0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nwfp94VYEtoV4tysT11KlJUVHlgIxfls
        UsO/AwUKWuny6RDEdHyrlB34XVgG03OTAIXsivupDiNetl1ji/781Sg3OdBg4F0n
        xOPRBFq6rLc6makEMu9EMRiZDGWHcXvXeQhucLj88BgbDkUsOCxq2reGVmmEqr19
        3rQMsUnnziQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88BC314B9A3;
        Tue,  2 Jul 2019 16:44:35 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA19614B9A2;
        Tue,  2 Jul 2019 16:44:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #07; Fri, 28)
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 02 Jul 2019 13:44:33 -0700
In-Reply-To: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 28 Jun 2019 15:17:42 -0700")
Message-ID: <xmqqftno2mku.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33701690-9D0A-11E9-8260-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * nd/index-dump-in-json (2019-06-26) 11 commits
>  - SQUASH???
>  - t3008: use the new SINGLE_CPU prereq
>  - read-cache.c: dump "IEOT" extension as json
>  - read-cache.c: dump "EOIE" extension as json
>  - resolve-undo.c: dump "REUC" extension as json
>  - fsmonitor.c: dump "FSMN" extension as json
>  - split-index.c: dump "link" extension as json
>  - dir.c: dump "UNTR" extension as json
>  - cache-tree.c: dump "TREE" extension as json
>  - read-cache.c: dump common extension info in json
>  - ls-files: add --json to dump the index
>
>  "ls-files" learned "--debug-json" option to dump the contents and
>  the extensions of the index file.

The t3011 test in this topic seems timing-dependent-flaky.

When we get "not ok 3 - ls-files --json, split index",
the "filtered" one looks like this:

$ diff -U999 t/t3011/split-index filtered
--- t/t3011/split-index	2019-07-02 13:17:19.676719212 -0700
+++ filtered	2019-07-02 13:40:32.068638361 -0700
@@ -1,39 +1,19 @@
 {
   "version": 2,
   "oid": <string>,
   "mtime_sec": <number>,
   "mtime_nsec": <number>,
   "entries": [
-    {
-      "id": 0,
-      "name": "",
-      "mode": "100644",
-      "flags": 0,
-      "oid": <string>,
-      "stat": {
-        "ctime_sec": <number>,
-        "ctime_nsec": <number>,
-        "mtime_sec": <number>,
-        "mtime_nsec": <number>,
-        "device": <number>,
-        "inode": <number>,
-        "uid": <number>,
-        "gid": <number>,
-        "size": 4
-      },
-      "file_offset": <number>
-    }
   ],
   "extensions": {
     "link": {
       "file_offset": <number>,
       "ext_size": <number>,
       "oid": <string>,
       "delete_bitmap": [
       ],
       "replace_bitmap": [
-        0
       ]
     }
   }
 }


