From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git-svn and repository hierarchy?
Date: Tue, 3 Mar 2009 19:18:04 -0500
Message-ID: <eaa105840903031618s5e0b6f24j64aade8d752fb11@mail.gmail.com>
References: <20090224223412.GA4573@raven.wolf.lan>
	 <49A50EB2.80300@drmicha.warpmail.net>
	 <20090227171248.GB14187@raven.wolf.lan>
	 <49A826C8.1060300@drmicha.warpmail.net>
	 <20090227220512.GC14187@raven.wolf.lan>
	 <49A97B7A.8010005@drmicha.warpmail.net>
	 <20090303185108.GA11278@raven.wolf.lan>
	 <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com>
	 <20090303223600.GB11278@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 01:19:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Leepl-0005YR-0u
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 01:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbZCDASK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 19:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbZCDASI
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 19:18:08 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:40819 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbZCDASH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 19:18:07 -0500
Received: by gxk22 with SMTP id 22so6054374gxk.13
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 16:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=VXfOY31H/fSghIOwwQeCigMXfKXdH+/2xN/NEpBbWfw=;
        b=nyUMnvdU9PKR5ydpOWZqWEMowIDy8XW0SPP6HbMier8NY77jt7GufObEonEl00f5Vx
         7mn73OrREitF7/TESKEFzBNf3j0XqC/psq1xsHveFWypUJlNdp9Wf2O2DD+7BIkS2Iha
         BQ2qoprqqGOa0ZrOcWUKSP5+Q1s6veX3+HbLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=aVyhouq/yoNPHAsTo4ZJJMzLozr4TDIiC7+uyMEDQONEalXFYb4Lsk4IO9ky5215oB
         Pz4MNlEABif4Jik3C5caUv0w9LylgYoQFZD0+iNUObOufqe+amRT4qvroH7rO/wK571/
         w0w7xX6ASrlH6uyJ9c/Xk7FwQ4o0dlIKrU564=
Received: by 10.220.92.80 with SMTP id q16mr2607703vcm.58.1236125884551; Tue, 
	03 Mar 2009 16:18:04 -0800 (PST)
In-Reply-To: <20090303223600.GB11278@raven.wolf.lan>
X-Google-Sender-Auth: ee35b6cf7d5ad86c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112175>

On Tue, Mar 3, 2009 at 5:36 PM, Josef Wolf wrote:
>
> I'd rather not let every clone talk to subversion for several reasons=
=2E
> One of them is that it is very inconvenient (e.g. the password has to
> be entered several times for every commit).

Sounds like subversion isn't properly caching your credentials, or
your admin is paranoid and turned off the svn credential cache. I
can't remember the last time I had to enter a password.

Of course, git-svn-repo can't cache credentials, since it has to
impersonate different users. You are impersonating different users so
that the svn author field is correct, aren't you? But that shouldn't
be a problem for userN working on cloneN.

> =A0After all, the whole point
> for having git-svn-repos is for the clone to avoid working directly
> against the subversion repos. =A0If every clone works against subvers=
ion
> anyway, I can get rid of git-svn-repos as well.

=46rom my perspective, the main advantage of git-svn-repos is the inita=
l
clone. Subversion is way too slow to clone an entire project's history
(days, vs minutes for git). Subsequent 'git pull --rebase's are faster
than 'git svn rebase's, too, although not by the same ratio (except
for large subtree moves, which really are that much faster).

> On Tue, Mar 03, 2009 at 02:35:28PM -0500, Peter Harris wrote:
>> Also, this line says "rebase my changes onto those of ../clone$clone=
",
>> which isn't what you want. It will end up rebasing svn commits that
>> the client didn't have on top of the client's commits, and will brea=
k
>> git-svn's index. Don't use --rebase here.
>
> Hmm, I must have misunderstood Michael, then. =A0Wasn't he suggesting
> to rebase here? =A0Here's the citation:
>
> |> =A0 (cd git-svn-repos; git pull ../clone1) =A0# if this line is ex=
ecuted,
> |
> |That's the problem. This creates a merge after which you 1-2-3-4 and
> |1-2'-3'-4' plus the merge of 4 and 4'.
> |
> |Instead, use git pull --rebase here. You don't want merges in the br=
anch
> |from which you dcommit.

I think he meant to say "git pull ../cloneN && git rebase trunk".

>> > =A0# Although we have resolved the conflict, spurious conflicts ar=
e
>> > =A0# propagated to the clones
>>
>> ...and this is because you had clones all merge from each other (via
>> git-svn-repos) *before* the changes were in svn.
>
> Does that mean that the conflicts would disappear if I do
> git-svn-rebase + git-svn-dcommit after every pull from a clone?

Well, 'disappear' is a strong word. "cloneX" has to be willing to
reset to your branch if you have resolved any conflicts on behalf of
cloneX. But the other cloneNs should not see those conflicts, at
least.

Not to mention that it's not outside the realm of possibility that
various cloneNs may be working with each other without involving you.

Plus, there is a small window where clones may be pulling from each
other, and will have to resolve the same conflicts you resolve during
your "git svn dcommit". I'm sure you've heard the saying "Every
computer science problem can be solved by adding a level of
indirection." You could add a git-svn-stage that pulls from cloneN and
does the dcommit (and then pushes to git-svn-repos, or lets
git-svn-repos do its own "git svn fetch"), leaving git-svn-repos clean
for cloneN to pull from...

Peter Harris
