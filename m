From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): tighten up pointer arithmetic
Date: Fri, 10 Jan 2014 15:16:44 +0100
Message-ID: <52D000CC.1060402@alum.mit.edu>
References: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu> <1389192220-13913-4-git-send-email-mhagger@alum.mit.edu> <xmqqtxdc92ub.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 15:16:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1ctM-0007j7-OH
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 15:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224AbaAJOQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 09:16:51 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:57498 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756087AbaAJOQs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jan 2014 09:16:48 -0500
X-AuditID: 1207440f-b7f306d000006d99-4e-52d000d0cf93
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.27.28057.0D000D25; Fri, 10 Jan 2014 09:16:48 -0500 (EST)
Received: from [172.16.46.13] ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0AEGjnD019528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 10 Jan 2014 09:16:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqtxdc92ub.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqHuB4UKQwea1zBZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3RufVNcwFh8QqmtbcZm5gbBDqYuTkkBAwkWht
	bGSGsMUkLtxbz9bFyMUhJHCZUeLpwp1sIAkhgQ1MEseWCYPYvALaEgc7XjOB2CwCqhLd83vA
	atgEdCUW9TSDxUUFgiVWX37AAlEvKHFy5hMwW0RATWJi2yEgm4ODWUBcov8fWFhYIFBiWvMR
	JohVaxgl7uy3BbE5Bawl9v85wA5SLgFU3tMYBBJmFtCReNf3gBnClpfY/nYO8wRGwVlIls1C
	UjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCGhy7+DsWu9zCFG
	AQ5GJR7eglnng4RYE8uKK3MPMUpyMCmJ8l78CxTiS8pPqcxILM6ILyrNSS0+xCjBwawkwmv/
	CijHm5JYWZValA+TkuZgURLnVV+i7ickkJ5YkpqdmlqQWgSTleHgUJLgzQTGqJBgUWp6akVa
	Zk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KHrji4HxC5LiAdprANLOW1yQmAsUhWg9xajLsWLD
	pz+MQix5+XmpUuK8xSBFAiBFGaV5cCtgieoVozjQx8K8xiBVPMAkBzfpFdASJqAlomHnQJaU
	JCKkpBoYuyRXZphUvzx1Y6f8SekSF/blB+ySrwSJnUo/ZPZKrNTa8MpLwSr7zREaEh4zV/SX
	x15R1RSe3h996uQMgxsXbZ4Gsv5bZ5SVFxWhpr3i05alq8LlXreYfDBnb3He+Ny4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240303>

On 01/10/2014 12:01 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> As long as we're being pathologically stingy with mallocs, we might as
>> well do the math right and save 6 (!) bytes.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> It is left to the reader to show how another 7 bytes could be saved
>> (11 bytes on a 64-bit architecture!)
>>
>> It probably wouldn't kill performance to use a string_list here
>> instead.
>>
>>  refs.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index ef9cdea..63b3a71 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3351,10 +3351,10 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
>>  		size_t total_len = 0;
>>  		size_t offset = 0;
>>  
>> -		/* the rule list is NULL terminated, count them first */
>> +		/* the rule list is NUL terminated, count them first */
> 
> I think this _is_ wrong; it talks about the NULL termination of the
> ref_rev_parse_rules[] array, not each string that is an element of
> the array being NUL terminated.

Yes, you're right.  Thanks for catching my sloppiness.  Would you mind
squashing the fix onto my patch?

> Output from "git grep -e refname_match -e ref_rev_parse_rules"
> suggests me that we actually could make ref_rev_parse_rules[] a
> file-scope static to refs.c, remove its NULL termination and convert
> all the iterators of the array to use ARRAY_SIZE() on it, after
> dropping the third parameter to refname_match().  That way, we do
> not have to count them first here.
> 
> But that is obviously a separate topic.
> 
>>  		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
>> -			/* no +1 because strlen("%s") < strlen("%.*s") */
>> -			total_len += strlen(ref_rev_parse_rules[nr_rules]);
>> +			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
>> +			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
>>  
>>  		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);

The way the code is written now (e.g., as long as it is not converted to
use a string_list or something) needs this loop not only to count the
number of rules but also to compute the total_len of the string into
which will be written all of the scanf format strings.

As for removing the third argument of refname_match(): although all
callers pass it ref_ref_parse_rules, that array is sometimes passed to
the function via the alias "ref_fetch_rules".  So I suppose somebody
wanted to leave the way open to make these two rule sets diverge (though
I don't know how likely that is to occur).  If we discard the third
argument to refname_match(), then we loose the distinction.

Thanks for your feedback,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
