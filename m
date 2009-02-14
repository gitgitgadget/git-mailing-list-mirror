From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [topgit] tg update error
Date: Fri, 13 Feb 2009 18:02:56 -0800
Message-ID: <7vy6w93hdb.fsf@gitster.siamese.dyndns.org>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com>
 <20090212084811.GA14261@piper.oerlikon.madduck.net>
 <20090212092558.GB21074@skywalker>
 <20090212125621.GB5397@sigill.intra.peff.net>
 <7veiy3l689.fsf@gitster.siamese.dyndns.org>
 <20090213182609.GB31860@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, madduck@debian.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 03:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY9tX-0002Rk-Sk
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbZBNCDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbZBNCDI
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:03:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbZBNCDE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:03:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 326142B155;
	Fri, 13 Feb 2009 21:03:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1EF4A2AB4E; Fri,
 13 Feb 2009 21:02:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9D68EB76-FA3B-11DD-B623-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109799>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 12, 2009 at 01:01:42PM -0800, Junio C Hamano wrote:
>
>> > Junio, I think we should probably revert b229d18 (and loosen
>> > symbolic-ref's check to just "refs/"). Even if you want to argue that
>> > topgit should be changed to handle this differently, we are still
>> > breaking existing topgit installations, and who knows what other scripts
>> > which might have relied on doing something like this.
>> 
>> I'm Ok with the revert (and I agree it is absolutely the right thing to do
>> at least for the short term).
>
> It looks like you have already pushed out the revert. But I think we
> need this on top to make topgit work correctly.

>
> -- >8 --
> Subject: [PATCH] symbolic-ref: allow refs/<whatever> in HEAD
>
> Commit afe5d3d5 introduced a safety valve to symbolic-ref to
> disallow installing an invalid HEAD. It was accompanied by
> b229d18a, which changed validate_headref to require that
> HEAD contain a pointer to refs/heads/ instead of just refs/.
> Therefore, the safety valve also checked for refs/heads/.
>
> As it turns out, topgit is using refs/top-bases/ in HEAD,
> leading us to re-loosen (at least temporarily) the
> validate_headref check made in b229d18a. This patch does the
> corresponding loosening for the symbolic-ref safety valve,
> so that the two are in agreement once more.
>
> Signed-off-by: Jeff King <peff@peff.net>

Actually we should simply revert afe5d3d5 altogether with the above
message, as it introduced a test that expects the tightened behaviour.
