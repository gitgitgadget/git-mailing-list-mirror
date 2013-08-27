From: Junio C Hamano <gitster@pobox.com>
Subject: Re: the pager
Date: Mon, 26 Aug 2013 21:38:28 -0700
Message-ID: <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Tue Aug 27 06:38:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEB36-0006fy-PM
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab3H0Eid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:38:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373Ab3H0Eic (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:38:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18C9938C46;
	Tue, 27 Aug 2013 04:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nqOKlmGWFKEDL+niXcf3Cxa0dFo=; b=fEY9oX
	L/cUE5huuo485mgNTbXLUO6qBh22e7Zvjiu4dRF+/mEuJJAkyRDRlARx9C7ZxiXh
	jETBAdxfoohL+ClBiHrGzXVx8TJdn0+txOo5s0qVDilk/wmYa3vhquMCYLAqabPO
	3pq2OszvUdYrHEniyaDbXGSwlTsEecCz6n2lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MXn/TJdSJpxwGiZsFBOi/PI2FMN5kHLg
	zbCMWPjSTrwIxquHKtcmHK8nAcIcgByIogA8EY+QPU87qXy9n3OElqfq4LU45BWc
	qf/kqbWRFXmWyG0RE8pslg/IHkWagKPVIeyGiiy7QtfpmDCT33YX+c/S/BB5IBC8
	RudT1h2pHDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B9B838C44;
	Tue, 27 Aug 2013 04:38:31 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 592D438C3F;
	Tue, 27 Aug 2013 04:38:30 +0000 (UTC)
In-Reply-To: <201308261957.r7QJvfjF028935@freeze.ariadne.com> (Dale
	R. Worley's message of "Mon, 26 Aug 2013 15:57:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 85E7EBC2-0ED2-11E3-A03C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233072>

worley@alum.mit.edu (Dale R. Worley) writes:

> I've noticed that Git by default puts long output through "less" as a
> pager.  I don't like that, but this is not the time to change
> established behavior.  But while tracking that down, I noticed that
> the paging behavior is controlled by at least 5 things:
>
> the -p/--paginate/--no-pager options
> the GIT_PAGER environment variable
> the PAGER environment variable
> the core.pager Git configuration variable
> the build-in default (which seems to usually be "less")
> ...
> What is the (intended) order of precedence of specifiers of paging
> behavior?  My guess is that it should be the order I've given above.

I think that sounds about right (I didn't check the code, though).
The most specific to the command line invocation (i.e. option)
trumps the environment, which trumps the configured default, and the
hard wired stuff is used as the fallback default.

I am not sure about PAGER environment and core.pager, though.
People want Git specific pager that applies only to Git process
specified to core.pager, and still want to use their own generic
PAGER to other programs, so my gut feeling is that it would make
sense to consider core.pager a way to specify GIT_PAGER without
contaminating the environment, and use both to override the generic
PAGER (in other words, core.pager should take precedence over PAGER
as far as Git is concerned).
