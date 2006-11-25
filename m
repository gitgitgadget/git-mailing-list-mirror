X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: [PATCH 3/5] get_shallow_commits: Avoid memory leak if a commit
 has been reached already.
Date: Sat, 25 Nov 2006 17:22:25 +0000 (UTC)
Message-ID: <ek9u4f$vmk$1@sea.gmane.org>
References: <87slg8uc0l.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sat, 25 Nov 2006 17:22:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 32
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88-110-175-230.dynamic.dsl.as9105.com
User-Agent: pan 0.119 (Karma Hunters)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32296>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go1Ee-00061R-Tp for gcvg-git@gmane.org; Sat, 25 Nov
 2006 18:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966867AbWKYRWh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 12:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966868AbWKYRWh
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 12:22:37 -0500
Received: from main.gmane.org ([80.91.229.2]:54687 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966867AbWKYRWh (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 12:22:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Go1EZ-00060L-M5 for git@vger.kernel.org; Sat, 25 Nov 2006 18:22:35 +0100
Received: from 88-110-175-230.dynamic.dsl.as9105.com ([88.110.175.230]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 18:22:35 +0100
Received: from wildfire by 88-110-175-230.dynamic.dsl.as9105.com with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 25
 Nov 2006 18:22:35 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Fri, 24 Nov 2006 15:58:50 +0100, Alexandre Julliard wrote:

> Signed-off-by: Alexandre Julliard <julliard@winehq.org>
> ---
>  shallow.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/shallow.c b/shallow.c
> index 2db1dc4..3d53d17 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -60,7 +60,9 @@ struct commit_list *get_shallow_commits(
>  					commit = NULL;
>  					continue;
>  				}
> -				commit->util = xcalloc(1, sizeof(int));
> +				if (!commit->util)
> +					commit->util = xmalloc(sizeof(int));
> +				*(int *)commit->util = 0;
>  				cur_depth = 0;

Hi,

Any reason you didn't do:

if (!commit->util)
	commit->util = xcalloc(1, sizeof(int));

That would seem to be the same.

Regards,
Anand
