From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add a command "fix" to rebase --interactive.
Date: Sat, 05 Dec 2009 10:53:02 -0800
Message-ID: <7vaaxxw8vl.fsf@alter.siamese.dyndns.org>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
 <6d779d2c244bf5d5b7924cdc5daf66a8186e4bc7.1259934977.git.mhagger@alum.mit.edu> <7v638mskmx.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0912041943160.21557@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 05 19:53:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGzl4-00040E-Uy
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 19:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbZLESxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 13:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757868AbZLESxH
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 13:53:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757802AbZLESxG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 13:53:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BB6985119;
	Sat,  5 Dec 2009 13:53:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0omBKCgM0u97PXUNd3qOmZdyGJE=; b=WDM9n0
	HzBbpVRQI1/by8zY4gQPLaR6vv16Lboq9e0BjY/0wbjCVQBOvyCIWVbIL4+G/tyH
	lTEXsa4tWhV3/jQN7eOHFCVs8c8Ce2LpVgGyZ6AFTFDBfcUjsdC7F48jNcbe8HlI
	ZByD2ryUG1UchiUz3ZXvqrcpJjH78VEIQ8pBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gmflHFCiscQozk+6F7+NBDRJ6OZz4avC
	WR4dXrmVuDhTA2uwsFNTGt7A+5Ayw3cEPjr3FHcuvx8NEY2xDt7guVy/JqpQTLna
	6jpvcdImBHOXaf/vCcTzWWY0i/5YH8iZt2+GD8/mJWbhLmSNkSx6x+QGTVfCIHof
	ftg1Y8/lyu4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14EC385117;
	Sat,  5 Dec 2009 13:53:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25B1185112; Sat,  5 Dec
 2009 13:53:04 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0912041943160.21557@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Fri\, 4 Dec 2009 19\:44\:31 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E2B891E-E1CF-11DE-AB22-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134612>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 4 Dec 2009, Junio C Hamano wrote:
>
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> > index 0bd3bf7..539413d 100755
>> > --- a/git-rebase--interactive.sh
>> > +++ b/git-rebase--interactive.sh
>> > @@ -302,7 +302,7 @@ nth_string () {
>> >  
>> >  make_squash_message () {
>> >  	if test -f "$SQUASH_MSG"; then
>> > -		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
>> > +		COUNT=$(($(sed -n "s/^# Th[^0-9]*\([1-9][0-9]*\)\(th\|st\|nd\|rd\) commit message.*:/\1/p" \
> ...
> IIRC "|" was not correctly handled by BSD sed (used e.g. in MacOSX).

You are right; we actually have seen and fixed a similar breakage.  For
example, "git log --all-match --grep=BRE --grep=ERE" finds:

    commit 1883a0d3b7ad7c9de1ac790bda6f1a6181237439
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Fri Sep 19 23:52:49 2008 -0700

        diff: use extended regexp to find hunk headers

        Using ERE elements such as "|" (alternation) by backquoting in BRE
        is a GNU extension and should not be done in portable programs.

and "sed" is defined to take BRE.

Tentatively I'd queue this on top of 3/3 for eventual squashing.

Thanks

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 5 Dec 2009 10:42:44 -0800
Subject: [PATCH] [squash to Add a command "fix"] Avoid "\(alternatives\|choices\)" in sed script

---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 539413d..c30209e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -302,7 +302,7 @@ nth_string () {
 
 make_squash_message () {
 	if test -f "$SQUASH_MSG"; then
-		COUNT=$(($(sed -n "s/^# Th[^0-9]*\([1-9][0-9]*\)\(th\|st\|nd\|rd\) commit message.*:/\1/p" \
+		COUNT=$(($(sed -n "s/^# Th[^0-9]*\([1-9][0-9]*\)[tsnr][htd] commit message.*:$/\1/p" \
 			< "$SQUASH_MSG" | sed -ne '$p')+1))
 		echo "# This is a combination of $COUNT commits."
 		sed -e 1d -e '2,/^./{
-- 
1.6.6.rc1.31.g1a56b
