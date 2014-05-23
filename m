From: John Keeping <john@keeping.me.uk>
Subject: Re: Plumbing to rename a ref?
Date: Fri, 23 May 2014 11:50:47 +0100
Message-ID: <20140523105047.GA2249@serenity.lan>
References: <87ha4golck.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri May 23 12:51:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnn4D-0000Oc-CG
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 12:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbaEWKvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 06:51:05 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:56979 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbaEWKvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 06:51:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B9CC686602C;
	Fri, 23 May 2014 11:51:00 +0100 (BST)
X-Quarantine-ID: <M0EXGC-gEDOG>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M0EXGC-gEDOG; Fri, 23 May 2014 11:50:58 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id BD818CDA636;
	Fri, 23 May 2014 11:50:52 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <87ha4golck.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249985>

On Fri, May 23, 2014 at 02:11:55PM +0400, Sergei Organov wrote:
> Hello,
> 
> After convertion of a project from CVS to git, I'd like to rename some
> references in the created git repository (before it's published, so no
> problems here). Is there a plumbing that would do:
> 
> git rename-ref <old_name> <new_name>
> 
> for me?

I think the best you can get is two invocations of `git update-ref`:

	git update-ref <new_name> <old_name> &&
	git update-ref -d <old_name>

Although if you're scripting it the `--stdin` mode may be easier:

	git update-ref --stdin <<-\EOF
	create <new_name> <old_name>
	delete <old_name>
	EOF

Note that "<new_name>" must be a fully-qualified ref (that is, it must
start with "refs/", so "refs/heads/new_name" for a branch or
"refs/tags/new_name" for a tag).
