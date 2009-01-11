From: Morgan Christiansson <git@mog.se>
Subject: Re: git-svn: File was not found in commit
Date: Sun, 11 Jan 2009 19:36:34 +0100
Message-ID: <496A3C32.3070703@mog.se>
References: <49678705.4040506@mog.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Morgan Christiansson <git@mog.se>
X-From: git-owner@vger.kernel.org Sun Jan 11 19:38:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM5CR-0006Q7-91
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 19:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbZAKSgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 13:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbZAKSgt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 13:36:49 -0500
Received: from mog.vm.bytemark.co.uk ([80.68.94.200]:41579 "EHLO mog.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbZAKSgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 13:36:47 -0500
Received: from [192.168.1.182] (81-226-238-170-no61.tbcn.telia.com [81.226.238.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mog.se (Postfix) with ESMTP id 2D8FC80CC4;
	Sun, 11 Jan 2009 18:36:43 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <49678705.4040506@mog.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105196>

Bump. Can anyone give any pointers or ideas for workarounds on this?

Searching the list archives i have found 2 others reporting similair 
problems with git-svn, both which were left unreplied:
http://marc.info/?t=122118776000001&r=1&w=2
http://marc.info/?t=121537770800003&r=1&w=2

I'm stuck at this point - if i can't migrate this repository i cannot 
use git for my work.

Morgan Christiansson wrote:
> Hi, i'm trying to "git svn fetch" my repository from a local file:///
> repo and i'm running into this problem:
>
> $ git svn init -t tags -b branches -T trunk file:///path/to/svn/repo
> $ git svn fetch
> branches/rails/rails/vendor/plugins/acts_as_xapian/.git/refs/heads/master
> was not found in commit a643e882c557593f36bb9fd0966490010b9dba61 (r10576)
>
>
> I found another report that seems to describe the same error:
> http://marc.info/?l=git&m=121537767308135&w=2
> Investigating the the history it's committed in r10577 and it's looking
> for it in r10576, so it seems to be off by one revision number. Exactly
> like the other report.
> I've tried the latest git version of git-svn.perl and the problem is not
> fixed there.
>
>
> $ svn log file:///path/to/repo -r10576:10577 -v
> ------------------------------------------------------------------------
> r10576 | morgan | 2008-11-28 14:35:53 +0000 (Fri, 28 Nov 2008) | 3 lines
> Changed paths:
>   A /branches/rails/rails/app/controllers/browse_sheetmusic_controller.rb
>   M /branches/rails/rails/app/controllers/scores_controller.rb
>   M /branches/rails/rails/app/models/composer.rb
>   M /branches/rails/rails/app/models/score.rb
>   M /branches/rails/rails/config/routes.rb
>
> Commit message.
>
> ------------------------------------------------------------------------
> r10577 | morgan | 2008-11-28 18:31:00 +0000 (Fri, 28 Nov 2008) | 3 lines
> Changed paths:
>   A /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/FETCH_HEAD
>   M /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/config
>   M /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/index
>   M /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/logs/HEAD
>   M
> /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/logs/refs/heads/master 
>
> # <-- THIS FILE
>   M
> /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/logs/refs/remotes/origin/HEAD 
>
>   M
> /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/logs/refs/remotes/origin/master 
>
>   A
> /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/objects/pack/pack-41ebdff27c581340ac7a71850e2e3a7d1cfea138.idx 
>
>   A
> /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/objects/pack/pack-41ebdff27c581340ac7a71850e2e3a7d1cfea138.pack 
>
>   M
> /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/refs/heads/master 
>
>   M
> /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/refs/remotes/origin/master 
>
>   A /branches/rails/rails/vendor/plugins/acts_as_xapian/README.textile
>   M
> /branches/rails/rails/vendor/plugins/acts_as_xapian/lib/acts_as_xapian.rb
>
> Switched repo to git://github.com/Overbryd/acts_as_xapian.git
>
> ------------------------------------------------------------------------
>
>
>
>
> I did some digging in the perl script and managed to generate this stack
> trace, it shows that gs_do_update is called with $rev_a=10576 and
> $rev_b=10577, the file is in $rev_b but it complains it's not found in
> $rev_a.
>
> SVN::Git::Fetcher::open_file('SVN::Git::Fetcher=HASH(0x25faf38)',
> 'branches/rails/rails/vendor/plugins/acts_as_xapian/.git/refs/heads/master', 
>
> 'HASH(0x25fdb00)', 10576, '_p_apr_pool_t=SCALAR(0x24f8978)') called at
> /usr/lib/perl5/SVN/Ra.pm line 623
> SVN::Ra::Reporter::AUTOLOAD('SVN::Ra::Reporter=ARRAY(0x24f8948)',
> 'SVN::Pool=REF(0x24f8528)') called at ../git-svn.perl line 4087
> Git::SVN::Ra::gs_do_update('Git::SVN::Ra=HASH(0x24beac8)', 10576, 10577,
> 'Git::SVN=HASH(0x24f7d18)', 'SVN::Git::Fetcher=HASH(0x25faf38)') called
> at ../git-svn.perl line 2481
> Git::SVN::do_fetch('Git::SVN=HASH(0x24f7d18)', 'HASH(0x24c01f0)', 10577)
> called at ../git-svn.perl line 4227
> Git::SVN::Ra::gs_fetch_loop_common('Git::SVN::Ra=HASH(0x24beac8)',
> 10575, 10724, 'ARRAY(0x1da1c20)', 'ARRAY(0x1da1c50)') called at
> ../git-svn.perl line 1506
> Git::SVN::fetch_all('svn', 'HASH(0x21d6440)') called at ../git-svn.perl
> line 387
> main::cmd_fetch at ../git-svn.perl line 268
> eval {...} at ../git-svn.perl line 266
> branches/rails/rails/vendor/plugins/acts_as_xapian/.git/refs/heads/master
> was not found in commit a643e882c557593f36bb9fd0966490010b9dba61
> (r10576) at ../git-svn.perl line 3271.
>
>
> I'm not sure whether this is correct behavior or not and I'm not
> familiar with SVN::Ra::Reporter... so some help would be appreciated.
>
> Thanks,
> Morgan
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
