From: Pedro Melo <melo@simplicidade.org>
Subject: Re: On pathnames
Date: Fri, 25 Jan 2008 08:08:08 +0000
Message-ID: <D1D9821C-0CB8-40AB-8640-D171E812E428@simplicidade.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu> <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org> <7vprvr7x8h.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801241722130.22568@xanadu.home> <7vy7ae7dcb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 09:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIJdv-00032C-Gk
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 09:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764660AbYAYIIP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 03:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764741AbYAYIIP
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 03:08:15 -0500
Received: from mail.sl.pt ([212.55.140.13]:48538 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1764736AbYAYIIM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 03:08:12 -0500
Received: (qmail 30659 invoked from network); 25 Jan 2008 08:08:09 -0000
Received: from unknown (HELO [192.168.1.209]) (melo@[81.193.201.116])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <nico@cam.org>; 25 Jan 2008 08:08:09 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 81.193.201.116 as permitted sender)
In-Reply-To: <7vy7ae7dcb.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71686>

Hi,

On Jan 25, 2008, at 4:12 AM, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
>
>> On Thu, 24 Jan 2008, Junio C Hamano wrote:
>>
>>> If it is a new file, we won't find any name that is equivalent
>>> to $A in the index, and we use the name $A obtained from
>>> readdir(3).
>>>
>>> BUT with a twist.
>>>
>>> If the filesystem is known to be inconveniently case folding, we
>>> are better off registering $B instead of $A (assuming we can
>>> convert from $A to $B).
>>
>> Why?
>>
>> If you have no other representation for the file name than $A =20
>> already,
>> then I don't see why Git would have to play similar evil games and
>> corru^H^H^Hnvert $A into $B.  Just store $A in the index and tree
>> objects and be done with it.
>
> Because this "conversion" is limited to the case where the
> filesystem is known to be inconveniently case folding, I
> personally do not care about this part of the outline that
> deeply.  It would not bite _me_ or my friends either way.
>
> But I would imagine that a person who has to work on HFS+ would
> appreciate it if these two sequences behaved the same way:
>
>     $ edit M=E4rchen ;# assume this is a new file
>     $ git add M=E4rchen ;# we were told that IM gives $B (aka NFC)
>
> vs
>
>     $ edit M=E4rchen ;# assume this is a new file
>     $ git add M*en ;# now readdir(3) gives $A (aka NFD)
>
> If we always convert $A (less interoperable form) to $B (more
> interoperable form) on inconveniently case folding filesystems,
> the new index entry will always be in form $B.  Without the
> conversion, the former will give form $B while the latter will
> give form $A.  It is, as you said, "similar evil game to
> corrupt", but it is not even a corruption at that point, because
> the inconveniently case folding filesystem already corrupted the
> pathname before we get our hands on it, and it won't make a
> difference for HFS+ only people anyway.
>
> However, if the resulting tree that adds a new file is prepared
> on an inconveniently case folding filesystem, the conversion
> process, by definition, would make the resulting tree more
> interoperable with other systems than without.

As a HFS+ user, I would welcome this very very much.

I want my tree to be seen by the rest of the world without problems, =20
and I don't think I should impose my filesystem view of proper naming =20
on others.

Junio, amazing write-up, many thanks.

Best regards,
--=20
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
