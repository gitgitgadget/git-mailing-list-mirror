From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] run_hook: use argv_array API
Date: Wed, 14 Sep 2011 11:54:11 -0700
Message-ID: <7vty8ft0oc.fsf@alter.siamese.dyndns.org>
References: <20110913215026.GA26743@sigill.intra.peff.net>
 <20110913215824.GG24490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3ubD-0000R7-8H
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab1INSyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:54:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757306Ab1INSyN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:54:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69A1052E4;
	Wed, 14 Sep 2011 14:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iU6DbWAnvjnYsLE7KWDcF4SWYYI=; b=pgC7pN
	2e39w9i45ctkyvtSoiaquDeyCqJlX1GeSmfiyFgbv7RXm2te5DeEqFQHd9iRenyT
	Sim7t0p/tQ1yMoCO7LkJWzUG3AW2JBB6weWQL7/x5v+X6y17NQLHO6izR0d70EzW
	3eqS9NhspDmzQHc934WvjJx4t5KJTdKgdc8LY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o8Q9NOoBW6GcyF0I0Zs9TVwtXdJTR+Et
	Z+hbr2nPECEmpEFd0RW7YpVd3vRaN8OsWo7EXKU1j9hfiqlUAmMVYjecooMMAOTH
	YK/884vT+g1At5KzSK2YYLlKPS0kgXuHAMHoXKClc/JUyiEewx2Hb6Lldgp89+mq
	UGKQcDCIOto=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6239552E3;
	Wed, 14 Sep 2011 14:54:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D20F852E2; Wed, 14 Sep 2011
 14:54:12 -0400 (EDT)
In-Reply-To: <20110913215824.GG24490@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Sep 2011 17:58:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFE38C4A-DF02-11E0-A90E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181382>

Jeff King <peff@peff.net> writes:

> @@ -609,26 +610,23 @@ int finish_async(struct async *async)
>  int run_hook(const char *index_file, const char *name, ...)
>  {
>  	struct child_process hook;
> -	const char **argv = NULL, *env[2];
> +	struct argv_array argv = ARGV_ARRAY_INIT;
> +	const char *p, *env[2];

Given that in argv-array.h you define it as

    #define ARGV_ARRAY_INIT { empty_argv, 0, 0 };

the above will introduce decl-after-stmt.
