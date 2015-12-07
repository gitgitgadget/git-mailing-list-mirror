From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] clean: new option --exclude-from
Date: Mon, 07 Dec 2015 13:44:43 -0800
Message-ID: <xmqq1taylyr8.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cRa31uriO4qkZUydooNx0V+dNrUgFvTUxoLL9gCjq9AHQ@mail.gmail.com>
	<1449413906-23256-1-git-send-email-rouzier@gmail.com>
	<1449413906-23256-2-git-send-email-rouzier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: James <rouzier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a63aV-0003fx-4s
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 22:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbbLGVoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 16:44:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754994AbbLGVop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 16:44:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA4CF31C54;
	Mon,  7 Dec 2015 16:44:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CEkQVHJkVRELWLR3ViunmcqC448=; b=Y0XnJ+
	tn5e+fuPyTTNOsgrnxDGToUfzDSAFFD941vUyD4qaM0q7yacafwRLt2MDzeAwFoC
	6WNSb/R+VuIbI3WN7cokou0AbZRWRB2DRQNbWqGYvRShd9uHi4ekGddb93sf9KNC
	fPHLq1cb0JnGxnSgtQ+FdGL24pFj6IBhMmvuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wzo0kpS+Ms0iBkanvsA/k+r2nZfl3UPl
	XRJ9CsZxSPD4jnVnBfr8PUOIuME/av3Gi6Xw0uD37D5Y6Ik1ESHN1Xr9M0JShOQL
	K5sO+Chx5D3RPyMaGmpenvWVJFhvY7qPaRi+ANxLL96WxrWMhGMIkzoxUHOiE0XO
	Q3+YZqfS3y8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E186331C53;
	Mon,  7 Dec 2015 16:44:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5B46E31C52;
	Mon,  7 Dec 2015 16:44:44 -0500 (EST)
In-Reply-To: <1449413906-23256-2-git-send-email-rouzier@gmail.com> (James's
	message of "Sun, 6 Dec 2015 09:58:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA903BF6-9D2B-11E5-959A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282131>

James <rouzier@gmail.com> writes:

> +static int exclude_from_cb(const struct option *opt,
> +				     const char *arg, int unset)
> +{
> +	struct dir_struct *dir = opt->value;
> +	add_excludes_from_file(dir, arg);

I suspect this is wrong.  add_excludes_from_file() creates a
new excludes_list that is separate from the command line level and
pushes that down to the exclude stack.  You'd instead need to add
each line of the input at the same EXC_CMDL level like -e <pattern>
option does from the command line, I would think.
