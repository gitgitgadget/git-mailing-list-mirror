From: Junio C Hamano <gitster@pobox.com>
Subject: Re: New Feature wanted: Is it possible to let git clone continue
 last break point?
Date: Wed, 02 Nov 2011 15:41:36 -0700
Message-ID: <7vwrbigna7.fsf@alter.siamese.dyndns.org>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
 <20111031090717.GA24978@elie.hsd1.il.comcast.net>
 <20111102220614.GB14108@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 02 23:41:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLjVA-0003C8-47
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 23:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab1KBWlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 18:41:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077Ab1KBWlj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 18:41:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDBD36C8D;
	Wed,  2 Nov 2011 18:41:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/v8FU4dPreXLwZGY7Qhrwc6rDfQ=; b=kiAyN0
	RST/UfPMWx9KCc7qC41sylVeBTr9rSo/Kv9HuyP0nXqQ8XDOMpLwXeCvBvBtJoJ8
	7lQLGDu4Yd0ddv0+2hwZIRtD66umen2fi+v0nmW0gVHC/5BE0z3uiydk+dpm7G9z
	6K5S11WxQoabF/6YHxAADXkrOb8RbuT3HjkHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dw/PqSU0AoQj4lM5BDBC0L1MPw+LJjmq
	3gaZGZ4z4w6Txjqb+crZILO5d638z+Cx4zbyAaecSJdSd9O86jayk5qMPiwrUfcc
	jVDB7fBsaGlI1nRUbOSRATLRG5btXw3wUMmhg7j5IpkhrACZ8bQqCXzlUDMSlhx6
	Weq3XSC5LIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE04D6C8C;
	Wed,  2 Nov 2011 18:41:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F92B6C8B; Wed,  2 Nov 2011
 18:41:38 -0400 (EDT)
In-Reply-To: <20111102220614.GB14108@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 Nov 2011 18:06:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D37647F6-05A3-11E1-8EE3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184679>

Jeff King <peff@peff.net> writes:

> Which is all a roundabout way of saying that the git protocol is really
> the sane way to do efficient transfers. An alternative, much simpler
> scheme would be for the server to just say:
>
>   - if you have nothing, then prime with URL http://host/bundle
>
> And then _only_ clone would bother with checking mirrors. People doing
> fetch would be expected to do it often enough that not being resumable
> isn't a big deal.

I think that is a sensible place to start.

A more fancy conditional "If you have X then fetch this, if you have Y
fetch that, ..." sounds nice but depending on what branch you are fetching
the answer has to be different. If we were to do that, the natural place
for the server to give the redirect instruction to the client is after the
client finishes saying "want", and before the client starts saying "have".
