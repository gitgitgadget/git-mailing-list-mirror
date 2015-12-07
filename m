From: Junio C Hamano <gitster@pobox.com>
Subject: Re: best practices against long git rebase times?
Date: Mon, 07 Dec 2015 14:56:33 -0800
Message-ID: <xmqqmvtllvfi.fsf@gitster.mtv.corp.google.com>
References: <20151204150546.GA17210@inner.h.apk.li>
	<20151204153103.GP18913@serenity.lan>
	<20151206164345.GH22288@inner.h.apk.li>
	<20151207210212.GF30203@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 23:56:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a64i0-0003uM-NQ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 23:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637AbbLGW4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 17:56:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756204AbbLGW4f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 17:56:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C317E32380;
	Mon,  7 Dec 2015 17:56:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=14QY3Eu65gQqGGn/SisWNhSilEw=; b=tYQrxq
	20pyZ3e2GP57N5pXrofT5ukpaiuftPJUj9F0N3B0rEB+86L/x6Sz7Z09A8PopLGm
	wL1S0GJ+I5dnVW34Icu83VnCz78390eT/wOfc8PZ0Z8DcrR9mFwpM2REA9Du+zau
	aPfUBBW+35xPOEio5UD9RtHgNtc6O++rEvWT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=APiAP6tmMalFSiE4LKm5lAQnCUaz4pTD
	6L9cZVUoZzbbbGhONNMs3oX79ZiRqV/C9RgN+YPU10gvJCz0wpemR9NCKcfJ5Mm1
	Lw4N1PxKuX+AZIju6eTeuE9hReogblMxVHcVPFgHi7HSHlyotrCOHXc8vTGU0E63
	zhEZ4kLf31Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA8223237F;
	Mon,  7 Dec 2015 17:56:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 419973237D;
	Mon,  7 Dec 2015 17:56:34 -0500 (EST)
In-Reply-To: <20151207210212.GF30203@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 7 Dec 2015 16:02:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3769BDE-9D35-11E5-B7A8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282138>

Jeff King <peff@peff.net> writes:

> You're computing the patch against the parent for each of those 3000
> commits (to get a hash of it to compare against the single hash on the
> other side). Twelve minutes sounds long, but if you have a really
> gigantic tree, it might not be unreasonable.
>
> You can also try compiling with "make XDL_FAST_HASH=" (i.e., setting
> that option to the empty string). Last year I found there were some
> pretty suboptimal corner cases, and you may be hitting one (we should
> probably turn that option off by default; I got stuck on trying to find
> a hash that would perform faster and never followed up[1].
>
> I doubt that is your problem, but it's possible).
>
> -Peff
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/261638

I vaguely recall having discussed caching the patch-ids somewhere so
that this does not have to be done every time.  Would such an
extension help here, I wonder?
