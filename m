From: Junio C Hamano <gitster@pobox.com>
Subject: Re: credential-helpers + remote-helper, starting  point?
Date: Thu, 24 May 2012 15:09:15 -0700
Message-ID: <7vtxz5ut84.fsf@alter.siamese.dyndns.org>
References: <b13df32797edbe8f71c796dbb4dc06a5@telesun.imag.fr>
 <20120524182110.GE3161@sigill.intra.peff.net>
 <vpq7gw1z8rb.fsf@bauges.imag.fr>
 <20120524200122.GA18936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	roucherj <roucherj@telesun.imag.fr>, git@vger.kernel.org,
	kim-thuat.nguyen@ensimag.fr, pavel.volek@ensimag.fr,
	javier.roucher-iglesias@ensimag.fr
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 25 00:09:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXgDn-00078o-OU
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 00:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758765Ab2EXWJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 18:09:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175Ab2EXWJS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 18:09:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A23BB873B;
	Thu, 24 May 2012 18:09:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FtvttW4P5TjSXCqN9OtOEw+S97w=; b=qtwIPR
	3cJ9X+SHihbMjR2tyXhfo0y+BxuDEn+nD3IBtGQbGPqy6/CZbdsRG8tbrUdr2WER
	R5IiHOhzvEBEgVtDVygHq6xv1iJuR6J94dak9SVsk60JQvuUqLTGN2sBbVj2V2Om
	92aDEmakImR3lJPL+nnexV5WDzm7bvwPgLL+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PkbPSICm2SDVzO2UQ3z8yEaNhpaQo3wH
	R20m7d5/chjpwmZLxMmTUAa7TXgzeAk3yxeodBa5rFuoKLyCm+emH3IUmeu9BWKE
	0I2ycjrTr/Z8K9jeeJNbCscLjFDP5uL/Im9Lb75Vp+cLkGhlp0khaS3DHyDV4Ere
	CnGe3b0BWx0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98DC9873A;
	Thu, 24 May 2012 18:09:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A0E18738; Thu, 24 May 2012
 18:09:17 -0400 (EDT)
In-Reply-To: <20120524200122.GA18936@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 May 2012 16:01:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AB711D8-A5ED-11E1-8311-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198438>

Jeff King <peff@peff.net> writes:

> On Thu, May 24, 2012 at 09:20:08PM +0200, Matthieu Moy wrote:
>
>> +------------
>> ++-----+ -----> +-----------------+
>> +| git |  pipe  | git remote-http | --- to HTTP server --->
>> ++-----+ <----- +-----------------+
>> +                    ^      |
>> +                    | pipe |
>> +                    |      v
>> +             +----------------------+
>> +             | git credential-cache |
>> +             +----------------------+
>> +------------
>> +
>> +git remote-http will take care of contacting the HTTP server, do the
>> +actual authentication and see if it's accepted by the server. The
>> +credential helper will deal with the credential store (which can be
>> +done by contacting a keyring daemon) and the prompting if needed.
>
> I feel like adding remote-helpers into the mix just makes the situation
> more complex (and necessitates the diagram).

I would also prefer to see an example _without_ the remote helper, but at
the same time it still helps to have an illustration.

> +This document describes two interfaces: the C API that the credential
> +subsystem provides to the rest of git, and the protocol that git uses to
> +communicate with system-specific "credential helpers". If you are
> +writing git code that wants to look up or prompt for credentials, see

Don't you "prompt" yourself?  The above sounds as if you are delegating
both looking up and prompting to the helper.

> +the section "C API" below. If you want to write your own helper, see
> +the section on "Credential Helpers" below.

Nice.
