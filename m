From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Statictics on Git.pm usage in git commands (was: [PATCH 2/3] add new Git::Repo API)
Date: Sun, 20 Jul 2008 02:16:36 +0200
Message-ID: <200807200216.37260.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <200807192254.24622.jnareb@gmail.com> <20080719211403.GA10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 20 02:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKMce-0001cr-2G
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 02:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbYGTAQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 20:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbYGTAQr
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 20:16:47 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:43524 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbYGTAQq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 20:16:46 -0400
Received: by mu-out-0910.google.com with SMTP id w8so559003mue.1
        for <git@vger.kernel.org>; Sat, 19 Jul 2008 17:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WIW3cezx1RdEOv03npoZIdEv900Rg+6S/en+U4UAHrA=;
        b=AQrG3L7F7PSrEQ6S085MLqOE2Pdyj2xte/PKEOE4U6nbWOegdlMjOG1+xOBEp26V/o
         qO67uVxASUsPfBxX/y6j7L4y4hB8vPkkJ42zq70NnqN1oud0N+m+tZmOQE+p/8TEEAUn
         c0toyboNciol7qMdiFObyGhnvBxwh7MYSDMqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fy//4tv3uDi1+m53kB+PYtg9wM3T/ZP62Np4ebyz7j24VL86LHHV2iXOq2nvSDcXOt
         GUowLnShXWjNsLXbQj5ehSS5ELMo38TGgFwoNofWER1AQKHs7KSvn4Y+GgxgvGbR+LkO
         i4JlFIlX0/7e7mFaPhcLKZJiARNu1t7JEAZ6U=
Received: by 10.103.131.18 with SMTP id i18mr1370008mun.126.1216513004252;
        Sat, 19 Jul 2008 17:16:44 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.237.89])
        by mx.google.com with ESMTPS id y37sm12455739mug.9.2008.07.19.17.16.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Jul 2008 17:16:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080719211403.GA10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89146>

On Sat, 19 July 2008, Petr Baudis wrote:
> On Sat, Jul 19, 2008 at 10:54:24PM +0200, Jakub Narebski wrote:

> > 3. git-send-email.perl uses 5 config, 2 config_bool, 2 ident_person
> >    (for author and for committer), 1 version, and of course once
> >    ->repository() constructor.  
> > 
> >    Here we can see how to work around current API to: it uses
> >    Git::config(@repo, "sendemail.identity") form, where 
> >    	my $repo = eval { Git->repository() };
> >    	my @repo = $repo ? ($repo) : ();
> >    to make it work both with git repository (using repo config), and
> >    outside/without git repository, using only user and system git
> >    config.
> 
>   With the envisioned model, it could use $git which would be either
> a reference to a Git::Standalone singleton or Git::Repo instance.

So that the code would look like the following, instead:

  my $git = new Git::Cmd; # or Git::Standalone, or Git::CommandFactory
  my $repo = eval { Git->repository() };
  $git = $repo if $repo;

and later use

  $git->config('sendemail.identity');


By the way, git-svn can use command(...) instead of $repo->command(...)
because it sets $ENV{'GIT_DIR'} if it is unset... but I don't see
where Git.pm inserts 'git' to commands list...
-- 
Jakub Narebski
Poland
