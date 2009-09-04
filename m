From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
 case
Date: Fri, 04 Sep 2009 10:23:43 -0700
Message-ID: <7vy6ouk4io.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>
 <fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com>
 <alpine.LNX.2.00.0909041114440.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 19:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjcYB-0002gg-8M
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 19:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933714AbZIDRXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 13:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933650AbZIDRXy
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 13:23:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933599AbZIDRXx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 13:23:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A694625964;
	Fri,  4 Sep 2009 13:23:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GgeVPuMp2eXOvqyCMFndSRHhKls=; b=KIVcdQ
	xUXFyQTyek5zgxXVogpXiEdnaKeq/tz7PU1aoBcdvuKxF6uXHxjkkCEkfWmG0nFs
	QLQnlqHJvkmo+fsht8bqiaBXgjvPPfIW6RftwkUBuQdXl6aHa/8SJVSrs1jyoYxe
	FR73s0IdA9T2k11z9zT+JHsDA3GpVLxrgZln8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xZZGx4aoeutg/l1T63RXRQg9Ukl6Kt/3
	J+OZ8Xk21W9sxMNCMk+MDg7SxKJ43E4pjk8JtJHK4LgWaItcc7Ld+GpTkF9fSxYK
	sJPv9MwJVZLFYhpYrcjrWneEfObck6TPzEvlznT5m83mkb0xDU3qFnDEHqVRauU1
	9KlSKff26qQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6517A25960;
	Fri,  4 Sep 2009 13:23:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D74F25956; Fri,  4 Sep
 2009 13:23:45 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0909041114440.28290@iabervon.org> (Daniel
 Barkalow's message of "Fri\, 4 Sep 2009 11\:40\:20 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B6BFA908-9977-11DE-A1D3-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127750>

Daniel Barkalow <barkalow@iabervon.org> writes:

> It turns out that the method used to form URLs that use a helper doesn't 
> generalize well to other cases, because it interferes with the ssh-style 
> locations. Instead, some different mechanism needs to be made up to handle 
> arbitrary handlers that git doesn't know about. Since we want to keep 
> supporting "http://something", that'll have to be a special case anyway, 
> and so we might as well handle it by having git know what helpers to use 
> for things that we've always supported, and use a single descriptive name 
> for the helper that handles that collection of URLs.
>
> As of this version, the idea is that there will be three ways helpers get 
> selected:
>
>  - git selects a helper based on the URL being something traditionally 
>    supported internally; that is, git recognizes the URL and knows what to 
>    run, if possible, to handle it
>
>  - git uses the "vcs" option if it is set
>
>  - something with the URL that we don't understand well enough yet to 
>    design, but which doesn't seem to be possible to fit in as a single 
>    rule with the first item.

Thanks for a clear description.

I do not see that there is much difference between the above description
and what Dscho is advocating, and I do not see anything to get excited
about as Dscho seems to do.  In his world, hg:// or any URL that begins
with <unknown>:// wants to be a short-hand to name the helper, and the
third rule whose detail is unspecified in the above list could be
something like:

 - With an explicit <prefix-separator>, i.e.

        <helper-name> <prefix-separator> <any-string>

   tells the named helper git-remote-<helper-name> to interact with
   repository that it can find using <any-string>.  We do not interpret,
   nor guess from, what <any-string> is, in this case.

 - When all else fails, and the URL looks like <unknown>://<any-string>,
   we see if git-remote-<unknown> is available and give it the whole
   string (including the <unknown>::// part).

which means that what Dscho wants is already a subset of the future
direction planned for this series.

As to the "curl" indirection, if you consider the possiblity of someday
adding the transparently backward compatible cgi based server with updated
clients Gitney talked about, I am reasonably sure that we would want to
have a new helper, say http-cgi, and have interested people invoke it
using the "more explicit" escape hatch:

    $ git clone http-cgi::http://repo.or.cz/w/alt-git.git/

while others can continue using the walker via a plain http://repo.or.cz/
URL.  When http-cgi helper proves to be successful and everybody's server
upgrades, we might choose to swap the default, say in git 1.10.0 release,
while leaving the door open for people to choose the old helper via an
explicit curl::http://repo.or.cz/ URL.

In short, from where I sit, I do not see much disagreement in the
semantics and in the future direction between what Dscho is saying (unless
I again misunderstood what he said) and what this round wants to bring.

The only slight difference is that having an explicit excape hatch as the
foundation, that usually does not have to be spelled out but does allow
you to, keeps the concept cleaner, while keeping the usability of the end
result.
