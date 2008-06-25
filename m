From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ask for "git program" when asking for "git-program" over
 SSH connection
Date: Tue, 24 Jun 2008 22:27:07 -0700
Message-ID: <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
References: <7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
 <20080624221049.GE29404@genesis.frugalware.org>
 <7vk5gea0ff.fsf@gitster.siamese.dyndns.org>
 <20080624233236.GI29404@genesis.frugalware.org>
 <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
 <20080625120832.6117@nanako3.lavabit.com>
 <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
 <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org>
 <20080625034538.GW11793@spearce.org>
 <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
 <20080625044409.GE11793@spearce.org>
 <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org>
 <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, Miklos Vajna <vmiklos@frugalware.org>,
	pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:28:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBNYP-0004M5-MQ
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbYFYF1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 01:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbYFYF13
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 01:27:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbYFYF13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 01:27:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CD0D17490;
	Wed, 25 Jun 2008 01:27:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2A8A41748D; Wed, 25 Jun 2008 01:27:15 -0400 (EDT)
In-Reply-To: <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 24 Jun 2008 22:13:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65047858-4277-11DD-920E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86229>

Junio C Hamano <gitster@pobox.com> writes:

> If we force --upload-pack workaround to _everybody_ we are already lost.
>
> Also I think the previous one still lets you work it around by giving a
> full path, like "/usr/local/bin/git-upload-pack", because "/usr" does not
> match "git-" ;-)

Ok, let's map this out seriously.

* 1.6.0 will install the server-side programs in $(bindir) so that 
  people coming over ssh will find them on the $PATH

* In 1.6.0 (and 1.5.6.1), we will change "git daemon" to accept both
  "git-program" and "git program" forms.  When the spaced form is used, it
  will behave as if the dashed form is requested.  This is a prerequisite
  for client side change to start asking for "git program".

* In the near future, there will no client-side change.  "git-program"
  will be asked for.

* 6 months after 1.6.0 ships, hopefully all the deployed server side will
  be running that version or newer.  Client side will start asking for
  "git program" by default, but we can still override with --upload-pack
  and friends.

* 12 months after client side changes, everybody will be running that
  version or newer.  We stop installing the server side programs in
  $(bindir) but people coming over ssh will be asking for "git program"
  and "git" will be on the $PATH so there is no issue.

The above 6 and 12 are yanked out of thin air and I am of course open to
tweaking them, but I think the above order of events would be workable.
