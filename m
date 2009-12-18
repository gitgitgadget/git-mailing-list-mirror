From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git remote set-head not working?
Date: Fri, 18 Dec 2009 16:28:35 -0500
Message-ID: <76718490912181328k5f87d82u499b7a1eba471126@mail.gmail.com>
References: <76c5b8580912180825t17bfc90eq20dfc05cafa8c02e@mail.gmail.com>
	 <20091218165302.GA1746@sigill.intra.peff.net>
	 <76c5b8580912180938s2b885efax33be860f963ba92f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 22:28:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLkNO-0000vT-Po
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 22:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbZLRV2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 16:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbZLRV2h
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 16:28:37 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:55211 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932703AbZLRV2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 16:28:35 -0500
Received: by iwn1 with SMTP id 1so2459551iwn.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 13:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vmmetPI4A0Bd9MpSwjqufFnoBNIWesl9TCB0bFJ1aBE=;
        b=a/e/ua0MCwBTp2fzCPNJwdLNi2LYAlO9qTA8vxYYYFZqElflqEw4SedaWyCtrzDeWV
         YAlia2QcM9M60XpC1joGh5Eyn3ZZYYSfFYOZq3N6MExehlS9pxk4CFzjuQ6GYA/HvnCN
         0SHF4QpYMiLjUUFQGJ6frsfSPhWZEg063+oQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CIsjgNgBqneaGLBZPaFG40ULrBrNr/WHZixrZtfCDfFoQFkwDL4J/6P55LFflB0Ajs
         OOv4r/OfO1umQDf+O6Lj2knbg6ywsvZ2OQHH6S+DVqm9vTCEuV69X6MhKH7DFPTYO6S+
         tiluZdCyussdhc0fYEIpRrAWc5wfjzeEJJD3k=
Received: by 10.231.121.164 with SMTP id h36mr1731043ibr.9.1261171715323; Fri, 
	18 Dec 2009 13:28:35 -0800 (PST)
In-Reply-To: <76c5b8580912180938s2b885efax33be860f963ba92f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135438>

On Fri, Dec 18, 2009 at 12:38 PM, Eugene Sajine <euguess@gmail.com> wrote:
> Yes. I was trying to change the HEAD on the bare remote (origin) repo
> and the concept here is really confusing.

The remote command is about updating things under .git/refs/remotes,
not about updating a remote server. For updating a remote server,
there is really only push. Clear as mud?

> Firstly, when i cloned from some repo "clone" comand is setting HEAD
> branch for remote in accordance to where the HEAD is pointing on
> origin side. I just recently realized that and i'm not sure it is best
> thing to do - i think it should default to origin/master first, if it
> doesn't exist then to where the HEAD is pointing.

It is expected that the person setting up the bare repo is the person
who knows best which is the "default" branch. Which is why clone uses
the remote HEAD as the default branch to checkout.

But, if you don't like that, you can always use:

% git clone -b master ...

And you'll get master checked out instead of whatever the remote HEAD is.

> Secondly, I don't really understand what is the purpose of "git remote
> set-head" if the change cannot be transferred to the actual origin
> repo, so it will start serving another branch as default?

Hmm, the man page says:

       set-head
           Sets or deletes the default branch ($GIT_DIR/remotes/<name>/HEAD)
           for the named remote. Having a default branch for a remote is not
           required, but allows the name of the remote to be specified in lieu
           of a specific branch. For example, if the default branch for origin
           is set to master, then origin may be specified wherever you would
           normally specify origin/master.

This seems clear to me, but I guess if you expect that "git remote"
updates the remote server I can see some confusion. Perhaps the
DESCRIPTION for git remote should include something like:

"This command updates the local repository only. For updating a remote
repository, see git push."

> I might not
> have access to the server to perform git symbolic-ref on my bare repo
> (imagine the repo on github), so it might be not an option.

Understood. I'm not sure whether the send-pack/receive-pack protocol
supports the notion of "I want to change what HEAD points to."

j.
