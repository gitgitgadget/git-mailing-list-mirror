From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Sat, 1 Dec 2007 14:58:30 +0100
Message-ID: <71367167-E94C-4229-9A29-3B6C2DDC75DC@wincent.com>
References: <7vmysx2ac8.fsf@gitster.siamese.dyndns.org> <1196337638-45972-1-git-send-email-win@wincent.com> <7vy7cf87jz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, dzwell@gmail.com, peff@peff.net,
	Matthieu.Moy@imag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 15:02:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IySvg-0003eo-4w
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 15:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbXLAOC3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Dec 2007 09:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbXLAOC3
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 09:02:29 -0500
Received: from wincent.com ([72.3.236.74]:55141 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbXLAOC1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2007 09:02:27 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB1DwUhX029572;
	Sat, 1 Dec 2007 07:58:32 -0600
In-Reply-To: <7vy7cf87jz.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66717>


El 1/12/2007, a las 3:36, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> A "hidden" feature is that any string can be entered, and an anchore=
d
>> regex search is used to find the first matching option.
>
> I'd run s/the first/the uniquely/ here.
>
> When list_and_choose() function is letting you choose more than one
> items, its prompt becomes ">> ", instead of "> " that is used for a
> singleton choice.  To that prompt, you can say "3-7" (Add these 5 =20
> items
> to the choice), "*" (I want all of them), "-2-4" (exclude 2 and 3 =20
> and 4
> from the set I have chosen so far).  These are also "hidden", and nee=
d
> to be documented, but that would be a separate patch.

Agreed that it belongs in a separate patch.

But I'm glad you brought this up as it reminds me of the need to watch =
=20
out for those characters which have special meaning for =20
list_and_choose().

> I'd rewrite the last line to:
>
> 	return (defined $prefix) ? "[$prefix]$remainder" : $remainder;
>
> just in case the unique prefix is "0".  Otherwise you would lose the
> first letter from "00ReadMe" and show remainder "0ReadMe" alone.

Excellent catch. Crazy old perl; I didn't realize that "0" (the =20
string, not the number) would evaluate to false.

Will send a separate mail with a revised, squashed patch with these =20
changes:

- "s/the first/the uniquely/" in the commit message as you suggest

- filter out prefixes which contain characters with special meaning =20
for list_and_choose()

- check "defined $prefix" rather than just "$prefix"

- also fixes a problem discovered while playing with this; it didn't =20
play nicely with untracked files

Cheers,
Wincent
