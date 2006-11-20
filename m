X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: gitweb install
Date: Mon, 20 Nov 2006 04:29:26 +0200
Message-ID: <45611306.4070705@cc.jyu.fi>
References: <45610199.4030502@cc.jyu.fi> <ejr0gi$ea8$1@sea.gmane.org>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 02:30:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at cc.jyu.fi
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
In-Reply-To: <ejr0gi$ea8$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31877>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glyvb-00015b-Ib for gcvg-git@gmane.org; Mon, 20 Nov
 2006 03:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933899AbWKTC3a (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 21:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933901AbWKTC33
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 21:29:29 -0500
Received: from posti6.jyu.fi ([130.234.4.43]:49300 "EHLO posti6.jyu.fi") by
 vger.kernel.org with ESMTP id S933899AbWKTC30 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 21:29:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1]) by posti6.jyu.fi
 (8.13.6/8.13.6) with ESMTP id kAK2TOZ7031866; Mon, 20 Nov 2006 04:29:24 +0200
Received: from posti6.jyu.fi ([127.0.0.1]) by localhost (posti6.jyu.fi
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id A2OYEY8rU+KU; Mon, 20
 Nov 2006 04:29:24 +0200 (EET)
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi
 [130.234.182.120]) by posti6.jyu.fi (8.13.6/8.13.6) with ESMTP id
 kAK2TMQp031810; Mon, 20 Nov 2006 04:29:24 +0200
Received: from [127.0.0.1] (aragorn2.kortex.jyu.fi [127.0.0.1]) by
 aragorn.kortex.jyu.fi (Postfix) with ESMTP id 283B54683C8; Mon, 20 Nov 2006
 04:29:27 +0200 (EET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> lamikr wrote:
>
>   
>> Hi
>>
>> Following dummyuser test case (me :-) might be usefull for improving docs.
>> I have read the gitweb/README but in addition of that I find out that
>> there is really little documentation about installing gitweb
>> except the Makefile & git-instaweb.sh itself.
>>
>> I would like to install gitweb to /var/run/html/gitweb directory and
>> after reading the git/INSTALL & gitweb/README
>> I came to conclusion that something like following could work
>>
>> 1) build git by changing some of the default gitweb configs as a user
>>     make prefix=/usr all doc GITWEB_SITENAME='gitweb test' \
>>          GITWEB_PROJECTROOT=/var/www/html/gitweb 
>> 2) install git as a root after build
>>     make prefix=/usr install install-doc
>> 3) add following to apache config
>>     <VirtualHost www:80>
>>         ServerName my-web-page
>>         DocumentRoot /gitweb
>>         RewriteEngine on
>>         RewriteRule ^/(.*\.git/(?!/?(info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
>>         SetEnv    GITWEB_CONFIG    /etc/gitweb.conf
>>     </VirtualHost>
>> 4) move git repository (kernel for example) to /var/www/html/gitweb
>>     
> It should be enough to symlink it, given appropriate setup.
>   
Are people usually using symlinks to their "real development"
repositories? Or is it more common to have personal working repository
for example in the own home directory and then the second "public copy"
for http pages? And then configure the personal repository to push the
changes somehow to public one?
That would seem to be more secure even it rises the gap between real and
published changes.

>> 5) restart apache
>> 6) open browser to http://my-web-page/gitweb
>>
>> Obviously something failed, as after step 2, I do not have either the
>> /etc/gitweb.conf or gitweb scripts under directory /var/www/html/gitweb
>>     
>
> First, "make install" does not install the gitweb, as the place where
> it should be installed depends from configuration to configuration.
> By the way, you may compile ony gitweb using "make gitweb/gitweb.cgi"
> with appropriate params. So 2.1) step would be to manually copy
> gitweb.cgi and gitweb.css at least, perhaps also git-logo.png and
> git-favicon.png.
>   
Ok, I did that.
> Second, you have to set up gitweb.cgi as a CGI script, or as legacy
> mod_perl script. I have for example in /var/www/cgi-bin symlink named
> gitweb to directory with gitweb.cgi, gitweb.css etc. and in
> /var/www/perl symplink to the same place.
>
> The CGI configuration for Apache2 is (simplest case, I'd appreciate
> better solutions):
>
>  LoadModule cgi_module modules/mod_cgi.so
>  ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
>  <Directory "/var/www/cgi-bin">
>     Options Indexes FollowSymlinks ExecCGI
>     AllowOverride None
>     Order allow,deny
>     Allow from all
>  </Directory>
>   
Thanks, it seems that in Mandriva the preferred way it to put each of
these to own files under webapps.d directory.
So I created following /etc/httpd/conf/webapps.d/gitweb.conf by using
your script and cgi-script examples from httpd.conf as a help and got
things working.
   
# gitweb Apache configuration file
Alias /gitweb /var/www/gitweb
<Directory "/var/www/gitweb">
    AllowOverride All
    Options ExecCGI FollowSymLinks SymLinksifOwnerMatch
    Order allow,deny
    Allow from all
    RewriteEngine on
    RewriteRule ^/(.*\.git/(?!/?(info|objects|refs)).*)?$
/cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
    SetEnv    GITWEB_CONFIG    /etc/gitweb.conf
</Directory>

Is there btw, any examples from the /etc/gitweb.conf file?

