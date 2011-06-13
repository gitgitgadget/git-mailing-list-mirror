From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Make $prevent_xss protection for 'blob_plain'
 more usable
Date: Mon, 13 Jun 2011 09:47:59 -0700
Message-ID: <7v8vt5ptj4.fsf@alter.siamese.dyndns.org>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com>
 <201106101401.19108.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matt McCutchen <matt@mattmccutchen.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 18:48:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWAJE-0001r2-6G
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 18:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab1FMQsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 12:48:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab1FMQsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 12:48:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25A645652;
	Mon, 13 Jun 2011 12:50:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Y7yRAAhnhRImSn8DEES1owcOLE=; b=FUoEw0
	XzkyqNupwdTsi7B4WPAkJWh1P9eU11LjBrnv94L92bBXOUj4SUQlkRWuxvbpC4Zi
	ei3tzkZxMnwhgxvX+rRDlcskx9b1icaLeL+OFNAnu+3YEX6UIHKhQdCuSh/1MT8i
	gTxHw5izn4rjr6O7bKO9zrYRwdYLuU1AW6mag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cL3IEE9c0mcAnlRLZrs7ZPd0/f19eWkr
	chVUKCS44111IdMV9pUSsxx25gA/0jBIOCTV2D4ekz5fd7JdfXN1tzHDa1ycx0CZ
	Z6aTXMLHbi3O9j8geV18eJiUY92hVlFHMqwsddQUPm28ZJWF0KU9TTqE29zIJXSG
	Zvskx9CBuu4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E71885651;
	Mon, 13 Jun 2011 12:50:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A4658564D; Mon, 13 Jun 2011
 12:50:11 -0400 (EDT)
In-Reply-To: <201106101401.19108.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 10 Jun 2011 14:01:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36A9783E-95DD-11E0-B75E-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175720>

Jakub Narebski <jnareb@gmail.com> writes:

> +	# serve text/* as text/plain
> +	if ($prevent_xss &&
> +	    $type =~ m!^text/([a-z]+)\b(.*)$!) {
> +		my ($subtype, $rest) = ($1, $2);
> +		$rest = defined $rest ? $rest : '';
> +		$type = "text/plain$rest" if ($subtype ne 'plain');

Hmph, wouldn't it be more straightforward if you dropped the statement
modifier?  I.e.

	my ($subtype, $rest) = ($1, $2);
        $rest = '' unless defined $rest;
        $type = "text/plain$rest";

Other than that, looks good to me.

Thanks.
