From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clearly specify what refs are honored by
 core.logAllRefUpdates
Date: Mon, 11 Jul 2011 10:29:15 -0700
Message-ID: <7v7h7og1zo.fsf@alter.siamese.dyndns.org>
References: <c63583df97ff8dd596d16d4471041d6ebedb67e8.1310375571.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 19:29:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgKIN-0000Pi-LD
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 19:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248Ab1GKR3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 13:29:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758235Ab1GKR3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 13:29:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51D096C26;
	Mon, 11 Jul 2011 13:29:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oYD/t7/0BUC6yV26UlCa6stXPGY=; b=X5R3YS
	xBaSGb1jr4iZq9unHmlN3j8PbJdtEcgEoBGzWVmV0JFMW6k+lJ+rr9k+stG4ERYw
	cEkKiMbWh+Iudt9KOAF5ylIXGEGkxFw5AlU6sSRWbHjWKRu4HP20qZSEalYarH+6
	C/YuzhXjKJ+yD6T9r8s6ucQIwTwsC3oIzFyQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w+uwusnPr1Vdxw5h7bLPCY9Pfx+XBo/q
	mBHiJSC+EXWOX30VuN3DhMpbahavrp1eU2y3qPxpgkDaEtIr1aKN8dgRkXquwNfd
	PBb/1JzQ/BgMHjgCC1VkR7xIPEka+LOXudtOuSsyYMiqEwrRgAZk6Xpb1MI3vXcW
	RVMxeFoysOM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A6856C25;
	Mon, 11 Jul 2011 13:29:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 94BC56C22; Mon, 11 Jul 2011
 13:29:16 -0400 (EDT)
In-Reply-To: <c63583df97ff8dd596d16d4471041d6ebedb67e8.1310375571.git.bert.wesarg@googlemail.com> (Bert Wesarg's message of "Mon, 11 Jul 2011 11:14:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D6F3E7A-ABE3-11E0-AEF4-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176877>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> The documentation for logging updates in git-update-ref, doesn't make it
> clear that only a specific subset of refs are honored by this variable.

Thanks.

> The initial justification in 4057deb (Junio C Hamano, 2006-10-08), leaves
> the impression, that a blacklist would have made more sense,...

I didn't mean it that way, and I still don't think blacklisting is
feasible nor necessarily desirable. Different porcelains can use
namespaces under refs/ for their own purposes, and it would be more
prudent not to create reflog files that can grow long and not useful
given that we cannot predict/guess what they are used for and how, so
I would prefer white-listing the ones that are known to be useful.

It might make sense to allow customizing the white-list via the
configuration mechanism, though. When your favorite third-party git
"frotz" add-on uses refs/frotz/ hierarchy for its own purpose, and if
viewing "git log -g frotz/master@{now}" is useful, you may want to be able
to say "In addition to the standard ones, please log refs/frotz/*
automatically". Of the top of my head, something like:

	[core]
		autoRefLog = refs/heads/*
		autoRefLog = refs/remotes/*
		autoRefLog = refs/notes/*

or less expressive but even simpler and probably sufficient:

	[core]
        	autoRefLog = heads remotes notes

can be the spelled-out form of traditional "core.logAllRefUpdates", and
you may be able to tweak it like:


	[core]
        	autoRefLog = heads remotes notes frotz
