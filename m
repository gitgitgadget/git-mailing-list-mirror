From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Wed, 18 Jul 2012 08:49:08 +0100
Message-ID: <20120718074908.GA23460@beczulka>
References: <20120625075726.GO3125@beczulka>
 <7vehp3gwbx.fsf@alter.siamese.dyndns.org>
 <20120626212108.GR3125@beczulka>
 <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
 <20120626223215.GB8336@beczulka>
 <20120709220321.GE30213@beczulka>
 <7v8vesk12v.fsf@alter.siamese.dyndns.org>
 <20120711012617.GA18369@dcvr.yhbt.net>
 <20120711214019.GF30213@beczulka>
 <7vmx35dhzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 10:01:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrPC7-000295-Cm
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 10:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab2GRIBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 04:01:10 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58548 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab2GRIBH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 04:01:07 -0400
Received: by wgbdr13 with SMTP id dr13so1127861wgb.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 01:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=RVDifNkrULWsy+ewnfOgJuWR8/Aka8roEp4KNKZFf9s=;
        b=HQtxdU0OwSgK4hMI5nfDFNuTpVkAQcIl52mCki72DkUOjKh9fpddjfUgzr5nu+YG1+
         piweQLovN2b2en53FcABnFgJGPO3qH7H7H+ECRk5sImONFovKXu6N2xcD7MEDDosB/Bu
         xUL4dz3l+3IrJoHWRZ5GcNRWwtyZCMq1wiIADQiizO0oR5Ikmmdv1Fa6qb4TD01/sNKY
         lUUKAbDKP6mDmDw4DiIQ8UBggEJ2cPL1Rrd2pJLZdY83CaNd05qad+xEI1GX2PR39BAa
         SPko6olyt49g8ScfN7z0ll14A5DdYe9nPQONTzZk5r7+IuE+HCs5GW+xJ0wzyJVGbUP3
         K3EA==
Received: by 10.216.62.204 with SMTP id y54mr1238101wec.31.1342598465804;
        Wed, 18 Jul 2012 01:01:05 -0700 (PDT)
Received: from beczulka (dhcp-172-26-143-156.dub.corp.google.com [172.26.143.156])
        by mx.google.com with ESMTPS id h9sm31359837wiz.1.2012.07.18.01.01.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jul 2012 01:01:04 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1SrP0O-0002p6-Ik; Wed, 18 Jul 2012 08:49:08 +0100
Content-Disposition: inline
In-Reply-To: <7vmx35dhzo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQlF3kXfco6SCK5SiWuHviyGj8hjA3puFPaWqpWtJU1i1PAt04oMU9QhlGp4yiVGdp8GfT1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201669>

Thanks for the review!

