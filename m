From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: avoid 'git reset' when possible
Date: Tue, 3 Mar 2009 10:24:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903031008580.6399@intel-tinevez-2-302>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com> <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302> <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com> <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
 <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302> <7vvdqt8wob.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903012242180.10279@pacific.mpi-cbg.de> <7v1vtfl8xi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 10:25:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQsk-0006l9-8S
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbZCCJYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 04:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbZCCJYS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 04:24:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:51817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751234AbZCCJYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 04:24:16 -0500
Received: (qmail invoked by alias); 03 Mar 2009 09:24:13 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 03 Mar 2009 10:24:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oiIwCAMKo/JWic8mPr8uFX+P9Uhmxk2l/FbS5k0
	JZiLDgvfv50Fgu
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v1vtfl8xi.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112042>

Hi,

On Mon, 2 Mar 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Or even
> >
> > 	current=$ONTO
> > 	fd=3
> > 	while read command sha1 rest
> > 	do
> > 		case "$fd,$command,$current" in
> > 		3,pick,"$sha1"*|t,p,"$sha1"*)
> > 			current=$sha1
> > 			;;
> > 		*)
> > 			fd=1
> > 			;;
> > 		esac
> > 		echo "$command $sha1 $rest" >&$fd
> > 	done < "$TODO" > "$TODO.new" 3>> "$DONE" &&
> > 	mv "$TODO.new" "$TODO"
> >
> > Hmm?
> 
> Certainly.
> 
> Even though "3 means we haven't found a non-pick yet" feels slightly
> hacky, the logic is contained in this small loop and I do not see it as a
> problem.

I'll add a one line comment.

> As long as you are sure $ONTO and all sha1 can be compared without 
> running them through rev-parse, avoiding rev-parse per iteration is a 
> very attractive optimization.

Yes, that is the beauty of abbreviated commit names: they are guaranteed 
to be unique, unless other objects were added since, which is not the case 
at this point.

Ciao,
Dscho
