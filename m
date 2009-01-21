From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 12:42:27 -0800
Message-ID: <7veiywe6h8.fsf@gitster.siamese.dyndns.org>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>
 <49773240.7090605@drmicha.warpmail.net>
 <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com>
 <49773E48.90302@drmicha.warpmail.net>
 <20090121161940.GA20702@coredump.intra.peff.net>
 <alpine.LNX.1.00.0901211237530.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 21:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPjve-0004YR-SY
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 21:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbZAUUmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 15:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbZAUUmi
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 15:42:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZAUUmi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 15:42:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EE6492989;
	Wed, 21 Jan 2009 15:42:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A041A92986; Wed,
 21 Jan 2009 15:42:29 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 095146D2-E7FC-11DD-95C5-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106663>

Daniel Barkalow <barkalow@iabervon.org> writes:

> That is, refs/remotes/origin/HEAD is only there to let the user abbreviate 
> the most useful branch of the remote; there's no reason it should reflect 
> the remote's HEAD, except that the remote's HEAD is a good guess if the 
> user hasn't said anything.
>
> I think it might be more appropriate to just care less about a broken 
> symref, explain what's wrong if the user actually tries to use it, and 
> otherwise mostly ignore it.

I agree with you in many of the points in your message.

The user used to be able to say "origin" as a shorthand for "origin/frotz"
by having "remotes/origin/HEAD" locally, and somebody (not necessarily the
user himself) broke this arrangement.  Silently discarding HEAD will lose
the information on which remote branch was the interesting one for the
user.  It may also change the disambiguation rules for "origin" without
telling the user.  Neither is desirable.

The tool needs a better explanation of the situation.  We also want an
easier way to help the user repoint the HEAD to something else, or remove
the dangling HEAD than telling him to use symbolic-ref.
