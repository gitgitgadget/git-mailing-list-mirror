From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v5 1/2] filter-branch: stop special-casing $filter_subdir argument
Date: Wed, 11 Nov 2009 11:24:49 +0100
Message-ID: <200911111124.52340.trast@student.ethz.ch>
References: <4AE945D0.5030403@viscovery.net> <4AFA7624.5040400@viscovery.net> <4AFA7B9A.4090005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 11:26:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8AOp-0006iq-RP
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 11:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbZKKKZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 05:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbZKKKZx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 05:25:53 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:28223 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbZKKKZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 05:25:52 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 11 Nov
 2009 11:25:57 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 11 Nov
 2009 11:25:35 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.29-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <4AFA7B9A.4090005@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132637>

Johannes Sixt wrote in the other reply:
> I thought that the intention to give an extra path argument is to reduce
> the number of commits that remain in the rewritten history. But by giving
> --subdirectory-filter, the path filter actually loosened, and many more
> commits are rewritten.

Right, I had a thinko there, the path filter adds up as an "or", so
filtering for paths outside the subdir loosens it (and filtering for
more paths inside doesn't make a difference).

> Since your intention to write this patch is actually to implement
> --remap-to-ancestor, I suggest that we defer the question whether the
> above use-case makes sense, and only rewrite this particular paragraph in
> the commit message to point out the real bug:

Agreed.

Johannes Sixt wrote:
> Furthermore, --subdirectory-filter supplies its own '--', and if the user
> provided one himself, such as in
> 
>   git filter-branch --subdirectory-filter subdir -- --all -- subdir/file
> 
> 	an extra '--' was used as path filter in the call to git-rev-list that
> determines the commits that shall be rewritten.

There's some stray space here that should probably also be removed.

> Here it is. The interdiff to your version is merely
[...]
>  # we need "--" only if there are no path arguments in $@
>  nonrevs=$(git rev-parse --no-revs "$@") || exit
> -dashdash=${nonrevs+"--"}
> +test -z "$nonrevs" && dashdash=-- || dashdash=

Ack.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
