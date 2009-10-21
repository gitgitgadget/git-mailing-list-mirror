From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-merge: imply --no-ff when --no-commit is given
Date: Wed, 21 Oct 2009 14:46:50 -0700
Message-ID: <7viqe81ktx.fsf_-_@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021030608.GA18997@atjola.homenet>
 <7vk4ypb71j.fsf@alter.siamese.dyndns.org> <20091021172123.GB27495@localhost>
 <7v3a5c2zrr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 23:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0j1X-0003v4-Ci
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 23:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbZJUVrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 17:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755637AbZJUVrA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 17:47:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625AbZJUVq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 17:46:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8C67612C5;
	Wed, 21 Oct 2009 17:47:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HYdx1iHFu8gBMXvg8iEGHWUlrOg=; b=u5jnua
	fOKtI9+UO7jMaIQXnvA1TWbYjHFfufOc22HtT6t9h6xfWQ1+KBKfs2dMK+dLganc
	asbIHKDG4zU9W3kMx3Af1BQQvpn9fNtCtzXoPzdr171d6/6epFQLWEmOHpPskk50
	pHmv3QHP7+IiMjFsjYkHhp/IpiCzZxPbEKmsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNhFvTPsb7Rbkbx4q/vhm7rfGAUZolsL
	mWOKFNzb2Uqt2zlF1JQahMSR6uY0917QEHoVYuQtbxI9AoUJIxOtoOIhnbVW2xpm
	AfvrfooCQUaS/OKzM3fA4dJRisjKuYa6wyhUAlUs5OUnDt3DfHoGKZEr7K0ZkI2h
	1gmSx/6fMh0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F26F612C2;
	Wed, 21 Oct 2009 17:46:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C5BF612C1; Wed, 21 Oct
 2009 17:46:51 -0400 (EDT)
In-Reply-To: <7v3a5c2zrr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 21 Oct 2009 14\:38\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 415FBB7E-BE8B-11DE-BE19-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130974>

Traditionally "git merge --no-commit" meant just that: do not create a new
commit even when a merge succeeds.  But this leads to confusion when the
merged commit is a descendant of the current commit, in which case we
succeed the merge by fast-forwarding and without creating a new commit.

Make --no-commit imply --no-ff; --no-commit is a request by the user to
tweak the resulting merge and it is clear indication that the user wants
to have a merge, even if it is an extra one, to futz with.

There is a test that relies on --no-commit silently fast forwarding; that
is obviously broken by this change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is another possibility, which I think is worse than the other one
   in practice but the justification sounds more respectable.

   Unlike the other one, this will still make --no-commit a no-op when you
   are already up-to-date.  As I do not think --no-ff makes much sense in
   my own workflow (either here or dayjob) it is not exactly my itch, but
   I suspect that people who wanted to have --no-ff may want to create an
   extra commit even in such a case; it may be a bug to allow up-to-date
   when --no-ff is given.  Yes, it would make the --no-ff even more insane
   than it already is, but I suspect it would be more consistent with the
   original reasoning of wanting to have the option in the first place,
   namely, to leave the trace of the fact that a "merge" was done at that
   point in the history.

 builtin-merge.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index b6b8428..fa86799 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -874,6 +874,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		option_commit = 0;
 	}
 
+	if (!option_commit)
+		allow_fast_forward = 0;
+
 	if (!argc)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
-- 
1.6.5.1.107.gba912
