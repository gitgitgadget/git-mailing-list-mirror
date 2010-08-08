From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 3/9] stash: introduce is_stash_ref and assert_stash_ref functions.
Date: Sun,  8 Aug 2010 14:46:05 +1000
Message-ID: <1281242771-24764-4-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, nanako3@bluebottle.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 06:49:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhxpQ-0008JV-RW
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934Ab0HHEtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:49:40 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63422 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab0HHErk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:47:40 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so971854pwj.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pcV6DOaLeCra1PilZs2Y2cmmuexWmjaFyCGy9yWuQHM=;
        b=U3XIH8/vhpcQVdogi4YN6fkr79Tbo1DCpCfRhVK/PxHzpWauxzM9Il3BbJVwHZbRBQ
         0aZeYpt6rf0VtPcCcsKajAt4BkPDyfoVudd3cej2c15Tx42wesMFC/YmMJEBkTtVQFHT
         1VUtEjmpSND7+mCzGWJDMtTqqeIpv9YAbHQ10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E837QkO4B9n5Ju2tULP9vbKI8j9BR2MxcrW1/V80qnB3zXsnpyPx9RRegzE7GEmjo7
         jZ7izi27/Q0FuS6Wrpu5DAQqv0Rok3m7sKusiDHIlfCcJd0eID/9Ib3PXOAmyBOf9HVq
         mCj/FMrCFwjxAwElq0oPhRz9qbJXapwWvtDZ0=
Received: by 10.142.174.4 with SMTP id w4mr12305669wfe.252.1281242859790;
        Sat, 07 Aug 2010 21:47:39 -0700 (PDT)
Received: from localhost.localdomain ([120.16.216.92])
        by mx.google.com with ESMTPS id n2sm4295884wfl.13.2010.08.07.21.47.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:47:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.47.gc532
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152893>

Introduce a function, is_stash_ref, which checks whether an
argument is valid stash reference (e.g. is of the form ['refs/']stash['@{'something'}])

Introduce a function, assert_stash_ref, which can be used to ensure
that certain commands are only called with stash references as
arguments.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index dbb7944..41a9359 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -223,6 +223,15 @@ show_stash () {
 	git diff $flags $b_commit $w_commit
 }
 
+is_stash_ref() {
+	revs="$(git rev-parse --revs-only --symbolic --verify --default ${ref_stash} "$@")" &&
+	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${revs%@*}")"
+}
+
+assert_stash_ref() {
+	is_stash_ref "$@" || die "$* is not a stash reference"
+}
+
 #
 # if this function returns, then:
 #   s is set to the stash commit
-- 
1.7.2.1.51.g82c0c0
