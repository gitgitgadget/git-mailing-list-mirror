From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/12] fetch: do not store peeled tag object names in
 FETCH_HEAD
Date: Mon,  7 Nov 2011 19:00:35 -0800
Message-ID: <1320721245-13223-3-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:01:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbvt-0001LQ-Uq
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 04:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab1KHDAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 22:00:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab1KHDAy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 22:00:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4253D6504;
	Mon,  7 Nov 2011 22:00:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9O0V
	BXA4x5j4CJaQBCdYY+bBS0g=; b=ucGVXG6l5F/uxbqttw1lQxvmVEh5ddJpbVv1
	2AoauP5zsG8VvHKTwLuvm2epmE+RG8PPQjKAWRkWc8CMU2hlRpK1SoO9gpkJy1To
	pVJIf0BsNaso83SVWO6QQbv3pfzB7ae8YKCqM0xaQIQFtWhnDCrZRlBJLSEKOE46
	tXPT4mA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	u6tQic8I1byXT63OCOvyuJZkrrA39k2YV7sRnjE/2Keu3kdR6hjsEs/SBBhN+HzG
	gL8HFH8kGd86Dh6jh/r6YibS75yjr/73x5EwcK+/0s1RsIOBUTeDV1PTo5voZJi4
	23iSVVbPB9NNUQv1QZEQ4HiA5gx82a7ZIS0FdfVLLS8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 385E56503;
	Mon,  7 Nov 2011 22:00:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC7AC6502; Mon,  7 Nov 2011
 22:00:51 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.g90e080
In-Reply-To: <1320721245-13223-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DE104D36-09B5-11E1-A29D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185056>

From: Linus Torvalds <torvalds@linux-foundation.org>

We do not want to record tags as parents of a merge when the user does
"git pull $there tag v1.0" to merge tagged commit, but that is not a good
enough excuse to peel the tag down to commit when storing in FETCH_HEAD.
The caller of underlying "git fetch $there tag v1.0" may have other uses
of information contained in v1.0 tag in mind.

