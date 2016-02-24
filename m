From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git config: do not create .git/ if it does not exist yet
Date: Wed, 24 Feb 2016 10:45:40 -0800
Message-ID: <xmqqio1et0a3.fsf@gitster.mtv.corp.google.com>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
	<20160224082657.GD12511@sigill.intra.peff.net>
	<20160224101403.GN1766@serenity.lan>
	<20160224103152.GA21448@sigill.intra.peff.net>
	<alpine.DEB.2.20.1602241230120.3152@virtualbox>
	<alpine.DEB.2.20.1602241309560.3152@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <blees@dcon.de>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 19:45:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYeRX-0007kJ-MD
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 19:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058AbcBXSpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 13:45:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752085AbcBXSpn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 13:45:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BDE245F23;
	Wed, 24 Feb 2016 13:45:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CM+iuou/8VaMXcfnvpie66rrnio=; b=lltGnW
	baBKTEvUbpHz0pnG6vgpnTKEJ+ZCr/nu+ayoJNxAL9LppAekco5+l+eb4xijYfxi
	G0faWONBgawh7tQUvQXo+cOK94z5QIg/GUeYJz5QZfTInicIEPJAm/iJhSc2wTdh
	3vSAbKJyMgNPNWh7h/0miFGZjvrX48nMneAAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ioc69XmHsG2OPfSFmZDPuXdvp1NqFTMM
	yhJbz4UrT1WJMY5x/kEh8cVEpv5wpV/9Fd5n7Th8KMzW41J/lC91t7nm4pRJ8x2f
	lN71XqdehkF3Dl3L68aMQMKz4T08qVC6sLh5vBXKN4Mh4OiK/gsV9UX9r2/ZUc4Q
	aRo0qtaVQMw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9351F45F22;
	Wed, 24 Feb 2016 13:45:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CC5D045F21;
	Wed, 24 Feb 2016 13:45:41 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1602241309560.3152@virtualbox> (Johannes
	Schindelin's message of "Wed, 24 Feb 2016 13:13:39 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CE3077FA-DB26-11E5-ACD5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287216>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 24 Feb 2016, Johannes Schindelin wrote:
>
>> I created a test and essentially duplicated Peff's finding: this is a
>> Windows-only issue.
>
> Indeed it is in our patches:
>
> 	https://github.com/git-for-windows/git/commit/3a4c37b22
>
> (short version: we carry some patches that simplify locking the config
> file before building on top of it, and somehow we agreed back in the days
> when this patch was written that it would be a good idea if that code
> created leading directories.)

The log message there says this:

    This is particularly important when calling

         git config -f /non/existing/directory/config ...

I think that the change should be ejected.

	cat >/non/existing/directory/file
	mkdir /non/existing/directory/dir

would fail, and I do not see any valid reason for "git config" to be
different.

> I will fix this issue in Git for Windows, but I still think that my patch
> brings a usability improvement: the error message is just so much more to
> the point (will submit v2 in a moment).

Thanks.  I think your patch in this thread is an improvement.
