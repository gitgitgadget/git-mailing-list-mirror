From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 02:39:20 -0700 (PDT)
Message-ID: <m3ej6nkw2u.fsf@localhost.localdomain>
References: <20080624081601.GA2692@sigill.intra.peff.net>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5kv6TFEDjCj8S>
	<15381.9593288519$1214297235@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Avery Pennarun" <apenwarr@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
To: "David Jeske" <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 11:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB512-0007qg-SJ
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 11:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809AbYFXJjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 05:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757907AbYFXJjX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 05:39:23 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:28948 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757809AbYFXJjW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 05:39:22 -0400
Received: by an-out-0708.google.com with SMTP id d40so683767and.103
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=UD/YN4emaucEwXT3/w91DB1kWr3xfxTgeLC9VB83JyA=;
        b=OeiEid/aeycOJWyU7pxjAiUPu+F6yM6saF7tXb7OeibNXj1T9z8Ua1CJPKNyqBzn9n
         0FdlMgtMlV67LurzwVrWhHqvRXi97uibzfT8LEglbhAm2kSwv8OtLtkxOiC+oqjjuJN5
         IPFCyq6AmlOHqqngWG5cTTbcfSP2D7EUN45+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Mbon4NgKifTXV7SfbPpmKOLOoVWT5mD7PgJPnDaBsGpyI7HSMQ6wTxKqltoEWkcFQp
         eJ4HHuYNEJNdK1q8LvDgJvdwLneTIKlhQfLR5Mf9YR5ax4wRVM0eXp4zREYoDJRbumot
         XAswv+wk+b//fZ9Tvgj8YE5EpsvipKA3f+6V8=
Received: by 10.100.92.9 with SMTP id p9mr15295664anb.13.1214300361148;
        Tue, 24 Jun 2008 02:39:21 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.195.249])
        by mx.google.com with ESMTPS id b12sm13928243ana.14.2008.06.24.02.39.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 02:39:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5O9gplm006348;
	Tue, 24 Jun 2008 11:42:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5O9goTS006344;
	Tue, 24 Jun 2008 11:42:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <15381.9593288519$1214297235@news.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86028>

"David Jeske" <jeske@google.com> writes:

> This is mostly moot since I've understood that it's easy to set git
> to never GC. I guess I'm curious about why those GC fields would
> ever be set to anything other than never?

Because not everybody has unlimited quota / unlimited disk space?
Besides growing repository, reflogs also grow even if you shitch
between some limited set of commits.

Note however that IIRC reflogs are not enabled by default for bare
repositories, and public repositories should be bare (without working
directory).  But see receive.denyNonFastForwards below.

> -- Jeff King wrote:
> >
> > No. Git keeps the reachable DAG. So if the DAG is part of development
> > that is merged into one of your long running branches, or if you keep
> > around the branch that points to it, it will never go away.
> 
> Right, that's what I thought.
> 
> I'm not primarily concerned with what developers can do to their
> local git repositories. I'm concerned with what the default sync
> operations can let them do to the crown-jewels in the 'central
> organization repositories' which everyone is periodically pushing
> to.
> 
> I like that deleting a branch in your repo does not cause it to be
> deleted in other repos. Presumably in an organization we could
> prevent the central repo from ever accepting branch deletes from
> developers. (without some kind of authorization)
> 
> Does it have the same protection for all operations that can cause
> DAGs to be dangling? For example, if they branch -f" and push the
> branch?

git-config(1)

  receive.denyNonFastForwards::
        If set to true, git-receive-pack will deny a ref update which is
        not a fast forward. Use this to prevent such an update via a push,
        even if that push is forced. This configuration variable is
        set when initializing a shared repository.

That is even more than protection against leaving some commits
dangling.  This makes working on top of published branches safe.

If such all-or-nothing policy is not for you, you can always set-up
hooks, like shown for example in contrib/hooks/update-paranoid

Or you can use different workflow, where maintainer _pulls_ from other
developers or groups of developers, or apply (git-am) patches from
email.  This way if you screw up, it would be your fault for not
having backups ;-)

[...]
> Quite a bit of my fear of losing data came from some issues in the
> git-gui. I'm trying out git on a windows project, and windows-shells
> just don't work right, so I'm using the "Git Gui". It turns out
> right-clicking on a history entry in the gui has no checkout option,

This might be result of the fact that in older versions of git you
could not checkout arbitrary commit.  You now can use so called
"detached HEAD" (when current branch pointer points directly to the
commit, instead of pointing to current branch [name]); note however
that comitting on top of detached HEAD is discouraged.

> and the only option it does have which will let you move the tree to
> that place is "reset --hard".. since this was the easiest thing to
> find in the GUI, I assumed it was the right way to do it, and then
> all my more recent changes disappeared. It doesn't seem to have
> reflog functionality, so I couldn't find any way to get back all my
> changes.

There is always ORIG_HEAD, which predates reflog introduction, and
contains only old "version", as in

  $ git reset --hard ORIG_HEAD


That said, it would be nice if git-gui had some reflog interface.

> [...] The docs clearly explained that it
> will garbage collect dangling refs, and frankly the information
> about how often this happens is buried so deep I had no idea what
> the frequency was.

git-gc(1), section called (suprise, suprise) "Configuration".

-- 
Jakub Narebski
Poland
ShadeHawk on #git
