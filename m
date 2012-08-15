From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Wed, 15 Aug 2012 13:02:48 -0700
Message-ID: <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <877gt16ewe.fsf@thomas.inf.ethz.ch> <7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
 <87sjbpa5m8.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	"Martin von Zweigbergk" <martin.von.zweigbergk@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:03:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1jo9-0001Qf-3N
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 22:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab2HOUCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 16:02:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932382Ab2HOUCv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 16:02:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CA439732;
	Wed, 15 Aug 2012 16:02:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z57WtJQ1YPVs2NN1H8FmJexApDk=; b=QW7e4K
	064buzN+9+tDlRk3rMC/p1JCdee//zU2JRu05FJDfFCqg+h61eINZBF7s+E3xeIU
	Dah+4X1ljHG/qtz921T46AJWjvcKKrcEzHCQghZ60ZwGdpVh57dLez5KFhAoGCKK
	UkBHkUd1slkBs2eCKiTkiE7jvY95Or78qi6Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lpovVV9OCA65PM/ZRmoOotDROtiQ81eP
	hYlfTLnnnziXrY6M+9P6t87BZbqKe6GfRljDN4LTPY7vtI03j5nX+JrSvNxLUEgZ
	9QQEoke/y3XG9tlKuT3fv3S1ruaUVB6ogOUUxTRJgb+0G6T6fGvpb7g6FL2HxArC
	x9LlSTs2zyY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A4149730;
	Wed, 15 Aug 2012 16:02:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62353972D; Wed, 15 Aug 2012
 16:02:50 -0400 (EDT)
In-Reply-To: <87sjbpa5m8.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 14 Aug 2012 16:51:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30EE1F1A-E714-11E1-B764-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was unclear what "--topo-order" was really about in the
documentation.  It is not just about "children before parent", but
also about "don't mix lineages".

Reword the description for both "--date-order" and "--topo-order",
and add an illustration to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
  Thomas Rast <trast@student.ethz.ch> writes:

  > But then the new description is wrong.  It claims that children are
  > always before parents, which is not true in the face of clock skew.

  Thanks for sanity-check.  Here is an updated one.

 Documentation/rev-list-options.txt | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 6a4b635..9404d08 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -578,16 +578,33 @@ Commit Ordering
 
 By default, the commits are shown in reverse chronological order.
 
---topo-order::
+--date-order::
+	Show no parents before all of its children are shown, but
+	otherwise show commits in the commit timestamp order.
 
-	This option makes them appear in topological order (i.e.
-	descendant commits are shown before their parents).
+--topo-order::
+	Show no parents before all of its children are shown, and
+	avoid showing commits on multiple lines of history
+	intermixed.
++
+For example, in a commit history like this:
++
+----------------------------------------------------------------
 
---date-order::
+    ---1----2----4----7
+	\	       \
+	 3----5----6----8---
 
-	This option is similar to '--topo-order' in the sense that no
-	parent comes before all of its children, but otherwise things
-	are still ordered in the commit timestamp order.
+----------------------------------------------------------------
++
+where the numbers denote the order of commit timestamps, `git
+rev-list` and friends with `--date-order` show the commits in the
+timestamp order: 8 7 6 5 4 3 2 1.
++
+With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
+3 1); some older commits are shown before newer ones in order to
+avoid showing the commits from two parallel development track mixed
+together.
 
 --reverse::
 
-- 
1.7.12.rc2.85.g1de7134