[jc: the test adjustment is to update for the new expectation]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c                                    |    3 +--
 t/t5515/fetch.br-branches-default                  |    6 +++---
 t/t5515/fetch.br-branches-default-merge            |    6 +++---
 ...etch.br-branches-default-merge_branches-default |    6 +++---
 t/t5515/fetch.br-branches-default-octopus          |    6 +++---
 ...ch.br-branches-default-octopus_branches-default |    6 +++---
 t/t5515/fetch.br-branches-default_branches-default |    6 +++---
 t/t5515/fetch.br-branches-one                      |    6 +++---
 t/t5515/fetch.br-branches-one-merge                |    6 +++---
 t/t5515/fetch.br-branches-one-merge_branches-one   |    6 +++---
 t/t5515/fetch.br-branches-one-octopus              |    6 +++---
 t/t5515/fetch.br-branches-one-octopus_branches-one |    6 +++---
 t/t5515/fetch.br-branches-one_branches-one         |    6 +++---
 t/t5515/fetch.br-config-explicit                   |    6 +++---
 t/t5515/fetch.br-config-explicit-merge             |    6 +++---
 .../fetch.br-config-explicit-merge_config-explicit |    6 +++---
 t/t5515/fetch.br-config-explicit-octopus           |    6 +++---
 ...etch.br-config-explicit-octopus_config-explicit |    6 +++---
 t/t5515/fetch.br-config-explicit_config-explicit   |    6 +++---
 t/t5515/fetch.br-config-glob                       |    6 +++---
 t/t5515/fetch.br-config-glob-merge                 |    6 +++---
 t/t5515/fetch.br-config-glob-merge_config-glob     |    6 +++---
 t/t5515/fetch.br-config-glob-octopus               |    6 +++---
 t/t5515/fetch.br-config-glob-octopus_config-glob   |    6 +++---
 t/t5515/fetch.br-config-glob_config-glob           |    6 +++---
 t/t5515/fetch.br-remote-explicit                   |    6 +++---
 t/t5515/fetch.br-remote-explicit-merge             |    6 +++---
 .../fetch.br-remote-explicit-merge_remote-explicit |    6 +++---
 t/t5515/fetch.br-remote-explicit-octopus           |    6 +++---
 ...etch.br-remote-explicit-octopus_remote-explicit |    6 +++---
 t/t5515/fetch.br-remote-explicit_remote-explicit   |    6 +++---
 t/t5515/fetch.br-remote-glob                       |    6 +++---
 t/t5515/fetch.br-remote-glob-merge                 |    6 +++---
 t/t5515/fetch.br-remote-glob-merge_remote-glob     |    6 +++---
 t/t5515/fetch.br-remote-glob-octopus               |    6 +++---
 t/t5515/fetch.br-remote-glob-octopus_remote-glob   |    6 +++---
 t/t5515/fetch.br-remote-glob_remote-glob           |    6 +++---
 t/t5515/fetch.br-unconfig                          |    6 +++---
 t/t5515/fetch.br-unconfig_--tags_.._.git           |    6 +++---
 ...nfig_.._.git_one_tag_tag-one_tag_tag-three-file |    6 +++---
 ...fig_.._.git_tag_tag-one-tree_tag_tag-three-file |    6 +++---
 ...h.br-unconfig_.._.git_tag_tag-one_tag_tag-three |    6 +++---
 t/t5515/fetch.br-unconfig_branches-default         |    6 +++---
 t/t5515/fetch.br-unconfig_branches-one             |    6 +++---
 t/t5515/fetch.br-unconfig_config-explicit          |    6 +++---
 t/t5515/fetch.br-unconfig_config-glob              |    6 +++---
 t/t5515/fetch.br-unconfig_remote-explicit          |    6 +++---
 t/t5515/fetch.br-unconfig_remote-glob              |    6 +++---
 t/t5515/fetch.master                               |    6 +++---
 t/t5515/fetch.master_--tags_.._.git                |    6 +++---
 ...ster_.._.git_one_tag_tag-one_tag_tag-three-file |    6 +++---
 ...ter_.._.git_tag_tag-one-tree_tag_tag-three-file |    6 +++---
 .../fetch.master_.._.git_tag_tag-one_tag_tag-three |    6 +++---
 t/t5515/fetch.master_branches-default              |    6 +++---
 t/t5515/fetch.master_branches-one                  |    6 +++---
 t/t5515/fetch.master_config-explicit               |    6 +++---
 t/t5515/fetch.master_config-glob                   |    6 +++---
 t/t5515/fetch.master_remote-explicit               |    6 +++---
 t/t5515/fetch.master_remote-glob                   |    6 +++---
 59 files changed, 175 insertions(+), 176 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1adf6c1..d061e2c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -436,8 +436,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		}
 		note[note_len] = '\0';
 		fprintf(fp, "%s\t%s\t%s",
-			sha1_to_hex(commit ? commit->object.sha1 :
-				    rm->old_sha1),
+			sha1_to_hex(rm->old_sha1),
 			rm->merge ? "" : "not-for-merge",
 			note);
 		for (i = 0; i < url_len; ++i)
diff --git a/t/t5515/fetch.br-branches-default b/t/t5515/fetch.br-branches-default
index 2e0414f..a1bc3d5 100644
--- a/t/t5515/fetch.br-branches-default
+++ b/t/t5515/fetch.br-branches-default
@@ -1,8 +1,8 @@
 # br-branches-default
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge b/t/t5515/fetch.br-branches-default-merge
index ca2cc1d..e3a41ae 100644
--- a/t/t5515/fetch.br-branches-default-merge
+++ b/t/t5515/fetch.br-branches-default-merge
@@ -1,9 +1,9 @@
 # br-branches-default-merge
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge_branches-default b/t/t5515/fetch.br-branches-default-merge_branches-default
index 7d947cd..1f60561 100644
--- a/t/t5515/fetch.br-branches-default-merge_branches-default
+++ b/t/t5515/fetch.br-branches-default-merge_branches-default
@@ -1,9 +1,9 @@
 # br-branches-default-merge branches-default
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus b/t/t5515/fetch.br-branches-default-octopus
index ec39c54..f31e1b3 100644
--- a/t/t5515/fetch.br-branches-default-octopus
+++ b/t/t5515/fetch.br-branches-default-octopus
@@ -2,9 +2,9 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus_branches-default b/t/t5515/fetch.br-branches-default-octopus_branches-default
index 6bf42e2..7060bd9 100644
--- a/t/t5515/fetch.br-branches-default-octopus_branches-default
+++ b/t/t5515/fetch.br-branches-default-octopus_branches-default
@@ -2,9 +2,9 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default_branches-default b/t/t5515/fetch.br-branches-default_branches-default
index 4a2bf3c..8cbd718 100644
--- a/t/t5515/fetch.br-branches-default_branches-default
+++ b/t/t5515/fetch.br-branches-default_branches-default
@@ -1,8 +1,8 @@
 # br-branches-default branches-default
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one b/t/t5515/fetch.br-branches-one
index 12ac8d2..c98f670 100644
--- a/t/t5515/fetch.br-branches-one
+++ b/t/t5515/fetch.br-branches-one
@@ -1,8 +1,8 @@
 # br-branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge b/t/t5515/fetch.br-branches-one-merge
