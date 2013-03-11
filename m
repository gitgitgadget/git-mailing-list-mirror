From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be
 depth-first, --parent option to execute command in supermodule as well
Date: Mon, 11 Mar 2013 17:46:30 +0100
Message-ID: <20130311164628.GA4167@sandbox-ub.fritz.box>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com>
 <51351CF5.7010308@web.de>
 <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
 <20130305075901.GB4677@sandbox-ub>
 <7vhakpvnex.fsf@alter.siamese.dyndns.org>
 <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com>
 <7vboaxu23y.fsf@alter.siamese.dyndns.org>
 <51365AB6.2010602@web.de>
 <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com>
 <513B7D08.20406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Cousineau <eacousineau@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 11 17:47:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF5sN-0006kU-Md
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 17:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab3CKQqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 12:46:37 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:52893 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab3CKQqh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 12:46:37 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UF5rq-0007GO-Uo; Mon, 11 Mar 2013 17:46:31 +0100
Content-Disposition: inline
In-Reply-To: <513B7D08.20406@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217888>

On Sat, Mar 09, 2013 at 07:18:48PM +0100, Jens Lehmann wrote:
> Am 05.03.2013 22:17, schrieb Phil Hord:
> > In a shell, it usually goes like this:
> > 
> >    git submodule foreach --recursive '${cmd}'
> >    <up><home><del>{30-ish}<end><backspace><enter>
> > 
> > It'd be easier if I could just include a switch for this, and maybe
> > even create an alias for it.  But maybe this is different command
> > altogether.
> 
> Are you sure you wouldn't forget to provide such a switch too? ;-)
> 
> I'm still not convinced we should add a new switch, as it can easily
> be achieved by adding "${cmd} &&" to your scripts. And on the command
> line you could use an alias like this one to achieve that:
> 
> [alias]
> 	recurse = !sh -c \"$@ && git submodule foreach --recursive $@\"

I also think it would be useful to have a switch (or even configuration)
to include the superproject.

The following (quite typical) use cases come to my mind:

# Assuming some not yet existing configuration values
git config submodule.recursive true
git config submodule.includeSuper true

# commit your work over the whole tree into one branch
git submodule foreach git checkout -b hv/my-super-cool-feature
git submodule foreach --post-order git commit -a -m "DRAFT: finished work for today"
git submodule foreach git push hvoigt hv/my-super-cool-feature

# cleanup
git submodule foreach git clean -xfd

# reset
git submodule foreach git reset --hard

...

Assuming you have a submodule heavy project and you work on multiple
submodules including the superproject. These are quite typical commands
you would use during development of your feature I imagine. Once you are
finished you need to get your feature upstream by the individual
submodule rules.

On a feature branch during development there is nothing wrong in simply
doing full cross-submodule project commits.

At some point we will probably extend the above commands with a
--recurse-submodules switch but until then this is a good substitute so
why not have a --include-super maybe even as a configuration option ?

Cheers Heiko
