From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: prevent warning in summary output
Date: Mon, 19 Aug 2013 23:17:31 +0200
Message-ID: <52128B6B.6090604@web.de>
References: <1376847095-767956-1-git-send-email-sandals@crustytoothpaste.net> <5211D3AA.6060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, gitster@pobox.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 23:17:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBWpV-0001KI-FF
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 23:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070Ab3HSVRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 17:17:34 -0400
Received: from mout.web.de ([212.227.17.11]:59833 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab3HSVRd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 17:17:33 -0400
Received: from [192.168.178.41] ([91.3.132.244]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Lfj2k-1VqgCH4B2o-00pNk7 for <git@vger.kernel.org>;
 Mon, 19 Aug 2013 23:17:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <5211D3AA.6060403@gmail.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:8j2p6g+Re2S9iWl3uGdf2JsC+JggGDSexY6Nkh0JxtrxXmDYmOb
 WSqKNsYdUw2qrTy9nf22iu8ZIMbnPvSwQhJQ9xeYKCLX8B9VWM6t4NqNw1Q8w3II/xaYqYJ
 gIzJa65TP4cjGqiDRFPwEPDWQzCHHcnlxJc/3z9/+nvIzxcmuJid6dEj4gl1aGESrlKtBWr
 x66W6Xc8XtXmsuKFpVt4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232569>

Am 19.08.2013 10:13, schrieb Chris Packham:
> Hi Brian,
> On 19/08/13 05:31, brian m. carlson wrote:
>> When git submodule summary is run and there is a deleted submodule, there is an
>> warning from git rev-parse:
>>
>>   fatal: Not a git repository: '.vim/pathogen/.git'
>>
>> Silence this warning, since it is fully expected that a deleted submodule will
>> not be a git repository.
>>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>>  git-submodule.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 2979197..66ee621 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -1071,7 +1071,7 @@ cmd_summary() {
>>  		missing_dst=
>>  
>>  		test $mod_src = 160000 &&
>> -		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
>> +		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null 2>&1 &&
>>  		missing_src=t
>>  
>>  		test $mod_dst = 160000 &&
>>
> 
> I wonder if there are other useful errors this will silence
> unintentionally. Perhaps this would be better (untested)
> 
>  test $mod_src = 160000 &&
>  test -e "$name/.git" &&
>  ! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 /dev/null &&
>   missing_src=t
> 
> Having said that there are precedents for both in git-submodule.sh. If
> there aren't any errors worth catching here then your way is probably
> cleaner than mine.

I'd prefer a way to not drop all errors too. We should be able to use
the status variable to see if the submodule is deleted and then skip
the rev-parse all together, or am I missing something here?
