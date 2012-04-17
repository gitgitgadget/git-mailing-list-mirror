From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 17 Apr 2012 15:51:58 -0500
Message-ID: <nng1unmnksx.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:52:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKFNm-0003f7-NS
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794Ab2DQUwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 16:52:07 -0400
Received: from exprod6og112.obsmtp.com ([64.18.1.29]:59112 "EHLO
	exprod6og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab2DQUwE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 16:52:04 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob112.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT43X8nao0CTDND1ZbZkchcDcdW5nYSWa@postini.com; Tue, 17 Apr 2012 13:52:04 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 17 Apr
 2012 15:52:01 -0500
In-Reply-To: <CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	(Hilco Wijbenga's message of "Tue, 17 Apr 2012 12:55:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195805>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> If you work on a subproject (in its own repo) then a subsequent pull
> in the umbrella project should bring this new code into the umbrella
> project (assuming that would make sense given the branches involved).

I don't necessarily think this is always what should happen.  I can't
comment on git-submodule since I haven't used it in its more recent
incarnation, but one thing I like about git-subtree is that it's
explicit.  I have to do a "git subtree pull" on the umbrella project to
pull in the new changes from a subproject.  That gives me some degree of
control over when to update sources.  I suspect one can do the same by
using "git pull" in submodule directories.

If you want the behavior you describe, a post-receive hook on the
component repositories is easy to implement.  I just did that a couple
of weeks ago for a subtree-aggregated repository.  When a component
receives something it immediately does a "git subtree pull" on a
workarea on the server and then does a push from that workarea to the
subtree-aggregated repository.

Of course, this is entirely driven by git-subtree's model of actually
incorporating subproject history into one big umbrella repository.
There is no separation between the subprojects and umbrella projects.
It's one giant history.  Therefore, push/pull to/from subprojects are
explicit operations.  That's probably not the best model for every
situation but I find it very nice.

> After rereading my earlier reply I felt that it might be interpreted
> as being disparaging of submodules/subtree/gitslave.

I didn't interpret it that way at all.  I agree with you that
subproject/superproject support could be much better.  But I don't agree
that we'll be able to design one model that works for everyone.  svn
externals are just one model to aggregate projects but it is not the
only one.  It just happens that no one working on Subversion bothered to
implement anything else.

Perhaps a good way to go would be to provide the basic operations (I
think we have most of that) and some hooks in contrib/ or elsewere to
implement various models.  Just like git imposes no particular workflow
model I don't think git should impose one particular aggregation model.
What we do need is better documentation of what the various models and
tools are.  For example, I would find a subtree/submodule comparison
highly valuable.  It would help people decide which model is best for
them.

                                -Dave
