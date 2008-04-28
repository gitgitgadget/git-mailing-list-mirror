From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [updated PATCH] Protect current tags, import tags into remote tree
Date: Mon, 28 Apr 2008 20:48:59 +0200
Message-ID: <20080428184859.GA21950@cuci.nl>
References: <20080427173246.10023.94820.stgit@aristoteles.cuci.nl> <7vmynec60v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 20:49:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYQA-0003i2-7o
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965670AbYD1StG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965634AbYD1StF
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:49:05 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:45525 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965585AbYD1StD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:49:03 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 78710545E; Mon, 28 Apr 2008 20:48:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmynec60v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80582>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:

>> ..., it currently stores any tags
>> directly in refs/tags,...

>which is consistent with the way all the native Porcelain commands handle
>tags.  There is no per-remote namespace for tags in git Porcelain.

There is in git-svn.

>For some people, the patch would be an improvement, but for some other
>people, this would be a regression.

Due to the quirks of CVS (and SVN), over time many CVS/SVN repositories
have picked up a lot of tags which either made sense at the time (but
don't anymore), or have not been wiped because of the
difficulty/impossibility to do so in the old repository.

The usual way to import from CVS is to do the import, then pick the
branches and tags you really want to keep, copy/replicate them outside
remotes and then move on in a clean fashion.

Rerunning cvsimport on a regular basis causes the import to (re)create
all the tags from CVS again; if this is done in your regular tags space,
this is a mess at best, or overwrites whatever renamed tags you
carefully created which happen to match with old CVS tagnames.

git-svn *does* use the tags namespace under remotes, so it does it the
'proper' way.
With respect to the concern that all git porcelain works without a
separate remotes/.../tags namespace, two things:
- git-svn and git-cvsimport cross the boundary to a different VCS and
  therefore can/should use an extra barrier before (auto)converting to
  git native tags (and branches).
- I personally would find it most natural when upon cloning a git
  repository not only the branches cloned end up in a separate remotes
  namespace (like they do now already), but that the tags would do the same
  (e.g. in remotes/.../tags).

Even if this behaviour is not deemed "good" to be a new default, I'd
strongly suggest to at least make it optional using an appropriate flag
(and respective git-config variable to make it the local default).
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
"It is better for civilization to be going down the drain than
 to be coming up it."
