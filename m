From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Expand ~ and ~user in core.excludesfile,
 commit.template
Date: Fri, 29 Aug 2008 22:31:51 -0700
Message-ID: <7v8wuf2hmg.fsf@gitster.siamese.dyndns.org>
References: <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
 <20080824220854.GA27299@coredump.intra.peff.net>
 <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
 <20080824231343.GC27619@coredump.intra.peff.net>
 <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
 <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
 <20080827002506.GB7347@coredump.intra.peff.net>
 <quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu>
 <7vy72jrr00.fsf@gitster.siamese.dyndns.org>
 <quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
 <20080829032630.GA7024@coredump.intra.peff.net>
 <7vod3ca2ey.fsf@gitster.siamese.dyndns.org>
 <quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu>
 <7vsksn4xdo.fsf@gitster.siamese.dyndns.org>
 <quack.20080829T1201.lthsksnir1u@roar.cs.berkeley.edu>
 <7vk5dz4o3t.fsf@gitster.siamese.dyndns.org>
 <quack.20080829T1534.lthd4jr30xq@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Sat Aug 30 07:33:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZJ58-0008P5-BX
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 07:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbYH3FcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 01:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbYH3FcA
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 01:32:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYH3Fb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 01:31:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA32E57886;
	Sat, 30 Aug 2008 01:31:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CA95057885; Sat, 30 Aug 2008 01:31:53 -0400 (EDT)
In-Reply-To: <quack.20080829T1534.lthd4jr30xq@roar.cs.berkeley.edu> (Karl
 Chen's message of "Fri, 29 Aug 2008 15:34:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F730FF2E-7654-11DD-9CD0-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94357>

Karl Chen <quarl@cs.berkeley.edu> writes:

>>>>>> On 2008-08-29 12:28 PDT, Junio C Hamano writes:
>
>     Junio>  [3/3] Update the sole caller of user_path() to use
>     Junio>  expand_user_path().
>
> Actually I just looked closer at enter_repo() and it's not quite
> as simple as your proposed patch, because enter_repo() wants to
> concatenate suffixes like ".git".

I thought the "just an illustration" patch at least took care of that
part.

The thing is that enter_repo() is not performance critical, it is where
server side programs validate the repository path received from the other
end of the network, and we can be stricter than necessary about path
lengths.  I do not particularly think it is necessary to convert it and
use strbuf to allow arbitrarily long paths --- rejecting requests to an
absurdly deep directory is not an end of the world there.
