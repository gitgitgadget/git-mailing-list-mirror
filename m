From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: ignore changeless commits when checking
	for a cherry-pick
Date: Wed, 6 Jan 2010 21:43:38 +0000
Message-ID: <20100106214338.GA5115@dcvr.yhbt.net>
References: <1262808529-1575-1-git-send-email-amyrick@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sam@vilain.net
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 22:43:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSdfY-0005fY-Ne
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 22:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890Ab0AFVnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 16:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879Ab0AFVnl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 16:43:41 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49714 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932867Ab0AFVnk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 16:43:40 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 3EA9D1F4F3;
	Wed,  6 Jan 2010 21:43:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1262808529-1575-1-git-send-email-amyrick@apple.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136301>

Andrew Myrick <amyrick@apple.com> wrote:
> diff --git a/git-svn.perl b/git-svn.perl
> index 650c9e5..8c7c034 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3052,12 +3052,36 @@ sub check_cherry_pick {
>  	for my $range ( @ranges ) {
>  		delete @commits{_rev_list($range)};
>  	}
> +        for my $commit (keys %commits) {

Hi Andrew,

I'll again defer to Sam for Acks on these.  Test cases would be nice to
have, too.

A few notes:

The prevailing standard for indentation in git is with hard tabs and
that's certainly the case with the rest of git-svn.perl.

> +sub has_no_changes {
> +        my $commit = shift;
> +
> +        my @revs = split / /, command_oneline(
> +                qw(rev-list --parents -1 -m), $commit);
> +
> +        # Commits with no parents, e.g. the start of a partial branch,
> +        # have changes by definition.
> +        return 1 if (@revs < 2);
> +    

I've become very picky about trailing whitespace (from Junio :), too.
"git diff --check" is helpful for this, especially in the pre-commit
hook.

Thanks!

-- 
Eric Wong
