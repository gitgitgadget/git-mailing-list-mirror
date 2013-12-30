From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] trailer: add tests for "git interpret-trailers"
Date: Mon, 30 Dec 2013 09:19:55 -0800
Message-ID: <xmqq1u0utfwk.fsf@gitster.dls.corp.google.com>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
	<20131224063726.19560.61859.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 18:20:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxgVj-0006Hw-E4
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 18:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297Ab3L3RUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 12:20:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932291Ab3L3RT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 12:19:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D573E5E59B;
	Mon, 30 Dec 2013 12:19:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=23FGC0HGFP6orT3ffKfpAgIchDQ=; b=rqDaOv
	fQ+g4YOMxTxbPkFFCJL5xMZFhEiEKRSSxKLhgN8K98B/dvuuNe9b9hbPra1AJv8H
	EWux6UeMGNZZvLfymt5EsbcAU1D9HU3S5GCoVtjpOzH1GdIoaqwcKw5YGhcilBKX
	uBqN1o22kH7aQuMO43oOC/f9T9pqGU2B1FVMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jYfh9VuIj2iokR8fucTDBNhfry3fSQNA
	ka7Vc1M3uqPlwkfarXRJ5N4/jTnGImg0tDVh51lFZo4tkQLiefyjjkISjcYjglbL
	o7iZOLrNXCCfMhm9rqhvcLfeGyI8sm0o+g9ZSJofVihyfJT+eF8FuvZJpC7Ff3QE
	fbsidosCNg4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C71675E59A;
	Mon, 30 Dec 2013 12:19:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A4F45E597;
	Mon, 30 Dec 2013 12:19:57 -0500 (EST)
In-Reply-To: <20131224063726.19560.61859.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 24 Dec 2013 07:37:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9B018D72-7176-11E3-8F01-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239810>

Christian Couder <chriscool@tuxfamily.org> writes:

> +# Do not remove trailing spaces below!
> +cat >complex_message_trailers <<'EOF'
> +Fixes: 
> +Acked-by: 
> +Reviewed-by: 
> +Signed-off-by: 
> +EOF

Just a hint.  I think it is far safer and robust over time to do
something like this:

	sed -e 's/ Z$/ /' <<-\EOF
        Fixes: Z
        Acked-by: Z
        EOF

instead of a comment, which can warn human developers but does not
do anything to prevent their editors' auto-fix features from kicking
in.
