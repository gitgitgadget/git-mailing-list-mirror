From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Tue, 24 Mar 2015 17:06:12 +0100
Message-ID: <55118B74.1030201@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>	<20150319052620.GA30645@peff.net> <xmqqk2ydjvcd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:06:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaRLp-00019K-A5
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 17:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbbCXQGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 12:06:40 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62704 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753359AbbCXQGS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 12:06:18 -0400
X-AuditID: 1207440c-f79376d00000680a-8b-55118b762d37
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id BC.51.26634.67B81155; Tue, 24 Mar 2015 12:06:14 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9745A.dip0.t-ipconnect.de [79.201.116.90])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2OG6CfX011426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 24 Mar 2015 12:06:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqk2ydjvcd.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqFvWLRhq8P+VokXXlW4mi4beK8wW
	P1p6mC0e35rA5MDi8ax3D6PH3PuWHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ2xfMlupoI5
	4hV/T3WyNzBuE+xi5OSQEDCRuN+1kgnCFpO4cG89WxcjF4eQwGVGif1X9jJDOOeZJJb8PMkO
	UsUroC1xftIXxi5GDg4WAVWJTyeFQMJsAroSi3qawQaJCgRJvLz1lxGiXFDi5MwnLCC2iICj
	xIkH11lBbGYBI4lZN86A2cIC4RJL781mgtg1hVHi14cTYAlOAWuJ61samSEa9CR2XP8F1Swv
	0bx1NvMERoFZSHbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSml
	mxgh4cyzg/HbOplDjAIcjEo8vAFLBEKFWBPLiitzDzFKcjApifJOdxIMFeJLyk+pzEgszogv
	Ks1JLT7EKMHBrCTC+7wdKMebklhZlVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQ
	kuDV7wJqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFanwxMFpBUjxAe81B2nmL
	CxJzgaIQracYFaXEeR92AiUEQBIZpXlwY2FJ6hWjONCXwrzhIO08wAQH1/0KaDAT0OBz+Xwg
	g0sSEVJSDYxZG1r7Ew69bnknxWD5+Tw3k8yiPdJXZGeX2kYzCCzIUP2v+zhw77HrAs2zRN/8
	mmO0yuXDxD6jIq8ay5a/z3v21+2+ku6Xd43D24KFcen5jKrppsX5l3ZFFj/+xWn0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266194>

On 03/19/2015 08:32 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I wonder how much of the boilerplate in the parse_* functions could be
>> factored out to use a uintmax_t, with the caller just providing the
>> range. That would make it easier to add new types like off_t, and
>> possibly even constrained types (e.g., an integer from 0 to 100). On the
>> other hand, you mentioned to me elsewhere that there may be some bugs in
>> the range-checks of config.c's integer parsing. I suspect they are
>> related to exactly this kind of refactoring, so perhaps writing things
>> out is best.
> 
> I like this idea very well.  I wonder if we can implement the family
> of
> 
>     parse_{type}(const char *, unsigned int flags,
>     		 const char **endptr, {type} *result)
> 
> functions by calls a helper that internally deals with the numbers
> in uintmax_t, and then checks if the value fits within the possible
> range of the *result before returning.
> 
>     int parse_i(const char *str, unsigned flags,
> 		const char **endptr, int *result) {
> 	uintmax_t val;
>         int sign = 1, status;
>         if (*str == '-') {
> 		sign = -1; 
>                 str++;
> 	}
>         status = parse_num(str, flags, endptr, &val, INT_MAX);
>         if (status < 0)
>         	return status;
> 	*result = sign < 0 ? -val : val;
>         return 0;
>     }
> 
> (assuming the last parameter to parse_num is used to check if the
> result fits within that range).  Or that may be easier and cleaner
> to be done in the caller with or something like that:
> 
> 	status = parse_num(str, flags, endptr, &val);
>         if (status < 0)
>         	return status;
> 	if (INT_MAX <= val * sign || val * sign <= INT_MIN) {
>         	errno = ERANGE;
>                 return -1;
> 	}
> 
> If we wanted to, we may even be able to avoid duplication of
> boilerplate by wrapping the above pattern within a macro,
> parameterizing the TYPE_{MIN,MAX} and using token pasting, to
> expand to four necessary result types.
> 
> There is no reason for the implementation of the parse_num() helper
> to be using strtoul(3) or strtoull(3); its behaviour will be under
> our total control.  It can become fancier by enriching the flags
> bits (e.g. allow scaling factor, etc.) only once and all variants
> for various result types will get the same feature.

Parsing numbers is not rocket science, but there are a lot of pitfalls,
especially around overflow. It's even harder to write such code via
macros and the result is less readable.

This patch series is mostly about finding a reasonable API and whipping
the callers into shape. That seems ambitious enough for me. I'd rather
stick with boring wrappers for now and lean on strtol()/strtoul() to do
the dirty work. It will be easy for a motivated person to change the
implementation later.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
