From: Beat Bolli <dev@drbeat.li>
Subject: Re: [PATCH v2 2/5] update_unicode.sh: set UNICODE_DIR only once
Date: Tue, 23 Dec 2014 01:32:43 +0100
Message-ID: <5498B82B.9090505@drbeat.li>
References: <1419006264-24741-1-git-send-email-dev+git@drbeat.li>	<1419006264-24741-2-git-send-email-dev+git@drbeat.li> <xmqqk31ja7h3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, dev+git@drbeat.li
X-From: git-owner@vger.kernel.org Tue Dec 23 01:39:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3DVU-0001n0-5w
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 01:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbaLWAjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 19:39:19 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:36041 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973AbaLWAjT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 19:39:19 -0500
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Dec 2014 19:39:19 EST
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id D5788C3442;
	Tue, 23 Dec 2014 01:29:06 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcmini.bolli (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id AD416C343E;
	Tue, 23 Dec 2014 01:29:06 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqk31ja7h3.fsf@gitster.dls.corp.google.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261704>

On 22.12.14 19:02, Junio C Hamano wrote:
> dev+git@drbeat.li writes:
> 
>> From: Beat Bolli <dev+git@drbeat.li>
>>
>> The value is the same on both uniset invocations, so "Don't Repeat
>> Yourself" applies.
>>
>> Since we're in a subshell already, there's no need to unset UNICODE_DIR
>> at the end.
> 
> Strictly speaking, you are not introducing your own subshell to
> prevent the environment from leaking (i.e. you used "{...}" not
> "(...)" in the previous step).  The reason you can do this is
> because the generation of UNICODEWIDTH_H file is the last thing in
> the subshell.

I don't introduce a new one, but we're still in the outer subshell that
starts on line 12 "( cd unicode &&".

> 
> I'll reword it to "Since this is done as the last command, ..."
> 
> Thanks.
> 
>>
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>  update_unicode.sh | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/update_unicode.sh b/update_unicode.sh
>> index c1c876c..bed8916 100755
>> --- a/update_unicode.sh
>> +++ b/update_unicode.sh
>> @@ -27,12 +27,13 @@ fi &&
>>  		fi &&
>>  		make
>>  	) && {
>> +		UNICODE_DIR=. && export UNICODE_DIR &&
>>  		echo "static const struct interval zero_width[] = {" &&
>> -		UNICODE_DIR=. ./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
>> +		./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
>>  		grep -v plane &&
>>  		echo "};" &&
>>  		echo "static const struct interval double_width[] = {" &&
>> -		UNICODE_DIR=. ./uniset/uniset --32 eaw:F,W &&
>> +		./uniset/uniset --32 eaw:F,W &&
>>  		echo "};"
>>  	} >$UNICODEWIDTH_H
>>  )
