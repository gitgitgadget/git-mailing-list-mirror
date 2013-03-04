From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow combined diff to ignore white-spaces
Date: Mon, 04 Mar 2013 10:36:51 -0800
Message-ID: <7vy5e3vwos.fsf@alter.siamese.dyndns.org>
References: <1362236658-17200-1-git-send-email-apelisse@gmail.com>
 <7v38wdc4ei.fsf@alter.siamese.dyndns.org>
 <CALWbr2z0eok-VOQX7DDZafevQUi7asCv_tD8=y6XA2PVYf52AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 19:37:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCaGH-0003BU-Pd
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 19:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589Ab3CDSgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 13:36:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61996 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758520Ab3CDSgy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 13:36:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8473FA77D;
	Mon,  4 Mar 2013 13:36:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q5lPsYYE9R4b2xVLkR5Q7Hw0h74=; b=fuEYl2
	V2uziMjAn6FqXRV6DTvNrybEhZr1dMa1p/TF1wXABYzJaMGBpAMq/ifHGtloyx8z
	bborbrdJ012r2wByEyQuDRdY2E088S2Xh1bCcyM4HaAZKjmcPvdo2v3A3iEu7KvG
	ADeAgFJl/ITed538UMaYd/LDruyOm9KttiOmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LfF3W++hbd9Cv+/eZMbB1eCuso8LxBEr
	FUxlix70vPNv671FC5Z5L92ouoZp64VcMcO61RJAxkmoUOKuo1lYzZ9Kd4bMGMQU
	OUupJ1u5F6LhFVrGW1TsBmaOp9IgvL3S4afTdeNiG8mqjB7EAse7H4R4/UmRHQqr
	rFdf9nF50lM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A599A77C;
	Mon,  4 Mar 2013 13:36:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0BECA77A; Mon,  4 Mar 2013
 13:36:52 -0500 (EST)
In-Reply-To: <CALWbr2z0eok-VOQX7DDZafevQUi7asCv_tD8=y6XA2PVYf52AQ@mail.gmail.com> (Antoine
 Pelisse's message of "Mon, 4 Mar 2013 19:17:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BE68532-84FA-11E2-BACB-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217405>

Antoine Pelisse <apelisse@gmail.com> writes:

> It feels incorrect to me to coalsesce "- 5" and "-  5" as it might
> look incorrect to the user. But still the idea is appealing.

The users already need to see that when reading a regular patch with
one or more context lines and -b/-w/etc., anyway.  The context lines
are made into context only because whitespace differences were
ignored, and in the regular unified patch format we can show only
one version, either from preimage or from postimage, and have to
pick one.  Coalescing "- 5" and "-  5" into "--5" or "--  5" by
picking one or the other is the same thing, no?

> Using the exact example you gave, and running the latest next, I have
> this output, where 11 is not coalesced.
> Is that a bug ?

It could be tickling a corner case because the removal is at the end
of the file.  Perhaps adding 12 that is all common across three
versions and see what happens?
