From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] fetch doc: on pulling multiple refspecs
Date: Thu, 29 May 2014 15:42:29 -0700
Message-ID: <1401403350-7122-5-git-send-email-gitster@pobox.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 00:43:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq92U-0003vU-PS
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 00:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbaE2Wm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 18:42:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65278 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841AbaE2Wm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 18:42:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB76B1C338;
	Thu, 29 May 2014 18:42:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AlMp
	4sQHyN/JbRercxuY3gRvUn0=; b=xthZDqRwekFlmaMSmKwXXhZw0OUYufE1JWQo
	BnB51n5Jx1aLKNDPllLbXTGsr7hPZMH4I+0mXYgRC/bQXZptapZ/PyzIDCB2epaY
	UZmFkNWn5WsI5aPcz+dzFNjG6KVDBtpQ5Iwuf5nxJ6Md77fkN//+Qh4AAlml9rtL
	vHeUl5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=AayCze
	aY60Z3XJU/PBm7oIkiiVb++o09yh1h1l5sO41naHwwTiKoPHHR+b+hH0EDDtNfVm
	o9bBnrNA9mIDLOtQZhbom0++tplbhRW4uj2gtsKKVkblW/6X2eNe+jtazNgCFJdI
	eWexPr4nmBWIHC5W2Ea+Og7GfwumNfMpt8LHM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D37CE1C337;
	Thu, 29 May 2014 18:42:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CE4741C328;
	Thu, 29 May 2014 18:42:51 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-479-g59ac8f9
In-Reply-To: <1401403350-7122-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 912B5D82-E782-11E3-AAC7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250415>

Replace desription of old-style "Pull:" lines in remotes/
configuration with modern remote.*.fetch variables.

As this note applies only to "git pull", enable it only
in git-pull manual page.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pull-fetch-param.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index e266c2d..ea4c5a6 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -34,22 +34,26 @@ will be needed for such branches.  There is no way to
 determine or declare that a branch will be made available
 in a repository with this behavior; the pulling user simply
 must know this is the expected usage pattern for a branch.
+ifdef::git-pull[]
 +
 [NOTE]
 There is a difference between listing multiple <refspec>
 directly on 'git pull' command line and having multiple
-`Pull:` <refspec> lines for a <repository> and running
+`remote.<repository>.fetch` entries in your configuration
+for a <repository> and running
 'git pull' command without any explicit <refspec> parameters.
 <refspec> listed explicitly on the command line are always
 merged into the current branch after fetching.  In other words,
 if you list more than one remote refs, you would be making
-an Octopus.  While 'git pull' run without any explicit <refspec>
-parameter takes default <refspec>s from `Pull:` lines, it
+an Octopus merge. On the other hand, 'git pull' that is run
+without any explicit <refspec> parameter takes default
+<refspec>s from `remote.<repository>.fetch` configuration, it
 merges only the first <refspec> found into the current branch,
-after fetching all the remote refs.  This is because making an
+after fetching all the remote refs specified.  This is because making an
 Octopus from remote refs is rarely done, while keeping track
 of multiple remote heads in one-go by fetching more than one
 is often useful.
+endif::git-pull[]
 +
 Some short-cut notations are also supported.
 +
-- 
2.0.0-479-g59ac8f9
