From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding support for "plackup" and similar web server tools to git-instaweb
Date: Tue, 4 May 2010 00:25:51 +0200
Message-ID: <201005040025.53473.jnareb@gmail.com>
References: <201005020317.42112.jnareb@gmail.com> <20100503205624.GA3791@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 04 00:26:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O945c-0001Ou-3j
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 00:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759074Ab0ECW0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 18:26:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:21200 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758965Ab0ECW0C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 18:26:02 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1279349fga.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=J5XmUavhekR+PafwtsFzXBLBlY3Zf+ECoQg6zDX3ox8=;
        b=mFQYSxo06CfKXO3l44c6NGtsppWdwql0Eu/YEklRF81IrjBGXkLHuZI13MN9g2MdnJ
         3x3ULtUGNXyu1q/mrzHVEoraNYeakyRDLmd/z5hLYiGfBDD/UbLbAhYoitRAZFxO1Cy+
         XaCvLWva2wO6+xrXHZHelSlIjz+GuToWh/KJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IirHk9/XgYiZEclHcy/egZBjms1Q/9/WLMtLI3jbbUy3yun/+uLjaxVerUXnk5HYNt
         xY+IH3BAWXKgNYZewdnTeTP+5jjhO1kICkEa/DP5Wwj7h4iWHF5KtPhFOe09orZ4fqXu
         YpHtvI3fktGFF0Ww5SEUrWmtZbJ+CXU+VDg9s=
Received: by 10.87.67.25 with SMTP id u25mr11273620fgk.32.1272925560871;
        Mon, 03 May 2010 15:26:00 -0700 (PDT)
Received: from [192.168.1.13] (abrz91.neoplus.adsl.tpnet.pl [83.8.119.91])
        by mx.google.com with ESMTPS id d13sm9853744fka.32.2010.05.03.15.25.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 15:25:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100503205624.GA3791@dcvr.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146264>

On Mon, 3 May 2010, Eric Wong wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > The problem is that contrary to other web servers that can be used by
> > git-instaweb, (namely apache2, lighttpd, mongoose and webrick), the
> > 'plackup' utility is configured using command line options, and not
> > via configuration file (well, one can use configuration file, but it
> > depends on the web server run from plackup).
> > 
> > How should one go with adding support for such httpd?  My first attempt
> > was putting full command line into 'httpd' in resolve_full_httpd():
> > 
> > +       *plackup*)
> > +               # plackup is configured via command-line options
> > +               bind=
> > +               test x"$local" = xtrue && bind="--host=127.0.0.1"
> > +               httpd="$httpd --port=$port $bind --app=$fqgitdir/gitweb/app.psgi"
> > +               ;;
[...]
> > So how should one go with adding support for new web server to git-instaweb,
> > that is configured via command line options (--port, --host) and not via
> > config file?
> 
> How about generating a small shell script that wraps plackup with the
> appropriate command-line options?

 RFC1925 - The Twelve Networking Truths                      1 April 1996
 
 2. The Fundamental Truths

         (6a) (corollary). It is always possible to add another level of
              indirection.

Just kidding...


More seriously, even currently in git-instaweb the 'httpd' variable
contains web server invocation *with options* (see the case of apache2
and lighttpd, where resolve_full_httpd() ensures that 'httpd' ends
with '-f' in such case.  Using 'httpd' variable to be plackup-with-options
naturally follows from such example.

Shell script (plackup.sh?  gitweb-plackup.sh?  instaweb-plackup.sh?)
might be good idea, though.  Note that we have to create gitweb.psgi
(or app.psgi) CGI-to-PSGI wrapper (and to serve static files like 
gitweb.css) anyway by git-instaweb.

-- 
Jakub Narebski
Poland
