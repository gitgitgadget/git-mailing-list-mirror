From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Dumb "continuous" commit dumb question
Date: Tue, 19 Aug 2008 15:32:58 +0100
Message-ID: <e1dab3980808190732i303f06ach50e36e13a624bd23@mail.gmail.com>
References: <48AA4263.8090606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pat LeSmithe" <qed777@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 16:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSHr-0001eG-3a
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 16:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbYHSOdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 10:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753144AbYHSOdA
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 10:33:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:50078 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbYHSOc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 10:32:59 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3755922wfd.4
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=e4UNPaRny+eBgeZYzBmt0TusxPxTnef92iVXQOHGkG8=;
        b=AUfDU1XbWkA7sonKXJDzf4QuCsWyxgHYMVjFDH377qWa5ENRz5G0BS56rYf0kE6Kmu
         +CrtIFXOSEjJvfvB9OYxPss3mzeDuPGZyadS4KBJM2TaolO8xSXdJDTehJpnte3Q+oiQ
         Q+eXyKNngboc8oWTl7jYYgkiz/1pnQoRK3jVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WN1kkh7lT1UocmgImvNAo3mIj6xJDuFfhEAJFvQzbgPssSwaYw2zGpnAZPPpdM+FUc
         61p29vfbQ6w8swkXGKBBSYloPr1en6IPZtb7nLhAn40iGfe/a7Yb+gkFxNHOl9YAIrU7
         0zQ/2Upw3YI0aNQhATpsSVdaYQECT9uhTemzg=
Received: by 10.142.154.20 with SMTP id b20mr2536436wfe.222.1219156378177;
        Tue, 19 Aug 2008 07:32:58 -0700 (PDT)
Received: by 10.142.136.18 with HTTP; Tue, 19 Aug 2008 07:32:58 -0700 (PDT)
In-Reply-To: <48AA4263.8090606@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92865>

On Tue, Aug 19, 2008 at 4:47 AM, Pat LeSmithe <qed777@gmail.com> wrote:
>
> Hello,
>
> Is it possible to enable git to automatically and continuously "softly"
> commit or stage *all* changes to a [subset of] files in a repository,
> without my intervention, as they happen?  Perhaps via a daemon which
> monitors the disk for explicit file-saving?
>
> Of course, I would still be able to perform explicit commits (with
> descriptive comments) and other git commands, in which case there
> probably should be smart handling of the recent soft history.  For
> example, it could simply be discarded.
>
> I understand that I could simply remember to commit and/or branch early
> and often.  But given that changes by an individual on a given branch
> are well-ordered by time, and that the "continuous" operation may be
> cheap in many situations, a "live" journal could be useful.

What I do is have a script that runs every 10 minutes that stages
files to the index and then, using the low-level git plumbing, creates
tree and commit objects on a side branch "temp". With this you can
easily commit to the main branch "main" PROVIDING you are commiting a
superset of the changes you're storing to the side-branch. If you
wanted to specify exactly the things in your "main" commit I suspect
you'd have to do some kind of "git-reset --mixed" to rollback the
side-branch state. One thing to be aware of if you do this is that git
expects your index file to be describing what you intend to do on the
current branch you are on (in, eg, git status), but by doing it this
way you'll get output that acts as if you've staged things for your
"main" branch.

This isn't a problem for me as my (idiosyncratic) usage is to have
commits on my main branch every hour via cron anyway.

If you're particularly interested in this approach I can either try
and explain the commands I use in email or you can try and extract
them from my python script chronoversion:

http://www.personal.rdg.ac.uk/~sis05dst/chronoversion.tgz

> Perhaps a better term is branch-aware undo or git with microstructure.

I actually find I don't use the temp branch to actually undo stuff
(partly because I'm not even trying to keep a neat history so I do
modifications primarily via new commits). Instead, I sometimes modify
and extend my research code in a way that I do maybe an hour or so of
new code and refactoring before it's in a state to actually run again.
If when it finally runs something's broken I find it very helpful to
be able to look backwards to see what changes I've made as the problem
either jumps out or I know where to start experimenting.

One problem with chronological backups is that they often don't
compile/run so you can't bisect on them. One thing I have been trying
to figure out is if there's an easy way to modify my build system so
that it makes a commit approximately every 10 minutes but just after a
successful compile. However, that looks to be a bit too complex and
error prone for the moment.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
