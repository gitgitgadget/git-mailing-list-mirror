From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 08/12] initial_ref_transaction_commit(): function for
 initial ref creation
Date: Sat, 20 Jun 2015 04:15:53 +0200
Message-ID: <5584CCD9.9030107@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu>	<19f421f504ae22538fd2a902840209c0799e67cb.1434206062.git.mhagger@alum.mit.edu> <xmqqioao952n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 04:16:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z68Kq-0003id-5o
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 04:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbbFTCQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 22:16:12 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58445 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752638AbbFTCQK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 22:16:10 -0400
X-AuditID: 12074414-f794f6d000007852-0a-5584ccdb404d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C4.05.30802.BDCC4855; Fri, 19 Jun 2015 22:15:55 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB04CB.dip0.t-ipconnect.de [93.219.4.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5K2FrSP018561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 19 Jun 2015 22:15:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqioao952n.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqHv7TEuowdnVQhZdV7qZLBp6rzBb
	/GjpYbbYvLmdxYHFY8GmUo9nvXsYPS5eUvb4vEkugCWK2yYpsaQsODM9T98ugTtj77alLAUH
	2Cpm7o1uYOxl7WLk5JAQMJF4cfg7I4QtJnHh3nq2LkYuDiGBy4wS31ubwYqEBM4xSfTMUwSx
	eQW0JZ7tf8UOYrMIqErcW9oN1swmoCuxqKeZqYuRg0NUIEji9ctciHJBiZMzn7CA2CICahIT
	2w6B2cwC8RJb268yg9jCAskSm551Q+3dyijx90UX2F5OAWuJnR3bmCAa9CR2XP/FCmHLS2x/
	O4d5AqPALCQ7ZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2M
	kFAW2cF45KTcIUYBDkYlHt4fS1tChVgTy4orcw8xSnIwKYnynj4EFOJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCO3c2UI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoNDSYL3
	0SmgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQnMYXAyMVJMUDtNfoNMje4oLE
	XKAoROspRl2OBT9ur2USYsnLz0uVEue9AFIkAFKUUZoHtwKWuF4xigN9LMzrDFLFA0x6cJNe
	AS1hAloyobwJZElJIkJKqoFRcuOqo4YXbCs3WN/7/7bl07zj6xaxRL+fJBS8/tTbysyP1vsF
	DqzJXdL/u+7Tl90z5j98fXDenCXNK8ovT/qfMGHqhp9+bJniKR6d/br9T12eC7df 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272220>

On 06/15/2015 08:53 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> +	struct ref_transaction *t;
>> +	struct strbuf err = STRBUF_INIT;
>> +
>> +	t = ref_transaction_begin(&err);
>> +	if (!t)
>> +		die(err.buf);
> 
> Yikes, and sorry for sending three messages without consolidating
> against the same patch, but
> 
> 	die("%s", err.buf);
> 
> because
> 
> extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
> 
> in its declaration causes -Werror=format-security to barf.
> 
> Likewise for a few other instances of the same construct all in 
> the same file.

Thanks for catching this. I'll fix it in the re-roll (and also add that
gcc option to my config.mak for the future).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
