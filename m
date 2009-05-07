From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t4200: avoid passing a non-newline terminated file to 	sed
Date: Wed, 06 May 2009 19:29:36 -0700
Message-ID: <7v4ovxtzlb.fsf@alter.siamese.dyndns.org>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil>
	<IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil>
	<IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil>
	<IHOAO7NDkb8K9nkprnkd2QibZp-GnWBSpcJ8fxO9NTUsmXbuv4_2x5S6YNLzUogav4gLkrx9ClI@cipher.nrlssc.navy.mil>
	<IHOAO7NDkb8K9nkprnkd2ZsdySdVG_ssYL84wqJwNHZYBqMWRKBIa_Ni6jJRHumlZvrQcXOEMhQ@cipher.nrlssc.navy.mil>
	<IHOAO7NDkb8K9nkprnkd2ep5vFgQr-bAuDGJW-OdtSbS6WmpSHl041GRSXpP3OcDP4_PsYKsQDU@cipher.nrlssc.navy.mil>
	<7vhbzyukyi.fsf@alter.siamese.dyndns.org>
	<fcaeb9bf0905061849v1dd50d8fk36e6804824a59032@mail.gmail.com>
	<rfLKcKXRAh_59y1L8wcIkQ16qjwUMJxA85JMjC1VL2Y42LunBol3Kg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 07 04:29:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1tMw-00052A-Bg
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 04:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbZEGC3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 22:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbZEGC3h
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 22:29:37 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64522 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbZEGC3g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 22:29:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090507022936.WWEE17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 May 2009 22:29:36 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id oSVc1b00H4aMwMQ04SVcmb; Wed, 06 May 2009 22:29:37 -0400
X-Authority-Analysis: v=1.0 c=1 a=1ZMnSAeqFEcA:10 a=KrguOZ7mv_8A:10
 a=ybZZDoGAAAAA:8 a=lCs-tVcRjJD0pOiz-mwA:9 a=uDTv9RvEEz2yOcef8BEA:7
 a=AGhdh4k-sJW0w9vfJg-MGcFnXekA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <rfLKcKXRAh_59y1L8wcIkQ16qjwUMJxA85JMjC1VL2Y42LunBol3Kg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed\, 06 May 2009 21\:06\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118422>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Nguyen Thai Ngoc Duy wrote:
>> On Thu, May 7, 2009 at 4:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>>>
>>>> Some versions of sed exit non-zero if the file they are supplied is not
>>>> newline terminated.  Solaris's /usr/xpg4/bin/sed is one such sed.  So
>>>> rework this test to avoid doing so.
>>> I think up to your 3/4 is reasonable, but this is not enough for POSIX
>>> conformance (it is Ok if it is just aiming to fix "Solaris quirk").  POSIX
>>> sed is only required to work on text files, but .git/MERGE_RR is not a
>>> text file (it is a sequence of NUL terminated records).
>>>
>>> I think something like this may work better.  Can somebody test?
>>>
>>>> -     sha1=$(sed -e "s/       .*//" .git/MERGE_RR) &&
>>>> +     sha1=$({ cat .git/MERGE_RR; echo; } | sed -e "s/        .*//") &&
>>>        sha1=$(tr "\\000" "\\012" <./git/MERGE_RR | sed -e "s/  .*//") &&
>
> The line referenced above will actually be deleted unless someone chimes
> in and says it is needed.

I've already removed it; thanks.
