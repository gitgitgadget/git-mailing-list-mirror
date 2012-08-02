From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Thu, 02 Aug 2012 15:51:17 -0700
Message-ID: <7v6290di1m.fsf@alter.siamese.dyndns.org>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <7vfw87isx1.fsf@alter.siamese.dyndns.org>
 <20120801004238.GA15428@sigill.intra.peff.net>
 <7v8vdzgngo.fsf@alter.siamese.dyndns.org>
 <20120801215414.GC16233@sigill.intra.peff.net>
 <7vipd2e00g.fsf@alter.siamese.dyndns.org>
 <20120802223733.GA28217@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:51:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx4F4-00022Y-6Z
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab2HBWvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:51:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab2HBWvU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:51:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4818F92E3;
	Thu,  2 Aug 2012 18:51:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pcrx58OSg7UbUQSk6Y4UF2ouLCA=; b=OG4EUS
	LrlY1+fdFK+uVjFEijnYgpCUjus2Nbp5flK0zNhIGlZOZbZPaFJmL4jwz+mMUC4m
	bJGHCioFfneNrXDE/W6eXdNliWk0RVHRef7YuFG9IlDEx0h4DHoNpPel0XuJQkOe
	w+hqcp2UEpk5nrE4tQAZrQFEM1zvJ3AV7kX3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lz8w3xWGdvpxs9Uxw5mqdJLmFld+ENeC
	VU0WjmKQOCwXb6fFRq0ZpzjF8vSxACl1E0JNJn1AothkooqKxXC/oiG8euuo850Y
	a2E9Da4EcLUnM3v+cGz8H/LkscDTJgCRiraAIcpIf1IPgtMuFmG9hSfNifcrFDIH
	Uc/XsD/PWRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3462A92E2;
	Thu,  2 Aug 2012 18:51:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9485692E1; Thu,  2 Aug 2012
 18:51:18 -0400 (EDT)
In-Reply-To: <20120802223733.GA28217@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 2 Aug 2012 18:37:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 928549D0-DCF4-11E1-9A77-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202810>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 01, 2012 at 03:10:55PM -0700, Junio C Hamano wrote:
> ...
>> When you move porn/0001.jpg in the preimage to naughty/00001.jpg in
>> the postimage, they both can hit "*.jpg contentid=jpeg" line in the
>> top-level .gitattribute file, and the contentid driver for jpeg type
>> may strip exif and hash the remainder bits in the image to come up
>> with a token you can use in a similar way as object ID is used in
>> the exact rename detection phase.
>> 
>> Just thinking aloud.
>
> Ah, I see. That still feels like way too specific a use case to me. A
> much more general use case to me would be a contentid driver which
> splits the file into multiple chunks (which can be concatenated to
> arrive at the original content), and marks chunks as "OK to delta" or
> "not able to delta".  In other words, a content-specific version of the
> bup-style splitting that people have proposed.
>
> Assuming we split a jpeg into its EXIF bits (+delta) and its image bits
> (-delta), then you could do a fast rename or pack-objects comparison
> between two such files (in fact, with chunked object storage,
> pack-objects can avoid looking at the image parts at all).
>
> However, it may be the case that such "smart" splitting is not
> necessary, as stupid and generic bup-style splitting may be enough. I
> really need to start playing with the patches you wrote last year that
> started in that direction.

I wasn't interested in "packing split object representation",
actually.  The idea was still within the context of "rename".
