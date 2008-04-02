From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Can I switch a git-svn clone from a file => http url?
Date: Wed, 2 Apr 2008 17:17:21 +0200
Message-ID: <20080402151721.GA31738@atjola.homenet>
References: <p06240804c41942f6276e@[192.168.1.114]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 17:18:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh4j3-0006jo-GV
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 17:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbYDBPRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Apr 2008 11:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbYDBPRY
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 11:17:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:47675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755087AbYDBPRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 11:17:24 -0400
Received: (qmail invoked by alias); 02 Apr 2008 15:17:22 -0000
Received: from i577AF785.versanet.de (EHLO atjola.local) [87.122.247.133]
  by mail.gmx.net (mp044) with SMTP; 02 Apr 2008 17:17:22 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/UqK1xyTrUSOJKFxr7hfR2NwZ98mkLD3G3rh/lHV
	eqe2rHUigS4Z5Y
Content-Disposition: inline
In-Reply-To: <p06240804c41942f6276e@[192.168.1.114]>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78696>

On 2008.04.02 10:38:34 -0400, Stephen Bannasch wrote:
> I've just created a git-svn clone from a svn repo accessed locally wi=
th a=20
> file:/// path.
>
> Unfortunately the local svn repo is just a copy of the main svn repo =
=20
> normally accessed with http or https (served through Apache). I was =20
> having problems cloning the main svn repository (more details below) =
so I=20
> archived the remote svn repository and copied it to my local hard dri=
ve.

I guess you should have used the --rewrite-root option when you did the
clone. Then the metadata in the log entries would already point to the
right URL and you could just adjust the URL in .git/config and drop the
rewriteRoot entry there.

> Is there an operation I can now do to switch the base url from:
>
>   file:///Path/to/svn/repository/projects
>
> to
>
>   https://svn.concord.org/svn/projects

Basically, this should work:

Change the URL to the repo in your .git/config.
Use filter-branch to change all git-svn-id lines in the log entries.
Delete the .rev_map.* files in .git/svn/*
Run git svn fetch (rebuilds the .rev_map.* files).

The filter-branch call should use the --msg-filter option to change the
log entries and should apply to all the svn branches/tags/trunk (or jus=
t
use " -- --all", if there's nothing that may not be filtered).

HTH
Bj=F6rn
