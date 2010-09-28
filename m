From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] tests: Prepare --textconv tests for
 correctly-failing conversion program
Date: Tue, 28 Sep 2010 08:36:46 -0700
Message-ID: <7vlj6lubg1.fsf@alter.siamese.dyndns.org>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru>
 <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru> <7vsk0vyriw.fsf@alter.siamese.dyndns.org> <20100928120722.GA29525@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Tue Sep 28 17:37:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0cF3-0006oW-GP
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 17:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab0I1PhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 11:37:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0I1PhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 11:37:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8824DA305;
	Tue, 28 Sep 2010 11:37:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J1TF/gxLw3UDy7pw3BSKNLB6uQY=; b=hdjTj5
	96TBEatBh10oNm4otMKUSh/DJ4ZelcHUF4f96kgXgLrXik7wxtqSveLI3ZG+HEpG
	KGdo9WtuarEB82Hd9ZNWsDLB5zGCdc+oEacI4+D5OwBolduKahR0v0wEBvFXgRoV
	M+2fyBMAP1ulh2b51VWRkFb6euo6EZnpojGuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tjV2x1IinRXMmeluqEFd8KADGkx6dfXu
	mwaWbZB5uIYYWhrFfLBLa6ToDYq7+anuvU4FfREOeQ5jN6eH9m6zIfxTm87giLk9
	8aMTRa5uTVRb6VEPREEdcQMXRqmpuibAT6VXBAvwmoOdzXeScVG9kWTxBtCPvlHd
	vYv16TtaKfw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07E77DA303;
	Tue, 28 Sep 2010 11:36:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F8A0DA2F8; Tue, 28 Sep
 2010 11:36:47 -0400 (EDT)
In-Reply-To: <20100928120722.GA29525@landau.phys.spbu.ru> (Kirill Smelkov's
 message of "Tue\, 28 Sep 2010 16\:07\:22 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39914528-CB16-11DF-8AEE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157435>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> On Mon, Sep 27, 2010 at 11:23:35AM -0700, Junio C Hamano wrote:
>> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
>
>
>> > +sed 's/^bin:/converted:/' "$@" >helper.out
>> 
>> Minor nit: this is inconsistent with the check done with grep above that
>> insists that the colon is followed by a SP.
>
> Yes, you are right. I'll amend it.
>
>> > diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
>> > index 91f8198..7668099 100755
>> > --- a/t/t4042-diff-textconv-caching.sh
>> > +++ b/t/t4042-diff-textconv-caching.sh
>> > @@ -5,18 +5,19 @@ test_description='test textconv caching'
>> >  
>> >  cat >helper <<'EOF'
>> >  #!/bin/sh
>> > -sed 's/^/converted: /' "$@" >helper.out
>> > +grep -q '^bin: ' "$@" || { echo "E: $@ is not \"binary\" file" 1>&2; exit 1; }
>>  ...
> ...
> I too think (1) is right. It was just that originally there was $@
> (which I now understand was wrong).

Well, the original's use of "$@" is perfectly fine; it would do the right
thing with one argument, of course, but it would do the right thing with
more than one, too.  On the other hand, your use inside "echo" is not.
