From: Junio C Hamano <junkio@cox.net>
Subject: Re: contrib/ area
Date: Mon, 20 Feb 2006 19:58:21 -0800
Message-ID: <7v64n95pnm.fsf@assigned-by-dhcp.cox.net>
References: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net>
	<Pine.OSX.4.64.0602201737260.16179@piva.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Clifford <benc@hawaga.org.uk>
X-From: git-owner@vger.kernel.org Tue Feb 21 04:58:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBOfe-0006uX-Ei
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 04:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbWBUD60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 22:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161305AbWBUD60
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 22:58:26 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60153 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161304AbWBUD60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 22:58:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060221035828.NUFK25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 22:58:28 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.OSX.4.64.0602201737260.16179@piva.hawaga.org.uk> (Ben
	Clifford's message of "Mon, 20 Feb 2006 17:41:50 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16517>

Ben Clifford <benc@hawaga.org.uk> writes:

> I have been keeping some (lazily-maintained) bash completion code at:
>
> http://www.hawaga.org.uk/ben/tech/gitcompletion/
>
> It isn't clear to me whether it should stay there or be merged into
> git/contrib/.
> ...
> The path of least resistence for me is to keep it at the above
> hawaga.org.uk URL, but it may be that some people would prefer it in
> the main repos.

I am OK either way.  They are small enough to be in contrib/
area, and bash users may appreciate easier availability.  What I
would _refuse_ to do is to maintain code for other people ;-).
As long as you or somebody else is going to keep them updated as
needed, I do not mind carrying them in contrib/.

As a practice for doing "even cooler merge", I did the
following, to see if I can treat it just like I treat gitk.

    (1) give you a topic branch.
    $ git checkout -b bc/completion master

    (2) fetch your tip
    $ git fetch http://www.hawaga.org.uk/gitcompletion.git/

    (3) for a practice of a later "renaming" merge, pretend you were
        one rev behind than you actually are.
    $ COMMIT=`git rev-parse FETCH_HEAD^`

    (4) extract things under contrib/completion/
    $ git read-tree $COMMIT
    $ git checkout-index --prefix=contrib/completion/ -a

    (5) throw the index away, and add the files back into the real index.
    $ git reset
    $ git add contrib/completion

    (6) write the result of "even cooler merge" out, with a merge
        commit message:
    $ T=`git-write-tree`
    $ sed -e 's/^[0-9a-f]*/'$COMMIT/ <.git/FETCH_HEAD |
      git-fmt-merge-msg |
      git commit-tree $T -p `git rev-parse HEAD` -p $COMMIT

    (7) a practice of later merge
    $ git pull -s recursive http://www.hawaga.org.uk/gitcompletion.git/

The result is sitting at the tip of "pu" branch.
