From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list (templating)
Date: Tue, 30 Sep 2008 14:45:26 +0200
Message-ID: <200809301445.28025.jnareb@gmail.com>
References: <200809251230.11342.jnareb@gmail.com> <200809251852.23315.jnareb@gmail.com> <20080925171029.GQ10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 30 14:47:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkecu-0000iD-7c
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 14:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbYI3Mpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 08:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbYI3Mpi
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 08:45:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:17439 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbYI3Mph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 08:45:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so34581fgg.17
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=C9I8KueGIkhIEteJolM8rpcsneNK21xxgOrjTgP6NgU=;
        b=HRlfFzKZquAifDiHvVjrXhXK7kI7TCeXMq+PDd3UgQN9PHQ1oi0jnGZ2VksYHOSfvE
         Qxi4KDH6xCSAhXFeouVOIXnmqrF/zDETJEaIzGikqOZU6/Z8n4NT2GTbQG5HPvCj4CH6
         EH4q9ZT0gMrbkRWzWysBpzjqlry+dVUfyiloM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oWTw505FO1z72oAZ7lkeUOh3O9nMSchCJV1LcRqn1TLo+hd60eZCQXlj8h9h1DP8eK
         Kt9v3vM3UB7WA+s00GKrFhW1QQeXCspAjSjUjL4XNHfuCmM6lYeD7VHsBABVwRBEzshQ
         mzwjncHrFYmfL09Vgox54sTDz2t3+o7C0eHpM=
Received: by 10.86.98.10 with SMTP id v10mr5546283fgb.46.1222778735522;
        Tue, 30 Sep 2008 05:45:35 -0700 (PDT)
Received: from ?192.168.1.11? (abvy102.neoplus.adsl.tpnet.pl [83.8.222.102])
        by mx.google.com with ESMTPS id d4sm2912740fga.5.2008.09.30.05.45.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 05:45:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080925171029.GQ10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97107>

On Thu, 25 Sep 2008, Petr Baudis wrote:
> On Thu, Sep 25, 2008 at 06:52:22PM +0200, Jakub Narebski wrote:

> > I think that making gitweb use something like Gitweb::Template, where
> > action appearance is governed by templates, be it something like
> > git-for-each-ref --format or StGit *.tmpl files, or XSLT / XSL,
> > could be a good idea.  But I think _that_ would require almost writing
> > from scratch, certainly making it long-term gitweb fork, perhaps even
> > with different name (and not residing inside git.git repository).
> > 
> > We can discuss this idea here in this subthread.  For example: do
> > create Gitweb::Template like HTML::Template or use Template Toolkit;
> > which parts put in template and which in "gitweb" driver, etc.
> 
> Actually, my implementation works quite differently - the idea of the
> templates is that you just specify data from which files to show and
> whether to take them right away or tabulate them in some way - so it is
> something very abstract, and agnostic to _presentation_ layer, which is
> still provided by gitweb. An example of made-up template configuration
> file would look something like:
> 
> [action "summary"]
> 	sections = metadata overview README shortlog forks
> 
> [section "overview"]
> 	type = csv
> 	row = Project Title,(info.txt:title)
> 	row = Project Authors,(info.txt:authors)
> 	row = Bussiness Impact,(info.txt:bizimpact)
> 	row = Base Equation,[formula.png]
> 
> [section "README"]
> 	type = html
> 	content = (README.html)
> 
> (where info.txt is another gitconfig-ish file in tree root, one that
> the user actually touches).
> 
> When I post the patch, I will probably apply it to repo.or.cz too so
> that I can show-case this in practice.

After reading above I'm not sure if what you think about as templating
system for gitweb is the same as I am talking about when thinking about
something like Gitweb::Template.

It looks like you are thinking about having templating system inside
gitweb, with templates describing page layout and view.  Reusing git
ini-like config syntax as (from what I understand) a kind of declarative
layout language (like for example Metafont and MetaPost used in TeX)
would be not that bad idea then; it certainly would avoid adding extra
dependencies on additional Perl modules, and reduce a bit size of code
to be added to deal with templating... if only git config syntax was
not such _limited_ language.  Git ini-like syntax is domain-specific
language meant for storing 2-level and 3+-level hierarchical
configuration; abusing it for templating system would be like writing
A.I. in COBOL.  Also to write all this constraint declarative part
of templating language would be lot of work, I'm not sure if more
work than implementing simple templating system from scratch.

I am thinking about something which would be rather alternate to
gitweb, rather than expanding it.  Gitweb started as simple single-file
CGI script to view and browse git repositories on the web; it is not
modular, and not much embeddable.  But it is easy to install; somewhat
harder than when it was single file (now there is script itself, CSS
and images), but in some parts easier (you don't have to edit file by
hand to make it find repositories and git binary, and to configure it).
Nevertheless easy installation is one of its advantages 
(see also git-instaweb).

Currently (after a bit of research and asking on #perl) I am thinking
about having it either as Template Toolkit[1] plugin (Template::Git or
Template::Plugin::Git) for getting data from git repositories, used
in place of usual DBI/database access module, and as Template Toolkit
filter (Template::Plugin::Gitweb or something like that) for massaging
output, like for example relative/absolute date formats and such,
or as plugin for Catalyst[2] MVC framework.  (Well TT (Template Toolkit)
can be used by Catalyst, so if it is TT module it can be used in
Catalyst).

But this won't be gitweb; more like GitHub.


For example if there was 'gitweb' Template Toolkit the 'shortlog' view
could look like this:

  [% USE Git(projectroot,project) %]
  [% INCLUDE header project=project %]
  ...
  [% FOREACH commit IN repo.log %]
  ...
  [% END %]

Note: I do not know TT, so there might be glaring errors there


References:
===========
[1] http://template-toolkit.org
[2] http://www.catalystframework.org/

P.S. Do anybody know any declarative (constraints based) templating
engine (templating system)? Preferably in Perl...
-- 
Jakub Narebski
Poland
