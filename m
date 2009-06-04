From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 04 Jun 2009 10:35:58 +0200
Message-ID: <op.uuzrh8jr1e62zd@balu.cs.uni-paderborn.de>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
 <20090602195533.6117@nanako3.lavabit.com>
 <7v7hzufxcu.fsf@alter.siamese.dyndns.org> <200906022035.30081.j6t@kdbg.org>
 <7vvdnc37b6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Nanako Shiraishi" <nanako3@lavabit.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 10:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC8Qi-0006JZ-7d
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 10:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZFDIgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 04:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbZFDIf7
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 04:35:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:35100 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751080AbZFDIf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 04:35:57 -0400
Received: (qmail invoked by alias); 04 Jun 2009 08:35:58 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp006) with SMTP; 04 Jun 2009 10:35:58 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18hmcQypbAhPSHj+rCSHpZ7bXufgEk9PWtw1WHah5
	qvN5HWKIMwQfz/
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KKPH7Z-0004O0-BR; Thu, 04 Jun 2009 10:35:59 +0200
In-Reply-To: <7vvdnc37b6.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120685>

Am 04.06.2009, 07:18 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> On Dienstag, 2. Juni 2009, Junio C Hamano wrote:
>>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>>> > Junio, I think you forgot to take a follow-up action on this thread  
>>> after
>>> > sending this message.  The patch favors the git program in the  
>>> current
>>> > directory.
>>>
>>> Indeed, I did, and I think I am Ok with the patch.  Thanks for a
>>> reminder.
>>>
>>> I thought there was an "simplicity" issue raised by J6t that was not
>>> addressed, but after re-reading the thread I do not think it applies
>>> (J6t?)
>>
>> Sorry, I don't recall anymore what I said; but since the thread petered  
>> out, I
>> use this patch in the repository where I share Matthias' 'sudo make  
>> install'
>> problem:
>>
>> Subject: [PATCH] version-gen: Use just built git if no other git is in  
>> PATH
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>>
>> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
>> index 39cde78..4779313 100755
>> --- a/GIT-VERSION-GEN
>> +++ b/GIT-VERSION-GEN
>> @@ -3,6 +3,9 @@
>>  GVF=GIT-VERSION-FILE
>>  DEF_VER=v1.6.3.GIT
>>
>> +# use git that was just compiled if there is no git elsewhere in PATH
>> +PATH=$PATH:.
>> +
>>  LF='
>>  '
>
> I actually think this is much saner and cleaner (it certainly is  
> smaller),
> especially having seen Matthias's v4, which feels a tad overengineered.

It's nothing more than

(a) followed your suggestion to look in $(prefix) first for cross-building  
support

(b) ported to git-gui as well (copy & paste-style)

Also, we certainly do not want to stuff "." in root's PATH, not even for  
simple scripts like GIT-VERSION-GEN.

> I honestly do not understand why we need to bend backwards to cater to
> "sudo".  Real men, when needing to do things as root, have always done
> "su", and _if_ the environment is unsuited for the job, they can do:
>
> 	$ su
>         # PATH=$PATH:/usr/local/bin make prefix=/usr/local install

sudo caches passwords for a couple of minutes, su does not, and su isn't  
available everywhere ("wheel" group on BSD and stuff); particularly, sudo  
is *the* get-root-tool on Ubuntu.

If you argue "real men", then break that damn rebuild cycle and either fix  
dependencies properly, rather than second-guessing in shell scripts at  
"make install" time, or add post-update hooks (or whatever) to update the  
GIT-VERSION-FILE...

"." doesn't belong in root's $PATH, period.

-- 
Matthias Andree
