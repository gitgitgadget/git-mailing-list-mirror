From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v6] add --summary option to git-push and git-fetch
Date: Sat, 30 Jan 2010 09:51:30 +0200
Message-ID: <20100130075129.GA27702@Knoppix>
References: <20100130020548.GA29343@cthulhu>
 <7vsk9oysds.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 08:52:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb88V-0007FG-H7
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 08:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab0A3Hvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 02:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110Ab0A3Hvj
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 02:51:39 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:33052 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab0A3Hvi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 02:51:38 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 6441C18D42E;
	Sat, 30 Jan 2010 09:51:37 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A054386140A; Sat, 30 Jan 2010 09:51:37 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id C5CD527D89;
	Sat, 30 Jan 2010 09:51:30 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vsk9oysds.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138460>

On Fri, Jan 29, 2010 at 11:16:31PM -0800, Junio C Hamano wrote:
 
> As I said in my review during the earlier rounds, I do not know if it is
> safe to use the flags and do the traversal inside this same process.  You
> may be clearing the flags to protect your traversal (one per branch) from
> stepping on each other, but how would this affect the use of object flags
> in existing parts of the "push" machinery?  Is the reasoning that even if
> push calls into traversal code and after it walked the commit ancestry for
> its own purpose, your addition will clear the flags and existing code will
> never look at object flags again, so this new code is free to use them and
> all is Ok?  As long as you made sure that nobody looks at object flags you
> modified, then I am fine with that---I just don't know if that is what is
> happening here, and that is why I am asking.
> 
> I'd need help from the usual "transport" suspects for this patch.

Well, I can say smart transports implemented by remote helpers are similar
to ssh://&co (no surprise, they connect differently, but use the same underlying
client code). Furthermore, actual remote helper stub code doesn't seem to play
with revisions.

And the actual remote helper parts seem to use clean memory image anyway
(they exec).

So that leaves the following:
- git:// "layer 7" (git://, ssh://, file:// & co.[*])
- rsync:// (third-class anyway)

Also, what about multiple-URL case? Don't know if there are problems, but it
seems to be quite rarely tested...

[*] OTOH, this is extremely heavily used code, so breakages here will usually
be pretty visible.

-Ilari
