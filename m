Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989541F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfAGIbx (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:31:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:56296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726273AbfAGIbx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:31:53 -0500
Received: (qmail 928 invoked by uid 109); 7 Jan 2019 08:31:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:31:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 644 invoked by uid 111); 7 Jan 2019 08:31:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:31:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:31:51 -0500
Date:   Mon, 7 Jan 2019 03:31:51 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
Message-ID: <20190107083150.GC21362@sigill.intra.peff.net>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 06, 2019 at 05:39:14PM +0100, René Scharfe wrote:

> Am 28.12.2018 um 19:04 schrieb Junio C Hamano:
> > * jk/loose-object-cache (2018-11-24) 10 commits
> >   (merged to 'next' on 2018-12-28 at 5a5faf384e)
> >  + odb_load_loose_cache: fix strbuf leak
> >  + fetch-pack: drop custom loose object cache
> >  + sha1-file: use loose object cache for quick existence check
> >  + object-store: provide helpers for loose_objects_cache
> >  + sha1-file: use an object_directory for the main object dir
> >  + handle alternates paths the same as the main object dir
> >  + sha1_file_name(): overwrite buffer instead of appending
> >  + rename "alternate_object_database" to "object_directory"
> >  + submodule--helper: prefer strip_suffix() to ends_with()
> >  + fsck: do not reuse child_process structs
> > 
> >  Originally merged to 'next' on 2018-11-24
> > 
> >  Code clean-up with optimization for the codepath that checks
> >  (non-)existence of loose objects.
> > 
> >  Will merge to 'master'.
> 
> So this has hit master in the meantime.  We discussed a sort performance
> fix in [1]; I'll reply with a short series containing a cleaned-up and
> rebased version as a follow-up.
> 
>   object-store: factor out odb_loose_cache()
>   object-store: factor out odb_clear_loose_cache()
>   object-store: use one oid_array per subdirectory for loose cache

Thanks! With the exception of one tiny nit, this looks good to me.

I also cleaned up my sha1/object_id patch and rebased it on top of what
you have here. Though as I worked on it, it expanded in scope a bit.
Possibly it should be a separate series entirely, but that would create
some annoying textual conflicts on merge.

  [01/11]: sha1-file: fix outdated sha1 comment references
  [02/11]: update comment references to sha1_object_info()
  [03/11]: http: use struct object_id instead of bare sha1
  [04/11]: sha1-file: modernize loose object file functions
  [05/11]: sha1-file: modernize loose header/stream functions
  [06/11]: sha1-file: convert pass-through functions to object_id
  [07/11]: convert has_sha1_file() callers to has_object_file()
  [08/11]: sha1-file: drop has_sha1_file()
  [09/11]: sha1-file: prefer "loose object file" to "sha1 file" in messages
  [10/11]: sha1-file: avoid "sha1 file" for generic use in messages
  [11/11]: prefer "hash mismatch" to "sha1 mismatch"

 Documentation/git-fsck.txt |   6 +-
 apply.c                    |   2 +-
 builtin/cat-file.c         |   6 +-
 builtin/fetch.c            |   7 +-
 builtin/index-pack.c       |   2 +-
 builtin/pack-objects.c     |   4 +-
 builtin/reflog.c           |   2 +-
 builtin/show-ref.c         |   2 +-
 bulk-checkin.c             |   2 +-
 cache-tree.c               |   4 +-
 cache.h                    |   6 +-
 http-push.c                |   2 +-
 http-walker.c              |  10 +-
 http.c                     |  14 +--
 http.h                     |   6 +-
 object-store.h             |  20 ++--
 object.c                   |   4 +-
 refs.c                     |   2 +-
 send-pack.c                |   2 +-
 sha1-file.c                | 219 +++++++++++++++++--------------------
 streaming.c                |  16 +--
 t/t1450-fsck.sh            |   2 +-
 22 files changed, 161 insertions(+), 179 deletions(-)

-Peff
