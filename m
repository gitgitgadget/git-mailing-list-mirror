From: Charles Bailey <charles@hashpling.org>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 19:28:58 +0000
Message-ID: <20080223192858.GA10655@hashpling.org>
References: <998d0e4a0802221823h3ba53097gf64fcc2ea826302b@mail.gmail.com> <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com> <20080223113952.GA4936@hashpling.org> <998d0e4a0802230508w12f236baiaf2d9ab5f364670a@mail.gmail.com> <20080223131749.GA5811@hashpling.org> <998d0e4a0802230536w74e93ec3s40c77d52b183a419@mail.gmail.com> <20080223140153.GB5811@hashpling.org> <998d0e4a0802230910o1cd087f1y6b2398cfde4cfe08@mail.gmail.com> <20080223181631.GA9405@hashpling.org> <998d0e4a0802231047t1338439cj1a1c98f046e6ebaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 20:30:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT04I-0002Qk-B6
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 20:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbYBWT3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 14:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbYBWT3J
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 14:29:09 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:48886 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbYBWT3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 14:29:08 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JT03W-0005xm-CI; Sat, 23 Feb 2008 19:29:06 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1NJSwtw011073;
	Sat, 23 Feb 2008 19:28:58 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1NJSwvP011072;
	Sat, 23 Feb 2008 19:28:58 GMT
Content-Disposition: inline
In-Reply-To: <998d0e4a0802231047t1338439cj1a1c98f046e6ebaf@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: c00c3a03550b3122414a63ae13b9098f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74841>

On Sat, Feb 23, 2008 at 07:47:13PM +0100, J.C. Pizarro wrote:
> On 2008/2/23, Charles Bailey <charles@hashpling.org> wrote:
> > You're confusing two things together here. Conceptually, the git
> >  database is a database of immutable objects. How it is stored is a
> >  lower level implementation detail (albeit a very important one in
> >  practice). The delta chains in the pack files are nothing to do with
> >  git objects.
> 
> In Documentation/git-repack.txt says:
> 
> git-repack is used to combine all objects that do not currently
> reside in a "pack", into a pack. It can also be used to re-organize
> existing packs into a single, more efficient pack.
> 
> A pack is a collection of objects, individually compressed, with
> delta compression applied, stored in a single file, with an
> associated index file.
> 
> ### Can you explain me that delta chains in the pack files are
>  nothing to do with git objects? ###

It's an abstraction thing. Perhaps I should have said that git objects
have nothing to do with pack files to indicate the direction of the
dependency.

> Is not it redundant to place git objects and pack files in the same repo?
> 1. Or erase the unnecesary pack files because there are git objects.
> 2. Or erase some git objects because there are delta chains in pack files
>      that can generate the same git objects erased previously.

Only if they overlap, but usually they don't.

> > What is the weekly user? Why would the 'binary delta' be better than
> >  an incremental pack in this case?
> 
> Because the user wants to clone weekly 240 MiB in 1st week, 220 MiB in
> 2nd week, 205 MiB in 3rd week, .... 100 MiB repo! in Nth week instead of
> 240+1+1+1+1 MiB of incremental packs.
> 
> What is better for the user in the Nth week, 100 MiB repo or 244 MiB repo?
> 

That depends, doesn't it. If the everyday workflow is quicker and
easier a 244 MiB clone could well be acceptable, but if it's not there
is always the option of a repack. I don't buy the premise that people
want to be continually repacking to find the ultimate pack file, I
don't think that the gain over a one-shot repack is ever going to be
worth it.
