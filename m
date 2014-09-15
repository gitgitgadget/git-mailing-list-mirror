From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 01/11] trailer: add data structures and basic functions
Date: Mon, 15 Sep 2014 13:39:25 -0700
Message-ID: <xmqqsijs4o02.fsf@gitster.dls.corp.google.com>
References: <20140915052330.26573.34823.chriscool@tuxfamily.org>
	<20140915053142.26573.86374.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 22:40:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTd45-0006nh-Lb
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 22:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbaIOUj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 16:39:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61071 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755928AbaIOUj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 16:39:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7FD23B846;
	Mon, 15 Sep 2014 16:39:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XD2Ljj1NlTmOAFDZcaOJzogESm4=; b=v5ajcJ
	zr+N1+4WNPZdFqWqnEP8vTBD8DCzlNkXVFt/Vxt/KHXbevkJqMTKzySTJGo9ilTd
	nbOh1F1bBdku6tVI9OlGNdct0+jx3k0W4/EeaO+vw4kRFe7ePrH4GFdrfiQlMM77
	xmcJ1obUZw+UBxHdRvt33kxRmoq4qtMGRevHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWMAwnMfmzWnePQwiLurIdr36qI/c1e5
	INKIFqk+xZ3/9WMhPFHQWXnMkkBf754/MgyUtMETIY0zlY3if8lrlKB1+pPLp8b7
	KBhTV7vla4VABDnJ5OZi0sGn9tix3eWz2dzKFwezcGTE38CiXfM1KNGuobbRXlK8
	l9VLESSwjPs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBABD3B845;
	Mon, 15 Sep 2014 16:39:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 262343B843;
	Mon, 15 Sep 2014 16:39:27 -0400 (EDT)
In-Reply-To: <20140915053142.26573.86374.chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 15 Sep 2014 07:31:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 62B3DAC4-3D18-11E4-A15B-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257080>

Christian Couder <chriscool@tuxfamily.org> writes:

> +/* Get the length of buf from its beginning until its last alphanumeric character */

That makes it sound as if feeding "abc%de#f@" to the function returns
3 for "abc", but

> +static size_t alnum_len(const char *buf, size_t len)
> +{
> +	while (len > 0 && !isalnum(buf[len - 1]))
> +		len--;
> +	return len;
> +}

doesn't it look at '@', be unhappy and decrement, look at 'f' and
break out to return the length of "abc%de#f"?

Perhaps that behaviour _is_ what you want, but then the comment is
lying, no?
