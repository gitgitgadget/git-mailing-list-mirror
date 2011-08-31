From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] Add a remote helper to interact with mediawiki (fetch & push)
Date: Wed, 31 Aug 2011 13:54:04 +0200
Message-ID: <vpqobz53ig3.fsf@bauges.imag.fr>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
	<1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
	<7v4o14dppz.fsf@alter.siamese.dyndns.org>
	<CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
	<7v4o1092hn.fsf@alter.siamese.dyndns.org>
	<CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
	<20110830035608.GB6647@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 13:54:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyjNZ-0000bA-30
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 13:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab1HaLyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 07:54:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53998 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174Ab1HaLyn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 07:54:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7VBrNGe032289
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Aug 2011 13:53:23 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QyjMq-0006F2-HR; Wed, 31 Aug 2011 13:54:04 +0200
In-Reply-To: <20110830035608.GB6647@elie.gateway.2wire.net> (Jonathan Nieder's
	message of "Mon, 29 Aug 2011 22:56:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 31 Aug 2011 13:53:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7VBrNGe032289
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315396407.55012@bq/jl/N/skcryPnUBWc5oA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180460>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Here's an old attempt to make the documentation a little easier to read,
> and hopefully also to add to.

Thanks, that helps. I wish we had all this earlier ;-).

> +Git sends the remote helper a list of commands on standard input, one
> +per line.  The first command is always the 'capabilities' command, 

Do we want to set this in stone? Wouldn't a Git implementation calling
"option" before "capabilities" be correct?

> +Capabilities
> +~~~~~~~~~~~~

(perhaps name the section "Overview of Capabilities"?)

[...]
> +'refspec' <refspec>::
> +	This modifies the 'import' capability, allowing the produced
> +	fast-import stream to modify refs in a private namespace
> +	instead of writing to refs/heads or refs/remotes directly.
> +	It is recommended that all importers providing the 'import'
> +	capability use this.
> ++
> +A helper advertising the capability
> +`refspec refs/heads/{asterisk}:refs/svn/origin/branches/{asterisk}`
> +is saying that, when it is asked to `import refs/heads/topic`, the
> +stream it outputs will update the `refs/svn/origin/branches/topic`
> +ref.
> ++
> +This capability can be advertised multiple times.  The first
> +applicable refspec takes precedence.  The left-hand of refspecs
> +advertised with this capability must cover all refs reported by
> +the list command.  If no 'refspec' capability is advertised,
> +there is an implied `refspec {asterisk}:{asterisk}`.

Since this "Capabilities" section is meant to be an overview, I'd
shorten this to

+'refspec' <refspec>::
+	This modifies the 'import' capability, allowing the produced
+	fast-import stream to modify refs in a private namespace
+	instead of writing to refs/heads or refs/remotes directly.

and drop the detailed explanation here.

> +Capabilities for Fetching
> +~~~~~~~~~~~~~~~~~~~~~~~~~
[...]
> +'refspec' <refspec>::
> +	This modifies the 'import' capability.

Since this would be the "detailed explanation" part, this is the one
readers will read more carefully, so I'd put the recommandation right
here:

+	It is recommended that all importers providing the 'import'
+	capability use this.

and of course, keep this:

> ++
> +A helper advertising
> +`refspec refs/heads/{asterisk}:refs/svn/origin/branches/{asterisk}`
> +in its capabilities is saying that, when it handles
> +`import refs/heads/topic`, the stream it outputs will update the
> +`refs/svn/origin/branches/topic` ref.
> ++
> +This capability can be advertised multiple times.  The first
> +applicable refspec takes precedence.  The left-hand of refspecs
> +advertised with this capability must cover all refs reported by
> +the list command.  If no 'refspec' capability is advertised,
> +there is an implied `refspec {asterisk}:{asterisk}`.
> +

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
