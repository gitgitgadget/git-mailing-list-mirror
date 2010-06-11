From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] t/t8006: test textconv support for blame
Date: Fri, 11 Jun 2010 16:52:26 -0700
Message-ID: <7vd3vxgm9x.fsf@alter.siamese.dyndns.org>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-3-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 12 01:52:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONE1p-00069H-Tt
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 01:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759682Ab0FKXwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 19:52:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758673Ab0FKXwi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 19:52:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E25EBB290;
	Fri, 11 Jun 2010 19:52:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=cLYJY3DeYgRD6yPTou+Lh5S0jOY=; b=u21l/GfZ+DaBx1XD7Vyhtnp
	g5X8e2fpaFxeJomvwU0bLU3KFdnqc8Khz8txpW+D2ljF+eiq/8mlj0TZe0TiuuXg
	w0YVv9EROHmLvdyKm1Dfgq/vDpt3gkGLaqHmMes/bJt7FPgFaNH4h9CjcEo/saLn
	LBYyIM0Vao3LuFgGsbyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=jLoFFfknqnkZ1FS0QQ/rhfEybZ1v99jTD8t9VKNtzl0Bq+bVV
	yv1g9rjvh9Uz984lzzpkqvxw7E1X58wxKi63OYEHl+tHVeOgWz788gVk/4SPAEAO
	uRHwFK+RkvbSluSM8VvhR7fE5yH5dgFIQF7wffpngIekLgTlxzxc7n6C6k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A3AE2BB289;
	Fri, 11 Jun 2010 19:52:32 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 997A8BB286; Fri, 11 Jun
 2010 19:52:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 66EFFE40-75B4-11DF-B2EB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148977>

Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:

> Test the correct functionning of textconv with blame <file> and blame HEAD^ <file>.
> Test the case when no driver is specified.

Good to see tests for both positive and negative cases.  Too many people
forget the latter.

> +find_blame() {
> +	sed -e 's/^.*(/(/g'
> +}

Two issues:

 - No need for "g" as your pattern is anchored at the left;

 - As ".*" is greedy, you will eat a lot more than what you expect when
   the line in the blamed contents happen to have '(' on it.

I'd rewrite it as:

    sed -e 's/^[^(]*//'

Will queue all three patches, with this fix and a style fix for 2/3; no
need to resend.

Thanks.
