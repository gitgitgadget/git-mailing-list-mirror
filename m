From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Wed, 17 Jul 2013 16:22:44 -0700
Message-ID: <7vd2qg6abf.fsf@alter.siamese.dyndns.org>
References: <51E431F1.6050002@ramsay1.demon.co.uk>
	<51E4E0C0.3060604@viscovery.net>
	<20130716062122.GA4964@sigill.intra.peff.net>
	<6BDA2E3E7318418BBB2C19B475B2B118@PhilipOakley>
	<51E715D8.9040307@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 01:22:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzb3e-0007vz-Gm
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 01:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934212Ab3GQXWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 19:22:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934206Ab3GQXWr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 19:22:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0604E31FBE;
	Wed, 17 Jul 2013 23:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pnn7A53WNYLiuCmN0y3rkYlOI30=; b=yCZSst
	51fAd7FCUb7L0nvcb7DeeK5PoeTx8DkEWoa5yWuEK86NBsPND8ewQEddFx9tSJ2r
	20y+q6+Ha+bP5nqVaDLCwvMU6flc0uSkCRxlLPeCkTn9Jq3MRCGkd6gdiE3n7QSA
	y2pHROQ+KbfdePGOPtk3vrkybfolw7yxpv6yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=khMo5Tp63TmklKWeZU0kGglb6HCGm++O
	RAgsv6TPgiqj8qHoMVTcE5ClH4ILQup85Y1PpM+SNzf1Lh/Xm8dOKBXyaq1Xo8+C
	JLKld2MrMwiAo8ht+BIaKRWklSDQ0VT3Wl3YXjyuin1fnSzjMrhQ9y9HjVAR3bKT
	lG72WAjiyuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEE9C31FBD;
	Wed, 17 Jul 2013 23:22:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27FC731FBB;
	Wed, 17 Jul 2013 23:22:46 +0000 (UTC)
In-Reply-To: <51E715D8.9040307@googlemail.com> (Stefan Beller's message of
	"Thu, 18 Jul 2013 00:08:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9CC9AA0-EF37-11E2-8806-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230662>

Stefan Beller <stefanbeller@googlemail.com> writes:

> And the parse_object_buffer looks like this with respect to the eaten 
> variable:
> 	struct object *parse_object_buffer(...)
> 	{
> 		int eaten = 0;
> 		if (something)
> 			return NULL;
> 		...
> 		if (something_different)
> 			eaten=1;
> 		*eaten_p = eaten;
> 	}
> ...
> Was there a particular idea or goal behind first having a local eaten
> variable, which later near the correct return of the function was used to set the 
> eaten_p?

I didn't run "blame" to see the evolution of this function, but I
suspect that the original code, when the "eaten" local variable was
introduced, very much tried to do exactly what you suspect.  The
early return codepaths you see in today's code may be much newer,
added without much thinking about the exact issue you are bringing
up.
