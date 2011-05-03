From: Michael Grubb <devel@dailyvoid.com>
Subject: Re: [PATCH 2] Add default merge options for all branches
Date: Tue, 03 May 2011 00:35:34 -0500
Message-ID: <4DBF9426.4090402@dailyvoid.com>
References: <4DBF04C5.1080608@dailyvoid.com> <7voc3kk748.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, vmiklos@frugalware.org, deskinm@umich.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 07:35:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH8Gu-0003H5-8o
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 07:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab1ECFfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 01:35:39 -0400
Received: from 75.98.162.166.static.a2webhosting.com ([75.98.162.166]:56475
	"EHLO dailyvoid.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab1ECFfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 01:35:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dailyvoid.com;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
	b=rXFCeytaSodZaOb7m9d4CnCLZ7B+owBGpIKhplCfj/cPx1AcUi8koi5Lv4Ohe5fp9MKc/LqV95xhGV323h6IbpqZEvf6ZW2HVcIr0gkAttPskm/l/HGWBEOQzSblItbi;
Received: from adsl-99-59-251-170.dsl.ltrkar.sbcglobal.net ([99.59.251.170] helo=macbook.local)
	by a2s24.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <devel@dailyvoid.com>)
	id 1QH8Gl-00060R-Gt; Tue, 03 May 2011 01:35:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7voc3kk748.fsf@alter.siamese.dyndns.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - a2s24.a2hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dailyvoid.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172643>


On 5/2/11 6:36 PM, Junio C Hamano wrote:
> Michael Grubb <devel@dailyvoid.com> writes:
> 
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index 0bdd19a..9e5b6bd 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -505,9 +505,18 @@ cleanup:
>>  
>>  static int git_merge_config(const char *k, const char *v, void *cb)
>>  {
>> -	if (branch && !prefixcmp(k, "branch.") &&
>> -		!prefixcmp(k + 7, branch) &&
>> -		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
>> +	static int branch_merge_options_set = 0;
> 
> I prefer to avoid "static int" that you cannot easily clear here.  It
> would make it impossible to call the function twice.
>
> I think it is easily doable by using the callback parameter (cb).
>
Too right.  I've reworked that bit to use the cb parameter.  With an eye
to the future I've created a new struct for this for future's sake, so
that this one feature doesn't monopolize the cb parameter in the future.
 
> I am also wondering how this will scale, both in the direction of "later
> it is likely that we would want to support a glob not just '*' here", and
> also "later it is likely that we would want to support other per-branch
> variables, not just "mergeoptions" here".
It seems that the easiest way would be to move this particular feature out into
it's own function at some point to pave the way for doing more complex things with
the branch configurations.

New patch forthcoming.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
