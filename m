From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-remote-mediawiki: better error message when HTTP(S) access fails
Date: Wed, 29 May 2013 14:01:59 +0200
Message-ID: <vpqzjvej8p4.fsf@anie.imag.fr>
References: <1369339503-12426-1-git-send-email-Matthieu.Moy@imag.fr>
	<20130528180727.GB21210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 29 14:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhf56-0007pJ-2X
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965912Ab3E2MCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 08:02:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53645 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965418Ab3E2MCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:02:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4TC1wa0025858
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 May 2013 14:01:58 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uhf4p-0005It-EX; Wed, 29 May 2013 14:01:59 +0200
In-Reply-To: <20130528180727.GB21210@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 28 May 2013 14:07:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 29 May 2013 14:01:59 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225795>

Jeff King <peff@peff.net> writes:

> On Thu, May 23, 2013 at 10:05:03PM +0200, Matthieu Moy wrote:
>
>> My use-case is an invalid SSL certificate. Pulling from the wiki with a
>> recent version of libwww-perl fails, and git-remote-mediawiki gave no
>> clue about the reason. Give the mediawiki API detailed error message, and
>> since it is not so informative, hint the user about an invalid SSL
>> certificate on https:// urls.
>
> This is definitely an improvement, but it seems like it just the tip of
> the iceberg.

Right.

> I wonder if we can do something like:
>
>   our $mw_operation;
>   $mediawiki->{config}->{on_error} = sub {
> [...]
>           die "$err\n";
>   };

Probably, but that would hardcode the fact that mediawiki errors are
fatal, while in an ideal world, some errors should be recoverable, and
some would require some cleanups before die-ing.

Also, an error during the first mediawiki operation should not
necessarily have the same diagnosis hint as the others: if I just
did a successfull querry, and the next fails, it can hardly be an SSL
certificate error.

I'll send a v2 that covers a bit more (at least, push and pull with an
invalid certificate both give the message).

More work is needed to get a real good error management, but I don't
have time for that now.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
