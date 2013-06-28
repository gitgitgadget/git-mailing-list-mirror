From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: Skip pack-*.keep files when cloning locally
Date: Fri, 28 Jun 2013 11:38:10 -0700
Message-ID: <7vvc4ynkrx.fsf@alter.siamese.dyndns.org>
References: <1372430538-19216-1-git-send-email-jl@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johan@herland.net
To: Jens Lindstrom <jl@opera.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 20:38:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsdYt-0006Jr-4B
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 20:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab3F1SiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 14:38:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab3F1SiN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 14:38:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D30A32CD96;
	Fri, 28 Jun 2013 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E8i77xTqC99I6J1267sq4MZc4AU=; b=ZsAZCM
	5CZMmXRhvd8RbfCVNfGI9J/9T5ehxzQJyG9U9U3XU9+ClIktO8MrA5I96YEVmyZy
	5O/BbJgv/fLY3HByzKFqjI1jb3FbBpt6IF62n6UjkhUjyn9NO2314zbWflEXkwLT
	b3RAlpzOKDnEE4ZbS1E4IK6vynqsockRNmHgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eyrBh+qwp3cLUVawqjQWOIxGvKGUVphI
	EO9KntNsyHQFrnRuCuZH9b6djNWH255OAFxVovHfG6vllguRwxhnO5mBmjwa3j78
	g/UikInwTAG1ycdbs0LJguTOcTYahK0XMNZyL8bc9sbKQ46WrFe5mKzzEgDHBgTo
	QJNd6AwbVNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C76C42CD95;
	Fri, 28 Jun 2013 18:38:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 421F52CD94;
	Fri, 28 Jun 2013 18:38:12 +0000 (UTC)
In-Reply-To: <1372430538-19216-1-git-send-email-jl@opera.com> (Jens
	Lindstrom's message of "Fri, 28 Jun 2013 16:42:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3142340-E021-11E2-8B54-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229223>

Jens Lindstrom <jl@opera.com> writes:

Hmph.  I am of two minds here.

> The pack-*.keep files are temporary, and serve no purpose in the
> clone.

They are not temporary, actually.  A user can deliberatey create a
"keep" marker after packing with a good set of parameters, so that
the resulting pack will be kept, instead of letting a later repack
(with faster set of parameters) remove and replace it with less
optimal results.

> Worse, though, they are created with access bits 0600, so if the
> user trying to clone the repository is different from the user that
> caused the pack-*.keep file to be created, the clone will likely
> fail due to not being allowed to read (and thus copy) the file in
> the first place.

I am perfectly fine with a change that allows a local clone to skip
and not error out when such a "keep" marker cannot be copied, I do
not know if it is a good idea to unconditionally skip and not even
attempt to copy it.
