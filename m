From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] repack: rewrite the shell script in C
Date: Tue, 17 Sep 2013 11:17:13 -0700
Message-ID: <xmqqy56vxqhi.fsf@gitster.dls.corp.google.com>
References: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 20:17:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLzpx-0004cW-K5
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 20:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007Ab3IQSRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 14:17:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab3IQSRR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 14:17:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB76042AC3;
	Tue, 17 Sep 2013 18:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LiOkifNOnAimcFwc8ndf8gU9mu0=; b=RHl1pr
	vrIxlIb0Pwf9TuMTWjQSmAi6Puu4DDnjqLgM2Ik5Q2GBdVv9g4K5iND10StqfeIK
	uroFNHTgta9d6GVpwujeTwECe+07Nb+kjy9t89oj3bn8VWJeECglRzWjJKTtG8I7
	WEKMuUVbO9v2hBeJcZo09CjDEYdVmJNQvxlGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uFrPBc5vT9kobo64cgQl2Bjeae6hB/6T
	GhfnmYr1eXNLgjrhLTP0iIL3ZmNMCZmud00uPEDrI6d+fDArH7NMPmSAd7oJJtjF
	V5ILcUeEOM4KuLtV6P6MRx3ALn6JKbQAUvjDxotq8vprD5mSnOJKEMyqDrKhhMZu
	uaiv5uLEZhE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEB7742AC2;
	Tue, 17 Sep 2013 18:17:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27F4842ABE;
	Tue, 17 Sep 2013 18:17:16 +0000 (UTC)
In-Reply-To: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Sun, 15 Sep 2013 17:33:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 61D6C682-1FC5-11E3-B5DB-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234900>

Stefan Beller <stefanbeller@googlemail.com> writes:

> +	struct option builtin_repack_options[] = {
> +		OPT_BIT('a', NULL, &pack_everything,
> +				N_("pack everything in a single pack"), ALL_INTO_ONE),
> +		OPT_BIT('A', NULL, &pack_everything,
> +				N_("same as -a, and turn unreachable objects loose"),
> +				   LOOSEN_UNREACHABLE),

Micronit.

With the current version of the code in cmd_repack() that uses the
pack_everything variable this may not make a difference, but I think
this should logically be "LOOSEN_UNREACHABLE | ALL_INTO_ONE" instead,
and the code should check (pack_evertying & ALL_INTO_ONE) instead of
checking "!pack_everything".  You may want to add to this flag variable
a new bit that does _not_ cause it to pack everything into one.
