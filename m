From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep: search whole tree by default?
Date: Thu, 24 Oct 2013 12:40:44 -0700
Message-ID: <xmqqd2muo3sz.fsf@gitster.dls.corp.google.com>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
	<vpqbo2guff7.fsf@anie.imag.fr>
	<xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
	<87hac7hmrb.fsf@mcs.anl.gov>
	<xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
	<87zjpzg592.fsf@mcs.anl.gov> <vpqy55jogzr.fsf@anie.imag.fr>
	<20131024022736.GA24992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jed Brown <jed@59A2.org>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 24 21:40:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZQm4-0001US-6s
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 21:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab3JXTks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 15:40:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33358 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754997Ab3JXTkr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 15:40:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64EC34DAED;
	Thu, 24 Oct 2013 19:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5a+D47Y3Evw7TMK1SbmlSfjLr+c=; b=U/UHVn
	0o+Vt4w6sYrEovnK+6rat5SR6uryWCp/ApNz+BvsMq3oaD+pdJOAB5i0vX5XvP+6
	E9s66q+OPZLyuu5oltqXKA3j2wy3UgtMClL565Jjrrb2VtE5BHL9U+IfTBFBmrxg
	7IgwajWs6ky/uR1yneV30O+JsPM0dkUAEioL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LHD4SGmIYVtx6ypgys5VT0GUtY+pzwmX
	RqinWzTquy/rePejV5ko3Gode2didXZHUxXpzIn3Jduo/BJWXTA35EEta8vQzHme
	M0WomL8TtxXHkO8GXlSYJlaDCwfD3AUEUCi1M3lq/lQ8fevi6hrKbGIKcGQj2H/2
	NiVq7iP1EjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4925F4DAEC;
	Thu, 24 Oct 2013 19:40:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D9F64DAE7;
	Thu, 24 Oct 2013 19:40:45 +0000 (UTC)
In-Reply-To: <20131024022736.GA24992@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 23 Oct 2013 22:27:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2D018906-3CE4-11E3-B7DA-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236612>

Jeff King <peff@peff.net> writes:

> That would also provide people who do not like the change of default an
> escape hatch to keep the current behavior. And I do not think scripted
> use will be inconvenienced; they will already have to use "." or ":/" to
> be explicit (if they care) since the behavior is changing.

There is a big difference between "scripted use will have an escape
hatch" and "scripted use will not be inconvenienced".  We *know*
scripts will be inconvenienced with or without such a configuration
variable, as they *have* to be updated if they rely on the current
behaviour of "git grep" that limits its search to the current
directory when fed no pathspec (and if their users want to keep the
current behaviour of such scripts).  Anything short of a warning (or
even erroring out) that is designed to annoy the users during the
transition period will help ease the pain of transition of scripts.

An annoying warning still can only *ease*, but cannot eliminate, the
pain of transition. The scripts need to be updated to adjust to the
new behaviour; there is no getting around to it.

Even if we ignore the "helping your colleague at her terminal", cf.

    http://thread.gmane.org/gmane.comp.version-control.git/133570/focus=133683

issue for now, adding a new configuration variable from day one
makes the transition of scripts somewhat worse, I am afraid.  Doing
so robs us a way to add such an annoying warning to help people
foresee problems in their existing scripts before the default
changes (the configuration presumably will disable the "this command
line will behave differently after the default changes" warning).

As I said, I think we can train people without an annoying warning,
as hits outside their current directory will serve as an annoyance
already, and people who set such a configuration in their repository
(or $HOME/.gitconfig), get used to the chosen behaviour too much,
and get surprised when they get to use a vanilla intallation of Git
(either helping colleague or setting up a new work environment) have
only themselves to blame, so it may not be too big a deal.

But I do not think the same reasoning extends to scripted uses X-<.
