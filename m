From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 8 Apr 2016 16:17:47 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604081616550.2967@virtualbox>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>  <1459980722-4836-4-git-send-email-dturner@twopensource.com>  <5705FC59.2050801@kdbg.org> <alpine.DEB.2.20.1604071614250.2967@virtualbox> <1460054824.5540.2.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	pclouds@gmail.com, aevarb@gmail.com, jeffhost@microsoft.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 16:18:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoXEh-0007h3-Jl
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 16:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167AbcDHOR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 10:17:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:60471 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbcDHOR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 10:17:57 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lxu7U-1brJ2e3ZQq-015L8L; Fri, 08 Apr 2016 16:17:48
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1460054824.5540.2.camel@twopensource.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UZCmlJT6O8unjpqyN8XihMI/69YOxReEtOrQ6NDKPcnHGuzQS2A
 Xu+rz7EJ9mb5hRT/e/+Cz/LBSio077A2nu3877et3ZTdYgXSsyQdqUUUMCXZFP3DIg0SdJ0
 zJVVnf1RLqDvbIY7fY4fdZYpyg/G3foBOgn3AegQZQYxSuo3EpkmF5riTJs1ToWCLlSROVJ
 2uVmW5N/z1nBgnStlznXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NkdI/a7F8TQ=:XCEUwV0EFM9ex74KWC6lFl
 hDEtMUxbQPtMNBUY86JPjdKb/6Yn0nlGI0CE/kmiMlY2SkzSD1yrrGJardD7r4JPizpCAvXRQ
 ERrlhNCUFfgRQ8yt7MvSrjH/gGR5SoeJnzI+f1nn1ke+8DrITf1zl4UeeujL/Zd+n44UXURRA
 R6pOaH97YGfj2dYY7Fn7/P8RzuC8Wl4pM8+qe9+FWKELqLXSP+m6IVP+82EGL/uxTGEG5iQbq
 gQGnygt5KvrL17U8Pxur9CMbKLQk8veXnqd1rq/Jid8sPuyC9+88g8xftAsK2e2hei2rq9uFb
 1IniYgpI01b3jBxxwZpxpOXJNh0GrWJNG33j7q6lwVPJJSu83IdOGrQhuabNae3QybBUvctKg
 R7/rHtBfENDkgkOBQsv2vYE2MZYqMN68YRNpp9uIrapuqIlyc485OxHz5B5JZVHDMc/2owx/P
 wdwvjuYUIOGY5SlMa2UvhD01RhZ5UPVaHJRX3Uvg+qvbdNZ7hpErEV5T4/rUqejtim7bnJd7Q
 09ezW7RMk/AMtQKla+akEmQ+SCmD5lU7YlEQpoW8GPlH856r6y31jY8urm16FNX5QF9Ugpkb6
 RZJ86fQkZm+PAEnRGJqlOVy4GV6kNy42lItrJ+Nrs87dD7obDDvR1ZusBeOhBN7rpaByg7JBy
 gRc53XlBrszKRoY+UK8rPQFpX7rIzeThHHrJJYj6MSB6d42Hp4Ycc8ODTd1ZmNrpPxKPfLR9a
 fQztEQoQ057y4gIL+NVUGQIrA5j2Ul7DvtRHKgW46hyd3dbYzoWm44lJT6BiODzHY0O8Om1g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291037>

Hi David,

On Thu, 7 Apr 2016, David Turner wrote:

> On Thu, 2016-04-07 at 16:14 +0200, Johannes Schindelin wrote:
> > 
> > On Thu, 7 Apr 2016, Johannes Sixt wrote:
> > 
> > > Am 07.04.2016 um 00:11 schrieb David Turner:
> > > > +static void share_index(struct index_state *istate, struct shm
> > > > *is)
> > > > +{
> > > > +	void *new_mmap;
> > > > +	if (istate->mmap_size <= 20 ||
> > > > +	    hashcmp(istate->sha1,
> > > > +		    (unsigned char *)istate->mmap + istate
> > > > ->mmap_size - 20)
> > > > > > 
> > > > +	    !hashcmp(istate->sha1, is->sha1) ||
> > > > +	    git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, istate
> > > > ->mmap_size,
> > > > +			&new_mmap, PROT_READ | PROT_WRITE,
> > > > MAP_SHARED,
> > > > +			"git-index-%s", sha1_to_hex(istate
> > > > ->sha1)) < 0)
> > > 
> > > Builds which have NO_MMAP set require that MAP_PRIVATE is set. So I
> > > would
> > > guess that at this point you leave those builds behind. Unless we
> > > declare
> > > such systems as hopelessly outdated and remove NO_MMAP and
> > > compat/mmap.c or
> > > you support index-helper only when NO_MMAP is not set.
> > 
> > I vote for the latter: support index-helper only when NO_MMAP is
> > unset.
> 
> Will fix, thanks.

Thank you!

Just for the record, I was really pushing forward with my rebase--helper
work, is the only reason I did not review your index-helper series yet!

Thanks,
Dscho
