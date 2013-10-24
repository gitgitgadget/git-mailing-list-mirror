From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: use reflog to find common base with upstream
Date: Thu, 24 Oct 2013 12:04:24 -0700
Message-ID: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
References: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
	<CANiSa6gqGKAyLwwPVoZ_gzN85_06aTCfkdRRscNNZYs7g1rL0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 21:04:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZQCu-0005si-JB
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 21:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093Ab3JXTE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 15:04:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069Ab3JXTE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 15:04:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE7254B907;
	Thu, 24 Oct 2013 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=GsSB/HIRnlkvIfUQKFf5IM1wy+Q=; b=e0ykIzZBIFnac7C1AEAr
	d2v1TeCeKDm9nL5137WlAfRLDKdml3cdsnImSoIOee21DlgmsUmPlngUfbIQQJMD
	w14Re/fK6OQUGVrHw9GH9wHBxlATEaQ/3DmWFK1yVRhlP8Z33JkPHKP58I+MrWfz
	U84iLg9ok6yueA2wilAEQMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=uFrV3zuW+g+bFjr83sveRK4wJIuplmYZasZJ3Zg8RZGUAk
	JW9QzzokTsxFFoll2f5E83Q/qMZXbWkcVt+VIiao8Tn/0L4EECy8HNuCY4kvxbSJ
	jovTMLLN9Zn9BPl3I13xXp4Flgd1sqWolBScNbZguHakFK0yOgmLt6GUajqZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF1094B906;
	Thu, 24 Oct 2013 19:04:26 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A00A4B900;
	Thu, 24 Oct 2013 19:04:26 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 19FBFFB2-3CDF-11E3-AECC-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236608>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> I think
>
>   git merge-base HEAD $(git rev-list -g "$upstream_name")
>
> is roughly correct and hopefully fast enough. That can lead to too
> long a command line, so I was planning on teaching merge-base a
> --stdin option, but never got around to it.

Sorry for coming in late.

I think the above with s/HEAD/$curr_branch/ is a good way to compute
what the whole "for reflog in $(git rev-list -g $remoteref" loop
computes when one of the historic tips recorded in the reflog was
where $curr_branch forked from, i.e. the loop actually finds at
least one ancestor in the reflog and breaks out after setting
oldremoteref.  But it would give a completely different commit if
none of the reflog entries is a fork point.

A two patch series forthcoming.
