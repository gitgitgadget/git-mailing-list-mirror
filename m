From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] What to you think about a loose status for submodules?
Date: Thu, 22 Oct 2009 12:58:04 -0700
Message-ID: <7vvdi7fbg3.fsf@alter.siamese.dyndns.org>
References: <20091021160122.GA2067@book.hvoigt.net>
 <7vy6n4339k.fsf@alter.siamese.dyndns.org>
 <20091022194446.GA3944@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Oct 22 21:58:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N13ns-0007Tn-DW
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 21:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbZJVT6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 15:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756568AbZJVT6S
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 15:58:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512AbZJVT6R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 15:58:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D576E81402;
	Thu, 22 Oct 2009 15:58:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+rXjPnUQt8T0LOrzLapU0eePoCE=; b=mUdNnw
	OpyZPkaqbpVnLKf3vWEhWpHb/c/Wq6xZnmc+tpKj9nWX36T9kttaW6E4prXFkokN
	je8sV3hw77Ya+UMsoTyqM/ZJ+WYEv6d3uq/BdArU20hK3AdpB3RJnNMEHHfVl9p9
	XjURAhgbRFmPSodNF7LDF3M0QOXUkhz+bNz0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HdNOeVJA2k5JlDxddgdUm+yZ2fjQ9Owv
	qCYvbuDZHTMB5Sz2rfowzMs3VlmDF+9wGaM9bSKbjF+T9R3NoBGN55rp63KVHIAH
	7QbIJDfboC2ZnokGPgWAvKekSIIiu6BmkQ8jPMckLj5c+Wm3v3VT9cPchB3Vh901
	SDp2fj0RU2g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CD12813FF;
	Thu, 22 Oct 2009 15:58:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7DE22813FD; Thu, 22 Oct 2009
 15:58:10 -0400 (EDT)
In-Reply-To: <20091022194446.GA3944@book.hvoigt.net> (Heiko Voigt's message
 of "Thu\, 22 Oct 2009 21\:44\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D11631E-BF45-11DE-B46C-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131050>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> I am not sure what is the best way to create such a group mapping using
> our config files though. I would like to allow multiple groups/views to
> have the submodules like:
>
> [submodule "doc"]
> 	path = Documentation
> 	views = doc
>
> [submodule "help"]
> 	path = help
> 	views = doc
>
> [submodule "core"]
> 	path = core
> 	views = doc default
>
> [submodule "app"]
> 	path = app
> 	views = default
>
> What do you think?

That, or alternatively:

    [submodule "doc"]
        path = Documentation

    [submodule "help"]
        path = help

    [submodule "core"]
        path = core

    [submodule "app"]
        path = app

    [view "default"]
        modules = core app

    [view "doc"]
        modules = core doc help

Or even (mimicking the way how "git remote" defines remote groups):

    [submodule "doc"]
        path = Documentation

    [submodule "help"]
        path = help

    [submodule "core"]
        path = core

    [submodule "app"]
        path = app

    [submodule]
        default = core app
        doc = core doc help
