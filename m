From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/4] git-p4: handle p4 branches and labels containing
 shell chars
Date: Tue, 17 Jan 2012 17:39:49 -0500
Message-ID: <20120117223949.GA811@padd.com>
References: <1326755689-3344-1-git-send-email-luke@diamand.org>
 <1326755689-3344-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Jan 17 23:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnHh7-00039m-U5
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 23:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab2AQWjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 17:39:53 -0500
Received: from honk.padd.com ([74.3.171.149]:55323 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241Ab2AQWjw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 17:39:52 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id B2D6A278;
	Tue, 17 Jan 2012 14:39:51 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3A66431446; Tue, 17 Jan 2012 17:39:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1326755689-3344-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188724>

luke@diamand.org wrote on Mon, 16 Jan 2012 23:14 +0000:
> Don't use shell expansion when detecting branches, as it will
> fail if the branch name contains a shell metachar. Similarly
> for labels.
> 
> Add additional test for branches with shell metachars.

Nice.  There will be a fixup on a command in Vitor's series,
depending on which goes first.  He'll have a couple of
un-listified read_pipe{,_lines} that we should treat similarly.

> @@ -1758,7 +1758,7 @@ class P4Sync(Command, P4UserMap):
>      def getLabels(self):
>          self.labels = {}
>  
> -        l = p4CmdList("labels %s..." % ' '.join (self.depotPaths))
> +        l = p4CmdList(["labels", "%s..." % ' '.join (self.depotPaths)])
>          if len(l) > 0 and not self.silent:
>              print "Finding files belonging to labels in %s" % `self.depotPaths`

I suspect the command "p4" "labels" "//depot/foo/...  //depot/bar/..."
might confuse p4, but haven't tested.  Maybe tuck each one in its
own argument?

    ["labels"] + ["%s..." % p for p in self.depotPaths]

What happened to your failing test?  It's fun to keep the broken
ones around to inspire others to fix them.

		-- Pete
