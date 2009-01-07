From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/3] refs: add a "for_each_replace_ref" function
Date: Wed, 7 Jan 2009 08:43:07 +0100
Message-ID: <20090107084307.21100bb5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 08:43:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKT4r-00006x-49
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 08:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbZAGHmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 02:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbZAGHmW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 02:42:22 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:59191 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbZAGHmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 02:42:21 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 04F964C812B;
	Wed,  7 Jan 2009 08:42:14 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id C4F8D4C8177;
	Wed,  7 Jan 2009 08:42:11 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104770>

This is some preparation work for the following patches that are using
the "refs/replace/" ref namespace.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 refs.c |    5 +++++
 refs.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

	Junio wrote:

	> What I thought we
	> discussed during GitTogether was to write out the object name of the
	> replacement object in refs/replace/<sha1>.
	>
	> When the caller asks read_sha1_file() for an object whose object name is
	> <sha1>, you see if there is refs/replace/<sha1> in the repository, and
	> read the ref to learn the object name of the object that replaces it. 
	> And you return that as if it is the original object.
	
	Patch 2/3 in this series implements the new mechanism. As you can see I
	prefered it to be called when reading parent commits than from
	"read_sha1_file", because it seems to simplify things. I hope you still like
	it.

	Regards,
	Christian.

diff --git a/refs.c b/refs.c
index 33ced65..042106d 100644
--- a/refs.c
+++ b/refs.c
@@ -632,6 +632,11 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/remotes/", fn, 13, cb_data);
 }
 
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref("refs/replace/", fn, 13, cb_data);
+}
+
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
  * We do not like it if:
diff --git a/refs.h b/refs.h
index 06ad260..8d2ee5a 100644
--- a/refs.h
+++ b/refs.h
@@ -23,6 +23,7 @@ extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
+extern int for_each_replace_ref(each_ref_fn, void *);
 
 /*
  * Extra refs will be listed by for_each_ref() before any actual refs
-- 
1.6.1.162.g1cd53
