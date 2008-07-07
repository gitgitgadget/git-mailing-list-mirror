From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 07 Jul 2008 11:20:08 -0700
Message-ID: <7v8wwd4kvb.fsf@gitster.siamese.dyndns.org>
References: <20080701150119.GE5852@joyeux>
 <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>
 <20080706160758.GA23385@jhaampe.org>
 <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness>
 <20080707062142.GA5506@jhaampe.org>
 <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>
 <alpine.DEB.1.00.0807071533240.18205@racer>
 <alpine.DEB.1.00.0807071537070.18205@racer> <20080707145726.GI3696@joyeux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 20:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFvKy-00074O-TB
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 20:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbYGGSUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 14:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754457AbYGGSUX
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 14:20:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbYGGSUX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 14:20:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5E432E97C;
	Mon,  7 Jul 2008 14:20:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B52622E979; Mon,  7 Jul 2008 14:20:11 -0400 (EDT)
Importance: high
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C5D5466-4C51-11DD-8E6E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87639>

Sylvain Joyeux <sylvain.joyeux@dfki.de> writes:

> Is it possible to make 'fetch' only .. well .. fetch objects, without
> updating any refs?

Not very easily, and that is very deliberate.  The objects fetched will
become dangling if you allowed such a mode of operation, and will
immediately become subject to gc.

As Avery said, when the user asks "what's the status" in the superproject,
"the superproject binds a commit you do not have locally at these paths"
is a perfectly valid answer, and as Dscho argues, it is not good to avoid
giving that answer by running fetch behind the user's back.

And the thing is, if you do the "without updating refs" fetch, I think you
would make things even worse.  The superproject status will then may say
that you have everything you need, but the commit is not anchored with any
ref in the subproject repository and can be gc'ed at any time.  The answer
you gave to the "status" request cannot be trusted anymore.

By honestly saying "The superproject binds a commit you do not have
locally at these paths", the user *can* choose *when* to go there and
update, or have "git submodule update" command to that for him.
