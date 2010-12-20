From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Sun, 19 Dec 2010 18:32:06 -0800
Message-ID: <7vhbe9dvix.fsf@alter.siamese.dyndns.org>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru> <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Jeff King <peff@peff.net>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Mon Dec 20 03:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUVYJ-0002Cc-Rd
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 03:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab0LTCc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 21:32:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab0LTCcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 21:32:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7CB347A3;
	Sun, 19 Dec 2010 21:32:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sYZ9xphYdfU9pZ0hJlB8+gkxBPQ=; b=srVCeu
	bBjiba7YZlH0KAQeVt99TlhqNcMlxOZQqqrva2t6K+vtectFC6CqBWBBDeQS5I7c
	azIQH4uZQaJicacr0sNvOmNS181jyLxK5Hunw0fAfZGvCwVOOSiojZkVfD30/Xmx
	aUQp2sQfr4+YeXvRevoKdvyleBg8BTFQSRZOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oiWWxPKi7OQrQ9cxk3+8/UiWed4nQJqD
	VqpVcU1RP1iB6urdvomj9f7aoegfn1fWI/PFvm8p4zxaEbgPfm6RFFehv7v66diW
	RjKCpYcUPxKnSdj6z7YKEnina/R+A82QMieSu2XztQUSezyrx8KotixdbbrN0Hxh
	F389phQrLr0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 120FB47A1;
	Sun, 19 Dec 2010 21:32:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E0F3D47A0; Sun, 19 Dec 2010
 21:32:36 -0500 (EST)
In-Reply-To: <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru> (Kirill Smelkov's message of "Sat\, 18 Dec 2010 17\:54\:12 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D4BB842-0BE1-11E0-89B2-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163977>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> It turned out, under blame there are requests to fill_textconv() with
> sha1=0000000000000000000000000000000000000000 and sha1_valid=0.

The code shouldn't even look at sha1[] if sha1_valid is false, as we do
not know the hash value for the blob (reading from the working tree).

Thanks.
