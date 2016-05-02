From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] travis-ci: build documentation
Date: Mon, 02 May 2016 13:45:09 -0700
Message-ID: <xmqq60uwrxyi.fsf@gitster.mtv.corp.google.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
	<1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
	<1462220405-12408-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon May 02 22:45:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axKiU-00081S-RP
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 22:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104AbcEBUpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 16:45:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754864AbcEBUpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 16:45:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2988A189F9;
	Mon,  2 May 2016 16:45:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YS6rKiBz24FXBfoDmqgjjvvIX98=; b=YrMLGn
	ACPjUr7nKZ9jA1rhFJQisYLBHBMqUrZeZ01y6woWtb7/xv5GXwlujUL2ShrmShgT
	MahUz0/lu494WCtsLAcUMVSZ9dWAjJxv46L4cHYrRFNNdIcSBtXl4Q9npfIUgFf1
	VY2pY06uzCWwYdoUiO32OWDtsfnVOxLvyasjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l3hJHBA17MMCOEhJ8ozlkEwSZgyAbeFm
	RjpnnnWVpzQgCZjm4mXXymw+vHlKxOneJUiIe9kv2RoOnYHzW1/bD+jzxYtR2fYd
	bpd+RMtNnJD1U9qJeNJSpmIyypDd8/UcvW7XG20K+DNbjw+xehcfu39xCa9b5jtT
	utasc2Hhk50=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F2CE189F8;
	Mon,  2 May 2016 16:45:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A3F6189F7;
	Mon,  2 May 2016 16:45:11 -0400 (EDT)
In-Reply-To: <1462220405-12408-3-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 2 May 2016 22:20:05
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3B0EA98-10A6-11E6-9CC3-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293288>

larsxschneider@gmail.com writes:

> +set -e
> +
> +LINKS=$(grep --recursive --only-matching --no-filename --perl-regexp \
> +    '(?<=linkgit:).*?(?=\[\d+\])' Documentation/* \
> +    | sort -u \
> +)
> +
> +for LINK in $LINKS; do
> +    echo "Checking linkgit:$LINK..."
> +    test -s Documentation/$LINK.txt
> +done

Please separate the above link check out of this step and do so
separately after the move of test body to a separate script
settles.

When you reintroduce the tests, please make sure the shell script
follow the coding style of other scripts.  E.g. I do not think the
last one in the $(...) needs a backslash continuation at all.  I am
assuming that you are doing this only on Linux, in which case use of
GNUism with grep may be fine.

> +make check-builtins
> +make check-docs
> +make doc
> +
> +test -s Documentation/git.html
> +test -s Documentation/git.xml
> +test -s Documentation/git.1