index b4b3b35..aa1c8a9 100644
--- a/t/t5515/fetch.br-branches-one-merge
+++ b/t/t5515/fetch.br-branches-one-merge
@@ -1,9 +1,9 @@
 # br-branches-one-merge
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge_branches-one b/t/t5515/fetch.br-branches-one-merge_branches-one
index 2ecef38..c93310a 100644
--- a/t/t5515/fetch.br-branches-one-merge_branches-one
+++ b/t/t5515/fetch.br-branches-one-merge_branches-one
@@ -1,9 +1,9 @@
 # br-branches-one-merge branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus b/t/t5515/fetch.br-branches-one-octopus
index 96e3029..97c4b54 100644
--- a/t/t5515/fetch.br-branches-one-octopus
+++ b/t/t5515/fetch.br-branches-one-octopus
@@ -1,9 +1,9 @@
 # br-branches-one-octopus
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus_branches-one b/t/t5515/fetch.br-branches-one-octopus_branches-one
index 55e0bad..df705f7 100644
--- a/t/t5515/fetch.br-branches-one-octopus_branches-one
+++ b/t/t5515/fetch.br-branches-one-octopus_branches-one
@@ -1,9 +1,9 @@
 # br-branches-one-octopus branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one_branches-one b/t/t5515/fetch.br-branches-one_branches-one
index 281fa09..96890e5 100644
--- a/t/t5515/fetch.br-branches-one_branches-one
+++ b/t/t5515/fetch.br-branches-one_branches-one
@@ -1,8 +1,8 @@
 # br-branches-one branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit b/t/t5515/fetch.br-config-explicit
