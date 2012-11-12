From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/4] git-status: show short sequencer state
Date: Mon, 12 Nov 2012 09:45:43 -0800
Message-ID: <7vip9aiuk8.fsf@alter.siamese.dyndns.org>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-4-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Jeff King <peff@peff.net>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:46:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy5B-0006Tn-Hi
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab2KLRps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:45:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929Ab2KLRpq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:45:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DE3B9650;
	Mon, 12 Nov 2012 12:45:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=OVHm+rHcUDLNWtRupkZWW1PKjR4=; b=NgO/mWQAPIpAFBTrMG9E
	eLjULFUURC06q5S51delqqeeB6RvA/GKPNEKobG5RkHIsw8v5HEJY8hDkGABkl5p
	wW2QhQ0w+jVudSvyeeH1s+tNAbFMXnROaVtVSN1QoK9wExl0w4QN1/w0CtU+Swp8
	WWdjVHcaAjmkLHThchWCyq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ToDxuXkjhGp5Ur0c1BJ+C1howaQzmChR+iZC/Ar2l/xjdm
	1gOc+dqTXU0KUAb+C+8pxfdxU/EzHvXNJ4ImYN+K9qgdBNRGrz6eSrB2qiBANvMd
	TnbMI9eyELybtx5JD+EbYuCftnewV8hVd7V/sSlunUQYG1uXCB60FM+m17kuE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE634964E;
	Mon, 12 Nov 2012 12:45:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63A36964B; Mon, 12 Nov 2012
 12:45:45 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C93CBB74-2CF0-11E2-9CF4-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209503>

Phil Hord <hordp@cisco.com> writes:

> State token strings which may be emitted and their meanings:
>     merge              a merge is in progress
>     am                 an am is in progress
>     am-is-empty        the am patch is empty
>     rebase             a rebase is in progress
>     rebase-interactive an interactive rebase is in progress
>     cherry-pick        a cherry-pick is in progress
>     bisect             a bisect is in progress
>     conflicted         there are unresolved conflicts
>     commit-pending     a commit operation is waiting to be completed
>     splitting          interactive rebase, commit is being split
>
> I also considered adding these tokens, but I decided it was not
> appropriate since these changes are not sequencer-related.  But
> it is possible I am being too short-sighted or have chosen the
> switch name poorly.
>     changed-index  Changes exist in the index
>     changed-files  Changes exist in the working directory
>     untracked      New files exist in the working directory

I tend to agree; unlike all the normal output from "status -s" that
are per-file, the above are the overall states of the working tree.

It is just that most of the "overall states" look as if they are
dominated by "sequencer states", but that is only because you chose
to call states related to things like "am" and "bisect" that are not
sequencer states as such.

It probably should be called the tree state, working tree state, or
somesuch.
