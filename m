From: Junio C Hamano <gitster@pobox.com>
Subject: Re: https_proxy and libcurl
Date: Fri, 22 Feb 2013 13:55:08 -0800
Message-ID: <7v7gm0c8ub.fsf@alter.siamese.dyndns.org>
References: <CABURp0qQ6tO0B4Ya6OStX59SJqG-Jx1F4g6MUL7tVwR_6VgDhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 22:55:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U90af-0004CM-GP
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 22:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979Ab3BVVzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 16:55:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756894Ab3BVVzL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 16:55:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2043B3BF;
	Fri, 22 Feb 2013 16:55:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOaGYJaIBhCDevuD4kKb2MMIjvQ=; b=J16Jz/
	6hnw5dbSOltcod4Vk68kfnVcQnOoVapXaNswx/2AS8ym95/mDDU85Qy4VhTQunqI
	lm/J3kwQPnAwYUctRwow0nJZgISkw1dTcF6aRWCJCeb4mICsdSNVcJ4iT4KYg8Xz
	eELlbR6twNtk72V+vHMXlkaotunxtoh9T4fS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KrWv2loMqaP6M6slmoBGdYiuY4Lyue2K
	OFWMu45c//o/R/HKFBSL0cvZpfZ0+BbhArhFyZagYS4JnOA9jBjLRcT4+XUTZ30x
	9/onPFu/a3wq8cIknRWA+KnG/s6Akp9fyb3DzoIJ/TuFy/unbdIhpcFQEPdH2MCk
	rTWehBErYxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9462AB3BD;
	Fri, 22 Feb 2013 16:55:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F336EB3BC; Fri, 22 Feb 2013
 16:55:09 -0500 (EST)
In-Reply-To: <CABURp0qQ6tO0B4Ya6OStX59SJqG-Jx1F4g6MUL7tVwR_6VgDhw@mail.gmail.com> (Phil
 Hord's message of "Fri, 22 Feb 2013 16:19:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86F0CD24-7D3A-11E2-8DD5-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216866>

Phil Hord <phil.hord@gmail.com> writes:

> I have been unable to clone via http proxy because of a wrongly
> configured proxy setup in my lab.
>
> I had this env:
>
>     http_proxy=http://proxy.myco.com
>     https_proxy=https://proxy.myco.com
>
> The problem is that libcurl ignores the protocol part of the proxy
> url, and it defaults to port 1080. wget honors the protocol specifier,
> but it defaults to port 80 if none is given.

IIRC, the historical norm is to set these to <host>:<port>.

So many people mistakenly write them with <method>:// that some
tools over time learned to strip and ignore that prefix, though.

> The fix was to specify the port explicitly, like this:
>
>     http_proxy=proxy.myco.com:80
>     https_proxy=proxy.myco.com:443

Yeah, that is the correct syntax to use.  Is there anything you want
Git to do to be more helpful?
