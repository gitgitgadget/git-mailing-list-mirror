From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Build broken for contrib/remote-helpers...
Date: Tue, 22 Jan 2013 21:55:51 +0100
Message-ID: <50FEFCD7.2060402@web.de>
References: <CAEBDL5U+Yrny-YgN1fZj1T+XTJRVaiFvMixT13Zzb2DhhYgQsA@mail.gmail.com> <20130122194135.GA23521@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 22 21:56:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxktR-00028x-Gw
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 21:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab3AVU4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 15:56:08 -0500
Received: from mout.web.de ([212.227.17.11]:59367 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789Ab3AVU4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 15:56:06 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MPGym-1TtL1z3QFU-0053M4; Tue, 22 Jan 2013 21:55:52
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130122194135.GA23521@sigill.intra.peff.net>
X-Provags-ID: V02:K0:W7dZE0+ahPuHW0kS4gvUTzr1W7PnukMEBux1/9X546A
 9GFq/U52Kb9LjRG2RbAHUAcglzzKZ0nVf23Fxh1c9BHYdbkI/F
 bpImA60DQ05GWgILdy0Q2de95XjmiRYpvWvSQ+P7NlU9uaK9Ta
 IWGfisnhahqpMSJumt03uTpRCn9ah6SnXTRREQ5H8JVt22XVNC
 UrZjEO8L6+UQiZAikQDGg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214250>

On 22.01.13 20:41, Jeff King wrote:
> On Tue, Jan 22, 2013 at 12:49:31AM -0500, John Szakmeister wrote:
> 
>> I tried running make in contrib/remote-helpers and it died with:
>>
>>     :: make
>>     make -e -C ../../t test
>>     rm -f -r test-results
>>     duplicate test numbers: /Users/jszakmeister/sources/git
>>     make[1]: *** [test-lint-duplicates] Error 1
>>     make: *** [test] Error 2
>>
>> The path shown is not quite correct.  I have the sources extracted to
>> /Users/jszakmeister/sources/git-1.8.1.1.  It appears that the Makefile
>> in contrib/remote-helpers is exporting T, which is causing the
>> duplicate test detection to fail.
> 
> It has to set T, because that is how t/Makefile knows what the set of
> tests is. The problem is that test-lint-duplicates does not understand
> absolute pathnames, as its regex is too simplistic:
> 
>   sed 's/-.*//' | sort | uniq -d
> 
> So it finds whatever is before the first "-", which would be the test
> number in "t0000-basic.sh" or similar, and then looks for duplicates.

would it help to filter for numbered tests before sorting like this:

sed 's/-.*//' | grep "[0-9][0-9][0-9][0-9]"| sort | uniq -d
