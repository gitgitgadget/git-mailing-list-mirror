From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Expand ~ and ~user in core.excludesfile,
 commit.template
Date: Fri, 29 Aug 2008 12:28:54 -0700
Message-ID: <7vk5dz4o3t.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Aug 29 21:30:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ9fe-0003oi-Hr
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 21:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbYH2T3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 15:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbYH2T3F
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 15:29:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbYH2T3E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 15:29:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 035C6577BE;
	Fri, 29 Aug 2008 15:29:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0554A577BD; Fri, 29 Aug 2008 15:28:56 -0400 (EDT)
In-Reply-To: <quack.20080829T1201.lthsksnir1u@roar.cs.berkeley.edu> (Karl
 Chen's message of "Fri, 29 Aug 2008 12:01:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC2A1ED2-7600-11DD-BD2D-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94318>

Karl Chen <quarl@cs.berkeley.edu> writes:

>>>>>> On 2008-08-29 09:08 PDT, Junio C Hamano writes:
>
>     Junio> I do not see any strong reason why the single caller of
>     Junio> user_path() has to keep using the static allocation.
>     Junio> Would it help to reduce the complexity of your
>     Junio> expand_user_path() implementation, if we fixed the
>     Junio> caller along the lines of this patch (untested, but
>     Junio> just to illustrate the point)?
>
> Yes, expand_user_path() would be much simpler, it would basically
> be me original implementation except for returning NULL on error.

Yeah, modulo those styles issues your v3 and v4 addressed, and use of
strbuf.

It might feel that we went full circles, wasting your time.  But it's not.
We found out that the final series would look like this:

 [1/3] Introduce expand_user_path();

 [2/3] Using #1, introduce git_config_pathname() and use it to parse your
       two variables;

 [3/3] Update the sole caller of user_path() to use expand_user_path().

Patch #1 and #2 can be squashed into one if you want.  Also you do not
have to do #3 yourself if you do not feel like it (but now we know how the
code would look like, why not?).

Thanks to these three initial rounds, we know whoever implements #1 knows
what kind of interface the (to-be-rewritten) user of user_path() would
want, so #3 will become much cleaner.  We made progress.

Thanks.
