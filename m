From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: accept "git program" as well
Date: Wed, 25 Jun 2008 16:26:46 -0700
Message-ID: <7vmyl9w0y1.fsf@gitster.siamese.dyndns.org>
References: <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
 <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org>
 <20080625034538.GW11793@spearce.org>
 <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
 <20080625044409.GE11793@spearce.org>
 <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org>
 <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
 <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
 <20080625053848.GJ11793@spearce.org>
 <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org>
 <20080625230228.GR11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tv@eagain.net,
	=?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, Miklos Vajna <vmiklos@frugalware.org>,
	pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:28:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBePj-0007sM-WA
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbYFYX1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbYFYX1N
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:27:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbYFYX1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:27:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 22695AD2B;
	Wed, 25 Jun 2008 19:27:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B07ADAD1F; Wed, 25 Jun 2008 19:26:55 -0400 (EDT)
In-Reply-To: <20080625230228.GR11793@spearce.org> (Shawn O. Pearce's message
 of "Wed, 25 Jun 2008 19:02:28 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3B1C19BE-430E-11DD-BE3B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86370>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> This is a step to futureproof git-daemon to accept clients that
>> ask for "git upload-pack" and friends, instead of using the more
>> traditional dash-form "git-upload-pack".  By allowing both, it
>> makes the client side easier to handle, as it makes "git" the only
>> thing necessary to be on $PATH when invoking the remote command
>> directly via ssh.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Obviously correct.  Ack.  Thanks Junio.

By the way I looked at gitosis (Tommi CC'ed).

    http://repo.or.cz/w/gitosis.git?a=blob;f=gitosis/serve.py;h=c0b7135bf45305ee1079b0dcab3b4ed1ce988aab;hb=38561aa6a51a2ef6cc04aa119481df62d213ffa4

In gitosis/serve.py, there are COMMANDS_READONLY and COMMANDS_WRITE array
that holds 'git-upload-pack' and 'git-receive-pack' commands, and they are
compared with user commands after doing:

	verb, args = command.split(None, 1)

(and "verb" is looked up in the set of valid commands).  It should not be
too involved to notice verb is 'git' and then re-split the args part to
see if they are upload-pack/receive-pack, which would be the equivalent
change to this patch.  It needs to be done before the clients are
updated.
