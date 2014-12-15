From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remote helper example with push/fetch capabilities
Date: Mon, 15 Dec 2014 13:47:20 -0800
Message-ID: <xmqqegs0d1qv.fsf@gitster.dls.corp.google.com>
References: <CAPCWLt6kxoJJSWAcyH_kW071Md0vc4zeo41hCKBQHd-_pvUMXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Klein W <wineklein@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 22:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0dUF-0004Ln-HF
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 22:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbaLOVrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 16:47:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750772AbaLOVrX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 16:47:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A47BD27D41;
	Mon, 15 Dec 2014 16:47:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l+MBrWOX1XkKSQFTec6yRaOJu6A=; b=LXu0Pg
	72hcslPZquU7Mtuv4CyusyEKeCfnpuO4GMqCOKeubdw6qbw/y2/BvNO4AWSLjr0N
	xSmvDSVFHaANJgL97NBjJD9sJziYHgQAYvDnrf1EbaUGlNM8FEUaaxJPnYk1a6y4
	aegTT3nVtmwA3n27tKMYA/hHkMU3m3GDs9yS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hkgZQ8UV+bZY5o6C/uOR1SgEBuxiZTes
	wPXb3QFue67FmumkWsh5bhNPDzit7Ja1aiDiLAkib6KxFwXby3F9RyZNGgp60jlR
	0xjexDRfIRs/Zg4zl4kanMPeD5aA2CqrkX3EUahdU0/s1sA3zEsFueqN2yqk7U7B
	H2BjHuqX5uc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98F1E27D40;
	Mon, 15 Dec 2014 16:47:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17C5827D3C;
	Mon, 15 Dec 2014 16:47:22 -0500 (EST)
In-Reply-To: <CAPCWLt6kxoJJSWAcyH_kW071Md0vc4zeo41hCKBQHd-_pvUMXQ@mail.gmail.com>
	(Klein W.'s message of "Mon, 15 Dec 2014 15:17:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F31B20A4-84A3-11E4-8D4C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261427>

Klein W <wineklein@gmail.com> writes:

> Is there any example of a remote helper [0] with push and fetch capabilities?
>
> The git-remote-testgit.sh example [1] only has import/export capabilities.
>
> Also, what are the advantages and disadvantages of a remote helper
> with push/fetch capabilities vs a remote helper with import/export
> capabilities?

A helper with push/fetch capabilities is responsible for (and more
importantly, "in control of") packdata creation, while helpers that
use import/export interface rely on fast-import, which is quite dumb
when it comes to storage efficiency of the resulting repository.
The former might be more preferrable from the efficiency point of
view.

BUT.

Unless your foreign SCM is Git itself, however, it is not practical
to write your own pack data generator correctly and efficiently to
support push/fetch capabilities anyway, so the choice is often made
not because of "advantages vs disadvantages" but because of what you
can write in practice.
