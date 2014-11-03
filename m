From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Mon, 03 Nov 2014 21:38:55 +0100
Message-ID: <5457E7DF.5070500@web.de>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz> <xmqqegtkrtt9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michal Sojka <sojkam1@fel.cvut.cz>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:39:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlOP9-0007GP-9q
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 21:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbaKCUjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 15:39:08 -0500
Received: from mout.web.de ([212.227.15.4]:58911 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624AbaKCUjF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 15:39:05 -0500
Received: from [192.168.178.41] ([79.211.117.185]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M0w07-1Y33oS2tGZ-00v7cj; Mon, 03 Nov 2014 21:38:59
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqegtkrtt9.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:vig2lJ7IOqelUdCT9tCUEctsL/i4PuEtXBKp88yUSrLVmZ1nOCx
 TndXEzMrqIkNZATzRU4yJev0UE5JKaiieytMW3J/q1OpBTa90QkRQmy4YrjiMcQQjj0VugZ
 Ony6h1sMB3ObZHIBzlTTCCVfxj3ztQFEmv3tZp0eDB+8N8cAPLkJ+8+B6EeHF7W6uUkn/ah
 UZUyMY6Ve6BJxyxTYIiKQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.11.2014 um 20:02 schrieb Junio C Hamano:
> Michal Sojka <sojkam1@fel.cvut.cz> writes:
>
>> The documentation says that submodule.$name.update can be overridden by
>> --checkout only if its value is `none`. This is not true, because both
>> implementation and documentation of --checkout specifies that the
>> override applies to all possible values.
>>
>> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
>> ---
>>   Documentation/git-submodule.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 8e6af65..84ab577 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -158,7 +158,7 @@ update::
>>   	checkout the commit specified in the index of the containing repository.
>>   	This will make the submodules HEAD be detached unless `--rebase` or
>>   	`--merge` is specified or the key `submodule.$name.update` is set to
>> -	`rebase`, `merge` or `none`. `none` can be overridden by specifying
>> +	`rebase`, `merge` or `none`. This can be overridden by specifying
>>   	`--checkout`. Setting the key `submodule.$name.update` to `!command`
>>   	will cause `command` to be run. `command` can be any arbitrary shell
>>   	command that takes a single argument, namely the sha1 to update to.
>
> Thanks.  This looks sensible, judging only from the text (iow I
> didn't check if there were legitimate reason why rebase/merge
> settings should not be overriden from the command line).

This was introduced in e6a1c43aaf (document submdule.$name.update=none
option for gitmodules), and I agree with Michal that we should fix it.
But I think we should rather say "This can be overridden by specifying
'--merge', '--rebase' or `--checkout`." here, as the other two options
also override the update setting. So I think we should queue this:

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..84ab577 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -158,7 +158,7 @@ update::
  	checkout the commit specified in the index of the containing repository.
  	This will make the submodules HEAD be detached unless `--rebase` or
  	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`. `none` can be overridden by specifying
+	`rebase`, `merge` or `none`. This can be overridden by using '--merge',
+	'--rebase' or
  	`--checkout`. Setting the key `submodule.$name.update` to `!command`
  	will cause `command` to be run. `command` can be any arbitrary shell
  	command that takes a single argument, namely the sha1 to update to.

Apart from that I'm all for it.
