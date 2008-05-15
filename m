From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix sed syntax in t7502-commit for OSX
Date: Thu, 15 May 2008 01:37:41 -0700
Message-ID: <7vwslwgdyi.fsf@gitster.siamese.dyndns.org>
References: <1210817948-72280-1-git-send-email-git-dev@marzelpan.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sbejar@gmail.com
To: Marcel Koeppen <git-dev@marzelpan.de>
X-From: git-owner@vger.kernel.org Thu May 15 10:39:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwYzI-0005SK-87
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 10:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbYEOIiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 04:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYEOIiE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 04:38:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYEOIiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 04:38:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D07064C88;
	Thu, 15 May 2008 04:37:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1A4F44C87; Thu, 15 May 2008 04:37:50 -0400 (EDT)
In-Reply-To: <1210817948-72280-1-git-send-email-git-dev@marzelpan.de> (Marcel
 Koeppen's message of "Thu, 15 May 2008 04:19:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37BB5C6E-225A-11DD-80B7-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82187>

Marcel Koeppen <git-dev@marzelpan.de> writes:

> The OSX version of sed interprets the command as argument to the -i option.
>
> Signed-off-by: Marcel Koeppen <git-dev@marzelpan.de>
> ---
>  t/t7502-commit.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index 018060c..9a43104 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -166,7 +166,7 @@ test_expect_success 'author different from committer' '
>  	test_cmp expect actual
>  '
>  
> -sed -i '$d' expect
> +sed -i -e '$d' expect
>  echo "# Committer:
>  #" >> expect
>  unset GIT_COMMITTER_EMAIL

Two comments and a half.

This patch does not make things worse, so I do not have much against it.

However, "sed -i $cmd" is also used in templates/hooks--prepare-commit-msg
and you would want to fix it as well.

But more importantly, as we are serious about portability, we should not
be using "sed -i" which is not even in POSIX to begin with.  Can we
rewrite these places without using the in-place extension?
