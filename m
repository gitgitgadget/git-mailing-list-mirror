From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC/PATCH 5/6] Let transport_helper_init() decide if a remote
 helper program can be used
Date: Tue, 11 Aug 2009 19:28:19 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908111915100.27553@iabervon.org>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org> <1249985426-13726-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, benji@silverinsanity.com,
	Johannes.Schindelin@gmx.de
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 01:28:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0lY-0002bE-VW
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbZHKX2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 19:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755589AbZHKX2T
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:28:19 -0400
Received: from iabervon.org ([66.92.72.58]:60617 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754383AbZHKX2S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 19:28:18 -0400
Received: (qmail 2595 invoked by uid 1000); 11 Aug 2009 23:28:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Aug 2009 23:28:19 -0000
In-Reply-To: <1249985426-13726-6-git-send-email-johan@herland.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125621>

On Tue, 11 Aug 2009, Johan Herland wrote:

> @@ -293,6 +301,16 @@ int transport_helper_init(struct transport *transport)
>  		data->name = xstrndup(transport->url, eom - transport->url);
>  	}
>  
> +	strbuf_addf(&buf, "remote-%s", data->name);
> +	cmd = strbuf_detach(&buf, NULL);
> +	if (!is_git_command_or_alias(cmd)) {
> +		warning("Could not find remote helper command \"git %s\". Assuming native remote.", cmd);

Won't this give you a warning for:

	url = master.kernel.org:something

of 'Could not find (...) "git remote-master.kernel.org" (...)'? That 
would be certain to upset some people. I think we can assume that people's 
scheme parts of their URLs that are actually URLs don't contain '.', and 
that people with:

	url = master:something

will append their domains if the warning gets annoying.

	-Daniel
*This .sig left intentionally blank*
