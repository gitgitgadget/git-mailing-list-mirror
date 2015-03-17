From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Tue, 17 Mar 2015 20:46:59 +0100
Message-ID: <550884B3.5010102@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu> <xmqqk2yfo3y0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 20:47:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXxSO-0003tR-8d
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 20:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbbCQTrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 15:47:12 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44444 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752669AbbCQTrK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 15:47:10 -0400
X-AuditID: 12074414-f797f6d000004084-fa-550884b67ff2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E7.75.16516.6B488055; Tue, 17 Mar 2015 15:47:02 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HJl05r003777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 15:47:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqk2yfo3y0.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1N3WwhFqcOkWv0XXlW4mi4beK8wW
	j29NYHJg9ph739Lj4iVlj8+b5AKYo7htkhJLyoIz0/P07RK4M1qm+Rd0CFYcnvuKrYFxCW8X
	IyeHhICJxJqJl5kgbDGJC/fWs3UxcnEICVxmlFh6vZ0VwrnAJHF642yWLkYODl4BbYlnk4VB
	GlgEVCUOd2xkBbHZBHQlFvU0gw0SFQiSeHnrLyOIzSsgKHFy5hMWEFtEQE1iYtshMJtZwEhi
	1o0zYL3CAuESS+/NBusVEiiSWPDwDxuIzSlgLdHTdJAZol5PYsf1X6wQtrxE89bZzBMYBWYh
	WTELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoSErcgOxiMn
	5Q4xCnAwKvHwNuSxhwqxJpYVV+YeYpTkYFIS5WXN5QgV4kvKT6nMSCzOiC8qzUktPsQowcGs
	JMJ7xx0ox5uSWFmVWpQPk5LmYFES5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEkwfuyGahRsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSn8cXASAVJ8QDt/QbSzltckJgLFIVoPcWo
	KCXOuxEkIQCSyCjNgxsLS0avGMWBvhTmZQemJiEeYCKD634FNJgJaHBLOxvI4JJEhJRUA6Pj
	gnCNyJT0h9NNkyy0173pmPPqwWSejHNSj6yE66a/cbx54n6VFPvq6fX5Ig+ZAh9s/Vghl8i7
	0umzEVdCSY7T1R0P3L+8zHU/xxidtuWHpPxJ2VUbjyp3p+9KW/PP51sRXy4HR2H6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265656>

On 03/17/2015 07:48 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> When I looked around, I found scores of sites that call atoi(),
>> strtoul(), and strtol() carelessly. And it's understandable. Calling
>> any of these functions safely is so much work as to be completely
>> impractical in day-to-day code.
>>
>> git-compat-util.h has two functions, strtoul_ui() and strtol_i(), that
>> try to make parsing integers a little bit easier.
> 
> Exactly.  They were introduced to prevent sloppy callers from
> passing NULL to the &end parameter to underlying strtoul(3).  The
> first thing that came to my mind while reading your message up to
> this point was "why not use them more, tighten them, adding
> different variants if necessary, instead of introducing an entirely
> new set of functions in a new namespace?"

Here were my thoughts:

* I wanted to change the interface to look less like
  strtol()/strtoul(), so it seemed appropriate to make the names
  more dissimilar.

* The functions seemed long enough that they shouldn't be inline,
  and I wanted to put them in their own module rather than put
  them in git-compat-util.h.

* It wasn't obvious to me how to generalize the names, strtoul_ui()
  and strtol_i(), to the eight functions that I wanted.

That being said, I'm not married to the names. Suggestions are
welcome--but we would need names for 8 functions, not 4 [1].

Michael

> For example:
> 
>> * Am I making callers too strict? In many cases where a positive
>>   integer is expected (e.g., "--abbrev=<num>"), I have been replacing
>>   code like
>>
>>       result = strtoul(s, NULL, 10);
>>
>>   with
>>
>>       if (convert_i(s, 10, &result))
>>               die("...");
> 
> I think strictness would be good and those who did "--abbrev='  20'"
> deserve what they get from the additional strictness, but 
> 
> 	if (strtol_i(s, 10, &result))
> 
> would have been more familiar.

[1] It could be that when we're done, it will turn out that some of the
eight variants are not needed. If so, we can delete them then.

-- 
Michael Haggerty
mhagger@alum.mit.edu
