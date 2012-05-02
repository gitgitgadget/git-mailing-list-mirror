From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT] [PATCH] Handle empty patches and patches with only a
 header.
Date: Wed, 02 May 2012 08:27:33 +0200
Message-ID: <4FA0D3D5.5080004@opera.com>
References: <87haw1342k.fsf@opera.com> <20120430164841.GG20761@poseidon.cudanet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ceder@lysator.liu.se
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed May 02 08:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPT2T-0001Bd-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 08:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab2EBG1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 02:27:44 -0400
Received: from smtp.opera.com ([213.236.208.81]:47765 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755763Ab2EBG1n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 02:27:43 -0400
Received: from [10.30.1.61] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q426RY2u028502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 May 2012 06:27:36 GMT
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
In-Reply-To: <20120430164841.GG20761@poseidon.cudanet.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196787>

On 04/30/2012 06:48 PM, Jeff Sipek wrote:
> On Mon, Apr 30, 2012 at 12:29:55PM +0200, Per Cederqvist wrote:
>> "git apply --numstat" in Git 1.7.10 gives an error message unless the
>> patch contains a diff, so don't attempt to apply it unless we find a
>
> Find a what?  Such a cliff-hanger! :)
>
> I assume you mean find a '^diff'.

Yes. Initially, I searched for "@@" and the commit message
said "diff hunk", but that heuristic failed if you had a
patch that just changed the mode of a single file.  So I
changed the patch to search for "^diff" instead, and
apparently got distracted while editing the commit message.

     /cederp

> I'll fix up the commit message before applying.
>
> Thanks,
>
> Jeff.
>
>> Signed-off-by: Per Cederqvist<cederp@opera.com>
>> ---
>>   guilt |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/guilt b/guilt
>> index 5d619c5..66a671a 100755
>> --- a/guilt
>> +++ b/guilt
>> @@ -622,7 +622,7 @@ push_patch()
>>   		cd_to_toplevel
>>
>>   		# apply the patch if and only if there is something to apply
>> -		if [ `git apply --numstat "$p" | wc -l` -gt 0 ]; then
>> +		if grep -q '^diff ' "$p"&&  [ `git apply --numstat "$p" | wc -l` -gt 0 ]; then
>>   			if [ "$bail_action" = abort ]; then
>>   				reject=""
>>   			fi
>> --
>> 1.7.10
>>
>
