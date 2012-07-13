From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-am: indicate where a failed patch is to be found.
Date: Fri, 13 Jul 2012 16:02:30 -0700
Message-ID: <7vobnj6z95.fsf@alter.siamese.dyndns.org>
References: <7vobnkadsw.fsf@alter.siamese.dyndns.org>
 <1342194690-31578-1-git-send-email-paul.gortmaker@windriver.com>
 <7vipdr8mch.fsf@alter.siamese.dyndns.org> <5000A52B.3090003@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 01:02:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sposh-0000Zn-Jk
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 01:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab2GMXCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 19:02:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475Ab2GMXCd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 19:02:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC0388F86;
	Fri, 13 Jul 2012 19:02:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RjhiM5AGngBqbQzCopkqq0MJsmo=; b=NbnPbj
	PBALi5XjXd2fzTcseTZU1ZHbeRtXABCgRXspXf+QMYvx1q9tj/2BwTZ1GGaFd3yu
	KUIQp/J77suTqjL9wnwOMFiMFjnQB8AGizfx1LjLa3vhj0/YsYSKXeGXJSOCIrju
	jfXsnk5pjV1R8NKEz8p8ujM8/KQJcx/Dp34W4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WXATxS9ktqNW+jS1JSeEWgKtBFEMIB5x
	E5e4OpfrAPcbnQYByGfpE4SzJlY6fBG+m0HG6SH3dd6NQJr1bMXmHbodUZpb/tUc
	o9ZiPZrQrmP0htf1w/PlBv9obTtNfsarmhd6KRj/LXWmwUVCuxhgLMcV33WaL7QD
	WXYao7ObbQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A3E38F85;
	Fri, 13 Jul 2012 19:02:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 008EB8F84; Fri, 13 Jul 2012
 19:02:31 -0400 (EDT)
In-Reply-To: <5000A52B.3090003@windriver.com> (Paul Gortmaker's message of
 "Fri, 13 Jul 2012 18:46:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3A21490-CD3E-11E1-8850-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201428>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> I'm fine with the changes you've proposed below,...

Here is what I committed for today's integration run.  Will be
pushed out on 'pu'.

Thanks.

-- >8 --
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 13 Jul 2012 11:51:30 -0400
Subject: [PATCH] am: indicate where a failed patch is to be found

If "git am" fails to apply something, the end user may need to know
where to find the patch that failed to apply, so that the user can
do other things (e.g. trying "GNU patch" on it, running "diffstat"
to see what it tried to change, etc.)  The input to "am" may have
contained more than one patch, or the message may have been MIME
encoded, and knowing what the user fed to "am" does not help very
much for this purpose.

Also introduce advice.amworkdir configuration to allow people who
learned where to look to squelch this message.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 3 +++
 git-am.sh                | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e1168c..b1f0a75 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -143,6 +143,9 @@ advice.*::
 		Advice shown when you used linkgit:git-checkout[1] to
 		move to the detach HEAD state, to instruct how to create
 		a local branch after the fact.
+	amWorkDir::
+		Advice that shows the location of the patch file when
+		linkgit:git-am[1] fails to apply it.
 --
 
 core.fileMode::
diff --git a/git-am.sh b/git-am.sh
index cb833e2..f1ae932 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -834,6 +834,11 @@ did you forget to use 'git add'?"
 	if test $apply_status != 0
 	then
 		eval_gettextln 'Patch failed at $msgnum $FIRSTLINE'
+		if test "$(git config --bool advice.amworkdir)" != false
+		then
+			eval_gettextln "The copy of the patch that failed is found in:
+   $dotest/patch"
+		fi
 		stop_here_user_resolve $this
 	fi
 
-- 
1.7.11.2
