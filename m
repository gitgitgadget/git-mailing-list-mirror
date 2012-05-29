From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] git-svn: use YAML format for mergeinfo cache when
 possible
Date: Tue, 29 May 2012 00:25:37 +0000
Message-ID: <20120529002537.GA4575@dcvr.yhbt.net>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
 <20120528003901.GA11103@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 02:26:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZAGK-0003ST-Am
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 02:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab2E2AZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 20:25:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54883 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab2E2AZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 20:25:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE22D1F42A;
	Tue, 29 May 2012 00:25:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120528003901.GA11103@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198729>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Wong wrote:
> > Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> >> +package Git::SVN::Memoize::YAML;
> >
> > Can we use this as an opportunity to start splitting git-svn.perl into
> > multiple .pm files?
> 
> Not a bad idea.  I've included an example patch to sanity-check the
> approach below.

Thank you.  I've signed-off and pushed that and your other two out to
"master" on git://bogomips.org/git-svn

> >> +	my $truehash = (-e $filename) ? YAML::Any::LoadFile($filename) : {};
> >
> >> +	YAML::Any::DumpFile($self->{FILENAME}, $self->{H});
> >
> > These should die on errors, right?
> 
> At least in YAML::Old, they use Carp::croak.  Maybe something like
> 
> 	local @CARP_NOT = qw(YAML::Any);
> 
> to blame the caller for the error would bring sanity.

Interesting, didn't know about @CARP_NOT.  It's barely documented in
on my Debian stable install(s), but it seems to be available since 5.8.
We should be able to use it without breaking compatibility.

> >> +=head1 BUGS
> >
> >> +Error handling is awkward.
> >
> > How so?
> 
> I mostly meant that it's not obvious what the state of %hash is at the
> point marked with (*) below:
> 
> 	if (not eval {
> 		tie my %hash => 'Foo::Bar', @params;
> 		1;
> 	}) {
> 		my $err = $@ ||
> 			# a destructor might have clobbered $@
> 			"Zombie error";
> 		die $err if worth_dying($err);
> 
> 		(*) ... try to recover ...
> 	}
> 
> That's not specific to Memoize::YAML, though.  It probably is not
> awkward for wizards who know the details. :)

OK, so we're no better or worse off than we were before :)
