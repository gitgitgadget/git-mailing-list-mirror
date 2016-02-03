From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Wed, 03 Feb 2016 00:31:03 -0800
Message-ID: <xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
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
	<xmqq37tar9g2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Feb 03 09:31:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQsqF-00021A-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 09:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310AbcBCIbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 03:31:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754843AbcBCIbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 03:31:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1CB5732A3E;
	Wed,  3 Feb 2016 03:31:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CjF2rHnjR1pgyEtr9Zl2vIdzmuY=; b=Si8ty0
	MSuBO8JXzKCgzdOyfiBXdzC1Pgopfovih89BGQuvuAa5gdbVCV+UcPC3ELT4LX37
	+IYG8tdgZ4gR26NTM4pmejbtgIrtl8ZMLWUx4jnTaRJm83gZNiFAK88TbPFbtIvn
	PLT40qsdNzOV9y+jAjzk6Y311QI0FFuNnguCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a1A03YZh88tFgORp/Oork+TAhBy6nx/w
	pQmX14zF2TTJHQVRC1Xen30AB/ktWy0i4USQ6Ay2kypW39zO/jMLpXiQNurwzy2U
	LRX2tDOvv2XdOn5adl3X3zYNcgo4ESwzsQRVKi70auhTc/z31egZMMkslkjFUktA
	45hMU2CGlsU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1384232A3D;
	Wed,  3 Feb 2016 03:31:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5CBC932A3A;
	Wed,  3 Feb 2016 03:31:04 -0500 (EST)
In-Reply-To: <xmqq37tar9g2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 02 Feb 2016 15:14:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76D8F860-CA50-11E5-86A2-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285341>

Junio C Hamano <gitster@pobox.com> writes:

> The change to t0023 is merely an example that shows that existing
> tests assume the convert_to_git() way of defining the dirtyness of
> the working tree.  It used to be OK to have core.autocrlf set to true,
> have LF terminated file on the working tree and add it to the index,
> and the resulting state was "We just added it to the index, and
> nobody touched the index nor the working tree file--by definition
> the working tree IS CLEAN".  With your updated semantics, that no
> longer is true.  "We just added it, but if we check it out, we would
> normalize the line ending to be CRLF on the working tree, so the
> working tree is dirty" is what happens.
>
> There are tons of tests that would break the same way all of which
> needs to be looked at and fixed if we were to go in this direction.

That made me think further aloud.  I haven't thought things through,
but I wonder what happens if we do both.  That is, we define the
working tree file is clean if either:

  * the result of running convert_to_git() on the working tree
    contents matches what is in the index (because that would mean
    doing another "git add" on the path is a no-op); OR

  * the result of running convert_to_working_tree() on the content
    in the index matches what is in the working tree (because that
    would mean doing another "git checkout -f" on the path is a
    no-op).

A possible downside (but again, I haven't thought things through, so
this may be a non-issue) of doing this is that it may make it even
harder to "fix" an index entry or a working tree file that is
inconsistent with the user's conversion settings.  Even when "git
add" would allow the user to fix an index entry by applying (an
updated) convert_to_git() filter to the working tree file, because
of the new rule that works in the opposite direction, we would end
up saying "the working tree file is clean, and there is no point
doing 'git add'".  And vice versa for fixing a working tree file by
running "git checkout".

Also this will make "update-index --refresh" potentially take twice
as long for paths that are not known to be clean and indeed dirty,
as they would need to be processed twice.

An updated patch to do so would look like this.  At least we don't
have to update the expectation t0023 makes with this approach.

 read-cache.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 84616c8..42d9452 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,17 +156,78 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
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
+ */
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 {
 	int match = -1;
 	int fd = open(ce->name, O_RDONLY);
 
+	/*
+	 * Would another "git add" on the path change what is in the
+	 * index for the path?
+	 */
 	if (fd >= 0) {
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
 			match = hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
+	if (!match)
+		return match;
+
+	/*
+	 * Would another "git checkout -f" out of the index change
+	 * what is in the working tree file?
+	 */
+	fd = open(ce->name, O_RDONLY);
+	if (fd >= 0) {
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
+	}
 	return match;
 }
 
