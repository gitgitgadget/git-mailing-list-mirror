From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] update-ref: fail create operation over stdin if ref already
 exists
Date: Thu, 03 Apr 2014 15:20:30 +0200
Message-ID: <533D601E.8020301@alum.mit.edu>
References: <1396426194-3292-1-git-send-email-mhagger@alum.mit.edu> <533C092B.1050801@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Aman Gupta <aman@tmm1.net>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 15:51:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVhZP-00041I-4N
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 15:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbaDCNUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 09:20:35 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45356 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751855AbaDCNUe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2014 09:20:34 -0400
X-AuditID: 1207440c-f79656d000003eba-32-533d6021bf3a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A9.41.16058.1206D335; Thu,  3 Apr 2014 09:20:33 -0400 (EDT)
Received: from [192.168.69.148] (p5B1562A0.dip0.t-ipconnect.de [91.21.98.160])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s33DKVLC014727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 3 Apr 2014 09:20:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <533C092B.1050801@kitware.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqKuYYBtssHiNnsW1NxfZLHauk7Do
	utLNZNHQe4XZgcXj47Pl7B4XLyl79M9rZPb4vEkugCWK2yYpsaQsODM9T98ugTtj0/Gv7AVL
	WStOTTjN3sA4k6WLkZNDQsBEYvHzj8wQtpjEhXvr2boYuTiEBC4zSpzcfIIRwjnLJLHz3XJ2
	kCpeAW2JXa0/2EBsFgFVid83JoHF2QR0JRb1NDOB2KICQRKHN5xihagXlDg58wnYNhGg+lXr
	GoB6OTiYBRIk5j3TBQkLC0RKvFhxHewIIYEkibNX7rKAlHACrbrwXwnElBAQl+hpDAKpYBbQ
	kXjX94AZwpaX2P52DvMERsFZSHbNQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	hnq5mSV6qSmlmxghAc6zg/HbOplDjAIcjEo8vA/EbYKFWBPLiitzDzFKcjApifK2x9kGC/El
	5adUZiQWZ8QXleakFh9ilOBgVhLhXWcFlONNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5N
	LUgtgsnKcHAoSfAeBxkqWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4re+GJg/IKk
	eID2/gZp5y0uSMwFikK0nmLU5diwbU0jkxBLXn5eqpQ4bydIkQBIUUZpHtwKWDp7xSgO9LEw
	72OQKh5gKoSb9ApoCRPQEu51ViBLShIRUlINjOHJKfoxpbbbClstsoMbPNOZ/xbnc5uvun/n
	QNJxb3GZi+2MdjHpa387OT9dYLJ7u9EHXjuBffNX7PwnNu+mXPmGTVm3VRhnTpjB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245736>

On 04/02/2014 02:57 PM, Brad King wrote:
> On 04/02/2014 04:09 AM, Michael Haggerty wrote:
>> From: Aman Gupta <aman@tmm1.net>
> [snip]
>> @@ -147,6 +147,7 @@ static void parse_cmd_create(const char *next)
>>  	struct ref_update *update;
>>  
>>  	update = update_alloc();
>> +	update->have_old = 1;
> 
> Looks good.
> 
>> +test_expect_success 'stdin -z create ref fails when ref exists' '
> 
> Strictly speaking we should have a non-z mode test too.

This code path is used regardless of whether -z is used, so I don't
think it is necessary to duplicate the test.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
