Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6FD020193
	for <e@80x24.org>; Fri, 28 Oct 2016 01:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943173AbcJ1BIT (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 21:08:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51595 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935453AbcJ1BIS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 21:08:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47AAB4A653;
        Thu, 27 Oct 2016 21:08:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xbNoFkuO7CqKPhjzqFyqKr+hFeQ=; b=UXNGW2
        rUFCgkGGmLTZJy5Va9X1smZOogZ2J/ZXWos9P0MYE3J/XxEVPs5Fo3sJt+ApYF0s
        62L5tQIgOEyFoEPwnacQ4Eg2FdBlanBHxZZ/N7rAlHTdyNW70sRpraqu+7KOdrwW
        +dm7ozTKvq7KZ4OKEqKEed0+6ban+gBu3wKhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t5Uoakb8meSLxftF881jUzaHROhSVeFy
        C39lhDsCeZsbSZoL149tu98ztFdTsLA9Io9tjFymejPOdtv5ykT2dp6QWHA31+mh
        yC2uDowuhvsKGjMTZrqTspoRUw9gYk+zlXt39/fP/SbDDh4sspq5vIa3IVbYZC5K
        ZoQjPD1ix3M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4052C4A652;
        Thu, 27 Oct 2016 21:08:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3A0D4A651;
        Thu, 27 Oct 2016 21:08:16 -0400 (EDT)
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
Date:   Thu, 27 Oct 2016 18:08:14 -0700
In-Reply-To: <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 27 Oct 2016 16:44:14 -0700")
Message-ID: <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01F40A7A-9CAB-11E6-B1CA-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Oct 27, 2016 at 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Would the best endgame shape for this function be to open with
>> O_NOATIME (and retry without), and then add CLOEXEC with fcntl(2)
>> but ignoring an error from it, I guess?  That would be the closest
>> to what we historically had, I would think.
>
> I think that's the best model.

OK, so perhaps like this.

-- >8 --
Subject: git_open(): untangle possible NOATIME and CLOEXEC interactions

The way we structured the fallback-retry for opening with O_NOATIME
and O_CLOEXEC meant that if we failed due to lack of support to open
the file with O_NOATIME option (i.e. EINVAL), we would still try to
drop O_CLOEXEC first and retry, and then drop O_NOATIME.  A platform
on which O_NOATIME is defined in the header without support from the
kernel wouldn't have a chance to open with O_CLOEXEC option due to
this code structure.

Arguably, O_CLOEXEC is more important than O_NOATIME, as the latter
is mostly about performance, while the former can affect correctness.
Let's revert the recent changes to the way git_open() attempts to
open a file with O_NOATIME and retries without to the original
sequence, and then use a separate fcntl(fd, F_SETFD, FD_CLOEXEC) on
the resulting file descriptor.  The helper to do the latter can be
usable in the codepath in ce_compare_data() that was recently added
to open a file descriptor with O_CLOEXEC, so let's refactor that
codepath with the helper while we are at it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |  5 +++--
 read-cache.c      | 12 ++++--------
 sha1_file.c       | 49 ++++++++++++++++++++++++++++++-------------------
 3 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 43718dabae..a751630db5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -679,9 +679,10 @@ char *gitstrdup(const char *s);
 #define getpagesize() sysconf(_SC_PAGESIZE)
 #endif
 
-#ifndef O_CLOEXEC
-#define O_CLOEXEC 0
+#ifndef FD_CLOEXEC
+#define FD_CLOEXEC 0
 #endif
+extern int git_set_cloexec(int);
 
 #ifdef FREAD_READS_DIRECTORIES
 #ifdef fopen
diff --git a/read-cache.c b/read-cache.c
index db5d910642..fb91514885 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,17 +156,13 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 {
 	int match = -1;
-	static int cloexec = O_CLOEXEC;
-	int fd = open(ce->name, O_RDONLY | cloexec);
-
-	if ((cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
-		/* Try again w/o O_CLOEXEC: the kernel might not support it */
-		cloexec &= ~O_CLOEXEC;
-		fd = open(ce->name, O_RDONLY | cloexec);
-	}
+	int fd = open(ce->name, O_RDONLY);
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
+
+		/* do not let child processes to hold onto the open fd */
+		git_set_cloexec(fd);
 		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
 			match = hashcmp(sha1, ce->oid.hash);
 		/* index_fd() closed the file descriptor already */
diff --git a/sha1_file.c b/sha1_file.c
index 09045df1dc..41383a6c20 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1559,31 +1559,42 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-int git_open(const char *name)
+int git_set_cloexec(int fd)
 {
-	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
+	static int cloexec = FD_CLOEXEC;
 
-	for (;;) {
-		int fd;
+	if (cloexec) {
+		if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0)
+			cloexec = 0;
+		/*
+		 * We might want to diagnose and complain upon seeing
+		 * an error from this call, but let's keep the same
+		 * behaviour as before for now.
+		 */
+	}
+	return 0;
+}
 
-		errno = 0;
-		fd = open(name, O_RDONLY | sha1_file_open_flag);
-		if (fd >= 0)
-			return fd;
+int git_open(const char *name)
+{
+	static int noatime = O_NOATIME;
+	int fd;
 
-		/* Try again w/o O_CLOEXEC: the kernel might not support it */
-		if ((sha1_file_open_flag & O_CLOEXEC) && errno == EINVAL) {
-			sha1_file_open_flag &= ~O_CLOEXEC;
-			continue;
-		}
+	errno = 0;
+	fd = open(name, O_RDONLY | noatime);
 
-		/* Might the failure be due to O_NOATIME? */
-		if (errno != ENOENT && (sha1_file_open_flag & O_NOATIME)) {
-			sha1_file_open_flag &= ~O_NOATIME;
-			continue;
-		}
-		return -1;
+	/* Might the failure be due to O_NOATIME? */
+	if ((noatime & O_NOATIME) && errno != ENOENT) {
+		noatime = 0;
+		fd = open(name, O_RDONLY);
 	}
+
+	if (fd < 0)
+		return fd;
+
+	/* do not let child processes to hold onto the open fd */
+	git_set_cloexec(fd);
+	return fd;
 }
 
 static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
