From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH/RFC 2/2] git-svn: Don't allow missing commit parent to
 stop  git-svn
Date: Thu, 22 Apr 2010 08:07:50 +1200
Message-ID: <1271880470.20208.47.camel@denix>
References: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 22:07:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4gDE-0006PP-GU
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 22:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab0DUUHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 16:07:51 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:38934 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab0DUUHu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 16:07:50 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 6C78A21C370; Thu, 22 Apr 2010 08:07:45 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id CE26E21C370;
	Thu, 22 Apr 2010 08:07:40 +1200 (NZST)
In-Reply-To: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145450>

On Tue, 2010-04-20 at 14:30 -0700, Michael Olson wrote:
> Instead, fall back to assuming that the incoming merge is a bunch of
> cherry-picks and ignore it.
> 
> Signed-off-by: Michael W. Olson <mwolson@gnu.org>
> ---
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 0e1feb3..1a53709 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3110,7 +3110,7 @@ sub check_cherry_pick {
>  	my %commits = map { $_ => 1 }
>  		_rev_list("--no-merges", $tip, "--not", $base);
>  	for my $range ( @ranges ) {
> -		delete @commits{_rev_list($range)};
> +		eval { delete @commits{_rev_list($range)} };
>  	}
>  	for my $commit (keys %commits) {
>  		if (has_no_changes($commit)) {

If the _rev_list here fails, it means it was passed in a bad range.
This means that the calling code somehow ends up with a commit ID
which doesn't exist.  It's normally better to detect errors when
they happen, not deeper into other functions when they break things...

Sam
