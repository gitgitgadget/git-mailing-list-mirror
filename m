Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C791F45F
	for <e@80x24.org>; Wed,  8 May 2019 17:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfEHRw0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 13:52:26 -0400
Received: from mail-gateway-shared13.cyon.net ([194.126.200.66]:51282 "EHLO
        mail-gateway-shared13.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbfEHRw0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 May 2019 13:52:26 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared13.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1hOQjt-0003mn-Nm
        for git@vger.kernel.org; Wed, 08 May 2019 19:52:23 +0200
Received: from [10.20.10.230] (port=12676 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1hOQjs-00ALK8-HD; Wed, 08 May 2019 19:52:20 +0200
Subject: Re: [PATCH v2 2/2] format-patch: teach format.notes config option
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1556388260.git.liu.denton@gmail.com>
 <cover.1557327652.git.liu.denton@gmail.com>
 <fe674bf63e8d5b8a06a3f880db4dc4bcfd2183f6.1557327652.git.liu.denton@gmail.com>
 <dbd01507-d56e-4353-c953-f0b05dfdf510@drbeat.li>
 <20190508173122.GA23712@archbookpro.localdomain>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <d5dc0655-9753-6343-2235-6cbd1bd2e198@drbeat.li>
Date:   Wed, 8 May 2019 19:52:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508173122.GA23712@archbookpro.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.05.19 19:31, Denton Liu wrote:
> Hi Beat,
> 
> On Wed, May 08, 2019 at 07:18:18PM +0200, Beat Bolli wrote:
>> On 08.05.19 17:02, Denton Liu wrote:
>>> In git-format-patch, notes can be appended with the `--notes` option.
>>> However, this must be specified by the user on an
>>> invocation-by-invocation basis. If a user is not careful, it's possible
>>> that they may forget to include it and generate a patch series without
>>> notes.
>>>
>>> Teach git-format-patch the `format.notes` config option its value is a
>>
>> s/its/. Its/
>>
>>> notes ref that will be automatically be appended. The special value of
>>
>> Drop the second "be ".
> 
> Thanks, I should've read through the log message more carefully before
> sending.
> 
>>
>>> "standard" can be used to specify the standard notes. This option is
>>> overridable with the `--no-notes` option in case a user wishes not to
>>> append notes.
>>>
>>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>>> ---
>>> One thing I'm worried about is that I'm not really sure using "standard"
>>> as the special value is a good idea. Would "auto" be a better special
>>> value?
>>>
>>>  Documentation/config/format.txt    | 13 ++++++
>>>  Documentation/git-format-patch.txt |  3 ++
>>>  builtin/log.c                      | 18 +++++++-
>>>  t/t4014-format-patch.sh            | 70 ++++++++++++++++++++++++++++++
>>>  4 files changed, 103 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
>>> index dc77941c48..e25f9cfc61 100644
>>> --- a/Documentation/config/format.txt
>>> +++ b/Documentation/config/format.txt
>>> @@ -85,3 +85,16 @@ format.outputDirectory::
>>>  format.useAutoBase::
>>>  	A boolean value which lets you enable the `--base=auto` option of
>>>  	format-patch by default.
>>> +
>>> +format.notes::
>>> +	A ref which specifies where to get the notes (see
>>> +	linkgit:git-notes[1]) that are appended for the commit after the
>>> +	three-dash line.
>>> ++
>>> +If the special value of "standard" is specified, then the standard notes
>>> +ref is used (i.e. the notes ref used by `git notes` when no `--ref`
>>> +argument is specified). If one wishes to use the ref
>>> +`ref/notes/standard`, please use that literal instead.
>>> ++
>>> +This configuration can be specified multiple times in order to allow
>>> +multiple notes refs to be included.
>>> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
>>> index 2c3971390e..9ce5b8aaee 100644
>>> --- a/Documentation/git-format-patch.txt
>>> +++ b/Documentation/git-format-patch.txt
>>> @@ -275,6 +275,9 @@ these explanations after `format-patch` has run but before sending,
>>>  keeping them as Git notes allows them to be maintained between versions
>>>  of the patch series (but see the discussion of the `notes.rewrite`
>>>  configuration options in linkgit:git-notes[1] to use this workflow).
>>> ++
>>> +The default is `--no-notes`, unless the `format.notes` configuration is
>>> +set.
>>>  
>>>  --[no-]signature=<signature>::
>>>  	Add a signature to each message produced. Per RFC 3676 the signature
>>> diff --git a/builtin/log.c b/builtin/log.c
>>> index e43ee12fb1..24954e42b0 100644
>>> --- a/builtin/log.c
>>> +++ b/builtin/log.c
>>> @@ -779,6 +779,8 @@ enum {
>>>  
>>>  static int git_format_config(const char *var, const char *value, void *cb)
>>>  {
>>> +	struct rev_info *rev = cb;
>>> +
>>>  	if (!strcmp(var, "format.headers")) {
>>>  		if (!value)
>>>  			die(_("format.headers without value"));
>>> @@ -864,6 +866,20 @@ static int git_format_config(const char *var, const char *value, void *cb)
>>>  			from = NULL;
>>>  		return 0;
>>>  	}
>>> +	if (!strcmp(var, "format.notes")) {
>>> +		struct strbuf buf = STRBUF_INIT;
>>> +
>>> +		rev->show_notes = 1;
>>> +		if (!strcmp(value, "standard"))
>>> +			rev->notes_opt.use_default_notes = 1;
>>> +		else {
>>
>> Use braces on both parts of the "if", if one part needs them.
> 
> I thought that the style preference in this project is to not use braces
> whenever it's unnecessary, even if it's on just one arm of an if-else.

No, Documentation/CodingGuidelines mentions this case explicitly. Search
for "multiple arms".

ATB, Beat

