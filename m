From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 16/38] resolve_gitlink_ref(): implement using
 resolve_ref_recursively()
Date: Thu, 16 Jun 2016 06:03:26 +0200
Message-ID: <5762250E.6020200@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <a9787723bcd990413661b8cb2e5542d618ab6321.1464983301.git.mhagger@alum.mit.edu>
 <CAPig+cQTDrUw63qWknZQxmuDBXkoYr6gLyp5Bu=JopeT394puw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 06:03:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDOWq-0001cj-EP
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jun 2016 06:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbcFPEDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2016 00:03:36 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60949 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750757AbcFPEDf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2016 00:03:35 -0400
X-AuditID: 12074414-62bff700000008e6-99-57622512f654
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 27.B0.02278.21522675; Thu, 16 Jun 2016 00:03:30 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFDE.dip0.t-ipconnect.de [80.142.175.222])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5G43RKp010266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 16 Jun 2016 00:03:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <CAPig+cQTDrUw63qWknZQxmuDBXkoYr6gLyp5Bu=JopeT394puw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqCukmhRucP2VicX8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zxcyr1hZn3jQyOrB77Jx1l93jWe8eRo+Ll5Q99i/dxuax+IGXx4Ln
	99k9Pm+SC2CP4rZJSiwpC85Mz9O3S+DOaDm5jrXgCW/F6W1bWBsYb3F1MXJySAiYSBzY+oK9
	i5GLQ0hgK6PE5qtdrBDOBSaJTf+/MIJUCQvESjTv+cEKYosIaEt82LCJEaLoPKPEpfevmUEc
	ZoEFTBKHZ2xgAaliE9CVWNTTzARi8wJ1rG7eC9bNIqAqsXHKBHYQW1QgROL8uq2sEDWCEidn
	PgHq5eDgFAiUWPInEyTMLKAu8WfeJWYIW15i+9s5zBMY+Wch6ZiFpGwWkrIFjMyrGOUSc0pz
	dXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUJCXmQH45GTcocYBTgYlXh4BdYnhguxJpYV
	V+YeYpTkYFIS5e1VTgoX4kvKT6nMSCzOiC8qzUktPsQowcGsJMK7HCTHm5JYWZValA+TkuZg
	URLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBuxakUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUv
	JbUosbQkIx4UlfHFwLgESfEA7d0Ctre4IDEXKArReopRl+PI/ntrmYRY8vLzUqXEeVeCFAmA
	FGWU5sGtgCW4V4ziQB8L83KpAFXxAJMj3KRXQEuYgJbYTI8HWVKSiJCSamCUs+hinxZW91CA
	7f+U2uOXjTqOP94tu1whb+NEpRI56c093geX9imcyND8vvLmibXxrw/rvrRPsZr6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297407>

On 06/14/2016 07:03 AM, Eric Sunshine wrote:
> On Fri, Jun 3, 2016 at 5:03 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> resolve_ref_recursively() can handle references in arbitrary files
>> reference stores, so use it to resolve "gitlink" (i.e., submodule)
>> references. Aside from removing redundant code, this allows submodule
>> lookups to benefit from the much more robust code that we use for
>> reading non-submodule references. And, since the code is now agnostic
>> about reference backends, it will work for any future references
>> backend (so move its definition to refs.c).
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> diff --git a/refs.c b/refs.c
>> @@ -1299,6 +1299,30 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
>> +int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
>> +{
>> +       int len = strlen(path);
>> +       struct strbuf submodule = STRBUF_INIT;
>> +       struct ref_store *refs;
>> +       int flags;
>> +
>> +       while (len && path[len-1] == '/')
>> +               len--;
>> +       if (!len)
>> +               return -1;
>> +
>> +       strbuf_add(&submodule, path, len);
> 
> It took me a moment to figure out that you're using the strbuf only
> for its side-effect of giving you a NUL-terminated string needed by
> get_ref_store(), and not because you need any fancy functionality of
> strbuf. I wonder if xstrndup() would have made this clearer.
> 
> Not worth a re-roll.

I agree both that xstrndup() (or, in this case, xmemdupz()) would have
been clearer, and also that it's not worth a re-roll. I'll keep it in
mind if I touch this code again.

Thanks for your comment.

Michael
