From: Renato Botelho <garga@FreeBSD.org>
Subject: Re: [bug] 2.5.0 build with =?utf-8?b?Tk9fUEVSTA==?= is broken
Date: Tue, 18 Aug 2015 18:09:12 +0000 (UTC)
Message-ID: <loom.20150818T200305-434@post.gmane.org>
References: <loom.20150814T171757-901@post.gmane.org> <loom.20150814T184447-932@post.gmane.org> <xmqq7foxiqu6.fsf@gitster.dls.corp.google.com> <CAPig+cR77oFo6D3f8BjAB_yM-xPt+3EUGK4vZr3eYWJGTtksAQ@mail.gmail.com> <xmqqoai9h9co.fsf@gitster.dls.corp.google.com> <CAPig+cR6iT=AC8zq-vHHTkXMzRmDA-o9JLi0h8gbR1tzbqNyKA@mail.gmail.com> <xmqqzj1tfr2g.fsf@gitster.dls.corp.google.com> <CAPig+cQkApWfZ6N159F-XFZk+nnzY-gAgLRfZXNitdd0CHpm2g@mail.gmail.com> <loom.20150818T130309-687@post.gmane.org> <CAPig+cTvNQ74G4T3McNd2JUXLvxe-yX+ApFrevXDi4GXsFQ_3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 20:09:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRlKG-0003YP-Ue
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 20:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbbHRSJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 14:09:27 -0400
Received: from plane.gmane.org ([80.91.229.3]:46471 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbbHRSJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 14:09:27 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZRlK2-0003OG-PI
	for git@vger.kernel.org; Tue, 18 Aug 2015 20:09:19 +0200
Received: from 186-249-144-75.desktop.com.br ([186-249-144-75.desktop.com.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 20:09:18 +0200
Received: from garga by 186-249-144-75.desktop.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 20:09:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 186.249.144.75 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:40.0) Gecko/20100101 Firefox/40.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276132>

> Eric Sunshine <sunshine <at> sunshineco.com> writes:
> 
> Hmm, I was under the impression from your initial mail[1] that Git
> wouldn't even build without Perl available:
> 
>     /bin/sh: /usr/bin/perl: not found
>     Makefile:1701: recipe for target 'common-cmds.h' failed
>     gmake[2]: *** [common-cmds.h] Error 127

This assumption is correct, current 2.5.0 doesn't build without perl.

> Doesn't this failure prevent generation of the 'git' executable altogether?
> 
> > git-submodule
> > git-request-pull
> > git-am
> 
> Also...
> 
> git-add--interactive
> git-archimport
> git-cvsexportcommit
> git-cvsimport
> git-cvsserver
> git-difftool
> git-instaweb
> git-relink
> git-send-email
> git-svn

When I build with NO_PERL=1, above files are a simple shell script saying
git was built without it:

#!/bin/sh

echo >&2 "fatal: git was built without support for `basename $0` (NO_PERL=1)."
exit 128

But the same doesn't happen with submodule, request-pull and am.

> A C rewrite of git-am has recently graduated to 'master'.

cool!

> That might make sense. Although some of the above commands may not be
> used widely, others, such as git-send-email, probably are used
> regularly.

There is a port called git-lite with few dependencies, sometimes people
install it on servers that only need to clone and update local copies of
repos. It's interesting to keep it working as expected with NO_PERL, since
it offers this option.
