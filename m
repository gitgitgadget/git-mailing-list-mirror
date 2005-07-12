From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] tagger id
Date: Tue, 12 Jul 2005 01:44:15 -0700
Message-ID: <7veka48lcw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
	<m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507111815180.17536@g5.osdl.org>
	<m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com>
	<m18y0c1prv.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 10:48:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsGQK-0007tX-Qu
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 10:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVGLIrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 04:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVGLIoz
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 04:44:55 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58551 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261273AbVGLIoR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 04:44:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050712084415.IRWE17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 12 Jul 2005 04:44:15 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m18y0c1prv.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's message of "Tue, 12 Jul 2005 00:50:44 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Should this default to git_author_ident or git_committer_ident?
> I'm not really certain how we expect to use the different flavors.

The only in-tree user after your patch is applied is the tagger
stuff, so in that sense committer_ident may make more sense.
Having said that, for something like this that would not be used
constantly and interatively by the users, my preference is not
to have any default at all, and always require --author or
--committer.  You have to type a bit more when doing the script,
but that needs to be done only once.  You will be sure which one
you are asking from the command two weeks after you wrote the
script so it is not a big loss.

I am not seriously suggesting the below as an alternative, but
have you thought about doing an inverse function of your
computation for the case when the user has all the environment
variables, and have script eval its output, like this [*1*]:

    $ git-id
    GIT_AUTHOR_NAME='Junio C Hamano'
    GIT_AUTHOR_EMAIL='junkio@cox.net'
    GIT_COMMITTER_NAME='Junio C Hamano'
    GIT_COMMITTER_EMAIL='junkio@cox.net'
    $ eval "`git-id`"
    $ tagger="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"

Having names and emails available separately may turn out to be
easier to use in other situation.  Just a thought.

By the way, I do not particularly like the name "git-id".  There
could be IDs for different kinds (not just people) we would want
later (file IDs, for example).  Naming what you are computing
_the_ "id" feels a bit too generic.  I do not have a better
alternative to suggest, though.

[Footnote]

*1* This makes its output syntax a bit too specific to the shell
and unfriendly to Porcelain written in other languages.  The
only non-shell Porcelains I am aware of are done in Perl (I do
not remember hearing its name) and Python (StGIT), both of which
have reasonable regexp support to grok something like this, so
it would not be a big issue.
