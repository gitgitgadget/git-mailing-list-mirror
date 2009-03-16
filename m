From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [TopGit PATCH] tg-patch: fix invocation in sub working tree
 directory
Date: Mon, 16 Mar 2009 15:33:58 -0700
Message-ID: <7vbps1umg9.fsf@gitster.siamese.dyndns.org>
References: <1237241299-25515-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	u.kleine-koenig@pengutronix.de
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 23:35:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjLPJ-0007Wy-2S
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 23:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbZCPWeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 18:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZCPWeL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 18:34:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbZCPWeL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 18:34:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 135CD66E2;
	Mon, 16 Mar 2009 18:34:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 279E766DF; Mon,
 16 Mar 2009 18:34:00 -0400 (EDT)
In-Reply-To: <1237241299-25515-1-git-send-email-bert.wesarg@googlemail.com>
 (Bert Wesarg's message of "Mon, 16 Mar 2009 23:08:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8EE9D298-127A-11DE-8386-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113397>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> tg patch won't work in a sub directory of the working tree, because 'git diff
> --name-only' prints the names relative to the top working tree.

"diff --relative --name-only"?

> This is only a quick fix which prefixes all file names with 'git rev-parse
> --show-cdup'. The right solution would be to cd into the top working tree
> somewhere in tg.sh.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
>  tg-patch.sh |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/tg-patch.sh b/tg-patch.sh
> index d701c54..e33bab2 100644
> --- a/tg-patch.sh
> +++ b/tg-patch.sh
> @@ -50,13 +50,18 @@ cat_file "$topic:.topmsg"
>  echo
>  [ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$name"} -- ".topmsg")" ] || echo '---'
>  
> +# if we are in a sub working tree dir, we need to prefix all file names from
> +# git diff --name-only with this cdup
> +cdup=$(git rev-parse --show-cdup)
> ...
> +	sed -e "s#^#$cdup#" "$git_is_stupid" |

Do TopGit folks care about special characters in pathnames?
