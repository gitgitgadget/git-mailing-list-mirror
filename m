From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb.cgi: fix "comitter_tz" typo in feed
Date: Fri, 12 Oct 2012 08:43:03 -0700
Message-ID: <7v391j66ig.fsf@alter.siamese.dyndns.org>
References: <20121011204035.GA19361@datura.dylex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: Dylan Alex Simon <dylan@dylex.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 17:43:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMhOS-00037H-VB
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 17:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933142Ab2JLPnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 11:43:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933028Ab2JLPnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 11:43:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 520869E1C;
	Fri, 12 Oct 2012 11:43:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wP5X9JatIaerDf77ec2IJhKw0Go=; b=o2m01V
	Z/ipN1gKEnC0IHX9OOw6DEIXNe47K5GIE6dBmR+iM8i/ZL4djUYDGKLNqxaggP/F
	V+pU/VxHqYM/A4fg/e5TVa9MKosLP4Nohst/DS9xQi6fuLvk4XRDBR4cAexTgZay
	5etZQk9pWqXxe9oAG61KOMjXvNU0GzM/EOt4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=juvJsbxP9JIRbINsr7fhbxwRqUPfGlOq
	q/NjFadiwJ2i4AW1Wavr0it3zSf6uNiIExyjh1AUpi0Ip9Rsx0QkmWot+99pnwAr
	u0c9RtmXqM3Bcblma7S+qODlnh5eIzo9OYbX/ZXQ8mCee8BnaTzzbnvyFgIvjQJz
	qQslcf9jkwg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F7519E12;
	Fri, 12 Oct 2012 11:43:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E40059E11; Fri, 12 Oct 2012
 11:43:05 -0400 (EDT)
In-Reply-To: <20121011204035.GA19361@datura.dylex.net> (Dylan Alex Simon's
 message of "Thu, 11 Oct 2012 16:40:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83D2727A-1483-11E2-9EA1-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207548>

Dylan Alex Simon <dylan@dylex.net> writes:

> gitweb's feeds sometimes contained committer timestamps in the wrong timezone
> due to a misspelling.
>
> Signed-off-by: Dylan Simon <dylan@dylex.net>
> ---

This dates back to 6368d9f (gitweb: Always call parse_date with
timezone parameter, 2011-03-19) which was in 1.7.4.2 and has been
moved around without anybody noticing.

For any patch that is more complex, I would say "We've lived with
this bug for a long time and nobody was hurt enough to complain, so
it can wait until the next round", but I'll apply it directly to
'maint' because the fix is so trivially correct.  Otherwise I'll
forget ;-)

Thanks.

>  gitweb/gitweb.perl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7f8c187..10ed9e5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -8028,7 +8028,7 @@ sub git_feed {
>  		%latest_commit = %{$commitlist[0]};
>  		my $latest_epoch = $latest_commit{'committer_epoch'};
>  		exit_if_unmodified_since($latest_epoch);
> -		%latest_date = parse_date($latest_epoch, $latest_commit{'comitter_tz'});
> +		%latest_date = parse_date($latest_epoch, $latest_commit{'committer_tz'});
>  	}
>  	print $cgi->header(
>  		-type => $content_type,