index e2fa9c8..68fc927 100644
--- a/t/t5515/fetch.br-config-explicit
+++ b/t/t5515/fetch.br-config-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit-merge b/t/t5515/fetch.br-config-explicit-merge
index ec1a723..f6475b7 100644
--- a/t/t5515/fetch.br-config-explicit-merge
+++ b/t/t5515/fetch.br-config-explicit-merge
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit-merge_config-explicit b/t/t5515/fetch.br-config-explicit-merge_config-explicit
index 54f6891..018bdd7 100644
--- a/t/t5515/fetch.br-config-explicit-merge_config-explicit
+++ b/t/t5515/fetch.br-config-explicit-merge_config-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus b/t/t5515/fetch.br-config-explicit-octopus
index 7011dfc..36d0270 100644
--- a/t/t5515/fetch.br-config-explicit-octopus
+++ b/t/t5515/fetch.br-config-explicit-octopus
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus_config-explicit b/t/t5515/fetch.br-config-explicit-octopus_config-explicit
index bdad51f..6654ad0 100644
--- a/t/t5515/fetch.br-config-explicit-octopus_config-explicit
+++ b/t/t5515/fetch.br-config-explicit-octopus_config-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit_config-explicit b/t/t5515/fetch.br-config-explicit_config-explicit
index 1b237dd..b19b016 100644
--- a/t/t5515/fetch.br-config-explicit_config-explicit
+++ b/t/t5515/fetch.br-config-explicit_config-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob b/t/t5515/fetch.br-config-glob
index e75ec2f..946d70c 100644
--- a/t/t5515/fetch.br-config-glob
+++ b/t/t5515/fetch.br-config-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob-merge b/t/t5515/fetch.br-config-glob-merge
index ce8f739..8bb5e8b 100644
--- a/t/t5515/fetch.br-config-glob-merge
+++ b/t/t5515/fetch.br-config-glob-merge
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob-merge_config-glob b/t/t5515/fetch.br-config-glob-merge_config-glob
index 5817bed..113c08d 100644
--- a/t/t5515/fetch.br-config-glob-merge_config-glob
+++ b/t/t5515/fetch.br-config-glob-merge_config-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus b/t/t5515/fetch.br-config-glob-octopus
index 938e532..9bbd537 100644
--- a/t/t5515/fetch.br-config-glob-octopus
+++ b/t/t5515/fetch.br-config-glob-octopus
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus_config-glob b/t/t5515/fetch.br-config-glob-octopus_config-glob
index c9225bf..4e51043 100644
--- a/t/t5515/fetch.br-config-glob-octopus_config-glob
+++ b/t/t5515/fetch.br-config-glob-octopus_config-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob_config-glob b/t/t5515/fetch.br-config-glob_config-glob
index a6c20f9..19daf0c 100644
--- a/t/t5515/fetch.br-config-glob_config-glob
+++ b/t/t5515/fetch.br-config-glob_config-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit b/t/t5515/fetch.br-remote-explicit
index 83534d2..ab44bc5 100644
--- a/t/t5515/fetch.br-remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge b/t/t5515/fetch.br-remote-explicit-merge
index a9064dd..7421b2c 100644
--- a/t/t5515/fetch.br-remote-explicit-merge
+++ b/t/t5515/fetch.br-remote-explicit-merge
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit b/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
index 732a37e..b6975d3 100644
--- a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus b/t/t5515/fetch.br-remote-explicit-octopus
index ecf020d..7681281 100644
--- a/t/t5515/fetch.br-remote-explicit-octopus
+++ b/t/t5515/fetch.br-remote-explicit-octopus
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit b/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
index af77531..4c896cf 100644
--- a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit_remote-explicit b/t/t5515/fetch.br-remote-explicit_remote-explicit
index 51fae56..01e014e 100644
--- a/t/t5515/fetch.br-remote-explicit_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit_remote-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob b/t/t5515/fetch.br-remote-glob
index 94e6ad3..09bfcee 100644
--- a/t/t5515/fetch.br-remote-glob
+++ b/t/t5515/fetch.br-remote-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge b/t/t5515/fetch.br-remote-glob-merge
index 09362e2..4b62b01 100644
--- a/t/t5515/fetch.br-remote-glob-merge
+++ b/t/t5515/fetch.br-remote-glob-merge
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge_remote-glob b/t/t5515/fetch.br-remote-glob-merge_remote-glob
index e2eabec..7478f1f 100644
--- a/t/t5515/fetch.br-remote-glob-merge_remote-glob
+++ b/t/t5515/fetch.br-remote-glob-merge_remote-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus b/t/t5515/fetch.br-remote-glob-octopus
index b08e046..2543420 100644
--- a/t/t5515/fetch.br-remote-glob-octopus
+++ b/t/t5515/fetch.br-remote-glob-octopus
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus_remote-glob b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
index d4d547c..5ffde9c 100644
--- a/t/t5515/fetch.br-remote-glob-octopus_remote-glob
+++ b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob_remote-glob b/t/t5515/fetch.br-remote-glob_remote-glob
index 646dbc8..20ba5cb 100644
--- a/t/t5515/fetch.br-remote-glob_remote-glob
+++ b/t/t5515/fetch.br-remote-glob_remote-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig b/t/t5515/fetch.br-unconfig
index 65ce6d9..887ccfc 100644
--- a/t/t5515/fetch.br-unconfig
+++ b/t/t5515/fetch.br-unconfig
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_--tags_.._.git b/t/t5515/fetch.br-unconfig_--tags_.._.git
index 8258c80..1669cc4 100644
--- a/t/t5515/fetch.br-unconfig_--tags_.._.git
+++ b/t/t5515/fetch.br-unconfig_--tags_.._.git
@@ -1,7 +1,7 @@
 # br-unconfig --tags ../.git
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file b/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
index f02bab2..7411536 100644
--- a/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
+++ b/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -2,7 +2,7 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
index 85de411..7726983 100644
--- a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
+++ b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
@@ -1,7 +1,7 @@
 # br-unconfig ../.git tag tag-one-tree tag tag-three-file
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
index 0da2337..7b3750c 100644
--- a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
+++ b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
@@ -1,7 +1,7 @@
 # br-unconfig ../.git tag tag-one tag tag-three
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		tag 'tag-three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899		tag 'tag-three' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_branches-default b/t/t5515/fetch.br-unconfig_branches-default
index fc7041e..da30e3c 100644
--- a/t/t5515/fetch.br-unconfig_branches-default
+++ b/t/t5515/fetch.br-unconfig_branches-default
@@ -1,8 +1,8 @@
 # br-unconfig branches-default
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_branches-one b/t/t5515/fetch.br-unconfig_branches-one
index e94cde7..e461431 100644
--- a/t/t5515/fetch.br-unconfig_branches-one
+++ b/t/t5515/fetch.br-unconfig_branches-one
@@ -1,8 +1,8 @@
 # br-unconfig branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_config-explicit b/t/t5515/fetch.br-unconfig_config-explicit
