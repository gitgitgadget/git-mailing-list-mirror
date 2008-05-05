From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 0/3] log --graph and rev-list --graph
Date: Sun, 4 May 2008 23:19:41 -0700
Message-ID: <20080505061940.GA26319@adamsimpkins.net>
References: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net> <46dff0320805041913t31c05a36w92be4a81a3da07af@mail.gmail.com>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 08:20:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsu3t-00060n-3V
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 08:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbYEEGTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 02:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbYEEGTp
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 02:19:45 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:40780 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbYEEGTo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 02:19:44 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 7F7FA1B4095;
	Mon,  5 May 2008 02:19:43 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 5846C1B4057;
	Mon,  5 May 2008 02:19:43 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 91E7B14100C2; Sun,  4 May 2008 23:19:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46dff0320805041913t31c05a36w92be4a81a3da07af@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81233>

On Mon, May 05, 2008 at 10:13:43AM +0800, Ping Yin wrote:
> 
> Is the indention between ba7f5b and 38254 intentional?
> 
> * ba7f5b log and rev-list: add --graph option
> *   38254 Add history graph API
> *   12918 revision API: split parent rewriting
> *   c697a Cleanup xread() loops to use read_in_full()
> M     47179 Merge branch 'maint'


It's not really intentional, it's just the result of a rather
simplistic computation.

The amount of horizontal padding used for each commit is computed as
(2 * number of incoming columns from the previous commit) + (2 * number
of parents of the current commit).  This always results in enough
padding.  However, if the current commit is a child of one of the
incoming columns, it results in 2 more spaces than necessary.

There's a comment in graph_pad_horizontally() graph.c that describes
this behavior:

     * This computation results in 3 extra spaces to the right in most
     * cases, but only 1 extra space if the commit doesn't have any
     * children that have already been displayed in the graph (i.e.,
     * if the current commit isn't in graph->columns).

It could easily be fixed by performing an extra pass over the columns
to check if any of the existing columns refers to the current commit.

I'll try to come up with a patch when I get the chance.

-- 
Adam Simpkins
adam@adamsimpkins.net
