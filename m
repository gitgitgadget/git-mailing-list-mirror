From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Mon, 7 Apr 2008 01:34:12 -0700
Message-ID: <20080407083412.GA9764@adamsimpkins.net>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <alpine.DEB.1.00.0804062135290.12583@eeepc-johanness> <20080406224724.GC5822@adamsimpkins.net> <200804070824.10764.tlikonen@iki.fi>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Apr 07 10:35:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jimoe-0000gE-FO
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609AbYDGIeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbYDGIeQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:34:16 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:57965 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbYDGIeP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 04:34:15 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 025321B406F;
	Mon,  7 Apr 2008 04:34:14 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id CDD211B4007;
	Mon,  7 Apr 2008 04:34:13 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id DD81314100BB; Mon,  7 Apr 2008 01:34:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200804070824.10764.tlikonen@iki.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78964>

On Mon, Apr 07, 2008 at 08:24:10AM +0300, Teemu Likonen wrote:
> Adam Simpkins kirjoitti:
> 
> > Actually, going back and testing this, it looks like I have a bug
> > when handling --graph together with --pretty=format.  There's a
> > missing newline after the user's format message and the next graph
> > line.  I'll try to fix this and submit a patch later this evening.
> 
> Also, the output is not indented for options that display some 
> additional information to commit message. Those include:
> 
> --raw
> --stat
> --numstat
> --shortstat
> --summary
> --name-only
> --name-status
> 
> I'm not sure if the diff output of -p, -u etc. should be 
> indented--probably not--but for different stat and summary options it 
> would be nice to not have their output displayed over the graph area. 
> Especially --name-status is funny since it displays "M" to column 1 to 
> indicate modified file while "M" also means merge commit in the graph.

Hmm.  This is a harder problem to fix.  All of the options you list
above are handled by the internal diff API.  The diff API doesn't have
any knowledge about log and rev-list options, such as --graph.

The nicest way to fix this would probably be to write new diff API
functions that output to a strbuf instead of printing directly to
stdout.  Then the log code could prefix each line of the buffer with
the graph info before printing it.

However, this would be a lot of work, and I'm not sure that it's
really worth the effort at the moment.  For now, I'm leaning towards
changing the code to just exit with an error if --graph is used with
any of these options.

Any opinions?  Alternative suggestions?

-- 
Adam Simpkins
adam@adamsimpkins.net
