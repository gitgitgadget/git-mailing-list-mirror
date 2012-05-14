From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: submodule update --force
Date: Mon, 14 May 2012 21:18:02 +0200
Message-ID: <20120514191802.GE58058@book.hvoigt.net>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com> <CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com> <7vobpwpoyi.fsf@alter.siamese.dyndns.org> <7vk40kpnia.fsf@alter.siamese.dyndns.org> <CAHOQ7J_6+sfU6egjvVSPj-FAS6zjSUT=a057=kz_wYbogHLMMA@mail.gmail.com> <7v8vh0ozge.fsf@alter.siamese.dyndns.org> <20120510185738.GE76400@book.hvoigt.net> <CABURp0rFQ+330X8g3C2rmozQ77zxqhZhReZhaYMi1FE4uKeQtA@mail.gmail.com> <20120514165231.GB58058@book.hvoigt.net> <CAHOQ7J_O=8NL0wp0Pu6pfjN_Y6NDJhKZUft9G2FL0vUWL7aEBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Mon May 14 21:18:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU0mZ-0001kY-9v
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 21:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757529Ab2ENTSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 15:18:06 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40248 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756466Ab2ENTSF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 15:18:05 -0400
Received: (qmail 3104 invoked from network); 14 May 2012 19:18:02 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 14 May 2012 19:18:02 -0000
Content-Disposition: inline
In-Reply-To: <CAHOQ7J_O=8NL0wp0Pu6pfjN_Y6NDJhKZUft9G2FL0vUWL7aEBw@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197801>

Hi,

On Mon, May 14, 2012 at 10:17:53AM -0700, Stefan Zager wrote:
> On Mon, May 14, 2012 at 9:52 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> 
> > Yes we should eliminate surprises thats true. On the other hand there is
> > no way to setup submodules in the way Stefan had them by using the git
> > submodule command or is there? So for his use case the command sequence
> > you described seems to be more appropriate but I am not sure whether
> > that justifies a separate option for it.
> >
> >> (3) is too heavy when I really only wanted (2).
> >>
> >> I do not understand that use case that led Stefan to the predicament
> >> he was in where he had submodules with HEADs but with no checked out
> >> files. ?But I do not begrudge his being there.
> >
> > Yes, but currently -f is wrong in the way that when the submodules HEAD
> > sha1 is the same as registered in the superproject it will skip the
> > checkout. That is wrong when you have local uncommitted changes in the
> > worktree. In such a state I would expect it to throw away those local
> > changes and checkout HEAD. So I think Stefans patch makes sense anyway
> > even though it might actually be to heavy for his use case.
> 
> To satisfy your curiosity, although it probably won't help me make my
> case: I'm working on very large project with a lot of commit history.
> Cloning this repository is prohibitively slow, so I'm trying to speed
> it up by periodically creating a snapshot of the repository (and all
> submodule repositories) that can be downloaded and cloned locally.
> 
> I first tried using `git bundle`, but cloning from the bundle files
> was still very slow, because it took a long time to replay all the
> commit history to recreate the index.  So, I hit upon another
> solution: run `git clone -n` on the top-level repository and all
> submodule repositories, and create a zip file of the empty checkout.
> The resulting zip file is the same size as the git bundle file, but
> unpacking it on the client (basically, `unzip` followed by `git
> checkout HEAD`) is much faster.

For this use case running

	git submodule update -f

is just fine. The only objection I had was against a new option. So I am
all for making -f skip this sha1 comparing optimization like your patch
did.

On a side note: I am surprised that cloning through git is really that
much slower than copying a zip from the network. Do you run git gc
regularly enough on the server?

Cheers Heiko
