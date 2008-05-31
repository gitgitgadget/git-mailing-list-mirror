From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH review] Build: make PERL_PATH = /usr/bin/env perl
Date: Sat, 31 May 2008 12:55:12 -0700
Message-ID: <7vabi6fdun.fsf@gitster.siamese.dyndns.org>
References: <1212258886-87484-1-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat May 31 21:56:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2XBX-00008b-1v
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 21:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbYEaTzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 15:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbYEaTzW
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 15:55:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbYEaTzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 15:55:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 01BC338EF;
	Sat, 31 May 2008 15:55:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5413238ED; Sat, 31 May 2008 15:55:15 -0400 (EDT)
In-Reply-To: <1212258886-87484-1-git-send-email-mfwitten@mit.edu> (Michael
 Witten's message of "Sat, 31 May 2008 14:34:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7F8C886C-2F4B-11DD-B82C-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83403>

Michael Witten <mfwitten@MIT.EDU> writes:

> This should make PERL_PATH more robust, as some
> systems may have multiple version of perl installed.
>
> Signed-off-by: Michael Witten <mfwitten@mit.edu>
> ---
>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 865e2bf..5828745 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -323,7 +323,7 @@ ifndef SHELL_PATH
>  	SHELL_PATH = /bin/sh
>  endif
>  ifndef PERL_PATH
> -	PERL_PATH = /usr/bin/perl
> +	PERL_PATH = /usr/bin/env perl
>  endif
>  
>  export PERL_PATH

If you insist, you can do so from your "make" command line, but I'd prefer
the default configuration as vanilla as possible.

I notice that both git-svn.perl and git-relink.perl begin with
"#!/usr/bin/env perl", and I think that is a mistake.  The #! line is
rewritten by Makefile, and there is no reason to write a "/usr/bin/env"
ugliness there in the source.  Not that it hurts, as it is blown away when
Makefile rewrites it to "#!$(PERL_PATH)", but it still looks ugly.
