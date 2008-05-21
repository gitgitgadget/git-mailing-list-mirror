From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Add format.date config variable
Date: Wed, 21 May 2008 11:24:42 -0700
Message-ID: <7vtzgr347p.fsf@gitster.siamese.dyndns.org>
References: <20080518171306.GA12948@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Wed May 21 20:25:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyt0U-0007il-KZ
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 20:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757007AbYEUSYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 14:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbYEUSYz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 14:24:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbYEUSYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 14:24:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B86FE64A8;
	Wed, 21 May 2008 14:24:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CDC4664A6; Wed, 21 May 2008 14:24:49 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 348604A0-2763-11DD-AC7A-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82561>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> format.date config variable sets the default date-time mode for the log
> command. Setting format.date value is similar to using git log's --date
> option.
>
> Also, add missing "short" alternative to --date in rev-list-options.txt.

Good change but is a separate issue.  Please make it a [PATCH 1/2].

> ---

Lacking Sign-off.

> I wanted to read all the logs in ISO 8601 time format so I decided to 
> implement this option.

Good intention.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 217980f..ddc68bd 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -573,6 +573,12 @@ fetch.unpackLimit::
>  	especially on slow filesystems.  If not set, the value of
>  	`transfer.unpackLimit` is used instead.
>  
> +format.date::
> +	Set default date-time mode for the log command. Setting format.date
> +	value is similar to using git log's --date option. The value is one of
> +	following alternatives: {relative,local,default,iso,rfc,short}.
> +	See linkgit:git-log[1].
> +

Look at other "format.*" variables --- notice that most of them are about
"format-patch" command?  And you absolutely do NOT want this "default date
format for log family" to apply to "format-patch" command.

> diff --git a/builtin-log.c b/builtin-log.c
> index 9d046b2..d3ff8f6 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -18,6 +18,9 @@

The patch itself is good, especially that you made sure that format-patch
output is not affected.

As to the configuration variable name, I'd suggest "log.date" instead.  We
may have to deprecate format.pretty and move it to something else for
consistency, though.  Just like we do not want "format.date" applied to
format-patch, we never want "format.pretty" apply to it either.
