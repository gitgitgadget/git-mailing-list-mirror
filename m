From: "Kyle Moffett" <kyle@moffetthome.net>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Thu, 13 Nov 2008 00:22:20 -0500
Message-ID: <f73f7ab80811122122i4ae3ba6dn2ceb314b86660a70@mail.gmail.com>
References: <20081107220730.GA15942@coredump.intra.peff.net>
	 <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
	 <20081108142756.GC17100@coredump.intra.peff.net>
	 <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org>
	 <20081109014926.GA31276@coredump.intra.peff.net>
	 <f73f7ab80811111644y14f0e0ccweed44440356a6508@mail.gmail.com>
	 <20081112084412.GA3860@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Sam Vilain" <sam@vilain.net>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 06:23:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Ug9-0001b7-QX
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 06:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbYKMFWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 00:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbYKMFWW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 00:22:22 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:43526 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbYKMFWV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 00:22:21 -0500
Received: by an-out-0708.google.com with SMTP id d40so354536and.1
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 21:22:20 -0800 (PST)
Received: by 10.100.153.6 with SMTP id a6mr2344779ane.76.1226553740287;
        Wed, 12 Nov 2008 21:22:20 -0800 (PST)
Received: by 10.100.241.4 with HTTP; Wed, 12 Nov 2008 21:22:20 -0800 (PST)
In-Reply-To: <20081112084412.GA3860@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100852>

On Wed, Nov 12, 2008 at 3:44 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 11, 2008 at 07:44:06PM -0500, Kyle Moffett wrote:
>> Hmm, I wonder if it would be possible to also add a "detach" variant;
>> which would create a detached-HEAD at the current commit when
>> automatically receiving a push to the working branch.  I have a
>> post-receive script that does so right now on a couple repositories.
>> It's still a little confusing to someone actively working in the
>> repository being pushed to, but it's much easier to explain than the
>> current default behavior.
>
> A neat idea, but I'm not sure what workflow that is meant to support.

Basically, I have a remote tree on a fast multicore box used for runs
of a test suite on various peoples different branches.  When I want
somebody to push something for me to test, they push directly to that
repo, and when I'm done playing with a previous run I just do:

$ git checkout new/branch/to/test
$ make clean
$ ./configure
$ make
$ make check

Occasionally I notice a bug which I want to temporarily fix to let the
build continue, even though I will need to have the author merge that
fix as a part of his original buggy patch.  If nobody pushes the
branch I'm currently testing again, I can "git diff" just fine to see
what I had to fix.  If somebody pushes to a different branch than the
one I'm testing, it's also fine.  The inconsistency is pushing to the
branch I'm on.

So it would be handy to be able to mark that repository as
"detach-HEAD-on-push-of-current-branch", which would let me remember
where I was, even if that's not where that branch is anymore.

There are other ways I could probably do something very similar, but
since the config option was being added it seemed it would probably be
easy to extend.  If nobody else is interested in that behavior, I will
just keep maintaining my own hook, but I thought I'd mention it.

Cheers,
Kyle Moffett
