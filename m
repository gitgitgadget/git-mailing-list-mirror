From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/21] bisect: make total number of commits global
Date: Fri, 15 Apr 2016 17:44:44 -0700
Message-ID: <xmqqh9f2756r.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-17-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:44:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arEM0-0001gY-6B
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbcDPAos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 20:44:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751335AbcDPAor (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:44:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 196F11371A;
	Fri, 15 Apr 2016 20:44:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dCiAwwcqqIScHzsPpY/zqpoZNgI=; b=Nd0yzs
	ytpt2JjLwm/Je/sCz2vNDJJMQmYeljiYH1+Me5xCojjrainm72irwZ16jmWDR0lD
	kod39WxaQB3EE6SR7s24NPx5OfVGFEDmRobpcMkuY2hIsSFOFBZHMgUoIKkr61Sx
	rt5awwo9uTMOATHLo04bkbp9dO1jYJFx7T6Vw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zf/z0JVPUNCcyzeE39mR2RRmwZIGiWSm
	f+sJxMJD7blB2nDon9PHTB3LmPG/pDGjyP9ZcYueWstI8AxJTy5GisYNYZDZPb1T
	p03IGVBX3jBrUv8V/b/07nu3roiBA7+0zOMTkT2p5i/u3WbWXAv1Kg2Dj8YK61kX
	zUe5t8rLNX4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1192113718;
	Fri, 15 Apr 2016 20:44:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 763FD13717;
	Fri, 15 Apr 2016 20:44:45 -0400 (EDT)
In-Reply-To: <1460294354-7031-17-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A3A99EC-036C-11E6-8F2C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291707>

Stephan Beyer <s-beyer@gmx.net> writes:

> The total number of commits in a bisect process is a property of
> the bisect process. Making this property global helps to make the code
> clearer.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---

After wondring about count++ vs nr, I re-read this one.

This patch is mislabled.

Making it global is a lessor, supposed-to-be-no-op change, but the
bigger change is that the definition of "total" is silently changed.

The definition of mid-point was based on 'nr' in the original code,
which counted only the tree-changing commits, and with this patch,
it is based on 'total', which now only counts the tree-changing
commits, so things are internally consistent, and the loop I was
puzzled with, "while (counted < total)", would properly terminate.

Perhaps things become cleaner and easier to understand if this was
split into two steps.  One that changes the meaning of 'total' (and
removes 'nr'), and the other that makes 'total' a global.

Thanks.
