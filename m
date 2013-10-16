From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: allow branch info color customization
Date: Wed, 16 Oct 2013 14:39:59 -0700
Message-ID: <xmqqzjq851zk.fsf@gitster.dls.corp.google.com>
References: <1381911773-9564-1-git-send-email-1zeeky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYpX-0000QY-VT
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760266Ab3JPVkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:40:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758644Ab3JPVkC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:40:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F7174BF88;
	Wed, 16 Oct 2013 21:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eSybOBFk0rkKTbHICCMrO1J+Xg8=; b=G0gbnxR6SJVj0ixyP+Ab
	eU8/nYsANZMb7GL9/Ak/uBNRLQgsGA3RaBpwfNPKyuvQ7ySXpfS698T0ujAyskJm
	WhmyfwNM4Itaupl+meljSuZjPHJ1lkR/JR4d0dCScIgEoblzsEVHyFwhg1+/lEPb
	76pLiA3DahUtJ+7JopkoIhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=WTNZVHbjRC0JNN7E1p5wTVFprdt4pzcYnjXOsbj4w6vSnH
	PKwXXkwuwpnHSQ1X/bcgEzfSSVVWkUybSoku+rCRG2zAlT7CNrzG/FQsSnpPwlJ0
	oLNqTHptkKgRTcGtoqqgFYvPEB6UjoPUL7ZWIVC9cf8hqgZLXfP3I3fzdHc+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CC6E4BF87;
	Wed, 16 Oct 2013 21:40:02 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FE8C4BF79;
	Wed, 16 Oct 2013 21:40:01 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 82C83C2A-36AB-11E3-9389-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236270>

Alexander 'z33ky' Hirsch <1zeeky@gmail.com> writes:

> From: Alexander Hirsch <1zeeky@gmail.com>
>
> git status -bs (--branch --short) does not seem to allow customization of the
> colors for the local and remote branch.

wt-status can use the following colors:

    WT_STATUS_CHANGED
    WT_STATUS_HEADER
  - WT_STATUS_LOCAL_BRANCH
    WT_STATUS_NOBRANCH
    WT_STATUS_ONBRANCH
  - WT_STATUS_REMOTE_BRANCH
    WT_STATUS_UNMERGED
    WT_STATUS_UNTRACKED
    WT_STATUS_UPDATED

but parse_status_slot() lets you set only these

    WT_STATUS_CHANGED
    WT_STATUS_HEADER
    WT_STATUS_NOBRANCH
    WT_STATUS_ONBRANCH
    WT_STATUS_UNMERGED
    WT_STATUS_UNTRACKED
    WT_STATUS_UPDATED

and this patch makes the configuration mechanism cover all of the
slots by adding parsing code for the missing two.

While I think the intent of the patch makes sense, I have to wonder
if "local" and "remote" without having the "branch" anywhere is
painting us into an unpleasant corner we cannot later get out
of. For example, we might want to show the remote-tracking branch
information (that is where REMOTE_BRANCH color matters in the
current code) in a more detailed way later, which may include where
the source repository resides, either locally on the same host or
remotely over the network, and WT_STATUS_{LOCAL,REMOTE}_REPOSITORY
may be the natural names for the colors to paint the repository
paths/URL in.
