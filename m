From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 5/7] refs: new public ref function: safe_create_reflog
Date: Wed, 08 Jul 2015 13:04:12 +0200
Message-ID: <559D03AC.4060706@alum.mit.edu>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>	 <1435609076-8592-6-git-send-email-dturner@twopensource.com>	 <559AAB18.1090701@alum.mit.edu> <1436311118.5521.16.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 13:04:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCn9L-0005ps-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 13:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758332AbbGHLET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 07:04:19 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53813 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758321AbbGHLER (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 07:04:17 -0400
X-AuditID: 1207440f-f79df6d000007c0f-9c-559d03ae199e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 73.B0.31759.EA30D955; Wed,  8 Jul 2015 07:04:14 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0310.dip0.t-ipconnect.de [93.219.3.16])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t68B4C1N002915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jul 2015 07:04:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436311118.5521.16.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqLuOeW6owaNeNov5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BkX9x1lLZjOXnFvegdjA+Mz1i5GTg4JAROJ
	3RN/skPYYhIX7q1n62Lk4hASuMwosWLrUlYI5wyTxNr9s9lAqngFtCXOtuwC62ARUJWYt6qX
	CcRmE9CVWNTTDGRzcIgKBEm8fpkLUS4ocXLmExYQWwSodfaRHlaQEmYBcYn+f2BhYQFfiROf
	n0KtusgoMfH6f2aQBKeAhcTTHU/BxjMLqEv8mXeJGcKWl9j+dg7zBEaBWUhWzEJSNgtJ2QJG
	5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkleqkppZsYIYHKv4Oxa73MIUYBDkYlHl6P
	mDmhQqyJZcWVuYcYJTmYlER54x4BhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw7roAlONNSays
	Si3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfD6Mc0NFRIsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHRWp8MTBWQVI8QHs5Qdp5iwsSc4GiEK2nGHU5Fvy4vZZJiCUv
	Py9VSpzXEKRIAKQoozQPbgUsLb1iFAf6WJh3FkgVDzClwU16BbSECWjJct1ZIEtKEhFSUg2M
	VnM37pSRmTjHnrXXY4mVHe8kyfkWFr9LNBbKbPnu8OezZBRfvXKWm6+etDO3w2q5mUee7r1s
	FqF2+CFf7Y2WTXPZI2Tt5prvFT00Z8f9NusZSmcDtH8yN3DFqiy6tjNZ5ESik5Tf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273670>

On 07/08/2015 01:18 AM, David Turner wrote:
> On Mon, 2015-07-06 at 18:21 +0200, Michael Haggerty wrote:
> 
> <snip> changes applied; will re-roll.
> 
>>> +
>>> +int safe_create_reflog(const char *refname, struct strbuf *err, int force_create)
>>> +{
>>> +	int ret;
>>> +	struct strbuf sb = STRBUF_INIT;
>>> +
>>> +	ret = log_ref_setup(refname, &sb, err, force_create);
>>> +	strbuf_release(&sb);
>>> +	return ret;
>>> +}
>>> +
>>
>> Is it really necessary to have two functions, safe_create_reflog() and
>> log_ref_setup()? I don't see any of the callers doing anything special
>> with the sb_logfile argument from the latter, so maybe it could be
>> inlined into safe_create_reflog()? Maybe I'm overlooking something.
> 
> log_ref_write_1 does use the sb_logfile argument.

Thanks for the clarification. I *did* overlook something.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
