From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: t5570 trap use in start/stop_git_daemon
Date: Fri, 13 Feb 2015 07:27:01 -0500
Message-ID: <019d01d04788$5e923970$1bb6ac50$@nexbridge.com>
References: <013601d04702$d7e721e0$87b565a0$@nexbridge.com> <20150213074403.GB26775@peff.net> <20150213080359.GC26775@peff.net> <loom.20150213T094712-477@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Joachim Schmitz'" <jojo@schmitz-digital.de>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 13:27:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMFL1-0005m2-Cx
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 13:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbbBMM1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 07:27:09 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55632 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbbBMM1I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 07:27:08 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t1DCR2go073086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Feb 2015 07:27:03 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <loom.20150213T094712-477@post.gmane.org>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLlk6fgg9R2/EmQ48FysdiY4jUl5QEp0JxQAcjRYWECu7j74ZqWdPYg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263807>

On 2015/02/13 3:58AM Joachim Schmitz wrote:
>Jeff King <peff <at> peff.net> writes:
> > On Fri, Feb 13, 2015 at 02:44:03AM -0500, Jeff King wrote:
> > On Thu, Feb 12, 2015 at 03:31:12PM -0500, Randall S. Becker wrote:
> > 
><snip> 
>> Hmm, today I learned something new about ksh. Apparently when you use
>> the "function" keyword to define a function like:
>> 
>>   function foo {
>>     trap 'echo trapped' EXIT
>>   }
>>   echo before
>>   foo
>>   echo after
>> 
>> then the trap runs when the function exits! If you declare the same
>> function as:
>> 
>>   foo() {
>>     trap 'echo trapped' EXIT
>>   }
>> 
>> it behaves differently. POSIX shell does not have the function keyword,
>> of course, and we are not using it here. Bash _does_ have the function
>> keyword, but seems to behave POSIX-y even when it is present. I.e.,
>> running the first script:
>> 
>>   $ ksh foo.sh
>>   before
>>   trapped
>>   after
>> 
>>   $ bash foo.sh
> >  before
>>   after
> >  trapped
>> 
<snip>
>Both versions produce your first output on our platform
>$ ksh foo1.sh
>before
>trapped
>after
>$ bash foo1.sh
>before
>after
>trapped
>$ ksh foo2.sh
>before
>trapped
>after
>$ bash foo2.sh
>before
>after
>trapped
>$
>This might have been one (or even _the_) reason why we picked bash as our 
>SHELL_PATH in config.mak.uname (I don't remember, it's more than 2 years 
>ago), not sure which shell Randall's test used?

I tested both for trying to get t5570 to work. No matter which, without
resetting the trap, function return would kill the git-daemon and the test
would fail.
