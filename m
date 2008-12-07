From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Sun, 7 Dec 2008 11:57:16 -0500
Message-ID: <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>
References: <493A6CEC.4060601@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Grzegorz Kossakowski" <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 07 17:58:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9Mxq-0002nl-9y
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 17:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbYLGQ5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 11:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbYLGQ5T
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 11:57:19 -0500
Received: from mail-gx0-f18.google.com ([209.85.217.18]:41123 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbYLGQ5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 11:57:18 -0500
Received: by gxk11 with SMTP id 11so644263gxk.13
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=VdQXKfZ/R3O92fgMcQf/tovZiHcZ4XS0xD92zmCO4mY=;
        b=ouwPqtGVYfBLzWud2F/59ywhhLxYSMt/uTbaa3Fwekbho94eSwf+AxJdpXfs0kamFg
         oclvVdCGxDmXi4aiBtmg3yII7gBxDAwWUy8mThsljJRFC27sW0lczVSZxGk/kjyLxLlu
         Ak96RBed3MUsVoJpSi4pdSzFl5l3+gEXiFcAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=YbVVlrDZdgHGy0XIbMAZxrFbTiE5zGsNb9zvlDSVuI83qJKEjMNMxQyZ8uPmzcV+n4
         7blQvwlJVVP3OomudTE1xIaUVlIziblkeWrWUeGvAX8AOQSZJ7VAuSvmlmstnjMK76KW
         pcsGAgamxkXVwjYsySTB4NygomSxnlYFCfhsk=
Received: by 10.65.137.5 with SMTP id p5mr2014306qbn.7.1228669036210;
        Sun, 07 Dec 2008 08:57:16 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Sun, 7 Dec 2008 08:57:16 -0800 (PST)
In-Reply-To: <493A6CEC.4060601@tuffmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: df8dc05b9741ccd1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102501>

On Sat, Dec 6, 2008 at 7:15 AM, Grzegorz Kossakowski wrote:
>
> Some folks at Apache are experimenting with Git and we are currently seeking for the git-svn
> integration that fits our needs and infrastructure.
>
> After some evaluation we decided that our setup could be described using following points:
>  a) our svn repository remains our main, official server where every committer is obligated to push
> their changes to at some time.
>  b) we set up clone of svn repository using git-svn. One of our members, Jukka Zitting, maintains
> such a service here[1]. Such repositories should be usable both for our committers (that have rights
> to push to svn) and our contributors that want to contribute random patches
>  c) we want carefully track who committed/contributed what
>
> Basically, a) implies b) and point b) looks little bit problematic right now.
> Jukka has set up his hosting using method described in his e-mail[2] which basically makes use of
> git svn. The major problem is that if one clones Jukka's repository then git svn information is not
> being cloned so committers have no means to push their changes to main, svn server.

Make sure you don't use the --no-metadata flag when setting up
git-svn. This will embed the metadata into commit messages, so git-svn
can rebuild it from scratch whenever it needs to. (You probably also
want git 1.6.1rc for incremental rebuild support). This also has the
advantage that you can see the svn revision number when looking at a
commit message.

> I've tried to play a little bit around with this issue and I tried to copy information from .git
> directory found on Jukka's server. This made me able to push my changes but git svn insisted on
> rebasing my repository using commits found in svn which is wrong. Basically we want such a setup
> that uses git repository (Jukka's clone) for pulling changes and local git svn for pushing changes.
> Git svn should never try to rebase local repository because this will lead to two different trees on
> two different machines so we won't be able to exchange and merge changesets.

svn doesn't really know what a merge is (not even 1.5). You MUST
rebase in order to commit to svn. This is a limitation of svn, not
git.

In terms of re-pulling from the git-svn mirror, git-svn will create
the same commits (with the same sha1s) from svn every time, so there
will be no conflicts there.

> Is it possible with Git right now?

Yes, but it might not be possible with svn, depending on which part of
the above "it" is.

> What if A was not fair and has rewritten a few commits coming from B so they contain malicious code?
> How we can detect something like that and how C be sure that what he merges is really work
> attributed by correct names?

If C doesn't trust A, C should not pull from A. C should pull only
from (trusted) B. Presumably B knows who (of A and B) did which work,
and B's repository can be trusted?

If neither of A or B can be trusted, then you have problems that a
computer cannot solve for you.

You could maybe use signed tags ("git help tag") - each contributor
could sign a certain tree state, and if you see commits attributed to
the other contributor after their last tag, you know something is
fishy. But that might be more effort than either you or your
contributors want to go through. And while it might help with
attribution problems, it still doesn't help with all the other
problems you might have with untrusted contributors.

Peter Harris
