From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: make prune work for mixed mirror/non-mirror repos
Date: Thu, 20 Jun 2013 16:36:01 -0700
Message-ID: <7vd2rgpd7i.fsf@alter.siamese.dyndns.org>
References: <1371763424.17896.32.camel@localhost>
	<1371766304-4601-1-git-send-email-dennis@kaarsemaker.net>
	<7vppvgpfib.fsf@alter.siamese.dyndns.org>
	<20130620230843.GA5780@sigill.intra.peff.net>
	<1371770988.17896.58.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 01:36:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpoOg-0006Lu-0N
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 01:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965509Ab3FTXgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 19:36:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965269Ab3FTXgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 19:36:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51B4F2A1A5;
	Thu, 20 Jun 2013 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jDXRPChP5REiMlzA9j24ew9VBng=; b=Jh7k9m
	CAwdlquc2eOzYRhCN3mne5Ve6IkyKjt92qWjkN5dS85HyHZYPADDVEldGhoTXJnF
	gCAYWtmMNTqcgP+5VstYAk/zENCETK0qfsVK9TZVzHXKNp2AVR1+QddFgoEnwwGW
	PIvRAj0WPp5FFo+Tenx/vBS0CQLURawYzkIOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=baSqoxwfNKBgp+sE7Lwp5zwauH7YTzWr
	wLPSauxCadqOsStzMWfjmpdJER6HjihuvBG6jWvA5DnnddNzgn+t4Ww7HcjMeccw
	BZAH+USIHT4EDOtBF9/QKMEPob4Cklsy/m/WZXN48tt7G8NwmwJh7qlJdJqql5u8
	Iq8DIsYtkfs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45C562A1A4;
	Thu, 20 Jun 2013 23:36:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3AB42A1A3;
	Thu, 20 Jun 2013 23:36:02 +0000 (UTC)
In-Reply-To: <1371770988.17896.58.camel@localhost> (Dennis Kaarsemaker's
	message of "Fri, 21 Jun 2013 01:29:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B5C349C-DA02-11E2-A239-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228560>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> I'm not doing that in non-bare repositories, neither do I use it for
> pushing. It's for a continuous integration system, which never has any
> locally created branches or commits, but does integrate things from
> different remotes in some cases.

Perhaps then

	[remote "origin"]
        	url = somewhere
                fetch = +refs/heads/*:refs/heads/*
                fetch = +refs/tags/*:refs/tags/*
	[remote "another"]
               	url = somewhere-else
                fetch = +refs/heads/*:refs/remotes/another/*
	[remote "third"]
               	url = third-place
                fetch = +refs/heads/*:refs/remotes/third/*

would be sufficient?  You may not even need tags, but that is an
independent issue.
