From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] git-remote-mediawiki: don't compute the diff when
 getting commit message
Date: Tue, 26 Jun 2012 10:47:32 -0700
Message-ID: <7v8vfac6dn.fsf@alter.siamese.dyndns.org>
References: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340726673-25496-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pavel.Volek@ensimag.imag.fr,
	Kim-Thuat.Nguyen@ensimag.imag.fr, roucherj@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 26 19:47:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjZrc-0002fx-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 19:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab2FZRrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 13:47:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab2FZRrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 13:47:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 322D899B6;
	Tue, 26 Jun 2012 13:47:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oImPXB4L7QpslcYhGIe8o+LT0TE=; b=EcS2v0
	OChTFE7ALgQl2q37egVyxlVQh5E2zfjPMpK+6duZ7CBSBWhGDYbLF3kN/FVWg5Uw
	yQwPlij4j2JEcD4WDiLCDcPqdWnH/vRwXR8RotJhMCsAKdjKipGI3WeAPt/Uifbo
	6CGfN2CTjRNrSd11KQ2IJJqeMFQmzbjF5qg10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gX0b+pnKmIRTO2hZFZfWHsfcy+MQC295
	snG/yyHNT7G3w5xK+c4qB6uTGXtpHXSERZ9BnPm7Oe18H+FgKwfH5E6fLtTKxac4
	8Lqi9B/40qyotOOdU0Ak6w/6OWG2THLKUXiSTN/7/GbKFQwLW5DbtmAuteb2FanZ
	pLQsHXi0V6k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 287EE99B5;
	Tue, 26 Jun 2012 13:47:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D9E599B4; Tue, 26 Jun 2012
 13:47:38 -0400 (EDT)
In-Reply-To: <1340726673-25496-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Tue, 26 Jun 2012 18:04:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 054178B4-BFB7-11E1-9C63-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200662>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> ---

Not signed off yet?

>  contrib/mw-to-git/git-remote-mediawiki | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
> index a34f53f..a8e6287 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki
> @@ -874,8 +874,7 @@ sub mw_push_revision {

Curious.  The hunk replaces an old line with a new one, but somehow
claims to reduce 8 to 7 by one???

>  		# TODO: for now, it's just a delete+add
>  		my @diff_info_list = split(/\0/, $diff_infos);
>  		# Keep the first line of the commit message as mediawiki comment for the revision
> -		my $commit_msg = (split(/\n/, run_git("show --pretty=format:\"%s\" $sha1_commit")))[0];
> +		my $commit_msg = (split(/\n/, run_git("log -1 --format=\"%s\" $sha1_commit")))[0];
>  		chomp($commit_msg);
>  		# Push every blob
>  		while (@diff_info_list) {
