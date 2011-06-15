From: Johan Herland <johan@herland.net>
Subject: Re: Commit notes workflow
Date: Wed, 15 Jun 2011 11:37:43 +0200
Message-ID: <201106151137.43231.johan@herland.net>
References: <243233943.1008861308129613120.JavaMail.root@zimbra44-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ydirson@free.fr
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Wed Jun 15 11:37:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWmXp-0006bI-3q
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 11:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582Ab1FOJhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 05:37:48 -0400
Received: from smtp.opera.com ([213.236.208.81]:48206 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209Ab1FOJhr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 05:37:47 -0400
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p5F9bieD020388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 15 Jun 2011 09:37:44 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-Reply-To: <243233943.1008861308129613120.JavaMail.root@zimbra44-e7.priv.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175815>

On Wednesday 15. June 2011, ydirson@free.fr wrote:
> > > A (minor) problem with the second possibility is that this naming
> > > convention could evolve, eg. if we end up with something like was
> > > proposed in [1] for 1.8.0.  Is there any real drawback with the
> > 
> > first
> > 
> > > suggestion ?
> > > 
> > > [1] http://marc.info/?l=git&m=129661334011986&w=4
> > 
> > My gut feeling is to keep some sort of limit notes refs, and
> > if/when we get around to implementing my proposal in [1] (or some
> > variation thereof), we will of course extend the limit to put
> > "refs/remotes/$remote/notes/*" (or whatever is decided) in the
> > same category as "refs/notes/*".
> > 
> > In the meantime, I'm unsure if it's a good idea to remove the
> > limitation altogether (allowing notes refs everywhere), since
> > re-introducing a limit at a later point will then be MUCH
> > harder...
> 
> I'm still unsure what that limitation brings to us.  OTOH, it has at
> least one funny downside: when someone tries to refer to some
> forbidden ref using --ref, it gets silently requalified:
> 
> $ git notes --ref=refs/remote-notes/foo add
> $ find .git/refs/notes/ -type f
> .git/refs/notes/refs/remote-notes/foo
> $
> 
> It just seems so wrong...  Surely we can mitigate it by considering a
> ref starting with "refs/" to be absolute, and thus never prepend
> "refs/notes/" to it, but it rather sounds to me a symptom that we
> may not want to filter things anyway.

The reason we put the limitation there, is to prevent the notes code 
from screwing with non-notes trees. The notes code reorganizes the notes 
tree depending on the number of tree entries, in order to achieve 
acceptable performance for notes trees of all sizes. Therefore, you 
definitely DON'T want the notes code rummaging around in non-notes trees 
(especially if some of your tree entries can be mistaken for strings of 
hex digits).

That said, the example you give above ("refs/remote-notes/foo" -> 
"refs/notes/refs/remote-notes/foo" is obviously a stupid failure, and 
should be fixed. Considering "refs/*" to be absolute seems safe to me. 
(Obviously we loose the "refs/notes/refs/*" namespace, but I can live 
with that.)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
