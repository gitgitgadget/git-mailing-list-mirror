From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] git submodule add: make the <path> parameter
 optional
Date: Sun, 04 Oct 2009 18:31:12 -0700
Message-ID: <7vtyyek4nz.fsf@alter.siamese.dyndns.org>
References: <4AB8E8D4.40105@web.de> <7vbpl2srw9.fsf@alter.siamese.dyndns.org>
 <4AC8E0A8.4000901@web.de>
 <alpine.DEB.1.00.0910042304060.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Lars Hjemli <hjemli@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 03:33:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MucSB-0004KR-Fu
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 03:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208AbZJEBcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 21:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758188AbZJEBcI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 21:32:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757385AbZJEBcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 21:32:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D2C306A975;
	Sun,  4 Oct 2009 21:31:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lmGlvh0EOPLucfVsw8A/kXLeHng=; b=f1f+XA
	PlIzq+cHAiH0tIBorarFbX5uxE4f9mlyeSTrKsWzMzfZifB1Le1mcIbyo8T/2xf0
	SvNgPoKFdBvhuCmOJ94AxhZn0lLooPUmMQF7H5LexA2OyxAr0ZZzLVf20kdYVmW5
	zBf0qptIhTFdFpOS1vJw1eNChC3ZKvT8dzuSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ub9Ns6L/1y727aF1b4+8VrkHXLz9nERG
	AlPhTUm1lGHB+ey2/o4GjTgJ2KHhMsPU/vt2v786PpKpOEPDETOV8qpTImdvXAQg
	bfmTEKDfiRMSCB5IxfcgDGaruOnu2dbKRcvLBQsLoDS2ktNrKeE6yjBBOpAP9vUX
	iYtJYeSBJD8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A4B86A974;
	Sun,  4 Oct 2009 21:31:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E506E6A970; Sun,  4 Oct 2009
 21:31:13 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0910042304060.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun\, 4 Oct 2009 23\:05\:35 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C86D1994-B14E-11DE-A5C5-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129523>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So far, I started submodules by cloning them, doing everything in the 
> other files needed to integrate, and then actually wondered why "git 
> submodule add" could not simply take the (relative) path to the 
> checked-out submodule and deduce the URL from the corresponding config?

Let me try to rephrase the above to see if I understand what you are
doing.  When building a top-level superproject that uses two submodules
from other places, you would do:

	$ git init toplevel
        $ cd toplevel
        $ git clone $overthere submodule1
        $ git clone $elsewhere submodule2
        $ edit Makefile common.h
        $ git add Makefile common.h submodule1 submodule2

and by "the corresponding config", you mean "submodule1/.git/config
already records that it came from $overthere, and there is no reason to
say it again in 'git submodule add $overthere submodule1'".

If that is the case, I think it is a very sane argument.  It also makes me
wonder why we need "git submodule add" as a separate step to begin with
(i.e. "git add" Porcelain could do that behind the scene), but that is
probably a separate topic.

> So I would actually vote for making the <repository> parameter optional...

In your "git submodule add submodule1", it would be quite clear that it is
a local path and <repository> is being omitted.  On the other hand, if you
said "git submodule add $overthere" without submodule1, because $overthere
is not likely to be an in-tree path, it also would be clear that it is
omitting the path.  IOW, these two typesavers are not mutually exclusive.

In real life, it is very likely $overthere does _not_ end with submodule1,
and your suggestion would probably be more useful than the patch under
discussion, I think.
