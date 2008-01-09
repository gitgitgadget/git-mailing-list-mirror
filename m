From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Trim leading / off of paths in git-svn prop_walk
Date: Wed, 09 Jan 2008 12:54:22 -0800
Message-ID: <7v63y2hg8x.fsf@gitster.siamese.dyndns.org>
References: <1199860640-74118-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:55:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JChx1-0005n4-5K
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 21:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYAIUyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 15:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYAIUyg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 15:54:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbYAIUyf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 15:54:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 701BE356E;
	Wed,  9 Jan 2008 15:54:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA3E356B;
	Wed,  9 Jan 2008 15:54:29 -0500 (EST)
In-Reply-To: <1199860640-74118-1-git-send-email-kevin@sb.org> (Kevin Ballard's
	message of "Wed, 9 Jan 2008 01:37:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70014>

Kevin Ballard <kevin@sb.org> writes:

> prop_walk adds a leading / to all subdirectory paths. Unfortunately
> this causes a problem when the remote repo lives in a subdirectory itself,
> as the leading / causes subsequent PROPFIND calls to be executed on
> the wrong path. Trimming the / before calling the PROPFIND fixes this problem.
>
> Signed-off-by: Kevin Ballard <kevin@sb.org>

Eric, the change is very limited in scope (only the parameter to
ra->get_dir() changes) so I can apply myself, if you agree this
is a trivially correct fix.  I just do not know svn-perl
interface well enough to judge.

> All tests passed after this change, but since it seems to only apply
> to WebDAV SVN repos I saw no way to add a new test.
>  git-svn.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 3308fe1..d5316eb 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1858,6 +1858,7 @@ sub rel_path {
>  sub prop_walk {
>  	my ($self, $path, $rev, $sub) = @_;
>  
> +	$path =~ s#^/##;
>  	my ($dirent, undef, $props) = $self->ra->get_dir($path, $rev);
>  	$path =~ s#^/*#/#g;
>  	my $p = $path;
> -- 
> 1.5.4.rc2.68.ge708a-dirty
