From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] teach update-index --refresh about --data-unchanged
Date: Sun, 14 Nov 2010 11:58:19 -0500
Message-ID: <20101114165819.GA8714@arf.padd.com>
References: <20101031174430.GA30236@arf.padd.com>
 <20101031195933.GA21240@burratino>
 <20101031222644.GA31257@arf.padd.com>
 <20101031222805.GB31257@arf.padd.com>
 <7vzktqwbob.fsf@alter.siamese.dyndns.org>
 <20101103183621.GA14019@burratino>
 <20101103220243.GA6777@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 17:58:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHfuT-0005X8-Ce
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 17:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249Ab0KNQ61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 11:58:27 -0500
Received: from honk.padd.com ([74.3.171.149]:45803 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755989Ab0KNQ60 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 11:58:26 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 6E87827A;
	Sun, 14 Nov 2010 08:58:24 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 68C3E319F0; Sun, 14 Nov 2010 11:58:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20101103220243.GA6777@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161420>

pw@padd.com wrote on Wed, 03 Nov 2010 18:02 -0400:
> jrnieder@gmail.com wrote on Wed, 03 Nov 2010 13:36 -0500:
> > On Wed, Nov 03, 2010 at 10:37:40AM -0700, Junio C Hamano wrote:
> > > Pete Wyckoff <pw@padd.com> writes:
> > 
> > >> When a repository has been copied with rsync, or cloned using
> > >> a volume manager, the index can be incorrect even though the
> > >> data is unchanged.  This new flag tells update-index --refresh
> > >> that it is not necessary to reread the data contents.
> > >
> > > I know our traditional attitude towards the plumbing commands have been
> > > "give them long enough rope and let users hang themselves", but this
> > > particular rope feels a bit too long for my taste.
> > 
> > Pete, I think you mentioned the possibility of a special-case tool for
> > contrib/ that just updates the inode, device number, and ctime fields?
> > That sounds a little less worrying to use, as plumbing.
> 
> Yes, I'd been discussing with Jonathan offlist that I too agree
> this is a bit bizarre for general use.  Especially when thinking
> about how to explain the new flag in the manpage, and how
> interactions with other command-line options should work.
> 
> I wrote a short C program to use existing functions from cache.h
> to read and write the index, updating the entries by hand.  Once
> I figure out how to build it nicely, I'll submit for contrib/.  I
> haven't figured out how to include the useful bits of the
> top-level Makefile (like SSL setting, which SHA1, -lpthread,
> etc.).

Turns out this was dead simple with dulwich, a python interface
to git internals:  http://samba.org/~jelmer/dulwich .  I got rid
of the C version.

The script uses dulwich to generate a list of index entries,
stats each file and updates the entries, then writes it back
out.  I won't submit it to contrib, since it is so trivial and
because it depends on dulwich.

		-- Pete
