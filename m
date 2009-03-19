From: Jeff King <peff@peff.net>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 00:18:37 -0400
Message-ID: <20090319041837.GA32642@coredump.intra.peff.net>
References: <49C0DE23.8020809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:20:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk9js-0001o1-Kj
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 05:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbZCSESr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 00:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZCSESr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 00:18:47 -0400
Received: from peff.net ([208.65.91.99]:53990 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbZCSESq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 00:18:46 -0400
Received: (qmail 29483 invoked by uid 107); 19 Mar 2009 04:18:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 00:18:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 00:18:37 -0400
Content-Disposition: inline
In-Reply-To: <49C0DE23.8020809@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113713>

On Wed, Mar 18, 2009 at 12:42:27PM +0100, Johannes Sixt wrote:

> --- expect      Wed Mar 18 11:22:53 2009
> +++ output      Wed Mar 18 11:22:54 2009
> @@ -12,8 +12,8 @@
>                  and with remote topic-c
>      rebase  rebases onto remote master
>    Local refs configured for 'git push':
> -    master pushes to master   (local out of date)
>      master pushes to upstream (create)
> +    master pushes to master   (local out of date)
>  * remote two
>    URL: ../two
>    HEAD branch (remote HEAD is ambiguous, may be one of the following):
> * FAIL 8: show
> 
> 
> As you can see, the entries for "master pushes to..." are reversed. It
> seems that this output is not stable. Before I delve into this, do you
> know whether there is some data structure involved that does not guarantee
> the order? Such as a hash table, a opendir/readdir sequence, or perhaps
> while reading the config file?

That is quite curious, because it is sorted immediately before printing:

  $ sed -n 1034,1040p builtin-remote.c
        for_each_string_list(add_push_to_show_info, &states.push, &info);
        sort_string_list(info.list);
        if (info.list->nr)
                printf("  Local ref%s configured for 'git push'%s:\n",
                        info.list->nr > 1 ? "s" : "",
                        no_query ? " (status not queried)" : "");
        for_each_string_list(show_push_info_item, info.list, &info);

can you step through in a debugger and make sure the sort_string_list is
actually sorting?

-Peff
