From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Redefine semantics of find_unique_abbrev()
Date: Sun, 02 Mar 2008 00:11:10 -0800
Message-ID: <7vtzjpsfz5.fsf@gitster.siamese.dyndns.org>
References: <7vpruf9q5a.fsf@gitster.siamese.dyndns.org>
 <20080301050641.GB8969@coredump.intra.peff.net>
 <7vd4qdtw7k.fsf@gitster.siamese.dyndns.org>
 <20080302074230.GD3935@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 02 09:12:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVjIo-0007bL-IW
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 09:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbYCBILc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 03:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbYCBILc
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 03:11:32 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbYCBILb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 03:11:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8CDF12173;
	Sun,  2 Mar 2008 03:11:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DD3422172; Sun,  2 Mar 2008 03:11:17 -0500 (EST)
In-Reply-To: <20080302074230.GD3935@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 2 Mar 2008 02:42:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75746>

Jeff King <peff@peff.net> writes:

> On Sat, Mar 01, 2008 at 11:35:11PM -0800, Junio C Hamano wrote:
>
>> That is, "for objects we have, make sure it uniquely identifies,
>> otherwise, make sure the phoney name is long enough such that it would not
>> name any existing object".
>
> I think your logic is correct, and I think naming it 'exists' is more
> readable (I don't have a tendency not to double-negate).
>
> But...
>
>> -		if (!status ||
>> -		    (is_null && status != SHORT_NAME_AMBIGUOUS)) {
>> +		if (exists
>> +		    ? !status
>> +		    : status == SHORT_NAME_NOT_FOUND) {
>>  			hex[len] = 0;
>>  			return hex;
>>  		}
>
> Maybe it is just me, but I find the ternary operator here reduces
> readability. I would have liked the more verbose:
>
>   if ((exists && !status) ||
>       (!exists && status == SHORT_NAME_NOT_FOUND)) {
>
> But now I am just painting your bikeshed.

Heh, the ternary is a mini "if-then-else" by itself.  Turn your head
sideways (just like you do when you meet a smiley) and the parse tree will
jump at you ;-).


