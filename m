From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 02 Feb 2016 15:14:53 -0800
Message-ID: <xmqq37tar9g2.fsf@gitster.mtv.corp.google.com>
References: <20160125144250.GM7100@hank>
	<xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
	<xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
	<20160127151602.GA1690@ecki.hitronhub.home>
	<xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
	<xmqqmvrq7nok.fsf@gitster.mtv.corp.google.com>
	<20160128070959.GA6815@ecki.hitronhub.home>
	<xmqqk2mtmlu9.fsf@gitster.mtv.corp.google.com>
	<20160130081306.GA2931@ecki.hitronhub.home>
	<xmqqlh74wb0r.fsf@gitster.mtv.corp.google.com>
	<20160201193340.GA892@ecki>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:15:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQkAP-0007th-Su
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 00:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbcBBXPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 18:15:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753530AbcBBXO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 18:14:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A0E06411C3;
	Tue,  2 Feb 2016 18:14:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pw0VaK72KcxAASvoX5jG/EUdynY=; b=UtU0Vl
	fJ30QUxl3SSV+iUFwdTYNZIywhaI9fWUr05HfQQOqBpifv+CkRYc5GltbabyY7cU
	kEa/K4gCLif50zj6TBD+YYo7dulFafp8mqY4RbT5Zvrc13eKpi7Mrl+h32DKZNaa
	zHYcZvqAbdgnPMwPZSUF7hKB+OMmL2c5lauNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aAoAWYxYM/ouywgvo0tgH5YYkIBofREg
	yapkbk4DrrexvzJ/OyF4EUN/XRYJGh3RvgCTedAoX2ZocpoUW1R/j1gOSqVT0p6n
	IA2m2kyKLHPVwTY4ZehZfVchjtc58Qa2SyvXgcXbUAE22lGHFScwbp2bQFR42Ocn
	eiLQN+PfcHA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96A98411C2;
	Tue,  2 Feb 2016 18:14:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0CE03411C1;
	Tue,  2 Feb 2016 18:14:55 -0500 (EST)
In-Reply-To: <20160201193340.GA892@ecki> (Clemens Buchacher's message of "Mon,
	1 Feb 2016 20:33:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C52B59E8-CA02-11E5-9E07-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285313>

Clemens Buchacher <drizzd@aon.at> writes:

> On Mon, Feb 01, 2016 at 10:17:24AM -0800, Junio C Hamano wrote:
>> 
>> Your proposal is to redefine "is the working tree dirty?"; it would
>> check if "git checkout -f" would change what is in the working tree.
>
> I like this definition. Sounds obviously right.

So this is an illustration.  The change to ce_compare_data() has a
room for improvement in that it assumes that it can always slurp the
whole blob in-core; it should try to use the streaming interface
when it makes sense.  Otherwise we would not be able to handle a
blob that we used to be able to (as index_fd() streams), which would
be a regression.

The change to t0023 is merely an example that shows that existing
tests assume the convert_to_git() way of defining the dirtyness of
the working tree.  It used to be OK to have core.autocrlf set to true,
have LF terminated file on the working tree and add it to the index,
and the resulting state was "We just added it to the index, and
nobody touched the index nor the working tree file--by definition
the working tree IS CLEAN".  With your updated semantics, that no
longer is true.  "We just added it, but if we check it out, we would
normalize the line ending to be CRLF on the working tree, so the
working tree is dirty" is what happens.

There are tons of tests that would break the same way all of which
needs to be looked at and fixed if we were to go in this direction.


 read-cache.c       | 53 +++++++++++++++++++++++++++++++++++++++++++++++++----
 t/t0023-crlf-am.sh |  2 +-
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 84616c8..c284f78 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,16 +156,61 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 		ce_mark_uptodate(ce);
 }
 
+/*
+ * Compare the data in buf with the data in the file pointed by fd and
+ * return 0 if they are identical, and non-zero if they differ.
+ */
+static int compare_with_fd(const char *input, ssize_t len, int fd)
+{
+	for (;;) {
+		char buf[1024 * 16];
+		ssize_t chunk_len, read_len;
+
+		chunk_len = sizeof(buf) < len ? sizeof(buf) : len;
+		read_len = xread(fd, buf, chunk_len ? chunk_len : 1);
+
+		if (!read_len)
+			/* EOF on the working tree file */
+			return !len ? 0 : -1;
+
+		if (!len)
+			/* we expected there is nothing left */
+			return -1;
+
+		if (memcmp(buf, input, read_len))
+			return -1;
+		input += read_len;
+		len -= read_len;
+	}
+}
+
+/*
+ * Does the file in the working tree match what is in the index?
+ * That is, do we lose any data from the working tree copy if we
+ * did a new "git checkout" of that path out of the index?
+ */
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 {
 	int match = -1;
 	int fd = open(ce->name, O_RDONLY);
 
 	if (fd >= 0) {
-		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
-			match = hashcmp(sha1, ce->sha1);
-		/* index_fd() closed the file descriptor already */
+		enum object_type type;
+		unsigned long size;
+		void *data = read_sha1_file(ce->sha1, &type, &size);
+
+		if (type == OBJ_BLOB) {
+			struct strbuf worktree = STRBUF_INIT;
+			if (convert_to_working_tree(ce->name, data, size,
+						    &worktree)) {
+				free(data);
+				data = strbuf_detach(&worktree, &size);
+			}
+			if (!compare_with_fd(data, size, fd))
+				match = 0;
+		}
+		free(data);
+		close(fd);
 	}
 	return match;
 }
diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
index f9bbb91..5c086b4 100755
--- a/t/t0023-crlf-am.sh
+++ b/t/t0023-crlf-am.sh
@@ -27,7 +27,7 @@ EOF
 test_expect_success 'setup' '
 
 	git config core.autocrlf true &&
-	echo foo >bar &&
+	printf "%s\r\n" foo >bar &&
 	git add bar &&
 	test_tick &&
 	git commit -m initial
