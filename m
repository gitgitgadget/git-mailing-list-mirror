From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 09/11] trailer: execute command from 'trailer.<name>.command'
Date: Wed, 05 Mar 2014 14:57:14 -0800
Message-ID: <xmqqvbvsz22d.fsf@gitster.dls.corp.google.com>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
	<20140304194810.14249.44355.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:57:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLKkg-0002Ds-Bp
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 23:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757661AbaCEW5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 17:57:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756806AbaCEW5S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 17:57:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B8917002F;
	Wed,  5 Mar 2014 17:57:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lg8jH+D573H2XW9TUocg5tHyFrA=; b=vHnTZnkkC8W3Xp7/ZbFt
	cGz8G1EJrmsmWRDMqF1m6x7ffpiA6KjNT2u/wkOdlFpYloppubasTSm1F1VZwpKl
	9EyFjNDO5GtGPoebPHobgdDox25rIFpUDkSQbOZwi4LWz4NKfbpHCkwldyY526rg
	TChPMfARjyR5odLremJURn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=J7jWqAQ6c5ZtCQeyrTQLUnw0bOcbqStTeI1V2BzUie22U9
	LjRCXvqGR+SdLXYD5DeOc638hi6TLx8SekUTLEVHsq4kGdXrCMydALr1rPR+J6dm
	cG1yZ3pqNRUKmnM5QuvKIa4nzUYLlc+qWyTyWKocS73jzLZ87HcATdcGu2f9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E44BF7002E;
	Wed,  5 Mar 2014 17:57:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD84F7002B;
	Wed,  5 Mar 2014 17:57:16 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7FB85F5C-A4B9-11E3-A528-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243492>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/trailer.c b/trailer.c
> index ab93c16..67e7baf 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -490,12 +544,22 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
> ...
> +	/* Add conf commands that don't use $ARG */
> +	for (item = first_conf_item; item; item = item->next) {
> +		if (item->conf.command && !item->conf.command_uses_arg)
> +		{

Opening brace of a block sits on the same line as the closing
condition of the control.  I.e.

	if (...) {
