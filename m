From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] git-remote-mediawiki: actually send empty comment
 when they're empty
Date: Mon, 16 Jul 2012 11:13:06 -0700
Message-ID: <7vd33v377x.fsf@alter.siamese.dyndns.org>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342440053-3058-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 20:13:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqpnS-0003go-DJ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 20:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab2GPSNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 14:13:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59947 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356Ab2GPSNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 14:13:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21870894B;
	Mon, 16 Jul 2012 14:13:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=89ML178l8Ez0WReiaJtd7aRyrFA=; b=W0RQfE
	y9TQMcFsH4bVgypbSiRqVbn2PyYoksrE5Dg9/kCbcPZnK7DkPTDIksfunNYQiPQw
	4RlXy8FfptsITzCwTcD+fuFzGORJlTxLi6GfoxXHjHtrJpndPga1xKRl6PSVRufr
	8mTQmd22Li951JlLJJlbqP6BBXuuNb9fmHwCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=quv3e8+w3AnCeGpzJpGkmIIe8pizPd2A
	aYl/KcwbP6oyKoF6zZy9hzAYk6bc1W+wDXauJiOgkNcagnjf+NFRhBOxoXdfu/S5
	1pcrrlvBx1eh/ufoyFOaR1wFjFagZjBgv3NN1MACgJni9GThXpbU0aGK0eM9hle2
	gS2/++anQo4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F371894A;
	Mon, 16 Jul 2012 14:13:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BF498949; Mon, 16 Jul 2012
 14:13:07 -0400 (EDT)
In-Reply-To: <1342440053-3058-3-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 16 Jul 2012 14:00:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4C9B180-CF71-11E1-8734-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201539>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
> index a6ad8cf..a2da52f 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki
> @@ -51,6 +51,9 @@ use constant EMPTY_CONTENT => "<!-- empty page -->\n";
>  # used to reflect file creation or deletion in diff.
>  use constant NULL_SHA1 => "0000000000000000000000000000000000000000";
>  
> +# Used on Git's side to reflect empty edit messages on the wiki
> +use constant EMPTY_MESSAGE => '*Empty MediaWiki Message*';
> +

Is there a reason why this sentinel value cannot be a real empty
string?

Not that I am complaining, as I find it highly unlikely for a
message stored in mw to be exactly "*Empty MediaWiki Message*", but
just wondering.

>  my $remotename = $ARGV[0];
>  my $url = $ARGV[1];
>  
> @@ -935,7 +938,7 @@ sub mw_import_revids {
>  
>  		my %commit;
>  		$commit{author} = $rev->{user} || 'Anonymous';
> -		$commit{comment} = $rev->{comment} || '*Empty MediaWiki Message*';
> +		$commit{comment} = $rev->{comment} || EMPTY_MESSAGE;
>  		$commit{title} = mediawiki_smudge_filename($page_title);
>  		$commit{mw_revision} = $rev->{revid};
>  		$commit{content} = mediawiki_smudge($rev->{'*'});
> @@ -1050,6 +1053,10 @@ sub mw_push_file {
>  	my $oldrevid = shift;
>  	my $newrevid;
>  
> +	if ($summary eq EMPTY_MESSAGE) {
> +		$summary = '';
> +	}
> +
>  	my $new_sha1 = $diff_info_split[3];
>  	my $old_sha1 = $diff_info_split[2];
>  	my $page_created = ($old_sha1 eq NULL_SHA1);
