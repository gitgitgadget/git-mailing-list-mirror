From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 7/7] git grep: honor textconv by default
Date: Wed, 24 Apr 2013 12:05:51 +0200
Message-ID: <5177AE7F.1040400@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net> <043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net> <7vwqrtjmtx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 12:05:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUwaE-0003TP-2y
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 12:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758055Ab3DXKFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 06:05:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40508 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758046Ab3DXKFo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 06:05:44 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 03FC2201DE;
	Wed, 24 Apr 2013 06:05:44 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 24 Apr 2013 06:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=zyQBEKCbRrj2LwKlP5RefP
	CGWm0=; b=gb0OovC242mryH4ax5yTfyXrs4cArztdunXnD4GAemE3cwoF40QxxH
	AwR4ES83cg7KvsoBMbzYX1ozVBdi3q7fBDRPxSEWyHyepO2c+8JMRW3YAPaj2cq4
	NgA7z20iP6imXNBAOvcRbZw2BjSMb/NwIWW/OY6hiC+pYJOjauYOQ=
X-Sasl-enc: wuljEB2LWahnsGSplbJOHSYCMzXkdwoHxBamwIYFzlSu 1366797943
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1D08A2000B3;
	Wed, 24 Apr 2013 06:05:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <7vwqrtjmtx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222245>

Junio C Hamano venit, vidit, dixit 23.04.2013 17:20:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, "git grep" does not honor textconv settings by default.
>> Make it honor them by default just like "git log --grep" does.
> 
> "git log --grep" looks for strings in the log message which never
> goes through textconv filters.
> 
> Puzzled....
> 
> If you meant -S/-G, it justifies use of textconv because we are
> generating diff and the user defines textconv to get a reasonable
> output for otherwise undiffable contents.

Sorry, yes, I meant "log grep diff", aka "log -S/-G".

> I do not know if it is sensible to apply textconv by default for
> "grep" (or for that matter "git show" that gives blob contents).

Well, that is the discussion that we were having, with no real end
result, which is why I haven't implemented this differently yet.

My point is that we apply textconv on "log diff greps" already, so why
should't we on content greps?

The question is really whether we should treat "content" similar to
"diff", that's question both when comparing "git log -S" to "git grep"
and "git show <commit>" to "git show <blob>".

My choice is clear, but others seem torn.

For "git grep", implementing a "no-textconv" default is simple, but for
"git show <blob>" this appears to be cumbersome to me.

>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  Documentation/git-grep.txt | 2 +-
>>  grep.c                     | 2 ++
>>  t/t7008-grep-binary.sh     | 4 ++--
>>  3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
>> index a5c5a27..f54ac0c 100644
>> --- a/Documentation/git-grep.txt
>> +++ b/Documentation/git-grep.txt
>> @@ -82,10 +82,10 @@ OPTIONS
>>  
>>  --textconv::
>>  	Honor textconv filter settings.
>> +	This is the default.
>>  
>>  --no-textconv::
>>  	Do not honor textconv filter settings.
>> -	This is the default.
>>  
>>  -i::
>>  --ignore-case::
>> diff --git a/grep.c b/grep.c
>> index c668034..161d3f0 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -31,6 +31,7 @@ void init_grep_defaults(void)
>>  	opt->max_depth = -1;
>>  	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
>>  	opt->extended_regexp_option = 0;
>> +	opt->allow_textconv = 1;
>>  	strcpy(opt->color_context, "");
>>  	strcpy(opt->color_filename, "");
>>  	strcpy(opt->color_function, "");
>> @@ -134,6 +135,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
>>  	opt->pathname = def->pathname;
>>  	opt->regflags = def->regflags;
>>  	opt->relative = def->relative;
>> +	opt->allow_textconv = def->allow_textconv;
>>  
>>  	strcpy(opt->color_context, def->color_context);
>>  	strcpy(opt->color_filename, def->color_filename);
>> diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
>> index 10b2c8b..2fc9d9c 100755
>> --- a/t/t7008-grep-binary.sh
>> +++ b/t/t7008-grep-binary.sh
>> @@ -156,7 +156,7 @@ test_expect_success 'setup textconv filters' '
>>  	git config diff.foo.textconv "\"$(pwd)\""/nul_to_q_textconv
>>  '
>>  
>> -test_expect_failure 'grep does not honor textconv' '
>> +test_expect_success 'grep does honor textconv' '
>>  	echo "a:binaryQfile" >expect &&
>>  	git grep Qfile >actual &&
>>  	test_cmp expect actual
>> @@ -172,7 +172,7 @@ test_expect_success 'grep --no-textconv does not honor textconv' '
>>  	test_must_fail git grep --no-textconv Qfile
>>  '
>>  
>> -test_expect_failure 'grep blob does not honor textconv' '
>> +test_expect_success 'grep blob does honor textconv' '
>>  	echo "HEAD:a:binaryQfile" >expect &&
>>  	git grep Qfile HEAD:a >actual &&
>>  	test_cmp expect actual
