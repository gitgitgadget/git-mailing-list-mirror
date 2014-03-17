From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] merge: Advise user to use "git merge --abort" to abort merges
Date: Mon, 17 Mar 2014 14:58:41 -0700
Message-ID: <xmqqr460bi7i.fsf@gitster.dls.corp.google.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
	<1394771872-25940-3-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 22:58:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfYX-0002rE-Rl
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbaCQV6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:58:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774AbaCQV6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:58:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C0F976FCF;
	Mon, 17 Mar 2014 17:58:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Ae8BtW1Kw1o9i1lq+Hah/GYwM0=; b=BmGUaG
	lBv1aFVHxdLTFT1LCBLm3nxtz4//vMAGQEdoA1wRWthkuCSVlNDzr0d6jNP1d7YO
	ASlSSPn9Mk9bn8cZcC0vJ60atez3MhBV2Zz561m3amafNvXIR+D3qJ6Rti9TiR3g
	EEx8IAlmgfLbhXz0U29Du+7e9aJIlzBiiM3AM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wGm+ueavR+TC67Av000a4fZpXjbtkA6a
	VJ6CcmijJdZyY94Xc8iWxwm48iNE+tygkTLTtu+2/Devysu343VfNUuUie5ATru/
	3pAg4CNowztyP6qvPt2gOMXqyM76zI3mJrjUH/kRzLcIgdMW61gMFkEtbi3Zqol2
	9iOihB/E0Dg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D3EA76FCE;
	Mon, 17 Mar 2014 17:58:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A92876FCA;
	Mon, 17 Mar 2014 17:58:43 -0400 (EDT)
In-Reply-To: <1394771872-25940-3-git-send-email-andrew.kw.w@gmail.com> (Andrew
	Wong's message of "Fri, 14 Mar 2014 00:37:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4E7A44A4-AE1F-11E3-A1CE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244296>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> Print message during "git merge" and "git status".
>
> Add a new "mergeHints" advice to silence these messages.

This sounds sensible.  Don't we want to have this one take effect on
the places where advice.resolveConflict is used in git-pull?
I.e. something like:

	do_we_advise=no
	if advice.resolveConflict is not set:
		if advice.mergeHints is set to false:
                	do_we_advise=no
		else:
                	do_we_advise=yes
	else:
        	do_we_advise=yes

        if do_we_advise == 'yes':
        	give advice in die_conflict and die_merge
