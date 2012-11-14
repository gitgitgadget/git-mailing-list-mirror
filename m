From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH nd/wildmatch] Correct Git's version of isprint and isspace
Date: Wed, 14 Nov 2012 20:30:36 +0100
Message-ID: <50A3F15C.7000200@lsrfire.ath.cx>
References: <507E9FDE.7080706@cs.tu-berlin.de> <1352803572-14547-1-git-send-email-pclouds@gmail.com> <50A29C3A.1070000@lsrfire.ath.cx> <CA+55aFwsjpOop=4mVkx4e=zw5LH41sD9x-b_WMo4Hvo7ygjEtQ@mail.gmail.com> <CA+55aFynRG-CbSp-aLoo1iZTvfBWMgt6kwrPiQjSZJ0ZzraDKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, schnhrr@cs.tu-berlin.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:31:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYifq-0005KD-2N
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 20:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423213Ab2KNTao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2012 14:30:44 -0500
Received: from india601.server4you.de ([85.25.151.105]:43829 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161019Ab2KNTan (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 14:30:43 -0500
Received: from [192.168.2.105] (p4FFDB891.dip.t-dialin.net [79.253.184.145])
	by india601.server4you.de (Postfix) with ESMTPSA id 6FC33130;
	Wed, 14 Nov 2012 20:30:41 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <CA+55aFynRG-CbSp-aLoo1iZTvfBWMgt6kwrPiQjSZJ0ZzraDKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209743>

Am 13.11.2012 20:50, schrieb Linus Torvalds:
> On Tue, Nov 13, 2012 at 11:40 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I have to wonder why you care? As far as I'm concerned, the only val=
id
>> space is space, TAB and CR/LF.
>>
>> Anything else is *noise*, not space. What's the reason for even cari=
ng?
>
> Btw, expanding the whitespace selection may actually be very
> counter-productive. It is used primarily for things like removing
> extraneous space at the end of lines etc, and for that, the current
> selection of SPACE, TAB and LF/CR is the right thing to do.
>
> Adding things like FF etc - that are *technically* whitespace, but
> aren't the normal kind of silent whitespace - is potentially going to
> change things too much. People might *want* a form-feed in their
> messages, for all we know.

The patch was motivated by the integration of the wildmatch library,=20
which exposes named character classes to users.  It replaces a call of=20
fnmatch in match_pathname.  Users probably expect [:space:] to mean the=
=20
same in git as in other programs.

I never saw a vertical tab and I can't imagine what it's used for.  I'd=
=20
expect form-feeds to be matched as space, though.  Didn't see them very=
=20
often, admittedly.

Nevertheless, it's unfortunate that we have an isspace() that *almost*=20
does what the widely known thing of the same name does.  I'd shy away=20
from changing git's version directly, because it's used more than a=20
hundred times in the code, and estimating the impact of adding \v and \=
f=20
to it.  Perhaps renaming it to isgitspace() is a good first step,=20
followed by adding a "standard" version of isspace() for wildmatch?

Ren=C3=A9
