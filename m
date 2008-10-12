From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: call 'fatal' correctly in set-tree
Date: Sat, 11 Oct 2008 22:34:06 -0700
Message-ID: <7v63nyidgx.fsf@gitster.siamese.dyndns.org>
References: <1222696698-97356-1-git-send-email-luc@honk-honk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Luc Heinrich <luc@honk-honk.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 07:38:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KotfK-00019v-PJ
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 07:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbYJLFeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 01:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbYJLFeU
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 01:34:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbYJLFeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 01:34:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 67E1689F44;
	Sun, 12 Oct 2008 01:34:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3BE1D89F22; Sun, 12 Oct 2008 01:34:09 -0400 (EDT)
In-Reply-To: <1222696698-97356-1-git-send-email-luc@honk-honk.com> (Luc
 Heinrich's message of "Mon, 29 Sep 2008 15:58:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A33033C-981F-11DD-913A-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98002>

Luc Heinrich <luc@honk-honk.com> writes:

> When doing a set-tree and there is no revision to commit to, the
> following unrelated error message is displayed: "Undefined subroutine
> &Git::SVN::fatal called at /opt/local/libexec/git-core/git-svn line
> 2575." The following patch fixes the problem and allows the real error
> message to be shown.
>
> Signed-off-by: Luc Heinrich <luc@honk-honk.com>
> ---
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 80a5728..7609a83 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2591,7 +2591,7 @@ sub set_tree {
>  	my ($self, $tree) = (shift, shift);
>  	my $log_entry = ::get_commit_entry($tree);
>  	unless ($self->{last_rev}) {
> -		fatal("Must have an existing revision to commit");
> +		::fatal("Must have an existing revision to commit");
>  	}
>  	my %ed_opts = ( r => $self->{last_rev},
>  	                log => $log_entry->{log},

Shouldn't the same change be done for the fatal call from apply_diff in
SVN::Git::Editor package?
