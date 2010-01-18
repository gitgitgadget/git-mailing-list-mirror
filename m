From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Allow empty commits during rebase -i
Date: Sun, 17 Jan 2010 17:29:29 -0800
Message-ID: <7vljfww686.fsf@alter.siamese.dyndns.org>
References: <4B53B561.0@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 02:29:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWgRD-00063r-M3
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 02:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab0ARB3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 20:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879Ab0ARB3j
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 20:29:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab0ARB3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 20:29:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B752D925EA;
	Sun, 17 Jan 2010 20:29:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TovtPHd/GDT7YtAF0q9j1qq4Ivg=; b=AdWum+
	4i81kZcdrhkzdNpTBtT+paJfGxXYcbwDq9JrNZNTXzGI/mSxvntX7c6XZ0bsnsmz
	DMhlUsmImYaLd7Nhja7lsPbyhEMZeBC4sodEsfNcnNX/GI+YKt3R24X3dJuYeXJj
	PI2ui7xaYVe8rkRxVqDfZKKx4vMRtRzzgJtXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GhWMmYYb8LWA2Fs+F2HIXXUmvPGGqPME
	2Qhc62dSW3X5wHZZrI5uK4GeYGxsgFm+ARXi2m84ja/MKarwwR3fLe/77AeVjOgG
	T+qk0rvWvGM3teGEHe5pER+UMdZb1LD4RNMxAVu5lr6TrgBRWfmkx0Iz+yMyVmO5
	4UEqCURtJW0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81457925E9;
	Sun, 17 Jan 2010 20:29:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB18C925E8; Sun, 17 Jan
 2010 20:29:30 -0500 (EST)
In-Reply-To: <4B53B561.0@pcharlan.com> (Pete Harlan's message of "Sun\, 17
 Jan 2010 17\:12\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF29E15A-03D0-11DF-A7C0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137354>

Pete Harlan <pgit@pcharlan.com> writes:

> I imagine an ideal version of this fix would make it so the use case I
> presented here would work, but rebase -i would still prevent
> introducing a new empty commit, or at least warn when it was
> introducing one.  In the absence of that ideal fix, I think this
> behavior is better than failing to handle this case.

Sorry, I actually tend to think that in the absense of that fix, your
version introduces risky behaviour that only a corner-case use case
benefits, and pros-and-cons doesn't look attractive enough.

Why not do something like:

    pick X a crap tree with a good message
    pick Y revert X
    pick Z a good tree with a crap message

-->

    # drop X
    # drop Y
    edit Z

and then run "git commit --amend -C X" when it is Z's turn to be
processed?
