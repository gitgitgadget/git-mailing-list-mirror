From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 4/4] t4200: avoid passing a non-newline terminated file
 to 	sed
Date: Wed, 06 May 2009 21:06:10 -0500
Message-ID: <rfLKcKXRAh_59y1L8wcIkQ16qjwUMJxA85JMjC1VL2Y42LunBol3Kg@cipher.nrlssc.navy.mil>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2QibZp-GnWBSpcJ8fxO9NTUsmXbuv4_2x5S6YNLzUogav4gLkrx9ClI@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2ZsdySdVG_ssYL84wqJwNHZYBqMWRKBIa_Ni6jJRHumlZvrQcXOEMhQ@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2ep5vFgQr-bAuDGJW-OdtSbS6WmpSHl041GRSXpP3OcDP4_PsYKsQDU@cipher.nrlssc.navy.mil> <7vhbzyukyi.fsf@alter.siamese.dyndns.org> <fcaeb9bf0905061849v1dd50d8fk36e6804824a59032@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 04:06:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1t0F-0007OK-Am
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 04:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759513AbZEGCGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 22:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758224AbZEGCGR
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 22:06:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37588 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678AbZEGCGR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 22:06:17 -0400
Received: by mail.nrlssc.navy.mil id n4726BJL005962; Wed, 6 May 2009 21:06:12 -0500
In-Reply-To: <fcaeb9bf0905061849v1dd50d8fk36e6804824a59032@mail.gmail.com>
X-OriginalArrivalTime: 07 May 2009 02:06:11.0429 (UTC) FILETIME=[64A02150:01C9CEB8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118420>

Nguyen Thai Ngoc Duy wrote:
> On Thu, May 7, 2009 at 4:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>>
>>> Some versions of sed exit non-zero if the file they are supplied is not
>>> newline terminated.  Solaris's /usr/xpg4/bin/sed is one such sed.  So
>>> rework this test to avoid doing so.
>> I think up to your 3/4 is reasonable, but this is not enough for POSIX
>> conformance (it is Ok if it is just aiming to fix "Solaris quirk").  POSIX
>> sed is only required to work on text files, but .git/MERGE_RR is not a
>> text file (it is a sequence of NUL terminated records).
>>
>> I think something like this may work better.  Can somebody test?
>>
>>> -     sha1=$(sed -e "s/       .*//" .git/MERGE_RR) &&
>>> +     sha1=$({ cat .git/MERGE_RR; echo; } | sed -e "s/        .*//") &&
>>        sha1=$(tr "\\000" "\\012" <./git/MERGE_RR | sed -e "s/  .*//") &&
>>
> 
> I would replace it again, according to e85fe4d8.

The line referenced above will actually be deleted unless someone chimes
in and says it is needed.

The commit you referenced was taken into account in the patch for the other
use of sed on .git/MERGE_RR in the same test script:
"[PATCH 2/2] t4200: convert sed expression which operates on non-text-file to perl"

-brandon
