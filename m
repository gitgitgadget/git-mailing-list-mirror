From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb and remote branches
Date: Thu, 30 Aug 2007 10:16:15 +0200
Message-ID: <200708301016.17552.jnareb@gmail.com>
References: <favitd$3ff$1@sea.gmane.org> <200708300001.39203.jnareb@gmail.com> <cb7bb73a0708300018u37f5c465u5d87eae0eb23543c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 10:16:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQfCw-0007cW-3m
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 10:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbXH3IQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 04:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465AbXH3IQZ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 04:16:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:8789 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbXH3IQY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 04:16:24 -0400
Received: by nf-out-0910.google.com with SMTP id f5so401695nfh
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 01:16:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=euwvm6+qz8b00qHlR7p/fGp4CsA5uuNOk6+GONxijIvb4xyDuvCSSwsRAMpGJXWWDk9bLY4yn8TV6vQhWSEfr3ORU1cvY5+1eV4paRj2RSjfsE5l2Xz9SXoW13Ly4pZmF4oVh7vxJTcVkIHNlh4hoWR3FeJiyUHVDs2B9WsQ+wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uHpc0jQ88UEsA0glwlLIzsqdF9wTyvuSziwWgRaUAszRX4ZyZ4OHRA3wMZxigLzwPjJk1Z4bYqOEdFFuiO9G/RtYAY3SetwfqkrUEjJaXx0CvQ6wyhaWc8JRhkKKxZ5QSbCyBp7Fcdo0CIsIFJ4IzDDP0OZxrMyd6fRGWtalFaw=
Received: by 10.86.90.2 with SMTP id n2mr210591fgb.1188461782386;
        Thu, 30 Aug 2007 01:16:22 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id p9sm453236fkb.2007.08.30.01.16.19
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Aug 2007 01:16:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0708300018u37f5c465u5d87eae0eb23543c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57011>

On Thu, 30 August 2007, Giuseppe Bilotta wrote:
> On 8/30/07, Jakub Narebski <jnareb@gmail.com> wrote:

>> First, in the idea to show also remote branches (from refs/remotes),
>> I wanted to separate heads list from remotes list in the 'summary'
>> view, and add 'remotes' view or modify 'heads' view to accept some
>> parameter specyfying kind of refs.
> 
> What I had in mind was a way to modify 'heads' view with a boolean
> option that enable/disabled remotes view.

That is a good idea. We can for example use extra_options ('opt')
parameter to pass 'refs/remotes' etc. to 'heads' view. Or we can
use some new CGI parameter. Or just make it configurable in gitweb
configuration, with per repository override, i.e. make it into
%feature.

> For their visualizations, I 
> had in mind a split 'heads' secion, with the lhs being as it is now,
> and the rhs having the remotes.

Care to provide some ascii-art mockup?

What I had in mind was for 'summary' view (*bold*, _underline_):

  [heads]
  27 min ago       _gitweb-allheads_   shortlog | log | tree
  24 hours ago     master 	       shortlog | log | tree

  [remotes]
  *origin*
    24 hours ago    man        shortlog | log | tree
    24 hours ago    html       shortlog | log | tree
    24 hours ago    next       shortlog | log | tree
    24 hours ago    pu         shortlog | log | tree
    24 hours ago    _master_   shortlog | log | tree
    2 weeks ago     maint      shortlog | log | tree
    2 weeks ago     todo       shortlog | log | tree

and similarly for 'remotes' view (or 'heads').

Note that we remove remote name from remote branch name, although
we can leave it as is (i.e. origin/man vs. man), and that we filter
out HEAD if it points to existing branch, marking one of the branches
as current instead.

That reminds me that gitweb has no support for detached HEAD as of yet,
although I don't think we want to encourage detached HEAD in public 
repo.

> However, I wasn't sure if such a view would have been appreciated, so
> I went for the merged view and used the spans to make the heads appear
> as they do in the shortlog, as a clear way to mark which ones were
> local and which ones were remote.

On

  http://oblomov.dnsalias.org/git?p=git.git;a=heads

I don't see any difference between formatting of remote heads and local
branches.
 
>> Second, what was stopping me from implementing that was an idea to
>> separate remote branches into categories (like gitwbe-xmms2
>> categories of projects) defined by the remote it belongs to. And
>> this is not so easy if we want to respect old .git/branches/
>> and .git/remotes/ remote config in addition to new config based
>> remote config. 
> 
> I don't know what gitweb-xmms2 does, but I think I understand what you
> mean, and I like the idea.

See my mockup and 'summary' view of gitweb-xmms2 installation:
  http://git.xmms.se/

> However, it's even harder if you consider 
> that even the latest git-svn plops all the svn-converted refs straight
> into refs/remotes and not in a subdir such as refs/remotes/svn.

Or refs/svn. I think that dumping remotes directly into refs/remotes
and not to refs/remotes/<remote> is a bug (also in git-svn).

> OTOH, we have to start from somewhere so we can build the feature
> step by step. 

We can start without separating into remotes category-like, i.e.
with the following mockup:

  [remotes]
    24 hours ago    origin/man        shortlog | log | tree
    24 hours ago    origin/html       shortlog | log | tree
    24 hours ago    origin/next       shortlog | log | tree
    24 hours ago    origin/pu         shortlog | log | tree
    24 hours ago    _origin/master_   shortlog | log | tree
    2 weeks ago     origin/maint      shortlog | log | tree
    2 weeks ago     origin/todo       shortlog | log | tree

 
[...]

> I'll be working on it here
> 
> http://oblomov.dnsalias.org/git?p=git.git;a=shortlog;h=gitweb-allheads
> 
> and keep you posted on my progress.

You can also make a git fork at http://repo.or.cz

-- 
Jakub Narebski
Poland
