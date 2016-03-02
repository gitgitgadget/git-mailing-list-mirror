From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 08:49:06 -0800
Message-ID: <20160302164906.GB13732@x>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <xmqqziuh46hb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org, sarah@thesharps.us, viro@zeniv.linux.org.uk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 17:49:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab9xd-00047R-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 17:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbcCBQtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 11:49:14 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37875 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbcCBQtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 11:49:13 -0500
Received: from mfilter27-d.gandi.net (mfilter27-d.gandi.net [217.70.178.155])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id CC5D6FB8CB;
	Wed,  2 Mar 2016 17:49:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter27-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter27-d.gandi.net (mfilter27-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id p4WQZAO4KG0O; Wed,  2 Mar 2016 17:49:09 +0100 (CET)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DADB6FB8B9;
	Wed,  2 Mar 2016 17:49:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqziuh46hb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288129>

On Wed, Mar 02, 2016 at 12:41:20AM -0800, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> > If you clone a repository, and the connection drops, the next attempt
> > will have to start from scratch.  This can add significant time and
> > expense if you're on a low-bandwidth or metered connection trying to
> > clone something like Linux.
> 
> For this particular issue, your friendly k.org administrator already
> has a solution.  Torvalds/linux.git is made into a bundle weekly
> with
> 
>     $ git bundle create clone.bundle --all
> 
> and the result placed on k.org CDN.  So low-bandwidth cloners can
> grab it over resumable http, clone from the bundle, and then fill
> the most recent part by fetching from k.org already.
> 
> The tooling to allow this kind of "bundle" (and possibly other forms
> of "CDN offload" material) transparently used by "git clone" was the
> proposal by Shawn Pearce mentioned elsewhere in this thread.

That does help in the case of cloning torvalds/linux.git from
kernel.org, and I'd love to see it used transparently.

However, even with that, I still also see value in a resumable git clone
(or git pull) for many other repositories elsewhere, with a somewhat
lower pull-to-push ratio than kernel.org.  Supporting resumption based
on objects, without the repository needing to generate and keep around a
bundle, seems preferable for such repositories.