On Wed, Jul 11, 2012 at 03:56:43PM -0700, Junio C Hamano wrote:
> Marcin Owsiany <marcin@owsiany.pl> writes:
> 
> > Date: Sun, 24 Jun 2012 22:40:05 +0100
> > Subject: [PATCH] git-svn: don't create master if another head exists
> >
> > git-svn insists on creating the "master" head (unless it exists) on every
> > "fetch". It is useful that it gets created initially, when no head exists
> > - users expect this git convention of having a "master" branch on initial
> > clone.
> >
> > However creating it when there already is another head does not provide any
> > value - the ref is never updated, so it just gets stale after a while.  Also,
> > some users find it annoying that it gets recreated, especially when they would
> > like the git branch names to follow SVN repository branch names. More
> > background in http://thread.gmane.org/gmane.comp.version-control.git/115030
> >
> > Make git-svn skip the "master" creation if HEAD points at a valid head. This
> > means "master" does get created on initial "clone" but does not get recreated
> > once a user deletes it.
> 
> The above description makes sense to me, but the code updated with
> this patch doesn't quite make sense to me.
> 
> This is your patch with a bit wider context.
> 
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 0b074c4..2379a71 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1599,35 +1599,35 @@ sub rebase_cmd {
> >  sub post_fetch_checkout {
> >         return if $_no_checkout;
> >         my $gs = $Git::SVN::_head or return;
> >         return if verify_ref('refs/heads/master^0');
> 
> Does "master" matter here?
> 
> I am wondering why this is not
> 
> 	return if verify_ref("HEAD^0");
> 
> Moreover, since the code will check verify_ref("HEAD^0") anyway in
> the place you updated, is this early return still necessary?

Hm, good point, nothing between these two returns seems to modify
on-disk state.

> >         # look for "trunk" ref if it exists
> >         my $remote = Git::SVN::read_all_remotes()->{$gs->{repo_id}};
> >         my $fetch = $remote->{fetch};
> >         if ($fetch) {
> >                 foreach my $p (keys %$fetch) {
> >                         basename($fetch->{$p}) eq 'trunk' or next;
> >                         $gs = Git::SVN->new($fetch->{$p}, $gs->{repo_id}, $p);
> >                         last;
> >                 }
> >         }
> > 
> > -	my $valid_head = verify_ref('HEAD^0');
> > +	return if verify_ref('HEAD^0');
> 
> This one matches the description.  When post_fetch_checkout() is
> called, if HEAD is already pointing at a valid commit, we do not
> want to run checkout (or create a ref).
> 
> >         command_noisy(qw(update-ref refs/heads/master), $gs->refname);
> > -	return if ($valid_head || !verify_ref('HEAD^0'));
> > +	return unless verify_ref('HEAD^0');
> 
> I do not understand these three lines.  Why aren't they like this?
> 
> 	command_noisy(qw(update-ref HEAD), $gs->refname) || return;
> 
> That is, in a fresh repository whose HEAD points at an unborn
> 'master', nothing changes from the current behaviour.  If a fresh
> repository whose HEAD points at some other unborn branch, should the
> code still want to update 'master'?  Wouldn't we rather want to
> update that branch?

I don't know if there can ever be some other unborn branch other than
"master", but I guess your proposal makes it more robust.

> If the caller does not handle errors, it could be even clearer to
> write it like
> 
> 	command_noisy(qw(update-ref HEAD), $gs->refname) ||
> 		die "Cannot update HEAD!!!";

Turns out that command_noisy()
 - has a meaningless return value
 - throws an exception on command failure
so the "||" bit does not work.
Also, for some reason command_noisy does not check for the command being
killed by a signal, so I'd prefer to leave the verify_ref there.

PTAL:

From: Marcin Owsiany <marcin@owsiany.pl>
Date: Sun, 24 Jun 2012 22:40:05 +0100
Subject: [PATCH] git-svn: don't create master if another head exists

git-svn insists on creating the "master" head (unless it exists) on every
"fetch". It is useful that it gets created initially, when no head exists
- users expect this git convention of having a "master" branch on initial
clone.

However creating it when there already is another head does not provide any
value - the ref is never updated, so it just gets stale after a while.  Also,
some users find it annoying that it gets recreated, especially when they would
like the git branch names to follow SVN repository branch names. More
background in http://thread.gmane.org/gmane.comp.version-control.git/115030

Make git-svn skip the "master" creation if HEAD already points at a valid head.
This means "master" does get created on initial "clone" but does not get
recreated once a user deletes it.

Also, make post_fetch_checkout work with any head that is pointed to by HEAD,
not just "master".

Also, use fatal error handling consistent with the rest of the program for
post_fetch_checkout.

Signed-off-by: Marcin Owsiany <marcin@owsiany.pl>
---
 git-svn.perl |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0b074c4..6673d21 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -367,9 +367,9 @@ Git::SVN::init_vars();
 eval {
 	Git::SVN::verify_remotes_sanity();
 	$cmd{$cmd}->[0]->(@ARGV);
+	post_fetch_checkout();
 };
 fatal $@ if $@;
-post_fetch_checkout();
 exit 0;
 
 ####################### primary functions ######################
@@ -1598,8 +1598,8 @@ sub rebase_cmd {
 
 sub post_fetch_checkout {
 	return if $_no_checkout;
+	return if verify_ref('HEAD^0');
 	my $gs = $Git::SVN::_head or return;
-	return if verify_ref('refs/heads/master^0');
 
 	# look for "trunk" ref if it exists
 	my $remote = Git::SVN::read_all_remotes()->{$gs->{repo_id}};
@@ -1612,9 +1612,8 @@ sub post_fetch_checkout {
 		}
 	}
 
-	my $valid_head = verify_ref('HEAD^0');
-	command_noisy(qw(update-ref refs/heads/master), $gs->refname);
-	return if ($valid_head || !verify_ref('HEAD^0'));
+	command_noisy(qw(update-ref HEAD), $gs->refname);
+	return unless verify_ref('HEAD^0');
 
 	return if $ENV{GIT_DIR} !~ m#^(?:.*/)?\.git$#;
 	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
-- 
1.7.7.3

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
