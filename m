From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 17:55:06 +0100
Message-ID: <201203211755.07121.jnareb@gmail.com>
References: <20120321140429.GA28721@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 21 17:55:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAOoj-0003Ja-J7
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 17:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab2CUQzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 12:55:15 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:51053 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab2CUQzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 12:55:13 -0400
Received: by wejx9 with SMTP id x9so1118823wej.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=qdvrboKlHA65HN6io73I7LOhjFNv83elXq+MaMqNv2s=;
        b=YiEZQzzOv+MnjY7nZNy0zpXUdP3hfFBpsl3q2vmdR1W41JB0zq+ViNoxkgf58QwyWc
         C0oCnq60i7o3/egdM6Dln8kR98FMOIz2YlQFHwg1U7ZQvFR6+pg9CVyTL/kosSQs6wiV
         ZMnO61F8J1GnEcu5IIrabp/3rTV2pS18JW1ObBRj0TFRjkqrFxNPGyQlT/Uef10M02gB
         UfOdRRfOrr5DcPmWeH31mJw0gmgR5P527Iw9zqkes03mr2etqcMOFwjFnubKmR5O1yHq
         F9pi9plOFvzerPOAGhGA5Amg4NNBCMq4AkAJrXlMJDEK+j+oAdPcfRHLbXq+QLWTc+7o
         sV2Q==
Received: by 10.180.76.74 with SMTP id i10mr40130024wiw.2.1332348912490;
        Wed, 21 Mar 2012 09:55:12 -0700 (PDT)
Received: from [192.168.1.13] (abvy85.neoplus.adsl.tpnet.pl. [83.8.222.85])
        by mx.google.com with ESMTPS id bx13sm5802219wib.10.2012.03.21.09.55.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 09:55:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120321140429.GA28721@odin.tremily.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193587>

On Wed, Mar 21, 2012, W. Trevor King wrote:
> On Wed, Mar 21, 2012 at 06:19:51AM -0700, Jakub Narebski wrote:

> > By the way, it is custom on this mailing list to usually Cc (send a
> > copy) to all people participating in discussion, and not only to git
> > mailing list.
> 
> Ah, sorry.  I figured that if you got the original email to the list,
> I'd just be doubling up in your inbox by Cc-ing you directly.

I am not subscribed to git mailing list, and I am reading it and
responding (to those emails that I'm not Cc-ed) via GMane's NNTP
(Usenet) interface:

  nntp://news.gmane.org/gmane.comp.version-control.git

And I think I am not the only one.  But I guess that even for those
subscribed, emails addressed directly to them take priority, which
is important considering volume of email on git mailing list.
 
[..]
> > BTW. what happened to diffstat?
> 
> My local branch has sequential commits for each patch version (e.g.,
> commits for v1, v2, ...).  When it's time to email the list, I'm
> supposed to send logical patches against the trunk (e.g., patches for
> refactoring, git_snapshot, ...).  For v2 I just used `git diff
> origin/master` to generate the patch, and it doesn't include the
> diffstat.  Now that I'm splitting into two patches, I'll probably use
> `git rebase -i origin/master` and just keep track of the changes by
> hand ;).  If there's a better way that I'm overlooking, feel free to
> point me in the right direction.

There is a tool to create patches to send: git-format-patch.  Myself I
usually create a new directory for a patch series, e.g. mdir.if_mod.v3,
and use git-format-patch to populate it, e.g.

  $ git format-patch origin/master.. -o mdir.if_mod.3/ \
                     --cover-letter --subject-prefix="PATCH v4"

Note that you need to edit at least cover letter.

BTW. "git diff" has '--stat -p' and '--patch-with-stat' options :-)

> > Tests (to be put, I think, in t/t9501-gitweb-standalone-http-status.sh)?
> > We could use test_tick() and $test_tick for that (or extract formatted
> > committer date from a commit).
> 
> I'll try to set that up.  Should it be bundled into the git_snapshot
> patch, or should there be three patches:
> 
> 1: gitweb: Refactor If-Modified-Since handling
> 2: gitweb: Add If-Modified-Since tests for git_snapshot
> 3: gitweb: Add If-Modified-Since support for git_snapshot

I think it would be better to add initial tests with refactoring, and
snapshot specific tests with snapshot support, e.g.:

  1/2: gitweb: Refactor If-Modified-Since handling and add tests
  2/2: gitweb: Add If-Modified-Since support for snapshots

> > > @@ -7029,6 +7051,10 @@ sub git_snapshot {
> > >  
> > >  	my ($name, $prefix) = snapshot_name($project, $hash);
> > >  	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
> > > +
> > > +	my %co = parse_commit($hash) or die_error(404, "Unknown commit object");
> > > +	die_if_unmodified($co{'committer_epoch'});
> > > +
> > 
> > That unexplainably changes behavior of 'snapshot' action.  Before we
> > would accept snapshot of a tree given by its SHA-1, now we do not.
> > 
> > This might be a good idea from a security point of view wrt. leaking
> > information (c.f. "git archive --remote" behavior), but it at least
> > needs to be explained in commit message, and perhaps even in a comment
> > above this line.
> > 
> > Alternative solution would be to skip If-Modified-Since handling if we
> > request snapshot by tree id:
> > 
> >   +
> >   +	my %co = parse_commit($hash);
> >   +	die_if_unmodified($co{'committer_epoch'}) if %co;
> >   +
> 
> I'm still not understanding the problem here.  The following all work
> in my testing:

But wouldn't work in my clone... ;-(

>   http://.../gitweb.cgi?p=a/.git;a=snapshot;h=1d545cab4a8dc894fae2c2634a74993ea62b054d;sf=tgz
>   http://.../gitweb.cgi?p=a/.git;a=snapshot;h=1d5;sf=tgz
>   http://.../gitweb.cgi?p=a/.git;a=snapshot;h=HEAD;sf=tgz
> 
> Can you give me an example of a hash that you expect to not work?

Currently all of those work

    http://.../gitweb.cgi?p=git.git;a=snapshot;h=v1.7.6;sf=tgz
    http://.../gitweb.cgi?p=git.git;a=snapshot;h=f696543d;sf=tgz"
    http://.../gitweb.cgi?p=git.git;a=snapshot;h=b1485af8;sf=tgz"

v1.7.6 is a tag, f696543d is a commit (v1.7.6^{}), b1485af8 is a tree
(v1.7.6^{tree}).

The last URL would stop working after your change with 404
"Unknown commit object".

I'm not sure but I think that currently 'snapshot' link in the navbar
of the 'tree' view uses that kind of link, with 'h' parameter set to
SHA-1 of a tree.

-- 
Jakub Narebski
Poland
