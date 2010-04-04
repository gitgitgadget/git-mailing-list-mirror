From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT_ONE_FILESYSTEM: flip the default to stop at
 filesystem boundaries
Date: Sun, 04 Apr 2010 15:39:58 -0700
Message-ID: <7vvdc6yh8h.fsf@alter.siamese.dyndns.org>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
 <1268855753-25840-4-git-send-email-lars@pixar.com>
 <20100328092253.GA17563@coredump.intra.peff.net>
 <7vr5n44crq.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
 <20100330230211.GC608@coredump.intra.peff.net>
 <alpine.LFD.2.00.1003301610151.3707@i5.linux-foundation.org>
 <40aa078e1003301754u3a1e5e9je7bb2aa2dc04f6a1@mail.gmail.com>
 <7v4ojr85ee.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org
To: "Lars R. Damerow" <lars@pixar.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 00:40:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyYUM-0005ve-Bj
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 00:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341Ab0DDWkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 18:40:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0DDWkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 18:40:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23F89A8B98;
	Sun,  4 Apr 2010 18:40:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+tCz7B82Z7NhiIzcXp3bc0ahB9k=; b=JROq1P
	Fw0dvozWjoEho9dPClgWiPVZGXajX/3qTa+SgSkS4BkzR5l6dq52Y/ZFivMI0+b6
	wcx1fZF05t77Ti2M2L+88drJAucgxb2H7tGScSPU/NWvHfrGP/0gnDCjLFxgsf5J
	YyV0x3SlQkllR1yGtSTCLE3s5Dj3DJXhXzur4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wktDRi7gKmealmzOGzuGUuP+p19HyOXu
	Kyfbwy0uw+9PFiEeQ7H4fDknVtqtolC766LUm9DsnKf7E/oa7aGdKso0S2HEiPKp
	mVqQSy5bOKjrpKG2FH0vPQ3AmL3S4DQq8lZkW3XhAhcW+M3jXR3PjeC9m2aK4u4M
	T6EdtRJMJcQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C6DFFA8B94;
	Sun,  4 Apr 2010 18:40:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE8BEA8B92; Sun,  4 Apr
 2010 18:39:59 -0400 (EDT)
In-Reply-To: <7v4ojr85ee.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 04 Apr 2010 11\:00\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03F23762-403B-11DF-98E3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143959>

Junio C Hamano <gitster@pobox.com> writes:

>    I wonder if "git add" and friends should also notice it and warn.  If
>    you have more than one values of ce->ce_dev in the index, it means that
>    the working tree spans more than one filesystem and from a subdirectory
>    with an entry that has a ce->ce_dev different from the value for a path
>    at the top of the work tree, you will not be able to discover the top
>    of the tree without GIT_ONE_FILESYSTEM set to true.  A likely scenario
>    for this to happen would be:
>
>     (1) You have a tarball of some sort; you extract it $there;
>
> 	$ mkdir $there && cd $there
>         $ tar xf /var/tmp/tarball.tar
>
>     (2) You notice the filesystem lacks enough free space, and move some
>         part (say "images/") to a separate filesystem, and bind-mount;
>
>         $ mv images $another/. && rm -fr images && mkdir images
>         $ mount --bind $another/images images
>
>     (3) You add everything to start the project;
>
>         $ git init && git add .
>
>         Up to this point it would work (you are at the top of the working
>         tree).  And this is the point we _could_ notice and warn that you
>         will have trouble in step (4).
>
>     (4) Go down to a subdirectory and start futzing;
>
> 	$ cd images && gimp naughty.jpg && git add -u

And this adds such a check.

 read-cache.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f1f789b..486bb2a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1550,6 +1550,7 @@ int write_index(struct index_state *istate, int newfd)
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
 	struct stat st;
+	int more_than_one_dev;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -1572,6 +1573,7 @@ int write_index(struct index_state *istate, int newfd)
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
+	more_than_one_dev = 0;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
 		if (ce->ce_flags & CE_REMOVE)
@@ -1580,8 +1582,15 @@ int write_index(struct index_state *istate, int newfd)
 			ce_smudge_racily_clean_entry(ce);
 		if (ce_write_entry(&c, newfd, ce) < 0)
 			return -1;
+		if (i && ce->ce_dev != cache[0]->ce_dev)
+			more_than_one_dev = 1;
 	}
 
+	if (more_than_one_dev &&
+	    !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0))
+		warning("working tree spans across filesystems but "
+			"GIT_DISCOVERY_ACROSS_FILESYSTEM is not set.");
+
 	/* Write extension data here */
 	if (istate->cache_tree) {
 		struct strbuf sb = STRBUF_INIT;
