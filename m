From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty-format: add append line-feed format specifier
Date: Wed, 10 Sep 2014 10:19:21 -0700
Message-ID: <xmqqtx4fgzqe.fsf@gitster.dls.corp.google.com>
References: <540F426E.6080908@exec64.co.uk>
	<xmqqmwa8k3lg.fsf@gitster.dls.corp.google.com>
	<540F554C.5010301@exec64.co.uk>
	<xmqqegvkk2k3.fsf@gitster.dls.corp.google.com>
	<20140909214520.GA13603@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Harry Jeffery <harry@exec64.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 19:19:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRlYH-0003Gu-9k
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 19:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbaIJRTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 13:19:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63906 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbaIJRTY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 13:19:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C25F38902;
	Wed, 10 Sep 2014 13:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8r1Uo8zNhCPRbzOV81xTg1ViOgU=; b=ugGHqr
	4LYTx/LCWF/ZpLoDugqRaMT4NCpMTe+yqBdD8jACNfBl71aE0NSvVR9oUJBMep4m
	/lm2uWtb77LUQ7E5bO38HSnSZ7W41S/8Ye/vmnO8D+xduyOla2R75j7b5uKdQ1Dm
	N1miB6n6tqXuF8U9Kmoj/63oLUx38BCJQRsj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q/tU3yWEIxJJMjgunFl4PrSOE05ri5fd
	GD/Y0W+YE7foCc7Q1/pgnwRmLX/4zx93V2DGekn0NLF//Toshg05CpBuqZqJMfOu
	r/QZ7Ir7KQ+Cn7Six715EyXYGIhbdk+HzhQVqIIEzEOagmmgsj9SkqzADESY2Bgt
	XtYl+Sip140=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0EA7A38901;
	Wed, 10 Sep 2014 13:19:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 809A638900;
	Wed, 10 Sep 2014 13:19:23 -0400 (EDT)
In-Reply-To: <20140909214520.GA13603@peff.net> (Jeff King's message of "Tue, 9
	Sep 2014 17:45:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9BDEF83C-390E-11E4-9984-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256755>

Jeff King <peff@peff.net> writes:

> Something like the patch below might work, but I didn't test it very
> thoroughly (and note the comments, which might need dealing with). Maybe
> it would make a sensible base for Harry to build on if he wants to
> pursue this.
>
> With it, you can do:
>
>   git log --format='%h %s%if(%d,%n  Decoration:%d)' origin
> ...
> You could also make "%d" more flexible with it. We unconditionally
> include the " (...)" wrapper when expanding it. But assuming we
> introduced a "%D" that is _just_ the decoration names, you could do:
>
>   %if(%D, (%D))
>
> to get the same effect with much more flexibility.

Yup.

I do not think we need to go overboard to support nesting and stuff,
let alone turing completeness ;-), especially when we are going to
test the condition part only for emptyness.  Even with this simple
patch, I sense that we are near a slipperly slope of wanting to add
%unless(%d, ) or %ifelse(%d,%d, \(undefined\)), so I am not 100%
convinced yet.
