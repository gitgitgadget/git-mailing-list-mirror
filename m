From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 2/2] submodule: drop the top-level requirement
Date: Fri, 19 Apr 2013 08:46:32 +0100
Message-ID: <20130419074632.GC2278@serenity.lan>
References: <cover.1365539059.git.john@keeping.me.uk>
 <cover.1366314439.git.john@keeping.me.uk>
 <cover.1366314439.git.john@keeping.me.uk>
 <6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
 <7vfvyn4g46.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 09:46:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT61y-0006ZQ-V8
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 09:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab3DSHqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 03:46:47 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:39405 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984Ab3DSHqq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 03:46:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 82300CDA618;
	Fri, 19 Apr 2013 08:46:44 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MFHhDtWouQE6; Fri, 19 Apr 2013 08:46:43 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 71D4ACDA61B;
	Fri, 19 Apr 2013 08:46:34 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vfvyn4g46.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221750>

On Thu, Apr 18, 2013 at 03:40:41PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > +relative_path ()
> > +{
> > +	local target curdir result
> > +	target=$1
> > +	curdir=${2-$wt_prefix}
> > +	curdir=${curdir%/}
> > +	result=
> > +
> > +	while test -n "$curdir"
> > +	do
> > +		case "$target" in
> > +		"$curdir/"*)
> > +			target=${target#$curdir/}
> > +			break
> > +			;;
> > +		esac
> 
> Could $curdir have glob wildcard to throw this part of the logic
> off?  It is OK to have limitations like "you cannot have a glob
> characters in your path to submodule working tree" (at least until
> we start rewriting these in C or Perl or Python), but we need to be
> aware of them.

I think the use of "#" instead of "##" saves us here because even with a
wildcard in $curdir the case statement matches literally, so we know
that "$target" starts with "$curdir/", so "${target#$curdir/}" can't
match anything longer than the literal "$curdir" prefix.

> >  module_list()
> >  {
> > +	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
> 
> An efficient reuse of "--" ;-)
> 
> > +test_expect_success 'run summary from subdir' '
> > +	mkdir sub &&
> > +	(
> > +		cd sub &&
> > +		git submodule summary >../actual
> > +	) &&
> > +	cat >expected <<-EOF &&
> > +* ../sm1 0000000...$head1 (2):
> > +  > Add foo2
> > +
> > +EOF
> 
> It somewhat looks strange to start with "<<-EOF" and then not to
> indent the body nor EOF.

Yes, but I copied this from the preceding test.  I'd rather leave this
as it is for consistency and let later style fixes change all of the
tests in this file.
