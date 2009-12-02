From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull.sh: Fix call to git-merge for new command  
 format
Date: Wed, 02 Dec 2009 09:49:08 -0800
Message-ID: <7viqcpgtbf.fsf@alter.siamese.dyndns.org>
References: <1259707451-20661-1-git-send-email-vonbrand@inf.utfsm.cl>
 <7vmy22qmgp.fsf@alter.siamese.dyndns.org>
 <4B163B49.4070606@drmicha.warpmail.net>
 <7vws15jpe7.fsf@alter.siamese.dyndns.org>
 <4B16A410.5090802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:49:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFtKf-0005vC-GI
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279AbZLBRtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbZLBRtO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:49:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbZLBRtM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:49:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 94F8FA3E71;
	Wed,  2 Dec 2009 12:49:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n9TQFXlgJ8SSsV0ecRsga13YPJc=; b=vwVYlN
	J6eQwEESd4LEaCm8ADeR/gw8p2JCn+55G4VSpq0lpR9yRn+iHR+y5Fn3InDqUMDW
	WeqcaVPqjSQDx2qny01TyGgH+BCvTWpkH2rXh4gnTr5crGoqB5FfzZUV/Pk3tHlY
	lWHQtKbdBUZUYYJMpzorFOWfisDH4EZrcr82o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgwYWSREyfKfwdRBbAZz62Fhcw/Zij6u
	23+U4d4HWPbq92Z9obPObZYSglmamaLeanoS5BfMw7OXH0MtY/1ZHDEhbn2Rcttk
	p6rGTWRGiLlxsWw994huHoWsb4Qdn/4QzrSLXbF13dcN+SFzDSxQsIBfu84pHx0C
	FsaJY85gWSk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 63CAEA3E65;
	Wed,  2 Dec 2009 12:49:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D124EA3E5B; Wed,  2 Dec 2009
 12:49:09 -0500 (EST)
In-Reply-To: <4B16A410.5090802@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed\, 02 Dec 2009 18\:29\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0146D0DA-DF6B-11DE-8A61-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134361>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Yes.  Anything that sets GIT_EXEC_PATH correctly can use git-foo form.
>
> I know they can. That was in the part you snipped ;)

You asked about the presense of "a policy", and you got an answer.

> The questions is: Should they? Should we avoid mixing both forms in one
> script?

Should we avoid it?  Yes but not very enthusiastically.  We should make
sure that new invocations anybody adds use dashless form, but I would
recommend against a "let's remove use of dashed form" patch _unless_ you
find a time when the project is really quiet and there is nothing else
going on.

The whole point of GIT_EXEC_PATH trick is to allow continued use of the
dashed form, so that we do not have to suffer from code churn and patches
to implement real changes do not have to crash with such clean-ups.

As we'll be changing "git pull", we should use dashless form in the
vicinity of the real change (which is only one line) while at it, like
this.

-- >8 --
From: Horst H. von Brand <vonbrand@inf.utfsm.cl>
Date: Tue, 1 Dec 2009 19:44:11 -0300
Subject: [PATCH] git-pull.sh: Fix call to git-merge for new command format

Now "git merge <msg> HEAD" is officially deprecated, we should
clean our own use as well.

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-pull.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index bfeb4a0..fcf6c81 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -216,7 +216,7 @@ fi
 
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
-	exec git-rebase $diffstat $strategy_args --onto $merge_head \
+	exec git rebase $diffstat $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
-	"$merge_name" HEAD $merge_head $verbosity
+exec git merge $verbosity $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
+	-m "$merge_name" $merge_head
