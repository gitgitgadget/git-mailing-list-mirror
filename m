From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: forward -q to git-rebase
Date: Tue, 12 Jun 2012 09:54:11 -0700
Message-ID: <7vd354jwss.fsf@alter.siamese.dyndns.org>
References: <1339515815-10752-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 18:54:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeUMU-0008AQ-8X
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 18:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab2FLQyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 12:54:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab2FLQyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 12:54:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B1D195B8;
	Tue, 12 Jun 2012 12:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hf7mh1IoynYRRDFH5o/8h1zTrE4=; b=hJdKnE
	ezExnQP0mGCEc1r+XF7ma8hS6uh+Wikb1p2E3qFoCJdgtmkdhVIeYaDEaAzqjczG
	qVSzxyOKYlrmc+1ASBvcSs/GF+hp4TXXfTJRrw6u1rU2lICiXRmKFRhvdyPqinU+
	y9wzkRT478tIN+ZrKT04ulyXQiA+kW3u8XY7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hdgbNYCOASH2C+TnrTXjgKdIJrbBnCdb
	1zGQHRFFEDYbAlWJ8LDbR7tpRbMazJRJ+TDPvKZQt09KSq6a/Cf8DvPvboUn0/78
	2VMuwIwFVKv17cGmZqVX+SRG1P/EFgEVHruAQmWB5aWr3zWVf5aVJzWA5Wchj/VV
	qv3xe07MXLU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62CFC95B7;
	Tue, 12 Jun 2012 12:54:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFC3F95B6; Tue, 12 Jun 2012
 12:54:12 -0400 (EDT)
In-Reply-To: <1339515815-10752-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Tue, 12 Jun 2012 17:43:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CBF4CD4-B4AF-11E1-AEF8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199812>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> When calling "git svn rebase -q", we still get the message
> "Current branch BRANCHNAME is up to date." from git-rebase, which
> isn't quite as quiet as we could be.
>
> Fix this by forwarding the -q flag to git-rebase.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> I just set up a cronjob that did a "git svn rebase -q", and noticed
> it triggered cron to send me an e-mail every time.
>
> Since I'm not really interested in getting an e-mail every time the
> script does nothing, but I'd like the option to get an e-mail whenever
> it does something useful, perhaps something like this can benefit
> other people as well?

If it matches what you would get from "git pull -q" run in a
cronjob, I would say that is a sensible change to make.

>  git-svn.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 0b074c4..34baa43 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1590,6 +1590,7 @@ sub cmd_gc {
>  sub rebase_cmd {
>  	my @cmd = qw/rebase/;
>  	push @cmd, '-v' if $_verbose;
> +	push @cmd, '-q' if $_q;
>  	push @cmd, qw/--merge/ if $_merge;
>  	push @cmd, "--strategy=$_strategy" if $_strategy;
>  	push @cmd, "--preserve-merges" if $_preserve_merges;
