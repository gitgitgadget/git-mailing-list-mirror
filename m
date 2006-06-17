From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 00:48:12 +0200
Organization: At home
Message-ID: <e720r0$qdv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jun 18 00:48:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrjaX-0003OG-5y
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 00:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWFQWsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 18:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWFQWsN
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 18:48:13 -0400
Received: from main.gmane.org ([80.91.229.2]:52166 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751046AbWFQWsN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 18:48:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FrjaN-0003Me-7x
	for git@vger.kernel.org; Sun, 18 Jun 2006 00:48:11 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 00:48:11 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 00:48:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22040>

Petr Baudis <pasky@suse.cz> writes:
>  - we might want to have a configuration mechanism in place
>    before enhancing gitweb.  My gut feeling is that we can use
>    [gitweb] section in project.git/config (and probably
>    duplicate first and deprecate later existing "description" as
>    well).

The problem is we have different types of configuration in gitweb, and we
should take care where to put appropriate configuration options/variables.

- build time options, like $gitexecdir ($gitbin now) or $gitweb_version 
  ($version now) which could be set at build time a la ./configure i.e
  my $gitexecdir = "@GIT_EXEC_DIR@"; or something like that.

- gitweb installation options (gitweb version need not to correspond to 
  git version, and we could theoretically have more than one gitweb
  installation while one git-core installation). It was proposed to put
  such options on gitweb.conf file in the same directory as gitweb.cgi.
  Unfortunately if one would want to use git-repo-config for managing
  gitweb.conf one is out of luck: git-repo-config uses $GIT_DIR/config.

  Among installation options we could put also defaults for repository-wide
  (repository specific) options.

  Global gitweb options include:
  * $projectroot - absolute fs-path which will be prepended to the 
    project path, i.e. where projects to display are located (dir)
  * $projects_list - source of projects list (file)
  * $home_text - html text to include at home page (file)
  * $stylesheet - default gitweb stylesheet (file)
  * $git_temp - where to place temporary files (dir)

- repository specific options, of which gitweb for now uses only 
  $GIT_DIR/description, and which could use repository configuration,
  [gitweb] section.

  Repository specific options [can] include:
  * description - One line description of repository; 
    theoretical problem: HTML escaping.
  * blame - to make 'blame'/'annotate' interface available.
  * blobmimemapfile - for repository specific mime map for blob_plain.
  * favicon - if default favicon is not used.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
