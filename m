From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] git-config: read remote config files over HTTP
Date: Sun, 06 May 2007 15:53:06 +0200
Message-ID: <20070506135306.GB942MdfPADPa@greensroom.kotnet.org>
References: <11782757671754-git-send-email-skimo@liacs.nl>
 <11782757671933-git-send-email-skimo@liacs.nl>
 <7virb6fnkv.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 15:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkhBC-00005O-DQ
	for gcvg-git@gmane.org; Sun, 06 May 2007 15:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbXEFNxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 09:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbXEFNxJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 09:53:09 -0400
Received: from smtp13.wxs.nl ([195.121.247.4]:39534 "EHLO smtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754710AbXEFNxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 09:53:08 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JHM00MQ8H8I51@smtp13.wxs.nl> for git@vger.kernel.org; Sun,
 06 May 2007 15:53:06 +0200 (CEST)
Received: (qmail 6926 invoked by uid 500); Sun, 06 May 2007 13:53:06 +0000
In-reply-to: <7virb6fnkv.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46335>

On Sat, May 05, 2007 at 11:55:28PM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@liacs.nl> writes:
> > +static int config_from_http(config_fn_t fn, char *dest)
> > +{
> > +	static char *config_temp = "config.temp";
> > +	if (git_http_fetch_config(dest, config_temp))
> > +		return 1;
> > +	git_config_from_file(fn, config_temp);
> > +	unlink(config_temp);
> > +	return 0;
> > +}
> 
> Not mkstemp()?

I more or less copy-pasted the way "index" is handled now.
I'll use mkstemp in the next round.

> > +	if (!prefixcmp(dest, "http://"))
> > +		return config_from_http(fn, dest);
> > +
> 
> Shouldn't this also work for other protocols we handle via curl?

I don't think I copied the required setup for https, but ftp should work.

> > +#ifdef USE_CURL_MULTI
> > +void (*fill_active_slots)(void) = NULL;
> > +#endif
> > +
> 
> I wonder if we could lose USE_CURL_MULTI around this one,...

I wondered about that too, but I wanted to make my changes as minimal
as possible.  I'll drop the #ifdef in the next round.

skimo
