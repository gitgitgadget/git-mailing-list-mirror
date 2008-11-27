From: William Pursell <bill.pursell@gmail.com>
Subject: Re: [PATCH 1/2] Add / command in add --patch (feature request)
Date: Thu, 27 Nov 2008 06:02:57 +0000
Message-ID: <492E3811.6050603@gmail.com>
References: <492DB6C8.7010205@gmail.com> <20081126223858.GB10786@coredump.intra.peff.net> <7vod02cd3p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 07:04:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5ZzH-0001Sm-C8
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 07:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbYK0GDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 01:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbYK0GDF
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 01:03:05 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:26328 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYK0GDC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 01:03:02 -0500
Received: by ey-out-2122.google.com with SMTP id 6so351729eyi.37
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 22:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Yg+rZMyX3wqLjCZFk62BLPuoxtyQFrqZM3MYGSN/zJ8=;
        b=XQ72PZ8/YMN15AosivQ6DVbwNZA3lPxPGL4/6KBHbXkJJQv0EW/t+l8FuPKbzOGYA8
         KfPyQGZa4d8WBL05hKcC3phdTL8t3LnaFkfvwcTPAKoxePyivRWwq4Ii5n3SvDttEmd9
         vXboH8ri2bna9/D2kru/5gcDlZZ/DxkV3gX+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=k31Mu8iV669kPRcT/NcJnoTuAEs6eoxJ9mRTB3stjVJq/21i3m3awoqMJjDUPufZd6
         P3MKkAZdzMGwpklfeu6A1qcmCCrDF7yvug+5iN2gXo3MBH2A1m78pLgAzzRoLw9X/vjH
         hxrlCPTA0HFQmiQo3CXstohFTfDU1V98d5tcs=
Received: by 10.210.121.8 with SMTP id t8mr6987744ebc.143.1227765781118;
        Wed, 26 Nov 2008 22:03:01 -0800 (PST)
Received: from clam.local (5ad934ac.bb.sky.com [90.217.52.172])
        by mx.google.com with ESMTPS id 20sm2674416eyc.48.2008.11.26.22.02.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 22:03:00 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <7vod02cd3p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101792>

Junio C Hamano wrote:

> 
> Use of eval is a good way to protect against this kind of breakage, but it
> should be done close to where the string is given by the user, perhaps in
> here:
> 
> 
> +			elsif ($line =~ m|^/(.*)|) {
> +				$search_s = $1;
> +			}
> 
> Something like...
> 
> 	elsif ($line =~ m|^/(.*)|) {
>         	$search_string = $1;
>                 eval {
>                 	$search_string =~ /$search_string/;
> 		};
>                 if ($@) {
>                 	print STDERR "Regexp error in $search_string: $@";
> 			next;
> 		}
> 	...

Thanks.  The second set of patches that I just sent
up is fatally flawed--by changing to skip unmatched
hunks instead of deselecting them, it enters a loop
if no hunks match.

Before working on patches, I'd like some ideas on
functionality:

1) If a hunk doesn't match, should it be as if the user
    selected 'n', or 'j'?
2) If no hunks match it is easiest to simply move to
    the last hunk and display it, but I'm not sure that
    is acceptable.  Probably better to return to the
    hunk that was being viewed when the search string
    is entered, but that seems to require some restructuring
    of the code.  What would be the preferred behavior?



-- 
William Pursell
