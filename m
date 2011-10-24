From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache.c: fix index memory allocation
Date: Mon, 24 Oct 2011 00:07:20 -0700
Message-ID: <7vipne50lz.fsf@alter.siamese.dyndns.org>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr>
 <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx>
 <20111023162944.GB28156@sigill.intra.peff.net>
 <4EA453D3.7080002@lsrfire.ath.cx> <4EA4B8E7.5070106@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Oct 24 09:07:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIEd6-0000DJ-6F
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 09:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab1JXHHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 03:07:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312Ab1JXHHW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 03:07:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3C728C6;
	Mon, 24 Oct 2011 03:07:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xJSPJjSUJFBfFDk6x70Oewyy21M=; b=Rg1K0C
	bbZ8j6Kb9ggjDflfnDpLMl24exEZjb0cVD5JYTH53xakqWOI/8i+7gcNXBBSl2Tk
	tq4+ri1Xnerk9dlNbl/rVStTCm70nR6E3MhzrVyPfz6yseYJFvp9tM0ka5LJIWbc
	q0cq/wLqin/2W9EAB8NJ7ZdPK2exfVi1pmLGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ab98qAekD7Pma7rAqTMW4y41iuMYO97u
	UCrKgDPX1k2qiGezHDz4mv4NtcpmfsGQeLZrFurK4kwf4XCBkT/2lEBZliwi/ES8
	yNhIdNokn1YTPOIckLlkNBk0AU+3jCFfKg574mvCBLxdtEQCBirIxBtfidhIrPWD
	659VhOM3km4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 567D228C5;
	Mon, 24 Oct 2011 03:07:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C317928C4; Mon, 24 Oct 2011
 03:07:21 -0400 (EDT)
In-Reply-To: <4EA4B8E7.5070106@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 24 Oct 2011 03:01:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D173553A-FE0E-11E0-ADEF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184166>

Thanks.

This approach may be the most appropriate for the maintenance track, but
for the purpose of going forward, I wonder if we really want to keep the
"estimate and allocate a large pool, and carve out individual pieces".

This bulk-allocate dates back to the days when we didn't have ondisk vs
incore representation differences, IIRC, and as the result we deliberately
leak cache entries whenever an entry in the index is replaced with a new
one. Does the overhead to allocate individually really kill us that much
for say a tree with 30k files in it?
