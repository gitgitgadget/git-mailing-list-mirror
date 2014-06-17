From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 01/14] test-lib: add test_dir_is_empty()
Date: Tue, 17 Jun 2014 18:47:07 +0200
Message-ID: <53A0710B.2060202@web.de>
References: <539DD029.4030506@web.de> <539DD068.6020301@web.de> <xmqq7g4gpl1g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 18:47:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwwXq-0003c8-L8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 18:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965493AbaFQQrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 12:47:33 -0400
Received: from mout.web.de ([212.227.15.4]:64222 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965256AbaFQQrc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 12:47:32 -0400
Received: from [192.168.178.41] ([84.132.188.209]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LmQS2-1WOR4F0cza-00a0HA; Tue, 17 Jun 2014 18:47:13
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq7g4gpl1g.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Mq6fqk8ctc9f2RXrf9v7a87y18vMfxlLqlQQimZ4xAFvtkMKXAh
 AcvYJNfbOK5LfRqu3RY2igxav6+vzIQpP97SA0BjJLlGhrpYEJrMagfZY3hmulVJxhSJGpT
 IWCCBGVyQrlwzN1FMDNc2KNlhVGs5XnHENTxt2GbpLrVA4tF4ngYV028am/OL0YtmcmwQE7
 L4fcmklZ4WBroE9QtT/cQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251921>

Am 17.06.2014 00:05, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> For the upcoming submodule test framework we often need to assert that an
>> empty directory exists in the work tree. Add the test_dir_is_empty()
>> function which asserts that the given argument is an empty directory.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>>  t/test-lib-functions.sh | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index 158e10a..546f0a6 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -489,6 +489,17 @@ test_path_is_dir () {
>>  	fi
>>  }
>>
>> +# Check if the directory exists and is empty as expected, barf otherwise.
>> +test_dir_is_empty () {
>> +	test_path_is_dir "$1" &&
>> +	if test "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
> 
> It is safer to say "test -n" when testing an emptyness of a string
> whose contents you do not know or control (e.g. the string may begin
> with "-something").

Yup, will do so in v2.

>> +	then
>> +		echo "Directory '$1' is not empty, it contains:"
>> +		ls -la "$1"
>> +		return 1
>> +	fi
>> +}
>> +
>>  test_path_is_missing () {
>>  	if [ -e "$1" ]
>>  	then
> 
