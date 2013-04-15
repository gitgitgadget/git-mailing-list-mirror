From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 14:43:30 -0400
Message-ID: <516C4A52.1080908@xiplink.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com> <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URoXA-0006Do-1T
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249Ab3DOSxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:53:40 -0400
Received: from smtp132.dfw.emailsrvr.com ([67.192.241.132]:40722 "EHLO
	smtp132.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab3DOSxj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:53:39 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2013 14:53:39 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp13.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 467E23D0EB1
	for <git@vger.kernel.org>; Mon, 15 Apr 2013 14:44:07 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp138.ord.emailsrvr.com (smtp138.ord.emailsrvr.com [173.203.6.138])
	by smtp13.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 2C28D3D0EAB
	for <git@vger.kernel.org>; Mon, 15 Apr 2013 14:44:07 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp18.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id B9AD73010E;
	Mon, 15 Apr 2013 14:43:30 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp18.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 57E91300B8;
	Mon, 15 Apr 2013 14:43:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221288>

On 13-04-15 01:50 PM, Junio C Hamano wrote:
> Marc Branchaud <mbranchaud@xiplink.com> writes:
> 
>> In general I think it is a mistake to overload "git clone" with the notion of
>> adding a submodule.
> 
> I agree with that principle, but my understanding is that this
> effort is not about teaching "git clone" to create a submodule.
> 
> Both "git clone" and "git init" already know how to use a directory
> that is outside the working tree of the newly created repository to
> store its $GIT_DIR and point at it with .git in the working tree
> using the gitfile mechanism (their --separate-git-dir option).  My
> understanding is that this "config" is about making that option
> easier to use when you _know_ any new repository you create with
> "git clone" or "git init" inside your (toplevel super)project's
> working tree will become its submodule, as it is more convenient to
> have their $GIT_DIR inside the .git/modules/$name of the
> superproject.
> 
> After that "clone" or "init" creates a repository, you still have to
> "add" if you want to make it a submodule to the toplevel.

To me it makes more sense to move the .git directory when the user invokes
"git submodule add" instead of creating it in an unusual place when the
sub-repo is cloned.  After all, git can't *know* that it'll be a submodule
until it's submodule-added to the super-repo.  Sure, the user might have set
clone.submoduleGitDir somewhere, but users make mistakes, and this setting
makes it harder to clean up a mistake:
	git clone foo.git
	# Doh!  I mean to clone foof.git!
	rm -rf foo
	# Gah, now there's cruft in my clone.submoduleGitDir...

All that said, the basic idea of being able to configure where "git clone"
stores .git directories might be reasonable.  Something like
clone.gitDirHome.  It seems like something only a git hacker would ever care
about, but that's no reason not to have such a config option.  OTOH, I still
don't see a reason for it, because I don't buy the submodule-at-clone-time
argument.

		M.
