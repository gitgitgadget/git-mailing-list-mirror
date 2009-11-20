From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Fri, 20 Nov 2009 03:02:44 -0800
Message-ID: <7veintzcff.fsf@alter.siamese.dyndns.org>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
 <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
 <20091120192800.6117@nanako3.lavabit.com>
 <7vk4xl1nkl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBRGY-0000dQ-IN
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 12:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbZKTLCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 06:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbZKTLCu
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 06:02:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbZKTLCu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 06:02:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F7539FB46;
	Fri, 20 Nov 2009 06:02:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+hkQJJwd6Z1/XibYeiT2eJM/064=; b=ce/0Ge
	cnBUNw9O/9uWNllCMVgwXXqcD5EJRMYB1lXvKogusLwub7ZztsQS7G3Rok3qjhV0
	da1OMPvZv5uaMDfY9LrJmm9urEExcyKSdsEY3eo0c0Ph+NJ+3WlfJlJiGWgRtUYB
	y4ebEokn4bxoJTiMShsQThzp359DwsIeNt4GA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=leXNlbEIpkkphEFGDs6nm3h5X5MpiJH+
	wC7f/C3a6L1mmz5YOzicD/Em/nBWnez3IBawdtjo1cYoAqbrRd1Pv1RozfPgPRBW
	ekHrJJo3g+hTvAtC3ySGVrq5ttJvlOQRMtTib0BKpEo3tpsE6PNw8gh/NOcq4qbH
	bD9eVsm+9uU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 125FA9FB45;
	Fri, 20 Nov 2009 06:02:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7F43F9FB44; Fri, 20 Nov 2009
 06:02:46 -0500 (EST)
In-Reply-To: <7vk4xl1nkl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 20 Nov 2009 02\:46\:02 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F51E8F2-D5C4-11DE-8971-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133332>

By the way, we could probably use this to make the command sequence even
shorter.

I have to warn that this has never been used in real life, unlike the
"checkout A...B" one --- caveat emptor.

Also I didn't bother touching up "rebase -i"; it is left as an excercise
to the readers ;-)

-- >8 --
Subject: [PATCH] "rebase --onto A...B" replays history on the merge base between A and B

This is in spirit similar to "checkout A...B".  To re-queue a new set of
patches for a series that the original author prepared to apply on 'next'
on the same base as before, you would do something like this:

    $ git checkout next^0
    $ git am -s rerolled-series.mbox
    $ git rebase --onto next...jh/notes next

The first two commands recreates commits to be rebased as the original
author intended (i.e. applies directly on top of 'next'), and the rebase
command replays that history on top of the same commit the series being
replaced was built on (which is typically much older than the tip of
'next').

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase.sh |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6830e16..570e2b6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -34,6 +34,8 @@ set_reflog_action rebase
 require_work_tree
 cd_to_toplevel
 
+LF='
+'
 OK_TO_SKIP_PRE_REBASE=
 RESOLVEMSG="
 When you have resolved this problem run \"git rebase --continue\".
@@ -417,7 +419,22 @@ fi
 
 # Make sure the branch to rebase onto is valid.
 onto_name=${newbase-"$upstream_name"}
-onto=$(git rev-parse --verify "${onto_name}^0") || exit
+if	left=$(expr "$onto_name" : '\(.*\)\.\.\.') &&
+	right=$(expr "$onto_name" : '\.\.\.\(.*\)$') &&
+	: ${left:=HEAD} ${right:=HEAD} &&
+	onto=$(git merge-base "$left" "$right")
+then
+	case "$onto" in
+	?*"$LF"?*)
+		die "$onto_name: there are more than one merge bases"
+		;;
+	'')
+		die "$onto_name: there is no merge base"
+		;;
+	esac
+else
+	onto=$(git rev-parse --verify "${onto_name}^0") || exit
+fi
 
 # If a hook exists, give it a chance to interrupt
 run_pre_rebase_hook "$upstream_arg" "$@"
-- 
1.6.5.3.342.g14bb9
