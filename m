From: John Keeping <john@keeping.me.uk>
Subject: Re: difftool -d symlinks, under what conditions
Date: Wed, 13 Mar 2013 17:08:21 +0000
Message-ID: <20130313170821.GK2317@serenity.lan>
References: <20130312194306.GE2317@serenity.lan>
 <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org>
 <3222724986386016520@unknownmsgid>
 <20130313001758.GH2317@serenity.lan>
 <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com>
 <7vtxof48sg.fsf@alter.siamese.dyndns.org>
 <7v1ubj45ac.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 18:09:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFpAh-00060D-11
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 18:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881Ab3CMRIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 13:08:32 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:45061 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab3CMRIc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 13:08:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 67D6C6064E2;
	Wed, 13 Mar 2013 17:08:31 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s3sBt36X+E9u; Wed, 13 Mar 2013 17:08:31 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id D0DFC6064E4;
	Wed, 13 Mar 2013 17:08:23 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v1ubj45ac.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218071>

On Wed, Mar 13, 2013 at 09:45:47AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > David Aguilar <davvid@gmail.com> writes:
> >
> >>> The implementation of Junio's suggestion is relatively straightforward
> >>> (this is untested, although t7800 passes, and can probably be improved
> >>> by someone better versed in Perl).  Does this work for your original
> >>> scenario?
> >>
> >> This is a nice straightforward approach.
> >>
> >> As Junio mentioned, a good next step would be this patch in
> >> combination with making the truly temporary files created by
> >> dir-diff readonly.
> >
> > Even though I agree that the idea Matt McClure mentioned to run a
> > three-way merge to take the modification back when the path checked
> > out to the temporary tree as a temporary file (because it does not
> > match the working tree version) gets edited by the user might be a
> > better longer-term direction to go, marking the temporaries that the
> > users should not modify clearly as such needs to be done in the
> > shorter term.  This thread wouldn't have had to happen if we had
> > such a safety measure in the first place.
> 
> One thing I forgot to add.  I suspect the patch in the thread will
> not work if the path needs smudge filter and end-of-line conversion,
> as it seems to just hash-object what is in the working tree (which
> should be _after_ these transformations) and compare with the object
> name.  The comparison should go the other way around.  Try to check
> out the object with these transformations applied, and compare the
> resulting file with what is in the working tree.

git-hash-object(1) implies that it will apply the clean filter and EOL
conversion when it's given a path to a file in the working tree (as it
is here).  Is that not the case?


John
