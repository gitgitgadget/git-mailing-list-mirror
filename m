From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Mon, 14 Jul 2008 08:32:56 +0200
Message-ID: <20080714063256.GC20751@diana.vm.bytemark.co.uk>
References: <20080617153247.GA12520@diana.vm.bytemark.co.uk> <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com> <20080618143633.GB30540@diana.vm.bytemark.co.uk> <b0943d9e0806180916m4af3970ck347408661e95663@mail.gmail.com> <20080618173246.GA1155@diana.vm.bytemark.co.uk> <b0943d9e0806190224v1b6434fesd3a54443422edaeb@mail.gmail.com> <20080619100722.GB14415@diana.vm.bytemark.co.uk> <b0943d9e0806200214j77aef272sc5cfb98b002cae22@mail.gmail.com> <20080623123631.GA18347@diana.vm.bytemark.co.uk> <b0943d9e0807120309jb01aa09se5749a19bc526240@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:34:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIHdM-00021C-2O
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 08:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbYGNGdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 02:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYGNGdF
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 02:33:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4046 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbYGNGdE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 02:33:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KIHcG-0005hT-00; Mon, 14 Jul 2008 07:32:56 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807120309jb01aa09se5749a19bc526240@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88382>

On 2008-07-12 11:09:18 +0100, Catalin Marinas wrote:

> 2008/6/23 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Two optimizations would hopefully make it fast:
> >
> >  1. If the patch's sha1 hasn't changed, we don't have to
> >     regenerate the diff.
> >
> >  2. If the patch's sha1 has changed, but git apply was sufficient
> >     during the merge stage, we can just reuse that patch. We do
> >     have to write it to a blob, but we have already generated the
> >     diff and don't need to do so again. (I've shamelessly stolen
> >     your idea here.)
>
> It can be optimised a bit more to actually apply the diff in the
> blob directly rather than the current way of generating the diff
> (since we don't store the diff).

Ah. Yes, that might be faster. While git is supposedly very fast in
diffing two trees, it should be even faster in just reading a blob.

> > In most cases, (1) would make sure that only a small handful of
> > patches would need to be considered. In the cases where a lot of
> > patches are touched, such as rebase, (2) would provide a good
> > speedup (except for the cases where we had to call
> > merge-recursive, and those are slow anyway).
>
> I think it should work. Rebase is indeed my worry but it might be
> even faster for most of the patches to apply the blob than computing
> the diff. In my experience with the Linux kernel, full merge is
> rarely needed.

Yes. Now all we need is a good benchmarking system so that we know
we're heading in the right direction. I need to fix up and post that
script I used.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
