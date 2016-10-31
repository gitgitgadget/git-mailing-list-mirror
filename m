Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822FE2021E
	for <e@80x24.org>; Mon, 31 Oct 2016 17:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945073AbcJaRhq (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 13:37:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50362 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S945051AbcJaRhp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 13:37:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7640149FC3;
        Mon, 31 Oct 2016 13:37:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=krCN0fAuoyQ9to7ADzsNFbDibA0=; b=PhgSO5
        PPI/tKnLf+w+ob7qiGG05TT6PNsyhHxJ10DJGyHw3p9v9GThHZ0Tvn3ya0P4dwRG
        nvA+bMLDboV8lSUMSSJWUbLFIVyQIwCOJdaYBTSfTLPg7wbEHmT2ZDIzOGCucGb+
        wOHouksdHMBG0JNNRdyn9PPh6r3SijzjzXExs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O59M6FPrHq5bkFrn6u1AOPpdtJ6QHuXR
        lANcXUYavw/ER0Ot4L8ZFnCd79jpSXa2E3n0mz7rmgdQ76uAu/CLRhcYWzvsm/9u
        LHS+kHrQlcCJ0mZg/ulZqlWuRchs5MrqbJypSKZVZAJturhnGd5mzaaT8JEc9B74
        9nV63FrKzz4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CB9B49FC2;
        Mon, 31 Oct 2016 13:37:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4E1249FC1;
        Mon, 31 Oct 2016 13:37:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
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
        <alpine.DEB.2.20.1610281306320.3264@virtualbox>
        <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
        <xmqqshrg1ksv.fsf@gitster.mtv.corp.google.com>
        <CA+55aFwUEzfvWVSZfhBi85QaKWSo-gVMOk1BJFrR0ZsdCRHRsg@mail.gmail.com>
        <xmqqr370vtba.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610291022120.3264@virtualbox>
        <CA+55aFxsjiuR8cp9SiPS88OnzmCiNN3B-gybz1CS71avsU8OOw@mail.gmail.com>
Date:   Mon, 31 Oct 2016 10:37:41 -0700
In-Reply-To: <CA+55aFxsjiuR8cp9SiPS88OnzmCiNN3B-gybz1CS71avsU8OOw@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 29 Oct 2016 10:06:59 -0700")
Message-ID: <xmqq1sywv2qi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAC3AFC8-9F90-11E6-A442-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Oct 29, 2016 at 1:25 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> Correct. We cannot change an open file handle's state ("FD_CLOEXEC") on
>> Windows, but we can ask open() to open said file handle with the correct
>> flag ("O_CLOEXEC", which is mapped to O_NOINHERIT on Windows.
>
> Ok. So then I have no issues with it, and let's use O_CLOEXEC if it
> exists and fcntl(FD_CLOEXEC) if O_CLOEXEC doesn't exist.

I am not sure if the fallback to FD_CLOEXEC is worth doing, because
it does not exist on Windows, where leaking an open file descriptor
to a child process matters more than other platforms [*1*].  

Of course, the world is not all Windows, and there may be other
platforms this fallback may help.  But there is a chance that some
other thread may fork between the time we open(2) and the time we
call fcntl(2), leaving FD_CLOEXEC ineffective and unreliable, so
that's another thing that makes me doubt if FD_CLOEXEC fallback is
worth doing.

Having said that, here is a rewrite of [*2*] to use the fallback
would look like.  After this topic settles, we may want to also
update the tempfile.c::create_tempfile() implementation to use the
helper function we use here.


[Footnotes]

*1* The call in ce_compare_data() is to see if the contents in the
    working tree file match what is in the index.  Perhaps the
    program is "git checkout another-branch" that knows this path is
    absent in the branch being switched to and trying to make sure
    we lose no local modification.  When the path needs to be passed
    through the clean/smudge filter before hashing to see if the
    working tree contents hashes to the object in the index, we need
    to fork and then after the filter finishes its processing, we
    close the file descriptor and then unlink(2) the path if it is
    clean.  We are about to add a variant of clean/smudge mechanism
    where a lazily spawned process can clean contents of multiple
    paths and that is where cloexec starts to matter.  This function
    starts to inspect one path, opens a fd to it, finds that it
    needs filtering, spawns a long-lingering process, while leaking
    the original fd to it.  After feeding the contents via pipe and
    then receiving the filtered contents (the protocol is not full
    duplex and there won't be a stuck pipe), the parent would decide
    that the path is clean and attempts to unlink(2).  Windows does
    not let you unlink a path with open filedescriptor held, causing
    "checkout" to fail.  As it is only one fd that leaks to the
    child, no matter how many subsequent paths are filtered by the
    same long-lingering child process, it will be a far less
    important issue on other platforms that lets you unlink(2) such
    a file.

*2* http://public-inbox.org/git/xmqqh97w38gj.fsf@gitster.mtv.corp.google.com

---
 cache.h           |  1 +
 git-compat-util.h |  4 ++++
 read-cache.c      |  9 +--------
 sha1_file.c       | 47 ++++++++++++++++++++++++++++-------------------
 4 files changed, 34 insertions(+), 27 deletions(-)

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
diff --git a/git-compat-util.h b/git-compat-util.h
index 43718dabae..64407c701c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -683,6 +683,10 @@ char *gitstrdup(const char *s);
 #define O_CLOEXEC 0
 #endif
 
+#ifndef FD_CLOEXEC
+#define FD_CLOEXEC 0
+#endif
+
 #ifdef FREAD_READS_DIRECTORIES
 #ifdef fopen
 #undef fopen
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
index 09045df1dc..fc8613a847 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1559,31 +1559,40 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-int git_open(const char *name)
+int git_open_cloexec(const char *name, int flags)
 {
-	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
+	int fd;
+	static int o_cloexec = O_CLOEXEC;
+	static int fd_cloexec = FD_CLOEXEC;
 
-	for (;;) {
-		int fd;
+	fd = open(name, flags | o_cloexec);
+	if ((o_cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
+		/* Try again w/o O_CLOEXEC: the kernel might not support it */
+		o_cloexec &= ~O_CLOEXEC;
+		fd = open(name, flags | o_cloexec);
+	}
 
-		errno = 0;
-		fd = open(name, O_RDONLY | sha1_file_open_flag);
-		if (fd >= 0)
-			return fd;
+	if (!o_cloexec && 0 <= fd && fd_cloexec) {
+		/* Opened w/o O_CLOEXEC?  try with fcntl(2) to add it */
+		int flags = fcntl(fd, F_GETFL);
+		if (fcntl(fd, F_SETFL, flags | fd_cloexec))
+			fd_cloexec = 0;
+	}
 
-		/* Try again w/o O_CLOEXEC: the kernel might not support it */
-		if ((sha1_file_open_flag & O_CLOEXEC) && errno == EINVAL) {
-			sha1_file_open_flag &= ~O_CLOEXEC;
-			continue;
-		}
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


