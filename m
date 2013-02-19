From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 2/2] check-ignore.c: fix segfault with '.' argument from
 repo root
Date: Tue, 19 Feb 2013 11:56:44 -0800
Message-ID: <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
 <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7tJP-0006BU-MO
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 20:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934010Ab3BST4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 14:56:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757977Ab3BST4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 14:56:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49152AA0F;
	Tue, 19 Feb 2013 14:56:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UI9dYoVDZ9WZ2Ba0q4nlTc6odew=; b=q22+fN
	5K7gDiDH8ehSJxWDQMxndzQIPfhmYypR7BDeXjHrS+YmtVOdulp2mAD2sWx/PthZ
	yUF0DIM8L2LVFWmxE2IBL1DNjgerLIPLEgnHRGqvB47Jha1mlGMDRk8tsVqOtetc
	NCvg5KLCrZemsUYdM9p6oIXHs1TcQJ29DklCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eLWSrVgAFSni150Tw/0mtxpTn9kJGQVT
	U4Cd7Prr6mdNTWijQ+r+0CdXxbOL+xM6fgyQB9nMXzdhSnQMKYOFyuQKJpF+duJE
	+D9Y98EbLUVuhvhf+T8DplffGcha9bEJ9fnZs0SPncHySQ6m15p78ZM+Z3O9g5Lx
	CDxKzOY4GsQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D925AA0D;
	Tue, 19 Feb 2013 14:56:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E5E1AA0C; Tue, 19 Feb 2013
 14:56:45 -0500 (EST)
In-Reply-To: <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com> (Adam
 Spiers's message of "Tue, 19 Feb 2013 19:07:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D2437E0-7ACE-11E2-A142-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216654>

Adam Spiers <git@adamspiers.org> writes:

> Fair enough.  I'll reply to this with a new version.[0]
>
> [0] I wish there was a clean way to include the new version inline,
>     but as I've noted before, there doesn't seem to be:
>
>     http://article.gmane.org/gmane.comp.version-control.git/146110

I find it easier to later find the patch if you made it a separate
follow-up like you did, but you can do it this way if you really
want to, using a scissors line, like so.  Please do not try to be
creative and change the shape of scissors just for the sake of
chaning it.

-- >8 --
Subject: name-hash: allow hashing an empty string

Usually we do not pass an empty string to the function hash_name()
because we almost always ask for hash values for a path that is a
candidate to be added to the index. However, check-ignore (and most
likely check-attr, but I didn't check) apparently has a callchain
to ask the hash value for an empty path when it was given a "." from
the top-level directory to ask "Is the path . excluded by default?"

Make sure that hash_name() does not overrun the end of the given
pathname even when it is empty.

Also remove a sweep-the-issue-under-the-rug conditional in
check-ignore that avoided to pass an empty string to the callchain.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/check-ignore.c | 2 +-
 name-hash.c            | 4 ++--
 t/t0008-ignores.sh     | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 709535c..0240f99 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -89,7 +89,7 @@ static int check_ignore(const char *prefix, const char **pathspec)
 					? strlen(prefix) : 0, path);
 		full_path = check_path_for_gitlink(full_path);
 		die_if_path_beyond_symlink(full_path, prefix);
-		if (!seen[i] && path[0]) {
+		if (!seen[i]) {
 			exclude = last_exclude_matching_path(&check, full_path,
 							     -1, &dtype);
 			if (exclude) {
diff --git a/name-hash.c b/name-hash.c
index d8d25c2..942c459 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -24,11 +24,11 @@ static unsigned int hash_name(const char *name, int namelen)
 {
 	unsigned int hash = 0x123;
 
-	do {
+	while (namelen--) {
 		unsigned char c = *name++;
 		c = icase_hash(c);
 		hash = hash*101 + c;
-	} while (--namelen);
+	}
 	return hash;
 }
 
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index ebe7c70..9c1bde1 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -138,6 +138,7 @@ test_expect_success 'setup' '
 	cat <<-\EOF >.gitignore &&
 		one
 		ignored-*
+		top-level-dir/
 	EOF
 	for dir in . a
 	do
@@ -177,6 +178,10 @@ test_expect_success 'setup' '
 #
 # test invalid inputs
 
+test_expect_success_multi '. corner-case' '' '
+	test_check_ignore . 1
+'
+
 test_expect_success_multi 'empty command line' '' '
 	test_check_ignore "" 128 &&
 	stderr_contains "fatal: no path specified"
