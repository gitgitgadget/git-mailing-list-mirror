From: John Keeping <john@keeping.me.uk>
Subject: Re: Use case (was Re: Should branches be objects?)
Date: Tue, 24 Jun 2014 12:01:27 +0100
Message-ID: <20140624110127.GH28807@serenity.lan>
References: <CAK3OfOgskVKs=eUT+EM+GZOjh0p6gxKeDWH-iTt29P1i1d1iZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 13:02:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzOU9-0004Dk-2T
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 13:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbaFXLBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 07:01:53 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:60347 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbaFXLBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 07:01:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A96B0CDA60E;
	Tue, 24 Jun 2014 12:01:51 +0100 (BST)
X-Quarantine-ID: <jEwdY6xz2KLn>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jEwdY6xz2KLn; Tue, 24 Jun 2014 12:01:50 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 8B15DCDA623;
	Tue, 24 Jun 2014 12:01:46 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7055E161E516;
	Tue, 24 Jun 2014 12:01:46 +0100 (BST)
X-Quarantine-ID: <yVsBu4FJskiK>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yVsBu4FJskiK; Tue, 24 Jun 2014 12:01:40 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 30094161E4B1;
	Tue, 24 Jun 2014 12:01:29 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAK3OfOgskVKs=eUT+EM+GZOjh0p6gxKeDWH-iTt29P1i1d1iZA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252396>

On Mon, Jun 23, 2014 at 10:20:14PM -0500, Nico Williams wrote:
> The Illumos repo, like OpenSolaris before it, and Solaris itself at
> Sun (and now at Oracle) requires that fixes be broken down into small
> commits, with related fixes, tests, and docs changes all typically in
> separate commits, but all pushed together, so that a single push of N
> commits is a logical set of changes (e.g., to be backed out together
> if, say, any one of them breaks a build).  With git the only way to
> record this grouping at push time is with a post-receive hook that
> does the recording (which is what the Illumos repo does, sending email
> to a list about all the commits pushed in one go).

Have you considered using merges for this instead?  If each set of
related changes is its own branch, then if you merge with `--no-ff` so
that a merge commit is always created, you can identify the set of
related changes with:

	git log ${MERGE_COMMIT}^1..${MERGE_COMMIT}^2

There are some interesting effects with reverting merge commits,
particularly if you want to merge the same set of changes at a later
date, but this seems like the "Git way" of identifying related commits.
