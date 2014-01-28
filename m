From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Tue, 28 Jan 2014 01:21:43 -0800
Message-ID: <xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
References: <52E080C1.4030402@fb.com>
	<20140123225238.GB2567@sigill.intra.peff.net>
	<52E1A99D.6010809@fb.com> <52E1AB78.1000504@fb.com>
	<20140124022822.GC4521@sigill.intra.peff.net>
	<52E1D39B.4050103@fb.com>
	<20140128060954.GA26401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 28 10:21:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W84rm-00056f-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 10:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbaA1JVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 04:21:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbaA1JVs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 04:21:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71DCA619DE;
	Tue, 28 Jan 2014 04:21:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6x+5eiiyYIlr4pIF8h1WQCpodO4=; b=GgGMMB
	H0kQbaw+ZxKFLob70a/sZg7uteRzg5K0nkj4aoMJo/SozRT7XiXjLvq5rlQ/o/iQ
	CSWkNiZgx2Gr3aJOycYGo2j7MqxjWTj59Z0uoDJrshMeSMP6fsHWsHEeUqrblO2h
	L+Ia512bSdGYxXK91nmUcsACWTsSb+Yu7GwuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=unEGu1IlbcIJG/hEL/aUd7kCz2tDBuwT
	O94RCEok8aqSPVqzVRv0yvE/fgDos8aWW1fqZ7yvbGQTXdPIywdClYlK7OkWEiMY
	blQizHP0mD/fqjj97YdJH6z1u5a11GPaqFr97nAM06VGkHRqSl1Y+vuF/hqLW7vd
	deg9+24mwmw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6223D619DD;
	Tue, 28 Jan 2014 04:21:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A85E3619DC;
	Tue, 28 Jan 2014 04:21:46 -0500 (EST)
In-Reply-To: <20140128060954.GA26401@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 28 Jan 2014 01:09:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C1EC934-87FD-11E3-950E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241181>

Jeff King <peff@peff.net> writes:

> The git-repack command always passes `--honor-pack-keep`
> to pack-objects. This has traditionally been a good thing,
> as we do not want to duplicate those objects in a new pack,
> and we are not going to delete the old pack.
> ...
> Note that this option just disables the pack-objects
> behavior. We still leave packs with a .keep in place, as we
> do not necessarily know that we have duplicated all of their
> objects.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Intended for the jk/pack-bitmap topic.

Two comments.

 - It seems that this adds a configuration variable that cannot be
   countermanded from the command line. It has to come with either a
   very good justification in the documentation describing why it is
   a bad idea to even allow overriding from the command line in a
   repository that sets it, or a command line option to let the
   users override it. I personally prefer the latter, because that
   will be one less thing for users to remember (i.e. "usually you
   can override the configured default from the command line, but
   this variable cannot be because of these very good reasons").

 - In the context of "pack-objects", the name "--honor-pack-keep"
   makes sense; it is understood that pack-objects will _not_ remove
   kept packfile, so "honoring" can only mean "do not attempt to
   pick objects out of kept packs to add to the pack being
   generated." and there is no room for --no-honor-pack-keep to be
   mistaken as "you canremove the ones marked to be kept after
   saving the still-used objects in it away."

   But does the same name make sense in the context of "repack"?

Thanks. 
