From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] use setup_git_directory() in test-* programs
Date: Sun, 06 Mar 2016 17:28:03 -0800
Message-ID: <xmqqoaarrs9o.fsf@gitster.mtv.corp.google.com>
References: <20160305220829.GA31316@sigill.intra.peff.net>
	<20160305221650.GF31508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 07 02:28:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acjyR-00085N-42
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 02:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbcCGB2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 20:28:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751236AbcCGB2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 20:28:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06A4E4A68A;
	Sun,  6 Mar 2016 20:28:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PhgPLer9+AcLJdnWHBDsBe6hPPM=; b=tZCkVC
	0Ozl9X/W/8EKHh9c8/x4/qIbzv6yR26AdZbEVT+TOSug1ihSpPbVe2lc1ydeyWIe
	bC+Eb7qS6+ch7/MfPXo5QnguwK8BLQQglB3pJSZT9xxHZGJBFS49a1aILE1bF5OZ
	BAJiVxs5nWMPDYQxiOLdQi9PGXFoPJDR7Mchc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jH1T4PuEpy+uaSW9a+eKM5TlQrcOu6xt
	WRv1S2ypN/gfxTzxTFssspIkfD2lFQTEs5xk2IgM7GvpwKPYRSpwLALrK+bjs57X
	VrZ5Qcu47k84/XHNeTGrHEijsgMqWhh64Vgoy+EOgbr6fY69g68SiAZE0KrvLKjr
	6Mxuw5rKO5w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0B364A687;
	Sun,  6 Mar 2016 20:28:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 61B1D4A685;
	Sun,  6 Mar 2016 20:28:04 -0500 (EST)
In-Reply-To: <20160305221650.GF31508@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 5 Mar 2016 17:16:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D6D4BAAC-E403-11E5-AF34-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288376>

Jeff King <peff@peff.net> writes:

> Some of the test-* programs rely on examining refs, but did
> not bother to make sure we are actually in a git repository.
> Let's have them call setup_git_directory() to do so.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> As discussed elsewhere, test-match-trees isn't actually used in the test
> suite (except for the weird use which was removed in patch 1 here). So
> we could also just get rid of it, but maybe somebody uses it for
> debugging or something.

I tend to agree that it is very tempting to remove that one.  It was
a throw-away program I wrote early while inventing the subtree merge
strategy.

It would be useful only to those who want to extend the heuristics
of figuring out how to shift two trees to make them match, without
having to exercise the whole merge-recursive machinery.
