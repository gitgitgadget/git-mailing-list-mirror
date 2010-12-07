From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/6] web--browse: use *www-browser if available
Date: Tue, 07 Dec 2010 15:36:08 -0800
Message-ID: <7vaakhnok7.fsf@alter.siamese.dyndns.org>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291657790-3719-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 00:36:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ758-0002vG-GN
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 00:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab0LGXgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 18:36:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab0LGXgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 18:36:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 23C283685;
	Tue,  7 Dec 2010 18:36:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p+W+ZJCbJQ7IT94YInzGmJlWJsA=; b=cnQvkv
	d+r15bu7ZZ/HlZyWp8EE+woTXrEiK2ep4WaQAYC7s+0InXTNJwX8AacfQ5k/QV+U
	MD7N7B/EBpLQogc0sOalz1ZljdBYFRp/lEMhNROJ/HGOP7MVGO8nWnb/uQBhbh1Y
	0qMrOkSn6wr+fYD3Q7yYoaM5ovoyyksxRhFL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C9tMaHU8FzcBV/ZdHYI+Bvqul5UKXUNd
	yLKbBBgmBwltQo6wwrsBotEZOiP1tp6S/5gM6XszC8aA9ZpkRqoyzKJYpExvfmlB
	x6XpSIOR1qW2HwsQc5yfraUwRkDXK3DudtRgoEMWpfLmC3DSVpz+Fv8dIhpTmdKa
	Aba6gGISIrM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3A4C3684;
	Tue,  7 Dec 2010 18:36:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 53C8C367F; Tue,  7 Dec 2010
 18:36:33 -0500 (EST)
In-Reply-To: <1291657790-3719-6-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Mon\,  6 Dec 2010 18\:49\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D6FBF13E-025A-11E0-AFB4-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163147>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> +	# if the linked executable doesn't match a browser name we know about,
> +	# look at the version string
> +
> +	# even though most browsers (and applications, in fact) will show their
> +	# name and version on the first line of the --version output, this is
> +	# not true in particular for the KDE apps (e.g. konqueror and kfmclient),
> +	# which display their name and version on the LAST line. So we cannot
> +	# clip the version string at the first line when retrieving it. Rather,
> +	# we keep it whole and then limit it when we know what we're dealing with.

I'd be more worried about the ones that do not understand --version and
spawn a new window.

> +	verstring="$("$testexe" --version 2> /dev/null)"
> +	browser="$(echo "$verstring" | head -n 1 | cut -f1 -d' ' | tr A-Z a-z)"
> +	case "$browser" in
> +		mozilla)

What was the first patch in this series about again ;-)?

> +			verstring="$(echo "$verstring" | head -n 1)"
> +			browser="$(echo "$verstring" | cut -f2 -d' ' | tr A-Z a-z)"
> +			;;
> +		google)
> +			verstring="$(echo "$verstring" | head -n 1)"
> +			browser="google-chrome"
> +			;;
> +		qt:)
> +			# konqueror, kfmclient or other KDE app
> +			verstring="$(echo "$verstring" | tail -n 1)"
> +			browser="$(echo "$verstring" | cut -f1 -d:)"
> +			;;
> +		*)
> +			verstring="$(echo "$verstring" | head -n 1)"
> +			;;
> +
> +	esac
> +	if valid_tool "$browser" ; then
> +		browser_path="$i"
> +		return 0
> +	fi
> +
> +	echo >&2 "$testexe (detected as $browser) is not a supported browser, skipping"
> +	browser=""
> +	return 1
> +}

Sorry, but I simply do not think it is worth this ugliness to get slight
customization between -new-tab, newTab, and nothingness.
