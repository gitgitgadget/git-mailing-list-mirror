From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 2/2] branch: allow -f with -m and -d
Date: Fri, 05 Dec 2014 11:57:43 +0100
Message-ID: <54818FA7.7040102@drmicha.warpmail.net>
References: <cover.1417699299.git.git@drmicha.warpmail.net>	<7b1ae15228841d3eaed739e89295ec10a2be45fa.1417699299.git.git@drmicha.warpmail.net> <xmqqh9xbtehw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 11:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwqa5-0003Ci-ON
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 11:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbaLEK5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 05:57:46 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39700 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751065AbaLEK5p (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 05:57:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 8DF0B20914
	for <git@vger.kernel.org>; Fri,  5 Dec 2014 05:57:44 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 05 Dec 2014 05:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Sm0lvocKmm7UyhcFvLf0iY
	h6xQI=; b=uA2tp0ud4UCPkbEx+lPKoD2e39sSXuVRogc3sPvWQ0ZWO+4fVnei9D
	YMPpSiN5juIPrxXGE1nghuhMePL7XPJYV2ZLb4huV9o8rFai3BWtQyvhK5Wk5o1k
	EXy8OGDfhSIdMLUc9UPYtmBnqO1Vi7GmnzfTAMwt0u77dqDUIj2mE=
X-Sasl-enc: ROX+gJiDYWJ7RXA06zEYt3f8q7hSPTelYF4m5P2jj7fY 1417777064
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0D3CBC00280;
	Fri,  5 Dec 2014 05:57:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqh9xbtehw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260867>

Junio C Hamano schrieb am 04.12.2014 um 20:13:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> -f/--force is the standard way to force an action, and is used by branch
>> for the recreation of existing branches, but not for deleting unmerged
>> branches nor for renaming to an existing branch.
>>
>> Make "-m -f" equivalent to "-M" and "-d -f" equivalent to" -D", i.e.
>> allow -f/--force to be used with -m/-d also.
> 
> I like that goal.  And I agree with your s/force_create/force/g
> remark on the cover, too.
> 
> 
> 
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  builtin/branch.c  | 9 +++++++--
>>  t/t3200-branch.sh | 5 +++++
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 3b79c50..8ea04d7 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -848,7 +848,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>  		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
>>  		OPT_BOOL(0, "edit-description", &edit_description,
>>  			 N_("edit the description for the branch")),
>> -		OPT__FORCE(&force_create, N_("force creation (when already exists)")),
>> +		OPT__FORCE(&force_create, N_("force creation, move/rename, deletion")),
>>  		{
>>  			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
>>  			N_("commit"), N_("print only not merged branches"),
>> @@ -891,7 +891,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>  	if (with_commit || merge_filter != NO_FILTER)
>>  		list = 1;
>>  
>> -	if (!!delete + !!rename + !!force_create + !!new_upstream +
>> +	if (!!delete + !!rename + !!new_upstream +
> 
> This puzzled me but earlier -f implied creation and no other mode
> (hence it was an error to give it together with delete and other
> modes), but now -f is merely a "do forcibly whatever mode of
> operation other option determines" that does not conflict.
> 
> What should "-f -u" and "-f -l" do, then, though?
> 
>>  	    list + unset_upstream > 1)
>>  		usage_with_options(builtin_branch_usage, options);
>>  

I would say there is nothing to force, so we ignore -f there.
Alternatively, we could warn about that. While I do consider forcing
something that doesn't need force a mistake in other contexts, I would
not apply that thinking to the -f option.

Michael
