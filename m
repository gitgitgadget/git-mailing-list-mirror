From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Thu, 05 Jul 2012 10:26:01 -0700
Message-ID: <7v3956rufq.fsf@alter.siamese.dyndns.org>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
 <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
 <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
 <20120703180439.GC3294@sigill.intra.peff.net>
 <CAKON4Oy0YBVTAhZPU=1B=yYY4t2O_uRWDW1zOMaC5iCb=kRQ2w@mail.gmail.com>
 <20120703184018.GB5765@sigill.intra.peff.net>
 <1341386512.3871.4.camel@flaca.cmartin.tk>
 <CABURp0rVPAvxP1sp_nmoNYd+F+OsvWeHgUAeo7-VTnQhdebFeg@mail.gmail.com>
 <1341472926.10752.5.camel@flaca.cmartin.tk>
 <CABURp0r8EfShHVE-Vycz3g8-WPXFzs1-WOT7LRwh-XOuWVYG+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeff King <peff@peff.net>,
	"jonsmirl\@gmail.com" <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 19:26:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smpoj-0003k3-NF
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 19:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab2GER0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 13:26:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab2GER0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 13:26:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7505A8C83;
	Thu,  5 Jul 2012 13:26:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FNSHQUdOWP6HuWfzBZSq43kGTKY=; b=NAZd6p
	Gfrr8Ufpm/idty189VUhm4bg5ccMvM5CQLSGg1LUjRWzVEsmKT+KKFaA/1RriqJW
	1nsV7oXCm4zYZ0Q6XrYaVs4Xmm7sb+LOh4Keo8ux359A3utImVpTOgfDyOMVme8X
	154DC7CxvOBThYBzhFdbBpwZJ8SuYYWh6DjM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nNpF42759w7Q+6KlDUj7+Dhk+am5o2ou
	QrcwJpwOIohgbDts2RDJ48gVIenD5JGPVucl91AlrY98i8I0laXeGv8lyI0QtYzN
	YGVQUlfh47nGw/FyDWq9UavJrAUFFH5KUzDxY4YyNq73BxOhqek1sWQPb7ySV47J
	Hv72MTQKH4E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68C818C81;
	Thu,  5 Jul 2012 13:26:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECAF28C80; Thu,  5 Jul 2012
 13:26:02 -0400 (EDT)
In-Reply-To: <CABURp0r8EfShHVE-Vycz3g8-WPXFzs1-WOT7LRwh-XOuWVYG+Q@mail.gmail.com> (Phil
 Hord's message of "Thu, 5 Jul 2012 11:32:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EBACBEE-C6C6-11E1-B089-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201054>

Phil Hord <phil.hord@gmail.com> writes:

> The possible enhancements to cover this I can think of are mostly in
> the form of enhanced help or advice.  For example, I could imagine
> these:

Thanks; I agree discoverability is the key for any large toolset.

> 1. Add a link to 'git push' on the 'git-branch' man page.   I suspect
> this is where newbies would go to look for this feature, but I am only
> guessing.  The git-branch help discusses deleting branches and even
> deleting remote-tracking branches.  But it does not discuss deleting
> branches on a remote repository, even to say "this is not the command
> you want" for that action, but "see this other one instead".

Or you can enhance the link to "git push" from "git" manpage (which
hopefully exists already), to make it clear that everything that
affects branches and tags that appear at a remote site is done via
that command.

> 2. Add 'apropos' behavior for git help.
>    $ git apropos delete
> ...
> 3. Add a search feature for help.  Currently this feature is provided
> instead by Google and StackOverflow.
>    $ git help --find delete --and branch --and remote
> Except I don't expect this "advanced" form of help, if it existed, to
> be noticed by newbies early enough on the learning curve.

I think you may be onto something here.  I can see that we could
help "git help -k delete" (modeled after "man -k") by adding
keywords to the documentation pages.

> 4. Add advice in appropriate locations.

I have to say that I am fairly negative on any attempt to anticipate
and list all the irrelevant possibilities that could come from
misunderstandings; it will lead to unreadable mess.
