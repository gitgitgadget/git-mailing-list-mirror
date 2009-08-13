From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 15:12:13 -0700
Message-ID: <20090813221213.GR1033@spearce.org>
References: <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> <alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302> <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> <20090813172508.GO1033@spearce.org> <fabb9a1e0908131028t438509d2m180293ca95daad74@mail.gmail.com> <20090813174119.GP1033@spearce.org> <fabb9a1e0908131044g583f126dm6a3818b4b295eaf5@mail.gmail.com> <20090813175211.GQ1033@spearce.org> <alpine.DEB.1.00.0908132350190.8306@pacific.mpi-cbg.de> <fabb9a1e0908131501o73807f81mb230530c284ad123@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 00:12:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbiXS-0002mJ-1w
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 00:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395AbZHMWMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 18:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbZHMWMN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 18:12:13 -0400
Received: from george.spearce.org ([209.20.77.23]:55608 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbZHMWMM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 18:12:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5E82F381FD; Thu, 13 Aug 2009 22:12:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0908131501o73807f81mb230530c284ad123@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125886>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Thu, Aug 13, 2009 at 14:51, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > Sorry if I spoil the party, but maybe if things get so complicated, it may
> > be a sign that the original version (stream overrides command line, since
> > it knows better) is to be preferred? ?After all, if hg fast-export says
> > that the marks should be imported from a certain file, it may be for a
> > _very good_ reason...
> 
> Yes, and that should Just Work (which it does). Also, I'm not sure how
> often one would output a stream on one computer, then move it to
> another and import it there, but I'll methinks Shawn brought it up for
> a reason ;). However, I do think it's better design to only store the
> name of the import file and then do the actual import later on (to
> prevent double imports).
> 
> I don't have a preference either way (both patches are already written
> after all). Shawn?

No, I don't have a really good reason for the command line overrides
the file other than this simple rule:

  If the file is likely to be several hundred MiB, or bigger; thou
  shall never try to open it with vi, *especially* vi on a Solaris
  system, as at least one line is likely to be too long.

  If the file header contains paths to other files, it is likely
  one will want to modify that header sometime, because you moved
  the file between systems.

  Given the size of the file above, you can't just fix it with vi.

  Lacking a tool that *can* do this edit safely (and Dscho's simple
  sed wasn't enough, as I already pointed out, oh and Solaris sed
  also fails on long lines), we *should* be able to override this on
  the command line, *especially* since we already have the command
  line option standardized!

What is this, gang up on Shawn's words-of-wisdom week?  Both this
thread and my intern this week have been argueing with me about
what seem to me to be fairly trivial things.  Maybe I just need to
take vacation.  Good thing I have one coming in 5 weeks.

I say use the version where we store the values (e.g. file names)
during option parsing, and then actually apply those saved values
just before the first non-option command.  Which I think only has
an impact on the import-marks option, the rest are all just simple
variable updates whose values aren't read until after the first
non-option command anyway.

-- 
Shawn.
