From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Adding support for "plackup" and similar web server tools to
	git-instaweb
Date: Mon, 3 May 2010 13:56:24 -0700
Message-ID: <20100503205624.GA3791@dcvr.yhbt.net>
References: <201005020317.42112.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 03 22:56:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O92gq-0001Vd-Eu
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 22:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab0ECU41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 16:56:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43199 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754921Ab0ECU40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 16:56:26 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4538F1F744;
	Mon,  3 May 2010 20:56:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <201005020317.42112.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146257>

Jakub Narebski <jnareb@gmail.com> wrote:
> The problem is that contrary to other web servers that can be used by
> git-instaweb, (namely apache2, lighttpd, mongoose and webrick), the
> 'plackup' utility is configured using command line options, and not
> via configuration file (well, one can use configuration file, but it
> depends on the web server run from plackup).
> 
> How should one go with adding support for such httpd?  My first attempt
> was putting full command line into 'httpd' in resolve_full_httpd():
> 
> +       *plackup*)
> +               # plackup is configured via command-line options
> +               bind=
> +               test x"$local" = xtrue && bind="--host=127.0.0.1"
> +               httpd="$httpd --port=$port $bind --app=$fqgitdir/gitweb/app.psgi"
> +               ;;
> 
> The default standalone web server used by plackup (HTTP::Server::PSGI)
> does not have daemon mode, so we would have to do the same as for moongose
> web server: set to background and save pid in pidfile in git-instaweb.
> 
> OTOH plackup prints information / logs to STDERR, so it would have to be
> silenced or redirected to error_log.  Also plackup does not need to have
> "$fqgitdir/gitweb/httpd.conf" passed as last argument, but it needs to
> be passed PSGI wrapper for CGI (I'd rather not use httpd.conf, but rather
> app.psgi or gitweb.psgi for that).
> 
> 
> So how should one go with adding support for new web server to git-instaweb,
> that is configured via command line options (--port, --host) and not via
> config file?

Hi Jakub,

How about generating a small shell script that wraps plackup with the
appropriate command-line options?

-- 
Eric Wong
