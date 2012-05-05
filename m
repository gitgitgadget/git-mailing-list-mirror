From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] fetch/push: allow refs/*:refs/*
Date: Sat, 05 May 2012 20:22:52 +0200
Message-ID: <4FA56FFC.9080201@alum.mit.edu>
References: <7vsjfj7des.fsf@alter.siamese.dyndns.org> <7vwr4r8tpm.fsf@alter.siamese.dyndns.org> <4FA4C2CC.7080205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 05 20:23:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQjdF-0001aC-4z
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 20:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607Ab2EESW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 14:22:56 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:45603 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757504Ab2EESWz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 14:22:55 -0400
X-AuditID: 1207440f-b7fe16d000000920-76-4fa56fff6d61
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 2F.40.02336.FFF65AF4; Sat,  5 May 2012 14:22:55 -0400 (EDT)
Received: from [192.168.69.140] (p4FC0D13D.dip.t-dialin.net [79.192.209.61])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q45IMrbs025313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 5 May 2012 14:22:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <4FA4C2CC.7080205@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1P2fv9Tf4MdBLouuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE7o2XWD8aCWxIVF+7eY29gnCrSxcjJISFgInH6
	+1tGCFtM4sK99WxdjFwcQgKXGSW+XNvOCOGcZpLoOfocKMPBwSugLXHwsDNIA4uAqsSCCdPY
	QWw2AV2JRT3NTCC2qECYRP/tLWA2r4CgxMmZT1hAbBEBNYmJbYdYQMYwC4hL9P8DCwsD3bDk
	2x2wMUIC9RK7G5eDxTkFdCTevNjBBlFuLfFtdxFImFlAXmL72znMExgFZiFZMAuhahaSqgWM
	zKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE30cjNL9FJTSjcxQgKUfwdj13qZQ4wCHIxKPLwZ
	vEv8hVgTy4orcw8xSnIwKYnyZuUt9RfiS8pPqcxILM6ILyrNSS0+xCjBwawkwtvtCJTjTUms
	rEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwJgIjUUiwKDU9tSItM6cEIc3E
	wQkynEtKpDg1LyW1KLG0JCMeFKPxxcAoBUnxAO0VBWnnLS5IzAWKQrSeYtTlmL1k61VGIZa8
	/LxUKXFeT5AiAZCijNI8uBWwdPSKURzoY2FeK5AqHmAqg5v0CmgJE9ASaYNFIEtKEhFSUg2M
	Yq6tKeLRknLXYo9tXCZV8fDd7xeXA4WcXkvHmy23Xvj6zJKpkjyBxut41D+v79jz89x1JXm2
	zy1cbgsnzT0izSKdFL9jhYTdhaDvd7MOmz98trrsk5j3wUNstw79c+PQv5X1+2zD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197131>

On 05/05/2012 08:03 AM, Michael Haggerty wrote:
> On 05/05/2012 12:30 AM, Junio C Hamano wrote:
>> There are a handful of places where we call check_refname_format() on a
>> substring after "refs/" of a refname we are going to use, and filter
>> out a
>> valid match with "refs/stash" with such a pathspec. Not sending a stash
>> may arguably be a feature (as stash is inherently a local workflow
>> element), but the code in the transport layer is oblivious to this
>> filtering performed by the lower layer of the code, and complains that
>> the
>> other side did not send all the objects that needs to complete refs/stash
>> at the end, even though the code will not write refs/stash out anyway,
>> and
>> making the whole command fail.
>>
>> This is an attempt to "fix" it by using check_refname_format() on the
>> whole "refs/....." string and allowing refs/stash to be also copied.
>>
>> Signed-off-by: Junio C Hamano<gitster@pobox.com>
>> ---
>>
>> * With this patch:
>>
>> $ git checkout HEAD^0 ;# make sure we are on detached HEAD
>> $ git fetch $somewhere +refs/*:refs/*
>>
>> and
>>
>> victim$ git config receive.denyCurrentBranch warn
>> master$ git push victim +refs/*:refs/*
>>
>> should work.
>>
>> builtin/fetch-pack.c | 2 +-
>> builtin/receive-pack.c | 2 +-
>> remote.c | 2 +-
>> t/t5516-fetch-push.sh | 30 ++++++++++++++++++++++++++++++
>> 4 files changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
>> index 6207ecd..a3e3fa3 100644
>> --- a/builtin/fetch-pack.c
>> +++ b/builtin/fetch-pack.c
>> @@ -546,7 +546,7 @@ static void filter_refs(struct ref **refs, int
>> nr_match, char **match)
>> for (ref = *refs; ref; ref = next) {
>> next = ref->next;
>> if (!memcmp(ref->name, "refs/", 5)&&
>> - check_refname_format(ref->name + 5, 0))
>> + check_refname_format(ref->name, 0))
>
> The patch looks fine to me.
>
> This combination "!memcmp(ref->name, "refs/", 5) &&
> check_refname_format(ref->name, 0)" is the reason that I suggested
> adding a REFNAME_FULL option [1], in which case it could be written
> "check_refname_format(ref->name, REFNAME_FULL)". However, now I think
> that the options should be constructed a little differently:
>
> flags==0: Require refname to start with "refs/"
>
> flags==REFNAME_ALLOW_SPECIAL: Also accept single-level ALL_CAPS refnames.
>
> flags==REFNAME_ALLOW_PARTIAL: Don't check the namespace or require '/').
> This could be used for checking partial names like "master" as shorthand
> for "refs/master".
>
> Does this sound reasonable to you?

Oops; I just realized that this particular example doesn't check "starts 
with "refs/" and valid refname" as expected.  In fact it checks "starts 
with "refs/" and INVALID refname".  The proposed REFNAME_FULL option 
would of course be equivalent to the former.  (Why the latter is needed 
here is something that needs a larger investment of time to figure out.)

The other examples that you patched do the expected combination of checks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
