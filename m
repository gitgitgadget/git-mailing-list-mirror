From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] Git::Repo API and gitweb caching
Date: Fri, 11 Jul 2008 11:33:09 +0200
Message-ID: <200807111133.11662.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 11:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHF1D-0001Kn-Py
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 11:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbYGKJd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 05:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYGKJd0
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 05:33:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:5782 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYGKJdZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jul 2008 05:33:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1510628fgg.17
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6uAUBukmrJyNN7Fh9a49qsikjvvL6vdMaeh6h9aF08g=;
        b=uEH3S2Vdpgf+MwPlfyEN+zzQvcsLmFilSEnO4X7We0AizG9cXADJ7dqI0C0Ewyv3Tr
         sYrcAsWIEiJVXeCZrYNbJBPKRETxxZR00DyYer8Ve8ihT14mIS3ank8qzBZ0S3krHlsy
         S8C/3x1TAkYNawHkFVTEicKobd0vCNVrL+lLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kfwucJoVPwZyCLdm9mXyEt9V8d7cUdDMQdxi4p/TJ7wfxmxQbocB5zjWppGbPHkqZw
         yNcLV0oPMFOw16Oj0Hz5iFgGmvBvWAn08Eoa3peJhlJz63VMw3cMPa577e9TI9ATNwmk
         sroSRljqgkvSmYWD+Qs1dYmvrO9+d7DNXEr8I=
Received: by 10.86.91.12 with SMTP id o12mr9553205fgb.1.1215768803371;
        Fri, 11 Jul 2008 02:33:23 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.227.34])
        by mx.google.com with ESMTPS id 4sm652376fge.5.2008.07.11.02.33.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jul 2008 02:33:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4876B223.4070707@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88102>

On Fri, 11 July 2008, Lea Wiemann wrote:

> As follow-ups to this message, I'll be sending three patches for
> 
> 1) adding the Mechanize tests,

Somehow I didn't get Cc-ed this patch...

> The Mechanize tests succeed before and after patch (3) is applied, so
> I'm reasonably confident that my refactoring didn't introduce any
> (major) bugs.

If I remember correctly Mechanize tests detected some bugs in gitweb
(nice!), but there were swept under the rug, i.e. put as TODO.

Does that mean that those errors were corrected, or that refactoring
"just" didn't break anything more?

> On my to-do list:
> 
> - Benchmarks.  I'm planning to time a replay of kernel.org's gitweb logs
> on the test server, with and without caching.  Nothing fancy.  (The
> performance of the test setup on odin3.kernel.org is not representative
> of gitweb's actual performance under load.)

Do you plan to compare other gitweb caching implementations? I mean
here old kernel.org caching by J.H., and repo.or.cz caching (only for
projects list page) by Pasky.

> - Implement support for Last-Modified or ETags, since those basically
> fall out for free with the current implementation.  (This will require
> mod_perl, since CGI doesn't allow for accessing arbitrary request
> headers AFAIK.)

>From CGI(3pm):

       http()
           Called with no arguments returns the list of HTTP environment vari-
           ables, including such things as HTTP_USER_AGENT, HTTP_ACCEPT_LANGUAGE,
           and HTTP_ACCEPT_CHARSET, corresponding to the like-named HTTP header
           fields in the request.  Called with the name of an HTTP header field,
           returns its value.  Capitalization and the use of hyphens versus under-
           scores are not significant.

           For example, all three of these examples are equivalent:

              $requested_language = http('Accept-language');
              $requested_language = http('Accept_language');
              $requested_language = http('HTTP_ACCEPT_LANGUAGE');


>From http://hoohoo.ncsa.uiuc.edu/cgi/env.html

  In addition to these, the header lines received from the client, if
  any, are placed into the environment with the prefix HTTP_ followed
  by the header name. Any '-' characters in the header name are changed
  to '_' characters. The server may exclude any headers which it has
  already processed, such as Authorization, Content-type, and
  Content-length. If necessary, the server may choose to exclude any
  or all of these headers if including them would exceed any system
  environment limits.

So you _can_ access 'If-Modified-Since', 'If-None-Match' (by web browsers)
and 'If-Not-Modified-Since', 'If-Match' (by caches) from CGI.

> That will make the site a tad more responsive, I hope,
> and it will also hugely reduce the load for RSS/Atom requests, which
> currently make up almost half of all requests to kernel.org's gitweb and
> get served in full each time (i.e. "200 OK" instead of "304 Not Modified").

Currently only one "shortcut" is that gitweb respects HEAD request
(returning only HTTP headers) for feeds, and if I remember correctly
only for feeds.  I don't know however how much work gitweb does before
HEAD request shortcut.

> - Make gitweb use more parts of the Git::Repo API; in particular, the
> commit and tag parsing code should be ripped out, and gitweb should use
> the (much prettier) Git::Commit/Git::Tag API instead.  Perhaps some more
> functions (like ls_tree) can be generalized into the API as well; I went
> the easy route for now and simply replaced most "open '-|'" calls with
> $repo->cmd_output calls.

I think that ls_tree and git-ls-tree output parsing should be
generalized into Git::Tree API as well.


I'll try to review the rest of patches by tomorrow...
-- 
Jakub Narebski
Poland
