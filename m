From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/21] remote-hg: general updates
Date: Thu, 11 Apr 2013 10:50:37 -0700
Message-ID: <7vwqs9hs7m.fsf@alter.siamese.dyndns.org>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 19:50:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQLe1-0001jo-KK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 19:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926Ab3DKRul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 13:50:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62577 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620Ab3DKRuk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 13:50:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD8101496B;
	Thu, 11 Apr 2013 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bncI62fP5ce8h7j4bfortWt6BG8=; b=D6pXpe
	0EB58fllCFjv9XZs5Uc87AQfA2VS2AYLRk38rvd0xcXI+1UZKtoVd3BYpUThO5V7
	sq8hDorB9sv/eUSWszDzGgtDiixZuNsVs678N5HfvbUEqW1wbR0xazILv0AvgrB4
	tR9PnDLkjQoTEsSYX3udXTYY2IE0nmCIsTQfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iu66QmAlHyu0a0ZaczVObPLUT/58oz8u
	2rSMHzowcQ7tZIZ7P98m1Tpm0ODLodYCHIeLt6AM3W28t50hMHrbHhsZgfhujk8V
	58s852w4aOVfj/20v5pB1wwHwVvdTd3Te2poLRopI/4URB4z0mcQBtKM8XM6otYU
	zKVRWFoat0I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D221D1496A;
	Thu, 11 Apr 2013 17:50:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43FEE14969; Thu, 11 Apr
 2013 17:50:39 +0000 (UTC)
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu, 11 Apr 2013 07:22:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5256D156-A2D0-11E2-8CCF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220900>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is a reroll of the previous series due to a few minor issues. As the
> previous version, forced pushes remain a configuration option. Also, I picked
> up a fix for test regarding hg_log() that was sent to the mailing list.

Will replace the previous round with this one.

The changes since the previous round looks like this on my end,
which all look sensible.

Thanks.

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index d45f16d..a5f0013 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -655,7 +655,7 @@ def parse_commit(parser):
 
     # Check if the ref is supposed to be a named branch
     if ref.startswith('refs/heads/branches/'):
-        extra['branch'] = ref.replace('refs/heads/branches/', '')
+        extra['branch'] = ref[len('refs/heads/branches/'):]
 
     if mode == 'hg':
         i = data.find('\n--HG--\n')
@@ -762,7 +762,7 @@ def do_export(parser):
 
     # handle bookmarks
     for bmark, node in p_bmarks:
-        ref = 'refs/heads' + bmark
+        ref = 'refs/heads/' + bmark
         new = hghex(node)
 
         if bmark in bmarks:
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index a3c88f6..f368953 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -50,7 +50,8 @@ hg_push () {
 }
 
 hg_log () {
-	hg -R $1 log --graph --debug | grep -v 'tag: *default/'
+	hg -R $1 log --graph --debug >log &&
+	grep -v 'tag: *default/' log
 }
 
 setup () {
@@ -62,6 +63,8 @@ setup () {
 	echo "commit = -d \"0 0\""
 	echo "debugrawcommit = -d \"0 0\""
 	echo "tag = -d \"0 0\""
+	echo "[extensions]"
+	echo "graphlog ="
 	) >> "$HOME"/.hgrc &&
 	git config --global remote-hg.hg-git-compat true
 
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 8c59d8e..5daad6b 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -78,7 +78,8 @@ hg_push_hg () {
 }
 
 hg_log () {
-	hg -R $1 log --graph --debug | grep -v 'tag: *default/'
+	hg -R $1 log --graph --debug >log &&
+	grep -v 'tag: *default/' log
 }
 
 git_log () {
@@ -97,6 +98,7 @@ setup () {
 	echo "[extensions]"
 	echo "hgext.bookmarks ="
 	echo "hggit ="
+	echo "graphlog ="
 	) >> "$HOME"/.hgrc &&
 	git config --global receive.denycurrentbranch warn
 	git config --global remote-hg.hg-git-compat true
