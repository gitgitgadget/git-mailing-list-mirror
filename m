From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] config: add include directive
Date: Mon, 06 Feb 2012 14:39:41 -0800
Message-ID: <7v62fj60ya.fsf@alter.siamese.dyndns.org>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095404.GB4300@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 23:39:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuXDw-000515-J8
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 23:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399Ab2BFWjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 17:39:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753869Ab2BFWjn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 17:39:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DB39728A;
	Mon,  6 Feb 2012 17:39:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O9SnS5XG1wc1itYIiWRpIP+wyHQ=; b=eRltAf
	fT2dPU1Wqh1w5Iej1ci8p/k4zLuV/UbtJTKTbcp0SgobyIetKmwLiBMh+UyoMst2
	ndIE8QQsn0BGsag1ldbN7RIoZgwmD4n7FzkISF8MVpilGuEN8qrwKrYeifBBCwPA
	ACPN/X1USDIpW/6axC81oUzrpYHr5anA9cMoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cq0bxuPDqD4fNkz3ZX2ryHPvPHX9BuZD
	1Ry+7ptYUC0Mi6e7NcdW831o595blk+1Fq1g3AKNIMCc09MdbgstCzszy/1CE5xu
	tVevh/RU+sMtB8bmbBOUoo/kqZ+UkNJ1ah2WtogLGhHiEvn8pWf5152H58S3Epa0
	Zuwd/O2fnPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2428B7289;
	Mon,  6 Feb 2012 17:39:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD77C7288; Mon,  6 Feb 2012
 17:39:42 -0500 (EST)
In-Reply-To: <20120206095404.GB4300@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Feb 2012 04:54:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76348FA6-5113-11E1-8455-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190116>

Jeff King <peff@peff.net> writes:

> +Includes
> +~~~~~~~~
> +
> +You can include one config file from another by setting the special
> +`include.path` variable to the name of the file to be included. The
> +included file is expanded immediately, as if its contents had been
> +found at the location of the include directive. If the value of the
> +`include.path` variable is a relative path, the path is considered to be
> +relative to the configuration file in which the include directive was
> +found. See below for examples.

If the file referenced by this directive does not exist, what should
happen?  Should it be signalled as an error?  Should it stop the whole
calling process with die()?

I think "die() when we are honoring the include, ignore when we are not"
would be a good way to handle this, as it allows us to catch mistakes
while allowing the user to fix broken configuration files using "git
config --unset include.path", but I may be overlooking something.
