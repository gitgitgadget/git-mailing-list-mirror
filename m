From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v2] config: add support for http.<url>.* settings
Date: Thu, 11 Jul 2013 14:49:45 -0700
Message-ID: <072BFEEA-249D-4971-82D3-E76E6C19A303@gmail.com>
References: <26507a43bd82855050b90f6a2b9d01bd@f74d39fa044aa309eaea14b9f57fe79c> <7vd2qorj7s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 23:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxOkL-0004a3-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 23:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742Ab3GKVtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 17:49:49 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:46778 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756703Ab3GKVtt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 17:49:49 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so8221930pab.7
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=w1KS3L1aty2B8m2T5T/fc83H9kySxSu3CU+ENy5SXSw=;
        b=qhxw21JYwiWRx20GhcsNFou178wHrNkjUQW0BxNj4WD3acZTSQobSMJvtAo9igtndi
         EnOcDT3X7CpL24F5LE+m0XuySqpZLXDCmXP6960Cquv76YJilxMBMi+Ah7udTlpY9rHo
         XBXnSogj/myaUIM1u99PuW/VdGKBfbTW70J5gB25FhtBr3AT7OtwqFot/gJlt3HT1tjS
         7lmAclR3+mpBskz/dszOojIQo7ZM//rwe99xzfW5rPbJfqxJPgPkkqmTtuyEnR6WKpY5
         dA7o+7XbjTvfj6XRLfYWIljGgUekuG6b6oz60rKiQT7DlGTp2XibXb6ABffnPWUyHebf
         TYhA==
X-Received: by 10.66.156.132 with SMTP id we4mr40801666pab.28.1373579388458;
        Thu, 11 Jul 2013 14:49:48 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ue9sm44178813pab.7.2013.07.11.14.49.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 14:49:47 -0700 (PDT)
In-Reply-To: <7vd2qorj7s.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230131>

On Jul 11, 2013, at 12:26, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> +static int http_option_maxlen[opt_max];
>
> I understand that this is to keep track of the length of the longest
> one that has matched (hence the current candidate).  The name "maxlen"
> captures the "longest" part, but "has matched" is somehow lost.
>
> Can we have a better name here please, or at least a comment to
> clarify what this variable keeps track of.

Will do.  How about "http_option_max_matched_len"?

>> +static int http_options_url_match_prefix(const char *url, const  
>> char *url_prefix)
>> +{
>> +	/*
>> +	 * url_prefix matches url if url_prefix is an exact match for url  
>> or it
>> +	 * is a prefix of url and the match ends on a path component  
>> boundary.
>> +	 * url_prefix is considered to have an implicit '/' on the end for
>> +	 * matching purposes if it does not already and it is shorter  
>> than url.
>> +	 * the return value is the length of the match in characters  
>> (excluding
>> +	 * any final '/') or 0 for no match.
>> +	 */
>> +	size_t url_len, url_prefix_len = strlen(url_prefix);
>> +	if (!url_prefix_len || strncmp(url, url_prefix, url_prefix_len))
>> +		return 0;
>
> Should "url=http://git.or.xz/git" match "url_prefix=http://git.or.xz/git/ 
> "?

My initial thought was no.  But your example is persuasive and  
probably should match.  Fix forthcoming.

>> +	url_len = strlen(url);
>> +	if (url_len == url_prefix_len || url[url_prefix_len - 1] == '/'  
>> || url[url_prefix_len] == '/')
>> +		return url[url_prefix_len - 1] == '/' ? url_prefix_len - 1 :  
>> url_prefix_len;
>
> Overlong lines that are somewhat hard to read.

OK.

>> static int http_options(const char *var, const char *value, void *cb)
>> {
>> -	if (!strcmp("http.sslverify", var)) {
>> +/*
>> + * Macro to ignore matches with a match length less than  
>> previously seen
>> + * for the same option type and to remember the largest match  
>> length seen so
>> + * far for each option type
>> + */
>> +#define CHECK_MATCHLEN(opt) \
>> +	if (http_option_maxlen[opt] > matchlen) return 0; \
>> +	else http_option_maxlen[opt] = matchlen
>
> Avoid defining a macro _inside_ a function.  Also if you can make it
> a static function, that would be much easier to read.

Was modeled after the credential_match() function from credential.c  
that defines a CHECK macro inside it and then undefines it at the end  
of the function.  I will change it to a static function.

>> +	if (dot) {
>> +		char *config_url = xmemdupz(key, dot - key);
>> +		matchlen = http_options_url_match_prefix(url, config_url);
>> +		free(config_url);
>
> Yikes.  http_options_url_match_prefix() could take a counted string
> to config_url to avoid this repeated allocation and deallocation,
> no?

Again, modeled after the credential_config_callback() function from  
credential.c that does this exact thing.

I will update http_options_url_match_prefix to take a size_t.
