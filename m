From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 03 Oct 2011 13:27:19 -0700
Message-ID: <7vobxxes7s.fsf@alter.siamese.dyndns.org>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111003074250.GB9455@sigill.intra.peff.net>
 <20111003110159.GA13064@LK-Perkele-VI.localdomain>
 <20111003181338.GA13392@duynguyen-vnpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 22:27:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAp6y-0004D9-Am
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 22:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757548Ab1JCU10 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 16:27:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab1JCU1X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 16:27:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7DDC4775;
	Mon,  3 Oct 2011 16:27:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oSTLMcl+ivJx
	/L7ihro4MQIGCC4=; b=paLiiLwyXvFL+1VavFg2WkpM7I4SErskKvDYN0Dl4eC0
	8WGygQyqQ4BvpWTzOgtsAEg26eWY3yYIGkUG9K7QFqpHfLNE7vQDXr28l6rybOWz
	qSAOjDpZcEclZQ0CHBqcykS4LlyJMe4EdBVJq7WosD4qaxdaCTtEeTB9S2wyLKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=W+dkAZ
	WKI4DTQjGp6pXGAh36cTcwYAZaHpaM9WWrdApJt8mGFmVfqA01LH6dlD2+I0V3Ps
	788DeQ+1TcaN/BUkuNIXze3qnGkEMlUkuhtfhDKRZa+27BI1v+Q36d5AZoewEM2R
	WAQUgX/Zhek3ke1J+PJuvigMS6yS1oONY7SRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EC3C4774;
	Mon,  3 Oct 2011 16:27:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D0854773; Mon,  3 Oct 2011
 16:27:21 -0400 (EDT)
In-Reply-To: <20111003181338.GA13392@duynguyen-vnpc> (Nguyen Thai Ngoc Duy's
 message of "Tue, 4 Oct 2011 05:13:38 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19280F72-EDFE-11E0-BEC0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182711>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> From ce3a402e4fa72cf603f92801d6f021ff89d3ac35 Mon Sep 17 00:00:00 20=
01
>> From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
>> Date: Mon, 3 Oct 2011 13:55:37 +0300
>> Subject: [PATCH] Support ERR in remote archive like in fetch/push
>>=20
>> Make ERR as first packet of remote snapshot reply work like it does =
in
>> fetch/push. Lets servers decline remote snapshot with message the sa=
me
>> way as declining fetch/push with a message.
>>=20
>> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
>
> Yeah, maybe with this patch also?
>
> -- 8< --
> Subject: [PATCH] pack-protocol: document "ERR" line
>
> Since a807328 (connect.c: add a way for git-daemon to pass an error
> back to client), git client recognizes "ERR" line and prints a
> friendly message to user if an error happens at server side.
>
> Document this.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Mmakes sense; thanks, both of you.
