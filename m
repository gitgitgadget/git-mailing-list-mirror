From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] check-headers: add header usage checks for .c files
Date: Mon, 15 Sep 2014 12:14:43 -0700
Message-ID: <xmqqr3zc66ho.fsf@gitster.dls.corp.google.com>
References: <1410680445-84593-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:14:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbje-0003cN-SV
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 21:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbaIOTOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 15:14:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52630 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbaIOTOq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 15:14:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEFBF3A1B9;
	Mon, 15 Sep 2014 15:14:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rqg04Dj1yrXZpD7kymCWzcw7w4Y=; b=uPHqhC
	Yz9izQMZA802NXM2JpzPLghlAGw1OZ5B1qU1kTcMIjTiec0igNOHOV6f9v5+PT7D
	RhpeG1Z2jA+GtCjMZ5ZJ/bKJ4iwBSrOTgmDW1fxTyomaWMxikp5g/JDDb6DqOfBU
	HYbMo7HifJ4QziqR7F9oZePTRB9411BQ/nAyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gsz0zIoFiGgicPlOO4nKJAEId2nj7F7B
	HsC3UDGPUtDaFpej4/aAhA2jOQW+8oI7ZmFF/6HauwASlSiGPs8BgAwBrguGD5xr
	PZ5yUUTbAEOncgz5dXaWGRnyTrrmfMeQ1cy32Vy2BM6+K6iwqGl+4Wtg7FI/OkWu
	0SvKzD9cpT0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3F623A1B8;
	Mon, 15 Sep 2014 15:14:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 459893A1B5;
	Mon, 15 Sep 2014 15:14:45 -0400 (EDT)
In-Reply-To: <1410680445-84593-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sun, 14 Sep 2014 00:40:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8DA0F958-3D0C-11E4-8211-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257073>

David Aguilar <davvid@gmail.com> writes:

> +check_header_usage () {
> +	first=$(grep '^#include' "$1" |
> +		head -n1 |
> +		sed -e 's,#include ",,' -e 's,"$,,')

perhaps a single "sed" invocation suffices?

	sed -n -e '/^#include/{
        	s/#include ["<]\(.*\)".*/\1/p
                q
	}' "$1"
