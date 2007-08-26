From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git.pm: Add remote_refs() git-ls-remote frontend
Date: Sat, 25 Aug 2007 21:26:29 -0700
Message-ID: <7v6432udje.fsf@gitster.siamese.dyndns.org>
References: <20070825221143.6514.22516.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Aug 26 06:26:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP9hv-00008c-KW
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 06:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbXHZE0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 00:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbXHZE0g
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 00:26:36 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbXHZE0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 00:26:35 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5992D126EF4;
	Sun, 26 Aug 2007 00:26:53 -0400 (EDT)
In-Reply-To: <20070825221143.6514.22516.stgit@rover> (Petr Baudis's message of
	"Sun, 26 Aug 2007 00:11:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56671>

Petr Baudis <pasky@suse.cz> writes:

> diff --git a/git-remote.perl b/git-remote.perl
> index 01cf480..8ce8418 100755
> --- a/git-remote.perl
> +++ b/git-remote.perl
> @@ -128,10 +128,7 @@ sub update_ls_remote {
>  	return if (($harder == 0) ||
>  		   (($harder == 1) && exists $info->{'LS_REMOTE'}));
>  
> -	my @ref = map {
> -		s|^[0-9a-f]{40}\s+refs/heads/||;
> -		$_;
> -	} $git->command(qw(ls-remote --heads), $info->{'URL'});
> +	my @ref = keys %{$git->remote_refs($info->{'URL'}, [ 'heads' ])};
>  	$info->{'LS_REMOTE'} = \@ref;
>  }

IIRC, ls-remote returns refs sorted and this function returns
them as it receives.

Doesn't this change make @ref randomly ordered?  
