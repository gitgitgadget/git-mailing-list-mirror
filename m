From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 17/38] resolve_gitlink_ref(): avoid memory allocation in
 many cases
Date: Thu, 9 Jun 2016 16:37:14 +0200
Message-ID: <57597F1A.3060400@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <c126a2bf5e1f48faf48b3b4ee7cc599313a76b99.1464983301.git.mhagger@alum.mit.edu>
 <xmqq37oosya6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 16:37:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB15Q-0003r1-29
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 16:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbcFIOhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 10:37:24 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45836 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752835AbcFIOhV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 10:37:21 -0400
X-AuditID: 12074412-51bff700000009f7-be-57597f1daf62
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 87.46.02551.D1F79575; Thu,  9 Jun 2016 10:37:17 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59EbEki006803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 10:37:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqq37oosya6.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqCtbHxlucHujpMX8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zxcyr1hZn3jQyOrB77Jx1l93jWe8eRo+Ll5Q99i/dxuax+IGXx4Ln
	99k9Pm+SC2CP4rZJSiwpC85Mz9O3S+DOWPh5E3tBB0/F+j0rmBoYN3N2MXJySAiYSGy7M5up
	i5GLQ0hgK6PE49nfGSGc80wSB++fYQSpEhaIlLj2vIcFxBYRUJOY2HaIBaJoJ6NE19cGdhCH
	WWAWk0TH1otgHWwCuhKLepqZQGxeAW2JT+vWgcVZBFQkrlx/BRYXFQiROL9uKytEjaDEyZlP
	gKZycHAKWEv82FQEEmYW0JPYcf0XK4QtL7H97RzmCYz8s5B0zEJSNgtJ2QJG5lWMcok5pbm6
	uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsYISEvtINx/Um5Q4wCHIxKPLwaKRHhQqyJZcWV
	uYcYJTmYlER5vUsiw4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8ErUAuV4UxIrq1KL8mFS0hws
	SuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4M0EaBYtS01Mr0jJzShDSTBycIMO5pESKU/NS
	UosSS0sy4kFRGV8MjEuQFA/Q3ktge4sLEnOBohCtpxh1OY7sv7eWSYglLz8vVUqcVx+kSACk
	KKM0D24FLMG9YhQH+liY9wtIFQ8wOcJNegW0hAloyfIj4SBLShIRUlINjBNv/I6flHHztdtU
	6fMPikyCBFcXinw5djP8Pv/S9UeUhT7KK1nLTXldI3lw+ZxD9g9qdlTuX1zQZObj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296889>

On 06/07/2016 07:29 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> If we don't have to strip trailing '/' from the submodule path, then
>> don't allocate and copy the submodule name.
> 
> Makes sense.
> 
>>  int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
>>  {
>> -	int len = strlen(path);
>> -	struct strbuf submodule = STRBUF_INIT;
>> +	size_t len, orig_len = strlen(path);
>>  	struct ref_store *refs;
>>  	int flags;
>>  
>> -	while (len && path[len-1] == '/')
>> -		len--;
>> +	for (len = orig_len; len && path[len - 1] == '/'; len--)
>> +		;
>> +
>>  	if (!len)
>>  		return -1;
>>  
>> -	strbuf_add(&submodule, path, len);
>> -	refs = get_ref_store(submodule.buf);
>> -	strbuf_release(&submodule);
>> +	if (len == orig_len) {
> 
> You can keep the original while (), without introducing orig_len,
> and check if path[len] is NUL, which would probably be an end result
> that is easier to read.

OK, I'll change it.

>> +		refs = get_ref_store(path);
>> +	} else {
>> +		char *stripped = xmemdupz(path, len);
>> +
>> +		refs = get_ref_store(stripped);
>> +		free(stripped);
> 
> An alternative might be to add get_ref_store_counted() that takes
> (path, len) instead of NUL-terminated path, which does not look too
> bad looking at the state after applying all 38 patches.

This slash-stripping code was introduced in 2007 (0ebde32c87) and it's
not my priority to improve it as part of this patch series.

Michael
