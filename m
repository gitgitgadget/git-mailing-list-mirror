From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Mon, 10 Feb 2014 10:14:34 -0800
Message-ID: <xmqq61omu96d.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.96525.chriscool@tuxfamily.org>
	<xmqqr47fx001.fsf@gitster.dls.corp.google.com>
	<20140209.145205.1882309246743951569.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 10 19:14:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCvNV-0008QX-Dd
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 19:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbaBJSOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 13:14:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43601 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbaBJSOk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 13:14:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05C7269A81;
	Mon, 10 Feb 2014 13:14:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IZglT2ZvBCcLYW+eP0FcbEe19XA=; b=WO8YVK
	qMXwSVB/myILxXB9xv1diZHzWnzrEtUJUAkhhv80yUzqJIt+nF6cVjJO032+Y34p
	QvXcprbY0SsoNuab5Zws1SWrNzaTzblhjmLRKTl/b/JoWgeXP9tRqVy9rW15lytw
	/G7BHEJqf5O+aQRETmY6RCqtSnRaIvqFLM03U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vtFZt8TmPAf75QqmSFUbjEr4Is9q3jaz
	aAiULb/ldgCWPdRF8gLGCtdr7v3kG0npHwA7SaGNPWYP/h0qX9potjD+qTK5A5MI
	7RgGJQA0XgpciS8NEZsGUXKpb04TGPU+XBkySYhx0BlSzvbQnuyybiBTayKhG1SX
	ZZvnDvvOm10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D82F669A80;
	Mon, 10 Feb 2014 13:14:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BB7869A7C;
	Mon, 10 Feb 2014 13:14:38 -0500 (EST)
In-Reply-To: <20140209.145205.1882309246743951569.chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 09 Feb 2014 14:52:05 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 33F5DF0A-927F-11E3-BD79-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241917>

Christian Couder <chriscool@tuxfamily.org> writes:

> This is what "if_exists" and "if_missing" are all about.
>
> Either:
>
> 	the same key already exists regardless of the value
>
> and, in this case, what happens depends on what has been specified using
> the "if_exists" configuration variable.
>
> Or:
>
> 	the same key DOES NOT already exists regardless of the value
>
> and in this case, what happens depends on what has been specified
> using the "if_missing" configuration variable.

Hmm, how should things like signed-off-by be handled?  You may want
to allow many entries with the same key with distinct values, but
duplicated values may want to be handled differently (currently we
only avoid to place a duplicate <key, value> consecutively, but keys
with different semantics (e.g. "fixes-bug: #bugid") may want to say
"unless the same key with the same value exists, append it at the
end".
