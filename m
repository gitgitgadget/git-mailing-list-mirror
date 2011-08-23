From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to check out the repository at a particular point in time
Date: Tue, 23 Aug 2011 11:53:59 -0500
Message-ID: <20110823165359.GD3545@elie.gateway.2wire.net>
References: <201108221525.32982.trast@student.ethz.ch>
 <1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
 <CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
 <20110823160525.GB3545@elie.gateway.2wire.net>
 <vpqliuk85ze.fsf@bauges.imag.fr>
 <CAMOZ1BuMfUT4D_UasLXsjDrXRKDw4EF_U-CV8tsS9W7AP+f8ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	rdiezmail-temp2@yahoo.de, Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 18:54:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvuEq-0006Qb-KY
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 18:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab1HWQyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 12:54:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42528 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab1HWQyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 12:54:04 -0400
Received: by vws1 with SMTP id 1so248936vws.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gSp4hHx8mxoKXGSeS5/9UImrdrsrOtAwjEahH5Ipjjw=;
        b=hDzBJTeMfGEidKEJNwlFIH8MF8tUhzLuTMaHJrMpO9NIgTw4jdroBhWvm7KGjU9IGP
         iVLosGNcnMuJTMsWgjlFsPHaxUxLbMpityGhGvv0EVtjLz8HmMgYSDSDBZHAgIPP8Xqk
         sEIvSeHFjuIc55qWzuZUHcw80bLVanTTPA3b4=
Received: by 10.52.98.166 with SMTP id ej6mr3695192vdb.320.1314118443751;
        Tue, 23 Aug 2011 09:54:03 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-73-45.dsl.chcgil.ameritech.net [69.209.73.45])
        by mx.google.com with ESMTPS id cg6sm121875vdc.29.2011.08.23.09.54.01
        (version=SSLv3 cipher=OTHER);
        Tue, 23 Aug 2011 09:54:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMOZ1BuMfUT4D_UasLXsjDrXRKDw4EF_U-CV8tsS9W7AP+f8ow@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179949>

Michael Witten wrote:

> Indeed. That example makes perfect sense when so-called `branches'
> master and new-feature are rightfully thought of as the `pointers'
> (or, `references') that they are.

You are right to point out there is potential for confusion, because
different VCSes model the practice of branching and merging in so many
different ways:

 - a single text field in each commit, as in Mercurial
 - a list of "sticky" keywords attached to each commit, as in CVS
 - special revision numbers, as in CVS
 - special directory names, as in Subversion
 - pointers to the tip of a line of history, as in Git

Each model has its strengths and weaknesses in terms of supporting
different operations one might to perform on a branch:

 - creating a branch
 - advancing a branch
 - studying the history of development on a single branch
 - fetching and pushing
 - renaming a branch
 - deleting
 - comparing the history of two branches
 - merging and deleting the now-merged-in branch
 - merging and not deleting the now-merged-in branch
 - "context switch" from working on one branch to another

In particular, you are right to emphasize that in git's model, "what
was on the foo branch at 12:00pm on Saturday" is just not a well
defined question.  The foo branch tip might have been at commit A on
my machine, commit B on a server we share, and commit C on your
machine, so Git doesn't even bother --- branch refs are pointers into
history rather than participating in the history themselves.

Instead, we can content ourselves with the answers to questions like
"what was in the foo branch at 12pm on Saturday on the server used as
a rendezvous point", by logging in and examining the reflog on the
server.

A nice side-benefit is that branch refs are considered to be _private_
unless they are pushed or mentioned in a commit message.  So there is
no pressure to come up with good names for them.

Hope that helps,
Jonathan
