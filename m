From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Sun, 25 Jan 2015 21:39:25 -0800
Message-ID: <xmqqtwzem776.fsf@gitster.dls.corp.google.com>
References: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
	<CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>
	<xmqqegqlnelu.fsf@gitster.dls.corp.google.com>
	<CAGXKyzEPWrbRFOhvCBm=2Z50zso85G50z-nLd_wyzyeEADQSmw@mail.gmail.com>
	<xmqqa916nq4p.fsf@gitster.dls.corp.google.com>
	<CAGXKyzEYVsz-nRs52pTKo+6JLBiO9daU_C3qev3H43=Vzuygiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Craig Silverstein <csilvers@khanacademy.org>
X-From: git-owner@vger.kernel.org Mon Jan 26 06:39:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFcOh-0007uv-4Y
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 06:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbbAZFj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 00:39:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750830AbbAZFj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 00:39:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC8C633675;
	Mon, 26 Jan 2015 00:39:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6jtdVHOeHY1epMAmcQZiOFH6vjc=; b=R4Xqqj
	x6PwlC7W5zCqhEIuUPDUiItL9yMM2pCAsLVw3jn5t5ZJ5EB+iJmF94qt6in1E6hp
	V+BAIWlrWgLT8Hc95Re5zzDHvCaFw/upQ0Ys/lDnFUWzBTeHWCpmkcV7GZS1qeJM
	z43D+WWkDX0iS181kUDms2alU8sCtRLWrE/Hs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oME4xtrXlDE4e+UmFgTKQVPgusHPFJMU
	ed2+oo+drxhFMCYDV5wpUMqmX2pAcWAvxYFpRZbhWIbv5doKBfKYojPfLX9GTEyf
	lB2jkXIApBrPs6zpf19Q4ZLP72Fclf5S/i3B1Y7uC1r2mjhMr67CCpoiNL/WYnS6
	94ri4f5crDs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E30AA33674;
	Mon, 26 Jan 2015 00:39:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 656E133673;
	Mon, 26 Jan 2015 00:39:26 -0500 (EST)
In-Reply-To: <CAGXKyzEYVsz-nRs52pTKo+6JLBiO9daU_C3qev3H43=Vzuygiw@mail.gmail.com>
	(Craig Silverstein's message of "Sun, 25 Jan 2015 20:57:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B0B0636A-A51D-11E4-BFFB-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263027>

Craig Silverstein <csilvers@khanacademy.org> writes:

> This patch, in adding submodule support, I expect would be
> similarly useful to people even though it, also, imposes those
> same constraints to the submodule's config files.

I would expect that you would see exactly the same issue with Duy's
multiple work tree series.  This is not limited to new-workdir.

The right way to look at this is to fix what "git submodule" does;
its use of "config" that is shared across branches is the root cause
of the trouble.  No other part of Git keeps data that needs to be
per-branch (or more specifically "tied to the working tree state")
in .git/config in such a way that leaving it stale when the working
tree state changes breaks the system.

One way to do so might be to move the bits it stores in the config
file to somewhere else that is more closely tied to the checkout
state and handle that similar to .git/index and .git/HEAD when it
comes to multiple work-trees.
