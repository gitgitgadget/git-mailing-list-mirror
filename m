From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 02/22] try_merge_strategy(): remove redundant lock_file
 allocation
Date: Wed, 02 Apr 2014 12:53:57 +0200
Message-ID: <533BEC45.4060803@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <1396367910-7299-3-git-send-email-mhagger@alum.mit.edu> <20140401195615.GB21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:32:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeMc-0000xS-Hg
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621AbaDBKyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 06:54:06 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:60738 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758518AbaDBKyB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 06:54:01 -0400
X-AuditID: 1207440c-f79656d000003eba-c4-533bec48e9d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A0.2A.16058.84CEB335; Wed,  2 Apr 2014 06:54:00 -0400 (EDT)
Received: from [192.168.69.148] (p57A25BD8.dip0.t-ipconnect.de [87.162.91.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s32ArvTD018375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 2 Apr 2014 06:53:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <20140401195615.GB21715@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqOvxxjrY4MwsIYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3BnLFmxnK9jEUXH1/0/2Bsbr
	bF2MHBwSAiYSf/r4uxg5gUwxiQv31gOFuTiEBC4zShzY+4gJwjnHJHHtej8TSAOvgLbEiTvF
	IA0sAqoSr+e9YwWx2QR0JRb1NDOB2KICQRKHN5wCi/MKCEqcnPmEBcQWEZCV+H54IyOIzSxg
	LbHi9WGwemGBCIkNP2+xQuxaxSgxY+FZsAZOoKKvkw8wQhwqLtHTGARiMguoS6yfJwQxRl5i
	+9s5zBMYBWch2TYLoWoWkqoFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3
	MUKCmWcH47d1MocYBTgYlXh4D5y3ChZiTSwrrsw9xCjJwaQkysv/wjpYiC8pP6UyI7E4I76o
	NCe1+BCjBAezkgiv0GOgHG9KYmVValE+TEqag0VJnFd1ibqfkEB6YklqdmpqQWoRTFaGg0NJ
	gnfra6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFDsxhcDoxckxQO0d9YrkL3F
	BYm5QFGI1lOMuhwbtq1pZBJiycvPS5US550EskMApCijNA9uBSx1vWIUB/pYmHcuSBUPMO3B
	TXoFtIQJaAn3OiuQJSWJCCmpBkZ1sZDtKdbxNsnXPBqdXj0UlvpYX6OdoGZits9Fdm/45R85
	76a1vdnUX7rlbkKJne3aJe6XJDfNfzxhx+LNp4NEOfeWKOZr8WV87Jl06gSr7c75 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245717>

On 04/01/2014 09:56 PM, Jeff King wrote:
> On Tue, Apr 01, 2014 at 05:58:10PM +0200, Michael Haggerty wrote:
> 
>> By the time the "if" block is entered, the lock_file instance from the
>> main function block is no longer in use, so re-use that one instead of
>> allocating a second one.
>>
>> Note that the "lock" variable in the "if" block used to shadow the
>> "lock" variable at function scope, so the only change needed is to
>> remove the inner definition.
> 
> I wonder if this would also be simpler if "lock" were simply declared as
> a static variable, and we drop the allocation entirely. I suppose that
> does create more cognitive load, though, in that it is only correct if
> the function is not recursive. On the other hand, the current code makes
> a reader unfamiliar with "struct lock" wonder if there is a free(lock)
> missing.

Yes, a single lock_file object should suffice.  I will make this change
in the next version of the patch series.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
