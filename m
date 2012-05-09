From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git-diff-tree does not use alternate objects for submodules
Date: Wed, 9 May 2012 23:58:17 +0200
Message-ID: <20120509215815.GC74366@book.hvoigt.net>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com> <7v1umuznuj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 23:58:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSEty-0006oT-NF
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 23:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414Ab2EIV60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 17:58:26 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40119 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932162Ab2EIV6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 17:58:25 -0400
Received: (qmail 20531 invoked from network); 9 May 2012 21:58:23 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 9 May 2012 21:58:23 -0000
Content-Disposition: inline
In-Reply-To: <7v1umuznuj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197522>

Hi,

On Tue, May 08, 2012 at 08:36:36AM -0700, Junio C Hamano wrote:
> Orgad and Raizel Shaneh <orgads@gmail.com> writes:
> 
> > I have a project with a submodule. Both have objects/info/alternate
> > (different ones).
> >
> > After running 'git gc', running gitk on the superproject results in:
> > ?? Submodule sub 227e2b5...d8597e2 (commits not present)
> 
> When "--submodule" option was implemented in 752c0c, it was done with an
> premature and incomplete optimization, and I think you are seeing an
> unfortunate side effect of it. The code attempts to link the object store
> of the submodule repository into the in-core representation of the object
> store of the superproject (in submodule.c::add_submodule_odb()), but does
> not do a good job of it.  It does not take alternates into account, and
> who knows what else is missing.  Sigh...
> 
> The right approach to implement this feature would have been to fork a
> child process and perform the submodule operation inside the child, which
> will chdir into the submodule and treat as if it is a freestanding git
> repository, without contaminating the superproject process.
> 
> For now, an easiest workaround would be to rephrase the error message to
> "commits not present" to "commit not present or missing", or something.

I will have a look if I can come up with something that reads the
submodules alternate config and uses it. Do you have other config
related things in mind that might be missing?

Cheers Heiko
