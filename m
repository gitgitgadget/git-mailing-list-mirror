From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Thu, 18 Sep 2008 17:47:57 +0200
Message-ID: <20080918154757.GA19868@diana.vm.bytemark.co.uk>
References: <20080914085118.GC30664@diana.vm.bytemark.co.uk> <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com> <20080915075740.GB14452@diana.vm.bytemark.co.uk> <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com> <20080916074024.GA2454@diana.vm.bytemark.co.uk> <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com> <20080916193647.GA12513@diana.vm.bytemark.co.uk> <b0943d9e0809170909j4fce34acr8f0b844d0cb5281d@mail.gmail.com> <20080918072450.GB12550@diana.vm.bytemark.co.uk> <b0943d9e0809180431x30c8f751g374732ee861ffe61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 17:27:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgLPR-0007id-Lx
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 17:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbYIRPZ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 11:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754128AbYIRPZ7
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 11:25:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2321 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbYIRPZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 11:25:58 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KgLjZ-0005CA-00; Thu, 18 Sep 2008 16:47:57 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0809180431x30c8f751g374732ee861ffe61@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96202>

On 2008-09-18 12:31:35 +0100, Catalin Marinas wrote:

> 2008/9/18 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Ah, OK. Then I think you want something like this:
> >
> >  try:
> >      trans.reorder_patches(applied, unapplied, hidden, iw)
> >  except transaction.TransactionHalted:
> >      if not options.conflict:
> >          trans.abort(iw)
> >          raise common.CmdException(
> >              'Operation rolled back -- would result in conflicts')
> >  return trans.run(iw)
>
> I tried this before but trans.abort(iw) seems to check out the iw
> index which is the one immediately after the push conflict, though
> the stack is unmodified, i.e. stg status shows some missing files
> (which are added by subsequent patches after the conflicting one)
> and a conflict.

Hmm, strange. That's not what I thought it was supposed to do. Look at
how coalesce uses it, for example.

> Or simply give up on the --conflict option and always stop after the
> conflict (catch the exception and don't re-raise it). This way we
> don't have to bother with checking out the initial state. With the
> "undo" command in your branch, people could simply revert the stack
> to the state prior to the sink command. Maybe that's a good idea so
> that we don't complicate commands further with different conflict
> behaviours.

Yes, this is what every other command does, so it makes sense
consistency-wise.

But I liked the idea of your "roll-back-in-case-of-conflicts" flag; it
would be nice to have in many commands.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
