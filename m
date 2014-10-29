From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git.pm: add specified name to tempfile template
Date: Wed, 29 Oct 2014 12:50:49 -0700
Message-ID: <xmqqd29ay7s6.fsf@gitster.dls.corp.google.com>
References: <20141029193155.GA2232@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:50:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjZGi-0008AT-JQ
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 20:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762AbaJ2Tuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 15:50:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755556AbaJ2Tuw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 15:50:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 227D819980;
	Wed, 29 Oct 2014 15:50:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aN60RDjsquGzkvgaT1Vyn6gwJIs=; b=eRQhyF
	6g7gf4BZ6ARpntuZTASCqF+aqQDrgOMdRJ72oAlq5y+eZiBK6ksrGoqOR6bNPGUj
	AbuS/S7wk02RJMwqP5kj4hHPyJ+i6fYyji9UIWcEhJfx58yMfHViLuLZw0itTIfN
	ESaVqzAiBiEb2/xJW5TVzXn2e7GaoTkz2kcY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cloGnAxvGnJzaMb91QaF7GLvsZo7zf4n
	bwgQjGyPwiMBJTb0/NVGuK8ORyaosl6NA926oihLp3jNEdoUGIg3RB+2K3Z3gNGU
	iN/QkcXFTQ7zs707qMXBkgvbYjwZQ9UYxzjOHF0THt2KqDUCO0DNHcBqntllmyDY
	M8XRgrYrKHY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1142E1997F;
	Wed, 29 Oct 2014 15:50:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9359D1997E;
	Wed, 29 Oct 2014 15:50:50 -0400 (EDT)
In-Reply-To: <20141029193155.GA2232@dcvr.yhbt.net> (Eric Wong's message of
	"Wed, 29 Oct 2014 19:31:55 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E26E9336-5FA4-11E4-ABBD-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> This should help me track down errors in git-svn more easily:
>
> 	write .git/Git_XXXXXX: Bad file descriptor
> 	 at /usr/lib/perl5/SVN/Ra.pm line 623
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>   Not sure you want to take this separately or in a git-svn pull.
>   Still working on the error this patch is meant to help me find.

Thanks; I think it is OK for it to be part of the git-svn update.
No other active perl/Git.pm user that wants to have access to this
facility early exists as far as I can see ;-)

>
>  perl/Git.pm | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 204fdc6..b5905ee 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1294,8 +1294,11 @@ sub _temp_cache {
>  			$tmpdir = $self->repo_path();
>  		}
>  
> +		my $n = $name;
> +		$n =~ s/\W/_/g; # no strange chars
> +
>  		($$temp_fd, $fname) = File::Temp::tempfile(
> -			'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
> +			"Git_${n}_XXXXXX", UNLINK => 1, DIR => $tmpdir,
>  			) or throw Error::Simple("couldn't open new temp file");
>  
>  		$$temp_fd->autoflush;
