From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: suggestions for gitweb
Date: Mon, 14 May 2007 18:49:35 +0200
Message-ID: <200705141849.36457.jnareb@gmail.com>
References: <20070512205529.GS14859@MichaelsNB> <20070514085314.GY14859@MichaelsNB> <20070514095857.GI4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael Niedermayer <michaelni@gmx.at>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon May 14 18:45:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HndfX-0001Hr-9X
	for gcvg-git@gmane.org; Mon, 14 May 2007 18:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbXENQpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 12:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755472AbXENQpA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 12:45:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:53842 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172AbXENQo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 12:44:59 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1381386uga
        for <git@vger.kernel.org>; Mon, 14 May 2007 09:44:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=E5fq5lAPq0oK17HXAl7xQ5YgmXnD6hcfZNvsbPgk8P/I1f6qQOlSPSYvldQc/L606mYWKTsz6WtcCoqL5MgNIzg54QYxnVCD+IDVAOVqEGHxhzrHlbjAN8/v3yfqgJWLpzP4HYrEhGr8ZbIzpa5Y9wf0/sZbq3Ml1noQj0HZYeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=OEotcLq1QJBIUOTdJhct+si38+qT7v3iQEyW6T4I0sDEWtOrhhhPLCvYEcxQhfAS6GYuNV0n6TrVAlAsmXp8oF+wMirdbixuVEkaYQ6I4/toZED/dkoV37cA8iLh+GU+7dV4uA9rUg0hmI4qZ5iGFEOFyjrZsdRXw3fqh5szBxo=
Received: by 10.67.25.9 with SMTP id c9mr5335282ugj.1179161097673;
        Mon, 14 May 2007 09:44:57 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id x26sm11545156ugc.2007.05.14.09.44.54;
        Mon, 14 May 2007 09:44:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070514095857.GI4489@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47269>

On Mon, 14 May 2007, Petr Baudis <pasky@suse.cz> wrote:
> On Mon, May 14, 2007 at 10:53:15AM CEST, Michael Niedermayer wrote:

>> also file size and last modified dates would be interresting on the tree
>> page
>> viewvc displays on its equivalent page, time since last change
>> svn revission of the last change, the author/commiter of the last change
>> and the corresponding abbreviated log entry
> 
>   I guess this is much easier to retrieve in svn than in git - you
> actually have to walk all the history to figure out this information as
> there's no global per-file info; so this is very troublesome
> performance-wise. I think there were some patches on the mailinglist
> that dit this, though I'm not sure. Might be reasonable to cache this
> (and git history properties make it possible to nicely make a very
> easily reusable cache for this information).

I have sent some implementations of tree_blame, without any core
support, directly in Perl (in gitweb), just like early versions of
git-annotate. It did suck performance-wise quite a bit. You can find
it in 'gitweb/tree_blame' branch in my git repository at repo.or.cz

  http://repo.or.cz/w/git/jnareb-git.git?a=shortlog;h=gitweb/tree_blame

I think it would be nice to have --blame option to git-ls-tree 
(optionally copuled with --porcelain and perhaps --incremental, like
in git-blame), which would return blame information for tree entries.
It means that for each tree entry return commit closest to given commit
(or furthest from a given commit) which has changed entry to current
version. It should be much easier and faster than to do "blob"-blame.

The --porcelain would also return 'last changed' info, like committer
info for a commit-which-changed.

But is this info actually interesting, or is it there in ViewVC because
it is easy to get this info in CVS and Subversion? The "last changed"
info for tree entries encourages to think of a history as a collection
of per file histories... while git is all about whole project history.
Note that history of two files is *more* than concatenation of
histories of those individual files. See entries on GitFaq wiki page:
 
>   About file sizes, that also has some extra performance hit, but in
> this case I suspect that it would be totally negligible (if implemented
> at the plumbing level) - and I admit that I would like to see file sizes
> too, they can help orientation in a foreign source tree a lot.

It should be very easy to add --long / --sizes option to git-ls-tree
which would return file sizes, perhaps after mode info.

-- 
Jakub Narebski
ShadeHawk on #git
Poland
