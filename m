From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving the git remote command
Date: Tue, 26 Aug 2014 10:24:35 -0700
Message-ID: <xmqq7g1vjh9o.fsf@gitster.dls.corp.google.com>
References: <53FC537C.4080206@gmail.com> <20140826124027.GE29180@peff.net>
	<CAGK7Mr7BPvV6oO_t4x_1m9sDtWBgPWUqDq+3kZx6rVYAhY+wqA@mail.gmail.com>
	<20140826163741.GA14983@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?Q?R=C3=A9my?= Hubscher <hubscher.remy@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:24:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKUF-0003bn-VT
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbaHZRYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 13:24:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58061 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbaHZRYr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:24:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9AB2D32F32;
	Tue, 26 Aug 2014 13:24:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rzDvjGwnoTqlDnX/OzCzPan/xnY=; b=Pn390Z
	8/wog0ZFNnUFh6CLm/Po6WcveuNzu48zmv6pnk/tw4dbpmy8IaC2NkPDSbpIKOg4
	+keZASiOFDfTyyQ1SW3mv7VoOR52p5qa67kACPVCejufAOmfrFzRvmOyR0dyZBhI
	PjDUV01JdXlBoyc31T4b4siXAstVuBuOyRkkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uVOO6T3caC3kNWTNCdgI7ULj7uh6xya9
	Y1w1ezHfMjc3vmQaG99Hw4Jl2WHOBpyFA0yO5BxuKGnUXxefg2MZBgk0vZS4uTi6
	cKiP/yXCssrH+vX1blsXg1PfjxH+EPRkDbP8MdeyKyM9XNkE2jW51rQD6RXIKeO1
	P+jss/+lV68=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EB0E32F31;
	Tue, 26 Aug 2014 13:24:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6226032F1D;
	Tue, 26 Aug 2014 13:24:37 -0400 (EDT)
In-Reply-To: <20140826163741.GA14983@peff.net> (Jeff King's message of "Tue,
	26 Aug 2014 12:37:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DAC2E448-2D45-11E4-92B4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255922>

Jeff King <peff@peff.net> writes:

> ... But we are left with three options:
>
>   1. Add "git remote list" with verbose output. This is bad because it
>      differs gratuitously from "git remote".
>
>   2. Add "git remote list" with non-verbose output. This is good because
>      it means "git remote" is just a shortcut for "git remote list",
>      which is consistent with other parts of git. But it is potentially
>      bad if "-v" is a better output format.
>
>   3. Add "git remote list" with verbose output, and tweak "git remote"
>      to match. This is bad because it breaks backwards compatibility.
>
> The proposal is for (1). I think we agree that (3) is out. The question
> is whether (1) or (2) is the least bad.

I would imagine that those who want list of remotes programatically
would read from "git config" output and it would be with less
friction to change the output from "git remote", a command that is
solely to cater to end-user humans, to suit people's needs, so I am
not sure if (3) is immediately "out".

Having said that, my preference is 

    0. Do nothing, but document the "default to listing" better if
       needed.

and then 2. above, and then 1.

> Yeah. Branch and tag need dashed subcommands because otherwise it is
> ambiguous with creating tag called "list", functionality that existed
> before "--list" was added. Git-remote was defined with subcommands from
> day one, so it can get away with it. Git-stash is sort of in the
> category as git-remote there, except that "save" can actually take an
> argument. So to provide it you can't say "git stash foobar", but instead
> have to say "git stash save foobar" (it actually used to allow the
> former, but you can imagine the annoyance when you typo "git stash
> lsit").

Yeah, and there also is this one:

  http://thread.gmane.org/gmane.comp.version-control.git/231376/focus=231478