index 01a283e..ed323c9 100644
--- a/t/t5515/fetch.br-unconfig_config-explicit
+++ b/t/t5515/fetch.br-unconfig_config-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_config-glob b/t/t5515/fetch.br-unconfig_config-glob
index 3a556c5..2372ed0 100644
--- a/t/t5515/fetch.br-unconfig_config-glob
+++ b/t/t5515/fetch.br-unconfig_config-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_remote-explicit b/t/t5515/fetch.br-unconfig_remote-explicit
index db216df..6318dd1 100644
--- a/t/t5515/fetch.br-unconfig_remote-explicit
+++ b/t/t5515/fetch.br-unconfig_remote-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_remote-glob b/t/t5515/fetch.br-unconfig_remote-glob
index aee65c2..1d9afad 100644
--- a/t/t5515/fetch.br-unconfig_remote-glob
+++ b/t/t5515/fetch.br-unconfig_remote-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master b/t/t5515/fetch.master
index 950fd07..9b29d67 100644
--- a/t/t5515/fetch.master
+++ b/t/t5515/fetch.master
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_--tags_.._.git b/t/t5515/fetch.master_--tags_.._.git
index 0e59950..8a74935 100644
--- a/t/t5515/fetch.master_--tags_.._.git
+++ b/t/t5515/fetch.master_--tags_.._.git
@@ -1,7 +1,7 @@
 # master --tags ../.git
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file b/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
index 8286852..0672d12 100644
--- a/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
+++ b/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -2,7 +2,7 @@
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file b/t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file
index 2e133ef..0fd737c 100644
--- a/t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file
+++ b/t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file
@@ -1,7 +1,7 @@
 # master ../.git tag tag-one-tree tag tag-three-file
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three b/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
index 92b18b4..e488986 100644
--- a/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
+++ b/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
@@ -1,7 +1,7 @@
 # master ../.git tag tag-one tag tag-three
 8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		tag 'tag-three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899		tag 'tag-three' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_branches-default b/t/t5515/fetch.master_branches-default
index 603d6d2..2eedd3b 100644
--- a/t/t5515/fetch.master_branches-default
+++ b/t/t5515/fetch.master_branches-default
@@ -1,8 +1,8 @@
 # master branches-default
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_branches-one b/t/t5515/fetch.master_branches-one
index fe9bb0b..901ce21 100644
--- a/t/t5515/fetch.master_branches-one
+++ b/t/t5515/fetch.master_branches-one
@@ -1,8 +1,8 @@
 # master branches-one
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_config-explicit b/t/t5515/fetch.master_config-explicit
index 4be97c7..251c826 100644
--- a/t/t5515/fetch.master_config-explicit
+++ b/t/t5515/fetch.master_config-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_config-glob b/t/t5515/fetch.master_config-glob
index cb0726f..27c158e 100644
--- a/t/t5515/fetch.master_config-glob
+++ b/t/t5515/fetch.master_config-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_remote-explicit b/t/t5515/fetch.master_remote-explicit
index 44a1ca8..b3cfe6b 100644
--- a/t/t5515/fetch.master_remote-explicit
+++ b/t/t5515/fetch.master_remote-explicit
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_remote-glob b/t/t5515/fetch.master_remote-glob
index 724e8db..118befd 100644
--- a/t/t5515/fetch.master_remote-glob
+++ b/t/t5515/fetch.master_remote-glob
@@ -3,9 +3,9 @@
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
+c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
 0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
+525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
-- 
1.7.8.rc0.128.g31aa4
