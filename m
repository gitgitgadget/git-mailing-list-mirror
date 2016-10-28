Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A912035F
	for <e@80x24.org>; Fri, 28 Oct 2016 13:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756637AbcJ1Ncd (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 09:32:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51403 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754599AbcJ1Ncc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 09:32:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA91F48910;
        Fri, 28 Oct 2016 09:32:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f+wWAEuGaV6041NDpJYBhiFC7cE=; b=UGKORd
        iS0q6VIIvHzOrmaua7DFdRDZ1tmIASD+U2Fv7iYOSbgfcRDu8Xs63I82kR56r+Kn
        L22JBpP+eldNml9k5m4zA9+W6NZNjriMj/27g/t390fDHOYuMn2L9FRVWztZO45E
        UJdAI30aJI1wthFFzKcG79sr6MZBZODqTUFeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M4K6E5YvajUnxm1ifuOzzgwsoMx2gEhm
        SmLLrTCkwg9WNP78pI2WfcT5ncojvl0IviR3/C0D94geaturl0KzBPNjuP9M3Vue
        9+GtzgT+k7+usyo58xSOlBaPTguN1x16xf9janR2U5IoZIdvCbCgQxaeZGcI947t
        T4x3ZdNYeQ0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1BE74890F;
        Fri, 28 Oct 2016 09:32:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 234A54890E;
        Fri, 28 Oct 2016 09:32:30 -0400 (EDT)
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
Date:   Fri, 28 Oct 2016 06:32:28 -0700
In-Reply-To: <xmqq60od42s0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 27 Oct 2016 19:37:35 -0700")
Message-ID: <xmqqh97w38gj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F98001CE-9D12-11E6-AEEB-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Hmph.  This may not fly well in practice, though.  

We can flip the order around, and then it becomes simpler to later
drop atime support.  The first step goes like this.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 28 Oct 2016 06:23:07 -0700
Subject: [PATCH] git_open(): untangle possible NOATIME and CLOEXEC interactions

The way we structured the fallback/retry mechanism for opening with
O_NOATIME and O_CLOEXEC meant that if we failed due to lack of
support to open the file with O_NOATIME option (i.e. EINVAL), we
would still try to drop O_CLOEXEC first and retry, and then drop
O_NOATIME.  A platform on which O_NOATIME is defined in the header
without support from the kernel wouldn't have a chance to open with
O_CLOEXEC option due to this code structure.

Arguably, O_CLOEXEC is more important than O_NOATIME, as the latter
is mostly about performance, while the former can affect correctness.

Instead use O_CLOEXEC to open the file, and then use fcntl(2) to set
O_NOATIME on the resulting file descriptor.  open(2) itself does not
cause atime to be updated according to Linus [*1*].

The helper to do the former can be usable in the codepath in
ce_compare_data() that was recently added to open a file descriptor
with O_CLOEXEC; use it while we are at it.

*1* <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h      |  1 +
 read-cache.c |  9 +--------
 sha1_file.c  | 39 +++++++++++++++++++--------------------
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/cache.h b/cache.h
index a902ca1f8e..6f1c21a352 100644
--- a/cache.h
+++ b/cache.h
@@ -1122,6 +1122,7 @@ extern int write_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
+extern int git_open_cloexec(const char *name, int flags);
 extern int git_open(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
diff --git a/read-cache.c b/read-cache.c
index db5d910642..c27d3e240b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,14 +156,7 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
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
+	int fd = git_open_cloexec(ce->name, O_RDONLY);
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
diff --git a/sha1_file.c b/sha1_file.c
index 09045df1dc..dfbf398183 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1559,31 +1559,30 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-int git_open(const char *name)
+int git_open_cloexec(const char *name, int flags)
 {
-	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
-
-	for (;;) {
-		int fd;
-
-		errno = 0;
-		fd = open(name, O_RDONLY | sha1_file_open_flag);
-		if (fd >= 0)
-			return fd;
+	static int cloexec = O_CLOEXEC;
+	int fd = open(name, flags | cloexec);
 
+	if ((cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
 		/* Try again w/o O_CLOEXEC: the kernel might not support it */
-		if ((sha1_file_open_flag & O_CLOEXEC) && errno == EINVAL) {
-			sha1_file_open_flag &= ~O_CLOEXEC;
-			continue;
-		}
+		cloexec &= ~O_CLOEXEC;
+		fd = open(name, flags | cloexec);
+	}
+	return fd;
+}
 
-		/* Might the failure be due to O_NOATIME? */
-		if (errno != ENOENT && (sha1_file_open_flag & O_NOATIME)) {
-			sha1_file_open_flag &= ~O_NOATIME;
-			continue;
-		}
-		return -1;
+int git_open(const char *name)
+{
+	static int noatime = O_NOATIME;
+	int fd = git_open_cloexec(name, O_RDONLY);
+
+	if (0 <= fd && (noatime & O_NOATIME)) {
+		int flags = fcntl(fd, F_GETFL);
+		if (fcntl(fd, F_SETFL, flags | noatime))
+			noatime = 0;
 	}
+	return fd;
 }
 
 static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
-- 
2.10.1-791-g404733b9cf

