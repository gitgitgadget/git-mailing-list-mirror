From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Secure central repositories by UNIX socket authentication
Date: Mon, 28 Jan 2008 22:11:05 -0500
Message-ID: <20080129031105.GI24004@spearce.org>
References: <20080127103934.GA2735@spearce.org> <7vsl0ix4gh.fsf@gitster.siamese.dyndns.org> <20080128004722.GZ24004@spearce.org> <7vabmqwgvt.fsf@gitster.siamese.dyndns.org> <20080128075125.GC24004@spearce.org> <alpine.DEB.1.00.0801280922160.3774@alchemy.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:11:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgsx-0005ho-Sw
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbYA2DLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 22:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbYA2DLM
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:11:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50562 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbYA2DLL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:11:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJgsB-0002p9-I4; Mon, 28 Jan 2008 22:10:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C32A220FBAE; Mon, 28 Jan 2008 22:11:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0801280922160.3774@alchemy.localdomain>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71935>

Asheesh Laroia <asheesh@asheesh.org> wrote:
> On Mon, 28 Jan 2008, Shawn O. Pearce wrote:
> >
> >I've had enough cases of users losing their SSH key and needing to 
> >recreate it that I'd rather not have to manage a 50 user long 
> >authorized_keys file.
> 
> For what it's worth, if you haven't seen gitosis yet, you might want to 
> take a look - at least it makes managing the keys easy. 
> http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way 
> has a nice tutorial.

Yea, I've looked at it before.  There's a few reasons I don't
use gitosis, although it does look to be an excellent chunk of
Git automation:

* Its access controls aren't as powerful

  Frankly the contrib/hooks/update-paranoid script is a lot more
  powerful then gitosis is, in terms of how it controls what
  branches a user can modify, and even what files they can change
  on a particular branch.  And yes, I really do have rulesets that
  bend that hook to its limits.

* It uses the OpenSSH authorized_keys file format

  I'm required to use the F-Secure SSH commerical server at
  day-job, because its "more trusthworthy" than the portable OpenSSH
  distribution.  It uses a different syntax for the authorized keys,
  but can do essentially the same restricted command concept.

* If its in git, I prefer raw repository access

  gitosis yanks stuff out into normal files to access it at runtime,
  e.g. its configuration file.  I've had bad experiences with CVS not
  properly updating its admin files when changes are made to them.
  The update-paranoid hook I use actually cats the objects right
  out of the admin ODB on demand, ensuring its always evaluating
  the most recent version of the access rules.

* Its Python based.

  I don't grok Python, and would rather not learn to.  So hacking
  on gitosis isn't something that I would be doing.  Ditto with
  all of my day-job cohorts.  We use Perl, Bourne shell, and Java,
  with some tiny amount of Tk thrown about (though I'd say I'm
  probably the only one there that even remotely groks Tcl/Tk).

But thanks for the pointer.

Now if others corrected all of the above in gitosis (except the
last item of course, I don't expect it to be rewritten in one of
my preferred languages) I'd reconsider using it, because inventing
wheels sucks.

-- 
Shawn.
