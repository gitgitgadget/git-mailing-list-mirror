From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc & deleted branches
Date: Fri, 09 May 2008 15:33:41 -0700
Message-ID: <7vwsm39kft.fsf@gitster.siamese.dyndns.org>
References: <20080508210125.GC32762@sigill.intra.peff.net>
 <alpine.LFD.1.10.0805081712270.23581@xanadu.home>
 <20080508211734.GA819@sigill.intra.peff.net>
 <48236F69.2060900@nrlssc.navy.mil>
 <20080508213107.GA1016@sigill.intra.peff.net>
 <48237344.6070405@nrlssc.navy.mil>
 <20080508214454.GA1939@sigill.intra.peff.net>
 <48237650.5060008@nrlssc.navy.mil>
 <20080508224827.GA2938@sigill.intra.peff.net>
 <loom.20080509T011318-478@post.gmane.org>
 <20080509041921.GA14773@sigill.intra.peff.net>
 <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
 <48246A44.7020303@nrlssc.navy.mil>
 <alpine.LFD.1.10.0805091205580.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat May 10 00:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JubAs-00042m-HB
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 00:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759393AbYEIWd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 18:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759334AbYEIWdz
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 18:33:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759008AbYEIWdx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 18:33:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 950C62D59;
	Fri,  9 May 2008 18:33:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9BA732D56; Fri,  9 May 2008 18:33:44 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0805091205580.23581@xanadu.home> (Nicolas
 Pitre's message of "Fri, 09 May 2008 12:12:22 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FFD10A9C-1E17-11DD-8294-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81631>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 9 May 2008, Brandon Casey wrote:
>
>> Unreferenced objects are sometimes used by other repositories which have
>> this repository listed as an alternate. So it may not be a good idea to
>> make the unreferenced objects inaccessible.
>
> Nah.  If this is really the case then you shouldn't be running gc at all 
> in the first place.

True.

I think the true motivation behind --keep-unreachable is not about the
shared object store (aka "alternates") but about races between gc and
push (or fetch).  Before push (or fetch) finishes and updates refs, the
new objects they create would be dangling _and_ the objects these dangling
objects refer to may be packed but unreferenced.  Repacking unreferenced
packed objects was a way to avoid losing them.
