Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0F82035F
	for <e@80x24.org>; Fri, 28 Oct 2016 13:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760089AbcJ1NdZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 09:33:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60516 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759993AbcJ1NdY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 09:33:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C867B44D12;
        Fri, 28 Oct 2016 09:33:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fO5LUVqMK/9ItvOhtdVJwbMU5Kg=; b=LYLw3p
        O1vjMLSK9WgZu4FROj+dR5O90HSRSvpj+BZ4QtCfY5+zeuGAG7iBzLdb6rGScz7P
        X3bzSK+3OF+2QVDHzMc0SETw9N0v6+FhDAQ5Z+39yrrVihpEvswmJowzlCsXcCvF
        NeEJJcOoC7IAnFgb2OQDb9dx8kVkwp7T+SpKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K/H0EFASorz2nUeZb7FoQcHySZwQK+bE
        OH27yo+9c955wruOey0UrxoAdf7YRkR+oRePO1nDyvvh+lwP2lOA8IPbWsYLpTbq
        5oOPlOgo/eAhwh3u4LRPVebHXeUFCv0RmHApwWo+NnjQ8LwmAKQquHiSdDnFILAA
        0T5Z9Dc4W0A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEBA744D11;
        Fri, 28 Oct 2016 09:33:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BAD844D0F;
        Fri, 28 Oct 2016 09:33:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <20161025181621.4201-3-gitster@pobox.com>
        <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
        <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
        <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
        <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
        <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
        <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
        <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
        <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
        <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
        <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
        <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
        <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
        <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
        <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com>
        <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
        <xmqqh97w38gj.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 28 Oct 2016 06:33:19 -0700
In-Reply-To: <xmqqh97w38gj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 28 Oct 2016 06:32:28 -0700")
Message-ID: <xmqqd1ik38f4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17EA4D2C-9D13-11E6-A44A-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Hmph.  This may not fly well in practice, though.  
>
> We can flip the order around, and then it becomes simpler to later
> drop atime support.  The first step goes like this.

And the second step would be like this.

-- >8 --
Subject: [PATCH] sha1_file: stop opening files with O_NOATIME

When we open object files, we try to do so with O_NOATIME.
This dates back to 144bde78e9 (Use O_NOATIME when opening
the sha1 files., 2005-04-23), which is an optimization to
avoid creating a bunch of dirty inodes when we're accessing
many objects.  But a few things have changed since then:

  1. In June 2005, git learned about packfiles, which means
     we would do a lot fewer atime updates (rather than one
     per object access, we'd generally get one per packfile).

  2. In late 2006, Linux learned about "relatime", which is
     generally the default on modern installs. So
     performance around atimes updates is a non-issue there
     these days.

     All the world isn't Linux, but as it turns out, Linux
     is the only platform to implement O_NOATIME in the
     first place.

So it's very unlikely that this code is helping anybody
these days.

Helped-by: Jeff King <peff@peff.net>
[jc: took idea and log message from peff]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |  2 +-
 sha1_file.c | 21 ---------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index 6f1c21a352..f440d3fd1e 100644
--- a/cache.h
+++ b/cache.h
@@ -1123,7 +1123,7 @@ extern int hash_sha1_file_literally(const void *buf, unsigned long len, const ch
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
-extern int git_open(const char *name);
+#define git_open(name) git_open_cloexec(name, O_RDONLY)
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
diff --git a/sha1_file.c b/sha1_file.c
index dfbf398183..25d9359402 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -27,14 +27,6 @@
 #include "list.h"
 #include "mergesort.h"
 
-#ifndef O_NOATIME
-#if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
-#define O_NOATIME 01000000
-#else
-#define O_NOATIME 0
-#endif
-#endif
-
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
@@ -1572,19 +1564,6 @@ int git_open_cloexec(const char *name, int flags)
 	return fd;
 }
 
-int git_open(const char *name)
-{
-	static int noatime = O_NOATIME;
-	int fd = git_open_cloexec(name, O_RDONLY);
-
-	if (0 <= fd && (noatime & O_NOATIME)) {
-		int flags = fcntl(fd, F_GETFL);
-		if (fcntl(fd, F_SETFL, flags | noatime))
-			noatime = 0;
-	}
-	return fd;
-}
-
 static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
 {
 	struct alternate_object_database *alt;
-- 
2.10.1-791-g404733b9cf

