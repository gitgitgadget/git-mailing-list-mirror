From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Instruct git-completion.bash that we are in test mode
Date: Mon, 21 Jan 2013 20:31:45 -0800
Message-ID: <7vham9dej2.fsf@alter.siamese.dyndns.org>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 22 05:32:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxVWs-0003bR-3o
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 05:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab3AVEbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 23:31:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404Ab3AVEbs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 23:31:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AF2FC95F;
	Mon, 21 Jan 2013 23:31:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3kWakuSs1jMeFAFQpK5cs3C3VrA=; b=gMX6sI
	T/3RzG8HtAfWtwIfmpOiHxHIsQlNun3TlApcR0Zil/VSsndNJ1Yu5j832d5zVzxt
	FtwyY7J6iowdlUomi33yymJnaKLmC59rzogSxCX00E3htZHHKyzqoFI/uSWq2cDf
	jbTv+I3AwJMi0uuFoemYq0s+yta5FwCKmVjCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dpv1VSsudufVaJQIoMtUWfQgW1OYyB2o
	/0jFjZyejWksWYypu3RbN1rdfjWWrASL4XpEw6hdvGi6DKjZ94tuJGj2RdeIoQ5d
	OAtNDx1UsefgXCvLPAtlb5WaBvjWD4a009OC+SrBMkjssXAvyA/UhtkjaPL0rbG6
	7s/8MBnudEE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3F43C95E;
	Mon, 21 Jan 2013 23:31:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81C53C95B; Mon, 21 Jan 2013
 23:31:47 -0500 (EST)
In-Reply-To: <20130122003954.GA23297@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 Jan 2013 19:39:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2288642-644C-11E2-94B3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214192>

Jeff King <peff@peff.net> writes:

> I really hate to suggest this, but should it be more like:
>
>   if test -z "$FAKE_COMMAND_LIST"; then
>           __git_cmdlist() {
>                   git help -a | egrep '^  [a-zA-Z0-9]'
>           }
>   else
>           __git_cmdlist() {
>                   printf '%s' "$FAKE_COMMAND_LIST"
>           }
>   fi
>
> That gives us a nice predictable starting point for actually testing the
> completion code. The downside is that it  doesn't let us test that we
> remain compatible with the output of "help -a".

Yeah, I think this is simpler and more to the point for the test in
t9902.  If we really want to test something that is the same as, or
at least any closer than this approach (or my "help --standard"), to
what the real users use, the test has to become inherently flaky, so
I think we should go for the simplicity of this patch shows.
