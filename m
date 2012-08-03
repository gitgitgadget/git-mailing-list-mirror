From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 11/16] Read cache-tree in index-v5
Date: Fri, 3 Aug 2012 10:31:17 +0200
Message-ID: <87haskbcmi.fsf@thomas.inf.ethz.ch>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
	<1343905326-23790-12-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <trast@student.ethz.ch>,
	<mhagger@alum.mit.edu>, <gitster@pobox.com>, <pclouds@gmail.com>,
	<robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 10:31:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxDI6-00064A-Lf
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 10:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab2HCIbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 04:31:21 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:31140 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab2HCIbT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 04:31:19 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 10:31:15 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 10:31:17 +0200
In-Reply-To: <1343905326-23790-12-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Thu, 2 Aug 2012 13:02:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202820>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Since the cache-tree data is saved as part of the directory data,
> we have already read it, when we want to read the cache-tree. The
> cache-tree then only has to be converted from the directory data.

I think the first sentence is wrong.  You have already read it at the
very beginning of reading the index format, when you parsed the
directory records, haven't you?

> The cache-tree isn't lexically sorted, but after the pathlen at
> each level, therefore the directories have to be reordered with
> respect to the ondisk layout.

I'm not a native speaker either, but I think this does't parse well.
Maybe

  The cache-tree data is arranged in a tree, with the children sorted by
  pathlen at each node.  So we have to rebuild this format from the
  on-disk directory list.

> +	for (i = 0; i < subtree_nr; i++) {
> +		struct cache_tree *sub;
> +		struct cache_tree_sub *subtree;
> +		char *buf, *name;
> +
> +		name = "";
> +		buf = strtok(down[i].de->pathname, "/");

man 3 strtok says

   Be cautious when using these functions.  If you do use them, note
   that:

   * These functions modify their first argument.

   * These functions cannot be used on constant strings.

   * The identity of the delimiting character is lost.

   * The strtok() function uses a static buffer while parsing, so it's
     not thread safe.  Use strtok_r() if this matters to you.

I don't think the last point will be a problem, but what about modifying
the argument?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
