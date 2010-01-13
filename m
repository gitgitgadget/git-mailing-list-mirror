From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: discussion: an option to fail git fetch if a pulled branch tip is not a fast forward of the existing remote tip?
Date: Wed, 13 Jan 2010 13:59:08 +0100
Message-ID: <201001131359.09613.trast@student.ethz.ch>
References: <2cfc40321001130354w626ec0fat7abdfaff9771c29f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:59:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV2oe-0007Kz-EJ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 13:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab0AMM7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 07:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486Ab0AMM7M
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 07:59:12 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:39396 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab0AMM7M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 07:59:12 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Wed, 13 Jan
 2010 13:59:10 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Wed, 13 Jan
 2010 13:59:09 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <2cfc40321001130354w626ec0fat7abdfaff9771c29f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136814>

Jon Seymour wrote:
[discussion of a case of branch rewriting, called "backtracking" here]
> Now clearly the upstream developer should not have backtracked. That
> said, it would have been nice if I could have easily configured my
> porcelain to detect the backtracking condition. An option on git fetch
> that implemented something similar to the git push check would have
> made this easy to achieve.

This is an instance of a non-fast-foward update, which is indicated by
the little "+" in git-fetch's output.  E.g., fetching git.git a moment
ago gave me

>From git://git.kernel.org/pub/scm/git/git
   fbb9971..8efa5f6  maint      -> origin/maint
   c0eb604..054d2fa  master     -> origin/master
   e295b7f..e84eab0  next       -> origin/next
 + 10659b7...6a048fc pu         -> origin/pu  (forced update)

which means that the 'pu' branch was a non-fast-forward update.

If you do not want to rely on checking the results manually, you can
edit the remote configuration.  Normally, it will look like

[remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = +refs/heads/*:refs/remotes/origin/*

Note the "+" in the 'fetch' line, which means "allow non-fast-forward
updates".  Removing the + (leaving the rest intact) results in

>From git://git.kernel.org/pub/scm/git/git
 ! [rejected]        pu         -> origin/pu  (non-fast-forward)

You can then manually add lines _with_ the "+" for branches where you
do want to allow non-ff updates, e.g., for git.git I might say

[remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = +refs/heads/pu:refs/remotes/origin/pu
        fetch = refs/heads/*:refs/remotes/origin/*

since only 'pu' will be rewritten regularly. ('next' gets the
occasional treatment too, so that config would not be very
futureproof.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
