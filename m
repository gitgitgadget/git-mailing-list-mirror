From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Separate default remotes for pulling and pushing
Date: Mon, 09 May 2011 15:46:19 -0700
Message-ID: <7vaaevo5l0.fsf@alter.siamese.dyndns.org>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
 <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com>
 <20110509081708.GA5871@sigill.intra.peff.net>
 <7viptjq0ua.fsf@alter.siamese.dyndns.org>
 <20110509220459.GA3719@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Lee <davidomundo@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 00:46:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZDq-0006Aw-My
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab1EIWqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:46:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab1EIWqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:46:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C86444BD8;
	Mon,  9 May 2011 18:48:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TaCXzOm17DrMeP5XCRppULsr6HQ=; b=jaA/VQ
	ui5QNSDihJ2ayMGRHkZhKWZPunIZye3eKfmehr8O+QIFkXl+h4c7lJxJSsj4dhM7
	6nTRN8xok9lGuP9lyND5kzWq+jRnwN/s0DrajilT/NnEq8PG3mtHSYDED/mbQ0HB
	ZOkCE7I6y/7mp4eERejr6KoSMj+tJ05Oa+Ksk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=owQKTPy6txx0ja4nw9sY2abfpoy2h28+
	1AuC4ot7qlU/i/8D4C/D2DRBJfnjntPH9uaUbnWmu/53lBNMxFw7ZexMcVZogRrI
	UjSnRIGRl1deq5I+V0IMu0U+SI6mroHdcUUCXkP3qhzmlegVlN9Pq8DvttECj/kY
	ZV8bgv1NEOQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 680BA4BD6;
	Mon,  9 May 2011 18:48:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 124D44BD4; Mon,  9 May 2011
 18:48:26 -0400 (EDT)
In-Reply-To: <20110509220459.GA3719@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 9 May 2011 18:04:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 771CEE06-7A8E-11E0-BE01-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173279>

Jeff King <peff@peff.net> writes:

>> In a sense, this is what I do as well.  As you mentioned, I push to "ko"
>> to publish, but when I "fetch" (or "pull") from "origin", I get the public
>> copy I have at kernel.org like everybody else, and I do fetch every time
>> after I push to "ko" to get the updated preformatted HTML and man page
>> branches.
>
> Interesting. Is your fetch from "ko" a no-op, or are you using it to
> syncrhonize development between different machines?

Preformatted html and man pages are made when I push the integrated source
branches out, triggered from the post-update hook at kernel.org.  I do not
format them on my box.

I say "git push ko", take a sip of tea, and after k.org finishes the
asciidoc dance "git fetch ko" to get them all, before pushing
remotes/ko/{maint,master,next,pu,todo,html,man} to secondary sites.

> I think it is important to note that calling them both "origin" is
> definitely the wrong thing. The proposal is instead that "git push"
> without a remote would default to something besides "origin". For people
> who publish multiple places, it might even make sense for it to be an
> iterative push to each place.

Either we add branch.<name>.pushremote or push.defaultremote then?
