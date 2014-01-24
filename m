From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 13:08:42 -0800
Message-ID: <xmqqeh3xqe91.fsf@gitster.dls.corp.google.com>
References: <20140124090104.GA396@x4>
	<0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
	<20140124170739.GC396@x4> <20140124170909.GD396@x4>
	<20140124182341.GB8202@sigill.intra.peff.net>
	<20140124183222.GE396@x4>
	<20140124185538.GA9836@sigill.intra.peff.net>
	<xmqq4n4trvzj.fsf@gitster.dls.corp.google.com>
	<20140124204825.GA17167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>,
	Jim Garrison <jim.garrison@nwea.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 22:08:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6nzh-0007kw-LN
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 22:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbaAXVIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 16:08:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbaAXVIq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 16:08:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A644645B3;
	Fri, 24 Jan 2014 16:08:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=khXkmCIAMsNeQKNkKmRRI+rObU0=; b=g6jy2D
	qSecqz4YKkJEdqjplw8F0FLWFcfXxSFDfgy9OW8sdBCHwtEqHBOqeat3sfpRUMni
	hMBqYo23ZK0kGsYH5EtPwLzWveocWAqpnEXK48CAHxdSngY4Ct2GdmGwx1O4Q/Ue
	QxRAi42UnsB1HF4fSiGRyeUdM7UmgTQhy3QgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wesAvfYfIZUhH3gXviXLb4tBxmG4pfGa
	hJjN8HhKS9WcMVEgjzP9fGC+NOgU5kcTjUM121LVdl+3usI+r5m24Gu2hJhqa0eA
	EXzMvSFHrWhDsOeFxUJ/BEVq2DxEZ9P3o8bbXBqSF7emwBw3bFwwCCz7P2vMIaX5
	wkiiM5jqbv0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DBCD645B2;
	Fri, 24 Jan 2014 16:08:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C482645B0;
	Fri, 24 Jan 2014 16:08:45 -0500 (EST)
In-Reply-To: <20140124204825.GA17167@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 24 Jan 2014 15:48:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B6182642-853B-11E3-AE70-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241042>

Jeff King <peff@peff.net> writes:

> I had imagined a "not" token at the front of the refspec, like:
>
>   git fetch origin +refs/heads/*:refs/remotes/origin/* ^refs/heads/foo
>
> In this case, a colon in the refspec would be an error. An alternative
> would be:
>
>   git fetch origin +refs/heads/*:refs/remotes/origin/* refs/heads/foo:
>
> I.e., to say "put foo to nowhere". But generally refspecs do not affect
> each other.

Not really.  You do not have to view it as "'not refs/heads/foo' is
affecting the previous '+refs/heads/*:refs/remotes/origin/*'".

You can think of two refspecs "refs/heads/foo refs/heads/bar" are
both affecting the "end result"; so far we only had a single way for
multiple refspecs to affect the end result and that was a "union".
Introducing "subtract" as another mode of combining is not too bad,
I would think, at the conceptual level.

> ... Making the "null destination" work
> differently might be confusing.

I tend to agree that "refs/heads/foo:" is being too cute and may be
confusing, at least if it will be the only way to express this in
the end-user-facing UI.  Even some people were confused enough on a
very sensible "push nothing to ref means deletion" to make us add
another explicit way, "push --delete", to ask for the same thing.
