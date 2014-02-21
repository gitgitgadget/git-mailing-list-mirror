From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Thu, 20 Feb 2014 16:22:46 -0800
Message-ID: <xmqq8ut55n6x.fsf@gitster.dls.corp.google.com>
References: <xmqq38jqsnc2.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Nq-LkE=FW5dnBZKKd7-ORJPo1BFs3sY+MLGxuXEWuTw@mail.gmail.com>
	<xmqqa9dxr09k.fsf@gitster.dls.corp.google.com>
	<20140214.224133.484636406629780362.chriscool@tuxfamily.org>
	<xmqqtxc1fdsk.fsf@gitster.dls.corp.google.com>
	<xmqqppmpfcx1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: christian.couder@gmail.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	sunshine@sunshineco.com, dan.carpenter@oracle.com, greg@kroah.com,
	peff@peff.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 21 01:23:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGdtN-0007Xc-AB
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 01:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbaBUAWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 19:22:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756866AbaBUAWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 19:22:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 459C56E403;
	Thu, 20 Feb 2014 19:22:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ggrMTTYoYOm2u6akflFgQELPxdw=; b=tFrPnX
	287aJJhOQWvHKqhiNeam3hSKaZZXPBq2eBaHO3gdDABrJArVfZtPnLeE4yt+PwaY
	7V4Jbj7XP3WaxaY0IPEJF0yfL9A6ICzaWIDdNcOgZLXvF7kTszMJESFr6lZgjtEb
	tA/tOqjeVUlorFK5MWdrWFY6Nfj/tSDKHu/B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HGOWFvMlw+WR6I68DylygacX7SyW6XTp
	lsftvvyUNinMWTk0ehIg5hSvNSYoSCg9hoRKl4VRJDY0xb6HL/7DHsvKhau7N6mu
	IiQApc2+q8oNgUkitnQeapkJB2L11+ROZZqllnzmyhdzP/shQbv2yucAni2pSQzH
	3P9fSVecCuM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22ADD6E402;
	Thu, 20 Feb 2014 19:22:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 474D86E3FE;
	Thu, 20 Feb 2014 19:22:48 -0500 (EST)
In-Reply-To: <xmqqppmpfcx1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 14 Feb 2014 16:16:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4AE5A878-9A8E-11E3-9ABD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242454>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> What is the right mental model the end-user needs to form when
> understanding these?  Conditions on keys go on the left, and any
> other random conditions can come as a modifier after action
> e.g. add_if_same_value_is_not_at_the_end?

Having said all that, it appears that nobody seems to be able to
come up with a saner arrangement that would not paint us into a
tough corner that we would not be able to later escape from without
being backward incompatible---I certainly didn't.

So... let's take this from your earlier message:

>> If we limit it to "if_exists" and "if_missing", the user can remember
>> that without things becoming too complex.

and go with the semantics the posted patches (I believe I have the
latest from you on 'pu') attempt to implement, at least for now.

IOW, when re-rolling, let's not try changing the arrangement to use
if-exists/if-missing (configuration variable names) for keys'
existence and include chosen set of conditions on values as
modifiers to the action (i.e. X in "do_Y_in_X").
