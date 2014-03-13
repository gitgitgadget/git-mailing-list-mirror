From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Thu, 13 Mar 2014 10:46:01 -0700
Message-ID: <xmqq8usej8km.fsf@gitster.dls.corp.google.com>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
	<20140312175624.GA7982@sigill.intra.peff.net>
	<xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
	<20140312194943.GA2912@sigill.intra.peff.net>
	<xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
	<20140312211415.GA10305@sigill.intra.peff.net>
	<20140312220640.GA14802@sigill.intra.peff.net>
	<xmqqd2hrjb4d.fsf@gitster.dls.corp.google.com>
	<CALs4jVHTBH3wTAQsv8+jb15Do1_oy0pcThsDL8ssE7fgrx5NxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 18:46:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO9hx-0005r9-BR
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 18:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbaCMRqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 13:46:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122AbaCMRqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 13:46:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF9257315E;
	Thu, 13 Mar 2014 13:46:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5SfvJos2riH36FP24d5w0TKeObk=; b=jUOpFf
	kWPF1swSfF1zNFt/AR0MqeXtne1HeURARnVx/BKSU6Ua0emBGrrQ7QcOHpwEg3F4
	KoCFM13jh7lbnQev0jSmVjuWNbtyO2knuqXFQqNv0qDPlcVkpmr8QzeQH5on5TkA
	W462dy5RhjRfMWHAEi2b9FLakoBrDSln4U1L4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PEWlasDn9LXCgWbizvEfEclCoO/MNNML
	V6ZvOx1+1Ed/49Ko1DwaZWWMoOag7wbObhvnvJqxySWpNPUab2TKpo5vD3t7OOxP
	rgFxrxllNYvzOUIsGQXoFT0w3/8+gs7RoEQEkJbsB1VrmTV64u1str3gUS7kW3Xe
	OOSRjKTUIjc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2B797315D;
	Thu, 13 Mar 2014 13:46:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3173E73151;
	Thu, 13 Mar 2014 13:46:08 -0400 (EDT)
In-Reply-To: <CALs4jVHTBH3wTAQsv8+jb15Do1_oy0pcThsDL8ssE7fgrx5NxA@mail.gmail.com>
	(Quint Guvernator's message of "Wed, 12 Mar 2014 23:33:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5B90E850-AAD7-11E3-A908-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244038>

Quint Guvernator <quintus.public@gmail.com> writes:

>> The result after the conversion, however, still have the same magic
>> numbers, but one less of them each.  Doesn't it make it harder to
>> later spot the patterns to come up with a better abstraction that
>> does not rely on the magic number?
>
> It is _not_ my goal to make the code harder to maintain down the road.

Good.

> So, at this point, which hunks (if any) are worth patching?

Will, I am not going through all the mechanical hits to memcmp() and
judge each and every one if it is a good idea to convert.  Anybody
who does so in order to tell you "which hunks are worth patching"
would end up being the one doing the real work, and at that point
there is nothing left to be credited as your work anymore ;-)

But as Peff said, there are good bits, like these ones just for a
few examples.

diff --git a/builtin/apply.c b/builtin/apply.c
index a7e72d5..16c20af 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1631,7 +1631,7 @@ static int parse_fragment(const char *line, unsigned long size,
 		 * l10n of "\ No newline..." is at least that long.
 		 */
 		case '\\':
-			if (len < 12 || memcmp(line, "\\ ", 2))
+			if (len < 12 || !starts_with(line, "\\ "))
 				return -1;
 			break;
 		}
@@ -1646,7 +1646,7 @@ static int parse_fragment(const char *line, unsigned long size,
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
 	 */
-	if (12 < size && !memcmp(line, "\\ ", 2))
+	if (12 < size && starts_with(line, "\\ "))
 		offset += linelen(line, size);
 
 	patch->lines_added += added;

These two are about "An incomplete line marker begins with a
backslash and a SP" and there is no other significance in the
constant 2 (like, "after we recognise the match, we start scanning
the remainder of the line starting at the offset 2").

It is a tangent but I notice that these two parts (both in the
original and in the version after patch) contradict what the
incomplete last line marker should look like in a minor detail.

On the other hand, I think this one from nearby is iffy.

@@ -846,8 +846,8 @@ static int has_epoch_timestamp(const char *nameline)
 	 * YYYY-MM-DD hh:mm:ss must be from either 1969-12-31
 	 * (west of GMT) or 1970-01-01 (east of GMT)
 	 */
-	if ((zoneoffset < 0 && memcmp(timestamp, "1969-12-31", 10)) ||
-	    (0 <= zoneoffset && memcmp(timestamp, "1970-01-01", 10)))
+	if ((zoneoffset < 0 && !starts_with(timestamp, "1969-12-31")) ||
+	    (0 <= zoneoffset && !starts_with(timestamp, "1970-01-01")))
 		return 0;
 
 	hourminute = (strtol(timestamp + 11, NULL, 10) * 60 +

If one looks at the post-context of the hunk, one would realize that
this codepath very intimately knows how the timestamp should look
like at the byte-offset level, not just "YYYY-MM-DD ought to be
10-byte long", but "there should be two-digit hour part after
skipping one byte after that YYYY-MM-DD part, followed by two-digit
minute part after further skipping one byte", knowing that these
details are guaranteed by the stamp_regexp[] pattern it earlier made
sure the given string would match.

I do not think it is a good idea to reduce this kind of precise
format knowledge from this function in the first place (after all,
this is parsing a header line in a traditional diff whose format is
known to us), and even if it were our eventual goal to reduce the
precise format knowledge, it would not help very much to get rid of
constant 10 only from these two memcmp() calls, and that is why I
think this hunk is iffy.

Hope the above shows what kind of thinking is needed to judge each
change from memcmp() to !starts_with().

Thanks.
