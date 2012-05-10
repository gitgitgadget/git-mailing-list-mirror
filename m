From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: submodule update --force
Date: Thu, 10 May 2012 20:57:38 +0200
Message-ID: <20120510185738.GE76400@book.hvoigt.net>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com> <CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com> <7vobpwpoyi.fsf@alter.siamese.dyndns.org> <7vk40kpnia.fsf@alter.siamese.dyndns.org> <CAHOQ7J_6+sfU6egjvVSPj-FAS6zjSUT=a057=kz_wYbogHLMMA@mail.gmail.com> <7v8vh0ozge.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 20:57:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSYYb-0005k2-Ai
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 20:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759943Ab2EJS5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 14:57:40 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40149 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755221Ab2EJS5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 14:57:40 -0400
Received: (qmail 23338 invoked from network); 10 May 2012 18:57:38 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 10 May 2012 18:57:38 -0000
Content-Disposition: inline
In-Reply-To: <7v8vh0ozge.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197614>

Hallo all,

On Thu, May 10, 2012 at 07:58:09AM -0700, Junio C Hamano wrote:
> Stefan Zager <szager@google.com> writes:
> 
> > ...  To my mind, any
> > `git submodule` command should *always* run on the first level of
> > submodules.  If you're going to specify --no-recurse, then why are you
> > running `git submodule` at all?  I think 'recursion' only applies to
> > moving beyond the first level of submodules.
> 
> Very true.
> 
> Submodule folks, any opinion on the Stefan's approach?

The distinction between first level of submodules and deeper is only
present in the "git submodule" subcommand and I think mainly for
historical reasons. I do not see a use case where this would be helpful.
To skip uninteresting submodules one can always use the
submodule.$name.update option set to 'none'. (I just found that its
documentation is in the wrong place but I will send a seperate patch
about that).

In the non submodule commands we usually name this option
--recurse-submodules=always and have another
--recurse-submodules=on-demand option for the current behavior. Those
options would either recurse or do nothing with the submodule. Such a
behavior, as pointed out, does not make sense for 'submodule update'.
Similar options names for 'submodule update' would probably be
--recurse=always and --recurse=on-demand.

Nonetheless is force a term where the user probably wants to skip all
optimizations which the sha1 equality provides. So to make the current
behavior more consistent I would be fine with adding this change.

One thing which might make force even more useful would be to also skip
the "is the sha1 available"-check for fetch that is possibly run before
the checkout and just always run the fetch.

In the long term, once checkout has learned things 'submodule update' is
currently doing, it probably makes sense to let 'submodule update'
always recurse into all checked out submodules. Since then it does not
make sense to run 'submodule update' for much more than resetting
things or changing the currently registered commits anymore. So in the
bright new future the 'on-demand' part will probably move away from
'submodule update' and as such it does not make sense to implement
the seperate recurse options I described above.

What do others think?

Cheers Heiko
