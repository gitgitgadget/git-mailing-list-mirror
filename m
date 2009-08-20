From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH next] t7407: use 'cut' utility rather than bash's substring
 expansion notation
Date: Thu, 20 Aug 2009 11:59:57 -0500
Message-ID: <5cqGRKnaah8NEt1Sx1jHwTRuuDfhT5e-wsLOzZOw4Hf1ady-n-TFfg@cipher.nrlssc.navy.mil>
References: <QHfHFS_5JGiL-O8GMDfdfscFUdxV1xVObzr6e5LPleagDRd7bCg8I9YUwL9xkbgM64vyf_EVLLg@cipher.nrlssc.navy.mil> <200908200856.30359.johan@herland.net> <7vskfnq6q5.fsf@alter.siamese.dyndns.org> <200908201124.54193.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 20 19:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeB09-0002N2-Di
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 19:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbZHTRA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 13:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbZHTRA2
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 13:00:28 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49621 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbZHTRA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 13:00:27 -0400
Received: by mail.nrlssc.navy.mil id n7KGxwQj030997; Thu, 20 Aug 2009 11:59:58 -0500
In-Reply-To: <200908201124.54193.johan@herland.net>
X-OriginalArrivalTime: 20 Aug 2009 16:59:57.0878 (UTC) FILETIME=[A5DA9D60:01CA21B7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126648>

Johan Herland wrote:
> On Thursday 20 August 2009, Junio C Hamano wrote:
>> Johan Herland <johan@herland.net> writes:
>>>> - $sub1sha1 sub1 (${sub1sha1:0:7})
>>>> - $sub2sha1 sub2 (${sub1sha1:0:7})
>>>> + $sub1sha1 sub1 ($(echo $sub1sha1 | cut -c 1-7))
>>>> + $sub2sha1 sub2 ($(echo $sub1sha1 | cut -c 1-7))
>>> Typo (both in the original, and the patch), should be:
>>> 	$sub2sha1 sub2 ($(echo $sub2sha1 | cut -c 1-7))
>>>
>>>>   $sub3sha1 sub3 (heads/master)
>>>>  EOF
>>> Otherwise:
>>>
>>> Acked-by: Johan Herland <johan@herland.net>
>> Hmm, what does the command use to shorten these object names?  It may be
>> safer and more correct to use "rev-parse --short" in case these object
>> names were ambigous in their first 7 hexdigits.
> 
> git submodule status (which is what we're testing here) uses
> 'git describe' to generate the short object name (see
> set_name_rev in git-submodule.sh). In this case, it falls back
> to 'git describe --all --always', which calls find_unique_abbrev()
> on the SHA1. 'git rev-parse --short' ends up calling the same
> find_unique_abbrev(), so I guess it is better to use it here.
> 
> Try this instead:
> 
> From: Johan Herland <johan@herland.net>
> 
> Subject: [PATCH] t7407: Use 'rev-parse --short' rather than bash's substring expansion notation
> 
> The substring expansion notation is a bashism that we have not so far
> adopted.  Use 'git rev-parse --short' instead, as this also handles
> the case where the unique abbreviation is longer than 7 characters.

Works for me.

Maybe it should be mentioned that a typo was fixed too.

-brandon
