From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Wed, 9 Jul 2014 19:56:19 +0000
Message-ID: <20140709195619.GA17454@dcvr.yhbt.net>
References: <539DD029.4030506@web.de>
 <53B41D42.2090805@web.de>
 <53B46425.3030000@web.de>
 <53B4F0AA.10809@web.de>
 <53B5C7AC.4040701@web.de>
 <xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
 <53BAF7AF.4020901@web.de>
 <53BC47BD.1000705@web.de>
 <53BD7A36.2030300@kdbg.org>
 <xmqqr41u9w27.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 22:04:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4y6X-0006Um-Uf
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 22:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbaGIUEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 16:04:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36882 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766AbaGIUEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 16:04:33 -0400
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jul 2014 16:04:33 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4572F44C1A0;
	Wed,  9 Jul 2014 19:56:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqr41u9w27.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253145>

Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > Am 08.07.2014 21:34, schrieb Jens Lehmann:
> >>> And Msysgit complains 
> >>> error: fchmod on c:/xxxt/trash directory.t7613-merge-submodule/submodule_update_repo/.git/modules/sub1/config.lock failed: Function not implemented
> >> 
> >> I'm not sure what this is about, seems to happen during the "cp -R" of
> >> the repo under .git/modules into the submodule.
> >
> > No. It happens because fchmod() is not implemented in our Windows port.
> >
> > Please see my band-aid patch at
> > http://thread.gmane.org/gmane.comp.version-control.git/248154/focus=20266
> > The sub-thread ended inconclusive.
> 
> We need to start somewhere, and a no-op fchmod() in your patch may
> be as a good place to start as anything.  At least we would then
> keep the old behaviour without introducing any new failure.

Right, this likely makes the most sense for single-user systems or
systesm without a *nix-like permission system.

> An alternative might be to use chmod() after we are done writing to
> the config.lock in order to avoid the use of fchmod() altogether,
> which I think can replace the existing two callsites of fchmod().
> That approach might be a more expedient, but may turn out to be
> undesirable in the longer term.

In that case, we would need to open with mode=0600 to avoid a window
where the file may be world-readable with any data in it.
