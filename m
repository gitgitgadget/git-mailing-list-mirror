From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Mon, 17 Dec 2007 11:21:03 -0500
Message-ID: <1197908463.8463.9.camel@hinata.boston.redhat.com>
References: <20071213091055.GA5674@coredump.intra.peff.net>
	 <20071213093536.GC12398@artemis.madism.org>
	 <7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
	 <20071213180347.GE1224@artemis.madism.org>
	 <1197570521.28742.0.camel@hinata.boston.redhat.com>
	 <1197571656.28742.13.camel@hinata.boston.redhat.com>
	 <20071214040803.GA10169@sigill.intra.peff.net>
	 <7vir31vmsn.fsf@gitster.siamese.dyndns.org>
	 <20071214083943.GA24475@artemis.madism.org>
	 <7v63z1qakt.fsf@gitster.siamese.dyndns.org>
	 <20071215110311.GA11321@artemis.madism.org>
	 <7vir2xeq76.fsf@gitster.siamese.dyndns.org> <47662715.9070200@op5.se>
	 <7v3au1eopr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 17:25:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Ikt-0000KM-NY
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 17:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934082AbXLQQXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 11:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757567AbXLQQXS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 11:23:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57013 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757236AbXLQQXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 11:23:16 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBHGLAn5027115;
	Mon, 17 Dec 2007 11:21:10 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBHGL9Aa002103;
	Mon, 17 Dec 2007 11:21:09 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBHGL9Cc018981;
	Mon, 17 Dec 2007 11:21:09 -0500
In-Reply-To: <7v3au1eopr.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68575>

On Sun, 2007-12-16 at 23:59 -0800, Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> > Junio C Hamano wrote:
> > 
> >> ...  The
> >> "must stick" restriction feels Ok on paper but in practice it looks
> >> rather draconian and very user unfriendly.
> >
> > Usually, optional arguments warrant adding a second parameter. This can
> > often even improve usability, as it's never unclear or ambiguous what's
> > happening. For the 'git tag -l' case, I'd use something like
> > 'git tag -l --match="regex"' or some such,...
> 
> That is essentially arguing for POSIXly correct "do not allow optional
> option-arguments" (utility syntax guidelines #7).  That position might
> be politically correct, but I am already discussing beyond that:
> usability.
> 
> For "git tag -l", the fix was rather simple, as the option would either
> have taken a zero pattern (list all) or a single pattern (list matching
> this pattern), and the command itself did not take any extra arguments,
> so that was what I did in the patch.  Compare your POSIXly correct
> version:
> 
>         git tag -l			(ok)
>         git tag -l pattern		(not ok)
> 	git tag -l --match=pattern	(ok)
> 
> with the traditional (and fixed):
> 
>         git tag -l			(ok)
>         git tag -l pattern		(ok)
> 	git tag -l pattern garbage	(not ok)
> 
> Which one is easier for the user?

git tag now lists tags by default so there's a couple of other options
to consider:

        git tag				(ok)
        git tag --match pattern		(ok)
	git tag --match=pattern     	(ok)
	git tag --match=pattern -l	(ok)
	git tag -l pattern		(not ok)

Or we could repurpose -l as the match option:

	git tag			(ok)
	git tag -l		(not ok)
	git tag -l pattern	(ok)

And that was the point I was trying to make earlier with my rather
abstract sounding post about jumping through hoops.  If we can't break
the options interface to make git sane, we'll be stuck with a broken
command line interface and must write complicated documents on what option
sticking is and how it works.

cheers,
Kristian
