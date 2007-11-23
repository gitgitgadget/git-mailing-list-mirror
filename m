From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow HTTP proxy to be overridden in config
Date: Thu, 22 Nov 2007 16:28:28 -0800
Message-ID: <7voddl24b7.fsf@gitster.siamese.dyndns.org>
References: <1195776420-22075-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, francois@debian.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Nov 23 01:28:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvMPd-0000IF-30
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 01:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbXKWA2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbXKWA2f
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 19:28:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48310 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbXKWA2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 19:28:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9874E2EF;
	Thu, 22 Nov 2007 19:28:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 21A4498B52;
	Thu, 22 Nov 2007 19:28:52 -0500 (EST)
In-Reply-To: <1195776420-22075-1-git-send-email-sam.vilain@catalyst.net.nz>
	(Sam Vilain's message of "Fri, 23 Nov 2007 13:07:00 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65860>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> The http_proxy / HTTPS_PROXY variables used by curl to control
> proxying may not be suitable for git.  Allow the user to override them
> in the configuration file.
> ---
>   In particular, privoxy will block directories called /ad/ ... d'oh!

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 7ee97df..859a7f3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -515,6 +515,10 @@ specified as 'gitcvs.<access_method>.<varname>' (where 'access_method'
>  is one of "ext" and "pserver") to make them apply only for the given
>  access method.
>  
> +http.proxy::
> +	Override the HTTP proxy, normally configured using the 'http_proxy'
> +	environment variable (see gitlink:curl[1]).
> +

This may work around the issue you cited, but it makes me wonder
if it is a road to insanity.  Does the curl library expect that
(1) each and every HTTP talking application that uses the
library offer this kind of knob for its users to tweak, and (2)
users set the knob for each and every one of such application?

I would say if privoxy cannot be tweaked to allow /ad/ in chosen
context (e.g. /ad/ in general is rejected but /objects/ad/ is
Ok), that is what needs to be fixed.

Or it would be the use of such a broken proxy by the user.  That
can be fixed and much easily.
