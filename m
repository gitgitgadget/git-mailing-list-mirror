From: =?ISO-8859-1?Q?Laurent_Charri=E8re?= <lcharriere@promptu.com>
Subject: Re: git-p4 useclientspec broken?
Date: Tue, 14 Feb 2012 15:25:44 -0800
Message-ID: <4F3AED78.7010500@promptu.com>
References: <4F39AF04.5080607@promptu.com> <20120214123632.GA5285@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 00:25:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRkr-0004KK-IC
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 00:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761320Ab2BNXZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 18:25:45 -0500
Received: from moat.promptu.com ([209.234.175.58]:44342 "EHLO
	pacman.mp.promptu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757246Ab2BNXZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 18:25:44 -0500
Received: from [192.168.0.95] (unknown [192.168.0.95])
	by pacman.mp.promptu.com (Postfix) with ESMTP id 4B2EC20185;
	Tue, 14 Feb 2012 15:25:44 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120214123632.GA5285@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190795>

On 2/14/12 4:36 AM, Pete Wyckoff wrote:
> lcharriere@promptu.com wrote on Mon, 13 Feb 2012 16:47 -0800:
>> $ git p4 clone //sandbox/lcharriere/foo --use-client-spec
>> $ cd foo&&  find .
>> ./.git
>> (...)
>> ./sandbox/lcharriere/foo/.gitignore
>> ./sandbox/lcharriere/foo/foo.py
>>
>> -- This is new behavior to me, BTW. Previously, I would have seen
>> ./.git
>> (...)
>> ./.gitignore
>> ./foo.py
>
...
>
> The client spec now has absolute control over what files get put
> where in the git repo, just like in p4.  The argument
> "//sandbox/lcharriere/foo" in your clone command limits the scope
> of what is checked out, but does not affect where it is placed.
>
...
>
> Is this new behavior bad for you?  Suggestions welcome.

I like the new behavior just fine. I think it's more consistent with how 
p4 operates. I just wanted to point out the change in behavior, because 
I had not seen it called out, and it seemed relevant to my bug report.
The only disadvantage of the new behavior, IMHO, is the associated 
transition. When If you have an 'old-style' repo and do a git p4 rebase 
with 1.7.9, you find yourself in a situation where files are in two 
location, e.g. ./gitignore and ./sandbox/lcharriere/foo/.gitignore. So 
really you need to re-clone from p4. Not a big deal, but it is a little 
surprising.

>> $ cat "test">>  sandbox/lcharriere/foo/.gitignore
>> $ git commit -a -m "test"
>> git commit -a -m "test"
>> [master 7398144] test
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>> $ git p4 submit
>> Perforce checkout for depot path //sandbox/lcharriere/foo/ located
>> at /Users/lcharriere/Documents/Perforce/all/sandbox/lcharriere/foo/
>> Synchronizing p4 checkout...
>> ... - file(s) up-to-date.
>> Applying 739814457a8faa84dc0bddd830f671569576b177 test
>>
>> sandbox/lcharriere/foo/.gitignore - file(s) not on client.
>> error: sandbox/lcharriere/foo/.gitignore: No such file or directory
>> Unfortunately applying the change failed!
>> What do you want to do?
>> [s]kip this patch / [a]pply the patch forcibly and with .rej files /
>> [w]rite the patch to a file (patch.txt)
>
> This is definitely a bug.  I reproduced a similar problem.
>
...
> I'll get a patch out tonight or soon.  Need to do gobs of testing
> on the submit path to make sure nothing else is broken.

Thanks, I appreciate your prompt reply.
