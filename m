From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP] attr: make attributes depend on file type
Date: Mon, 28 Feb 2011 09:48:17 -0800
Message-ID: <7v39n8jbj2.fsf@alter.siamese.dyndns.org>
References: <20110228130850.GB9054@sigill.intra.peff.net>
 <f35b1b4b57a563f57f169602440b3b0abdef5a07.1298906628.git.git@drmicha.warpmail.net> <20110228173037.GC24915@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 18:48:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu7Cz-00084q-Ft
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 18:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534Ab1B1Rs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 12:48:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab1B1Rs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 12:48:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 56CD548FF;
	Mon, 28 Feb 2011 12:49:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wLOLXRTdWqBEdMN3jdQ9Lg6hYEs=; b=aUMnr+
	hx4pASmLHFpF2xYB44gPHzbdunfUHAFaGfkh15Qmr+Djn05jGbtCa7GCQyPgGHt7
	ibTTZldSZMZiUxwGwxxzWvl5GEnbhnkJn3HJm6r5hgDExDuIEDairs4LWRRVV8PU
	Dub47Vx8wGL6xCtY1UFrjQd+RR8iXSe85vlcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xoZdreOS6ZrlxyHoaCAWhJRG6BSh+nLg
	68QQ2cQ77iFKCJHG7mj06dWaQH5OlsNUC/rQFuRstj/wHzMmBXOCHMm+mG9zoCc5
	wWogGRpoj8Zqb7PAAon9ls+yYxoS6m454nptejBLf0Yn3ztCXTIX12yQ01zibc9R
	ygp1KzdIExU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2420748FE;
	Mon, 28 Feb 2011 12:49:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 179BE48FC; Mon, 28 Feb 2011
 12:49:37 -0500 (EST)
In-Reply-To: <20110228173037.GC24915@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 28 Feb 2011 12\:30\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1EF15D3C-4363-11E0-A2E1-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168126>

Jeff King <peff@peff.net> writes:

> The only downside is that it is technically a regression if somebody was
> using gitattributes for the bizarrely named file "symlink:". It seems
> pretty unlikely, but possibly we should be carving out a syntactic
> namespace like:
>
>   ^[a-z]+:
>
> or even:
>
>   ^[a-z]+(=[^:]*)?:

Or even '^:[a-z]+(=[^,=])?(,[a-z]+(=[^,=])?)*:' to

 (1) always have some special character at the beginning, to limit the
     extent of the damage to existing funny pathnames (i.e. to collide
     your pathname must begin with such a special character).  This also
     has a nice side effect of making it clear that something special is
     going on; and

 (2) allow more than one such special on the line, comma-separated.

But that is just a small bikeshed.  Other than that, I like what Michael
and you are aiming for (I am only commenting on the general direction at
this moment, as I haven't looked at the patch at all yet).
