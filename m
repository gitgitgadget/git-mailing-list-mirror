From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Sat, 24 Jan 2009 14:51:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901241443270.13232@racer>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>  <1232659071-14401-2-git-send-email-hjemli@gmail.com>  <1232659071-14401-3-git-send-email-hjemli@gmail.com>  <1232659071-14401-4-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
  <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>  <alpine.DEB.1.00.0901232054360.21467@intel-tinevez-2-302> <8c5c35580901240044y452b465fj94df82fc2b8f7ee9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 14:53:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQiwZ-00041Z-GO
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 14:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbZAXNv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 08:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbZAXNv0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 08:51:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:34285 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751232AbZAXNvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 08:51:25 -0500
Received: (qmail invoked by alias); 24 Jan 2009 13:51:23 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp071) with SMTP; 24 Jan 2009 14:51:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vM40JtmIvm+JYFFk0/6LS2r/C7wH9R2NK+/qzim
	i0dSoZEAsClfxH
X-X-Sender: gene099@racer
In-Reply-To: <8c5c35580901240044y452b465fj94df82fc2b8f7ee9@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106966>

Hi,

On Sat, 24 Jan 2009, Lars Hjemli wrote:

> On Fri, Jan 23, 2009 at 20:57, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> >  in all of Git, we try to assume that only reachable objects are valid 
> >  objects.
> 
> I don't think this is true (most git commands accepts their arguments
> as valid objects without verifying if they are reachable from a ref).

The fact that a user can ask for some object directly, and that we do not 
try to validate it in that case has nothing to do with said assumption.

If something is pushed to a remote, and the connection fails, some commit 
could be pushed already, but some of its reachable objects lacking.

The user on the remote side can still try to salvage parts by accessing 
the objects directly, by their name.

But the only guarantee that the objects are reachable is to start from a 
ref.

Concretely, if your patch is applied as-is, such a half-pushed state could 
affect git-archive in a nasty way: even if the user started from a ref, 
there could be missing objects!

> Do you feel it is necessary to perform a reachability check of the 
> gitlink'd commit before traversing into a submodule tree?

No.  Because HEAD is a ref, too.

Now, there is still a problem when your submodule is missing the objects 
for the commit your superproject is referring to.

IMO that is a serious issue, as it just asks for confused users.

> > - presence of a specific commit in the supermodule is a _lousy_ 
> >   indicator that the user wants to include that submodule in the 
> >   archive.
> 
> This is the issue I tried to address with my
> `--submodules=[a|c|r][g:<name>]` proposal in the commit message for
> this patch.

Nope, doing this "in the future" does not please me one bit.

Besides, I find the semantics, uhm, "interesting".  (The other word would 
be "unintuitive".  Why do you have to be so cryptic that I have to read 
the proposal to understand what the heck "c" is about?)

Ciao,
Dscho
