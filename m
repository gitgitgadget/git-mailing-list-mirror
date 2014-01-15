From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refname_match(): always use the rules in ref_rev_parse_rules
Date: Wed, 15 Jan 2014 17:54:58 +0100
Message-ID: <52D6BD62.4020307@alum.mit.edu>
References: <xmqqlhyn90ka.fsf@gitster.dls.corp.google.com> <1389669367-27343-1-git-send-email-mhagger@alum.mit.edu> <xmqq38kq43bx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 17:55:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3TkE-0004RG-T4
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 17:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbaAOQzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 11:55:05 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56447 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751776AbaAOQzE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 11:55:04 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-81-52d6bd66efd5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 03.D7.19161.66DB6D25; Wed, 15 Jan 2014 11:55:02 -0500 (EST)
Received: from [192.168.69.148] (p4FDD4C39.dip0.t-ipconnect.de [79.221.76.57])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0FGsxSS022394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 15 Jan 2014 11:55:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqq38kq43bx.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqJu291qQwc4GFYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE7Y1E3f8FugYp/H96xNTAu4+1i5OSQEDCRWNDb
	yARhi0lcuLeerYuRi0NI4DKjRP+pX1DOOSaJh7ees4BU8QpoS+y+vZwNxGYRUJXYuLuVGcRm
	E9CVWNTTDDZJVCBYYvXlB1D1ghInZz4Bs0UE1CQmth0Csjk4mAXEJfr/gYWFBQIldv2exQix
	axGjxOwTW8DmcwpYS0y8tpMJpF4CqL6nMQgkzCygI/Gu7wEzhC0vsf3tHOYJjIKzkGybhaRs
	FpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNKNzFCgpdvB2P7eplDjAIc
	jEo8vJL7rwYJsSaWFVfmHmKU5GBSEuXl3XUtSIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb/Nm
	oBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYI3Zw9Qo2BRanpqRVpm
	TglCmomDE2Q4l5RIcWpeSmpRYmlJRjwofuOLgREMkuIB2lsL0s5bXJCYCxSFaD3FqMuxYsOn
	P4xCLHn5ealS4rxOIEUCIEUZpXlwK2Cp6hWjONDHwrxRIFU8wDQHN+kV0BImoCXBFVdBlpQk
	IqSkGhjDZkvd9Zt16uiPCpOYec3Ox1/v5Tz03Icjf+rTBx5pbZ2ht0NVfjtIpRw5/P/Y+czO
	CzGbblwR2B/qfufRh7Oz8++tifi5b+rKh/J1Bdkb1f9KpievYm45KqsR2VYSyfZg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240471>

On 01/14/2014 11:16 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> We used to use two separate rules for the normal ref resolution
>> dwimming and dwimming done to decide which remote ref to grab.  The
>> third parameter to refname_match() selected which rules to use.
>>
>> When these two rules were harmonized in
>>
>>     2011-11-04 dd621df9cd refs DWIMmery: use the same rule for both "git fetch" and others
>>
>> , ref_fetch_rules was #defined to avoid potential breakages for
>> in-flight topics.
>>
>> It is now safe to remove the backwards-compatibility code, so remove
>> refname_match()'s third parameter, make ref_rev_parse_rules private to
>> refs.c, and remove ref_fetch_rules entirely.
>>
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> See
>>
>>     http://article.gmane.org/gmane.comp.version-control.git/240305
>>
>> in which Junio made the suggestion and wrote most of the commit
>> message :-)
> 
> ;-) ...and on top of it this may be an obvious endgame follow-up.
> 
> was done mindlessly and mechanically, so there may be some slip-ups,
> though.
> 
> 
>  refs.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 5a10c25..b1c9cf5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1886,16 +1886,16 @@ static const char *ref_rev_parse_rules[] = {
>  	"refs/tags/%.*s",
>  	"refs/heads/%.*s",
>  	"refs/remotes/%.*s",
> -	"refs/remotes/%.*s/HEAD",
> -	NULL
> +	"refs/remotes/%.*s/HEAD"
>  };
> [...rewrite loops to use ARRAY_SIZE()...]

It's doable, but I don't see the point.  It's several lines longer (tho
that's not significant either).  The performance difference should be
negligible.  There are no users who benefit from knowing the length of
the list ahead of time.  If we ever decide to make the list vary at
runtime your version won't help.  Why bother?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
