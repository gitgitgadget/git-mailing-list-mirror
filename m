From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin
	command.
Date: Wed, 12 Dec 2007 13:25:43 -0500
Message-ID: <1197483943.10132.4.camel@hinata.boston.redhat.com>
References: <20071211195712.GA3865@bitplanet.net>
	 <Pine.LNX.4.64.0712111549490.5349@iabervon.org>
	 <1197416286.7552.4.camel@hinata.boston.redhat.com>
	 <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>
	 <1197473063.9269.20.camel@hinata.boston.redhat.com>
	 <Pine.LNX.4.64.0712121237540.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:31:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2WN3-0004TH-NA
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbXLLSb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbXLLSb1
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:31:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38473 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbXLLSb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:31:26 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBCIPnj6014567;
	Wed, 12 Dec 2007 13:25:49 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBCIPnVe013221;
	Wed, 12 Dec 2007 13:25:49 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBCIPnEj032123;
	Wed, 12 Dec 2007 13:25:49 -0500
In-Reply-To: <Pine.LNX.4.64.0712121237540.5349@iabervon.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68082>

On Wed, 2007-12-12 at 13:00 -0500, Daniel Barkalow wrote:
> On Wed, 12 Dec 2007, Kristian Hgsberg wrote:
> 
> > However, let me just say that the patch I sent is almost just that.
> > Part of the patch refactors init-db to be useful from clone, part of the
> > code is option parsing and figuring out the git dir, work tree.  Also,
> > the part of the patch that does 'git checkout' is approximately 20 lines
> > that end up calling unpack_tre() and then write_cache().  The bulk of
> > the work here is really just builtin boilerplate code, option parsing
> > and the builtin-clone tasks you describe below (HEAD discovery, --shared
> > and --reference optimizations and the local hardlink optimization - all
> > these are in the 500 line builtin-clone.c I sent).
> > 
> > And maybe it makes sense to use builtin-remote for the remote add -f
> > part, but the fetch part of the patch is 10 lines to set up for
> > fetch_pack().  So while I do agree that it makes sense to keep remotes
> > handling in one place, doing the fetch_pack() in builtin-clone.c doesn't
> > seem like a big duplication of code.  And either way, I agree with
> > Dscho, once we have either builtin-clone or builtin-fetch it's easier to
> > share code and refactor, and there is not a strong reason to do one or
> > the other first.
> 
> Er, we have builtin-fetch. We just don't have a way of calling it with all 
> of the option parsing done, but that should be easy. I was expecting that 
> step to get done when clone got converted, or maybe remote...

Ugh, I meant builtin-remote there, sorry.  I use fetch_pack() like the shell
script does, and it seem a lot easier that trying to call fetch:

        struct fetch_pack_args args;

        args.uploadpack = option_upload_pack;
        args.quiet = option_quiet;
        args.fetch_all = 1;
        args.lock_pack = 0;
        args.keep_pack = 1;
        args.depth = option_depth;
        args.no_progress = 1;

        refs = fetch_pack(&args, argv[0], 0, NULL, NULL);

Kristian
