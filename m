From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH] gitk: use mktemp -d to avoid predictable temporary directories
Date: Mon, 16 Jun 2014 13:40:03 +0200
Message-ID: <539ED793.7050409@virtuell-zuhause.de>
References: <1402695828-91537-1-git-send-email-davvid@gmail.com> <87k38ir4p0.fsf@red.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: patthoyts@users.sourceforge.net, David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 13:40:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwVGn-00040A-RM
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 13:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbaFPLkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 07:40:07 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:53735 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282AbaFPLkG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 07:40:06 -0400
Received: from p5ddc3c66.dip0.t-ipconnect.de ([93.220.60.102] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1WwVGd-00032p-Hr; Mon, 16 Jun 2014 13:40:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <87k38ir4p0.fsf@red.patthoyts.tk>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1402918806;d1f7fc50;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251712>

Am 15.06.2014 09:51, schrieb Pat Thoyts:
> David Aguilar <davvid@gmail.com> writes:
> 
>> gitk uses a predictable ".gitk-tmp.$PID" pattern when generating
>> a temporary directory.
>>
>> Use "mktemp -d .gitk-tmp.XXXXXX" to harden gitk against someone
>> seeding /tmp with files matching the pid pattern.
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> This issue was brought up during the first review of the previous patch
>> back in 2009.
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/132609/focus=132748
>>
>> This is really [PATCH 2/2] and should be applied on top of my previous
>> gitk patch.
>>
>> gitk | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/gitk b/gitk
>> index 82293dd..dd2ff63 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -3502,7 +3502,8 @@ proc gitknewtmpdir {} {
>> 	} else {
>> 	    set tmpdir $gitdir
>> 	}
>> -	set gitktmpdir [file join $tmpdir [format ".gitk-tmp.%s" [pid]]]
>> +	set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
>> +	set gitktmpdir [exec mktemp -d $gitktmpformat]
>> 	if {[catch {file mkdir $gitktmpdir} err]} {
>> 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
>> 	    unset gitktmpdir
> 
> This is a problem on Windows where we will not have mktemp. In Tcl 8.6
> the file command acquired a "file tempfile" command to help with this
> kind of issue (https://www.tcl.tk/man/tcl8.6/TclCmd/file.htm#M39) but
> for older versions we should probably stick with the existing pattern at
> least on Windows.

We could of course add mktemp from http://www.mktemp.org to msysgit.
I can do that if required.

In mingwgitDevEnv we already have the the need for mktemp, and a msys
package, so this is also not a problem.
