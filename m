From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: [PATCH 00/18] Signed push
Date: Mon, 25 Aug 2014 14:38:46 -0400
Organization: PD Inc
Message-ID: <7CB248C93DCA465FB383B6A248C81595@black>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com><53F7A119.7070704@gmail.com><xmqqiolknvfz.fsf@gitster.dls.corp.google.com><53F7A68D.2000109@gmail.com><xmqqegw8nu1g.fsf@gitster.dls.corp.google.com><53F7AA48.3000601@gmail.com><xmqqa96wnoj1.fsf@gitster.dls.corp.google.com><53F7C971.7080100@gmail.com> <xmqqha10mp3z.fsf@gitster.dls.corp.google.com>
Reply-To: "Junio C Hamano" <gitster@pobox.com>,
	  "Stefan Beller" <stefanbeller@gmail.com>, <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Stefan Beller'" <stefanbeller@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:39:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLzAd-0000nD-Pj
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 20:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464AbaHYSjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 14:39:05 -0400
Received: from mail.pdinc.us ([67.90.184.27]:55293 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646AbaHYSiu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2014 14:38:50 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s7PIcj3u012430;
	Mon, 25 Aug 2014 14:38:46 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <xmqqha10mp3z.fsf@gitster.dls.corp.google.com>
Thread-Index: Ac/AjxRFp3/23jQgR8uBWMWH9Vx9HwAA54nw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255850>

> -----Original Message-----
> From: Junio C Hamano
> Sent: Monday, August 25, 2014 13:55
> 
> Stefan Beller <stefanbeller@gmail.com> writes:
> 
> >> "burden" is not an issue, as I'll be signing the push certificate
> >> anyway when I push.  A signed tag or a signed commit and 
> signed push
> >> certificate solves two completely separate and orthogonal issues.
> >> 
> >> What happens if you break into GitHub or k.org and did
> >> 
> >>     $ git tag maint_2014_08_22 master_2014_08_22
> >
> > Ok, I personally haven't used tags a lot.
> > I just tried to
> > 	git tag -s testbreaktag v2.1.0
> > 	git show testbreaktag
> > 	# However it would still read:
> > tag v2.1.0
> > Tagger: Junio C Hamano <gitster@pobox.com>
> > Date:   Fri Aug 15 15:09:28 2014 -0700
> >
> > So as I do not posess your private key I could not create 
> signed tags
> > even if I were to break into github/k.org
> 
> The point was that after I push to 'maint', you break into the site
> and copy or move that tag as if I pushed to 'master'.

What is needed is not a signed push per se, but rather a need for a set of signed HEADS ...

> 
> You could argue that I could create a signed tag 'maint-2014-08-25',
> push it, and if you moved it to tags/master-2014-08-25 as an
> attacker, the refname would not match the "tag " line in the signed
> tag object.  While that is true, nobody other thaan fsck checks the
> contents on the "tag " line in practice.
> 
> But more importantly.
> 
> I may deem a commit a sensible version for the 'master' branch of
> one repository but it would not be sensible for another repository's
> 'master' branch.  Imagine a world just like the kernel development
> during 2.6 era used to be, where there was a separate tree 2.4
> maintained with its own 'master' branch.  What is appropriate for
> the tip of 'master' to one repository is not good for the other one,

... and these signed HEADS need to be tied to a particular repository instance. AFAIK git does not have any unique identifier per repository instance to leverage. If you were to make a repository instance id you could take that and the branch name as input to a signed hash for verification later. But this leads to deeper issues about new workflow, new configuration storage mechanisms, etc.

> and your timestamped "tag " line may say for which branch the push
> was for but does not say for which repository.  The exact problem is
> also shared with the desire to have a "branch" object expressed
> elsewhere; as there is no identity for a "branch" in a distributed
> world, trying to name "branch" as if it is a global entity without
> mentioning what repository will lead to tears.
> 
> Besides, these tags/maint-2014-08-25 tags will be interesting only
> for those who are auditing and not for general public, and we do not
> have a good way to "hide" uninteresting refs until those with narrow
> niche interest ask yet, which is something we may want to add soon,
> but I do not want "auditable push" taken hostage to that unrelated
> feature.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
