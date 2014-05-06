From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 17/28] "guilt graph" no longer loops when no patches are
 applied.
Date: Tue, 6 May 2014 16:10:23 -0400
Message-ID: <20140506201023.GN1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-18-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:25:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whlh4-0005GE-87
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 22:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbaEFUKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 16:10:21 -0400
Received: from josefsipek.net ([64.9.206.49]:1565 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbaEFUKU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 16:10:20 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 4385F55654;
	Tue,  6 May 2014 16:10:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-18-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248238>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, Mar 21, 2014 at 08:31:55AM +0100, Per Cederqvist wrote:
> Give an error message if no patches are applied.  Added a test case
> that never terminates unless this fix is applied.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-graph          | 10 ++++++++--
>  regression/t-033.out |  3 +++
>  regression/t-033.sh  | 11 +++++++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
>  create mode 100644 regression/t-033.out
>  create mode 100755 regression/t-033.sh
> 
> diff --git a/guilt-graph b/guilt-graph
> index b3469dc..00301d5 100755
> --- a/guilt-graph
> +++ b/guilt-graph
> @@ -17,8 +17,14 @@ fi
>  
>  patchname="$1"
>  
> -bottom=`git rev-parse refs/patches/$branch/$(head_n 1 < "$applied")`
> -base=`git rev-parse $bottom^`
> +bottompatch=$(head_n 1 < "$applied")
> +if [ -z "$bottompatch" ]
> +then
> +	echo "No patch applied." >&2
> +	exit 1
> +fi
> +
> +base=`git rev-parse "refs/patches/${branch}/${bottompatch}^"`
>  
>  if [ -z "$patchname" ]; then
>  	top=`git rev-parse HEAD`
> diff --git a/regression/t-033.out b/regression/t-033.out
> new file mode 100644
> index 0000000..76613f9
> --- /dev/null
> +++ b/regression/t-033.out
> @@ -0,0 +1,3 @@
> +% setup_repo
> +% guilt graph
> +No patch applied.
> diff --git a/regression/t-033.sh b/regression/t-033.sh
> new file mode 100755
> index 0000000..ae40577
> --- /dev/null
> +++ b/regression/t-033.sh
> @@ -0,0 +1,11 @@
> +#!/bin/bash
> +#
> +# Test the graph code
> +#
> +
> +source "$REG_DIR/scaffold"
> +
> +cmd setup_repo
> +
> +shouldfail guilt graph
> +
> -- 
> 1.8.3.1
> 

-- 
You measure democracy by the freedom it gives its dissidents, not the
freedom it gives its assimilated conformists.
		- Abbie Hoffman
