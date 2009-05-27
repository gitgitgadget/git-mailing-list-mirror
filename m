From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH RESEND] Git.pm: Always set Repository to absolute path
 if autodetecting
Date: Wed, 27 May 2009 13:16:16 +0200
Message-ID: <4A1D2100.5040903@viscovery.net>
References: <1241703688-6892-1-git-send-email-frank@lichtenheld.de> <1241703688-6892-2-git-send-email-frank@lichtenheld.de> <4A1A49C0.7040102@viscovery.net> <20090527105454.GW17706@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed May 27 13:20:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9HAw-0008R4-2U
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 13:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762811AbZE0LQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 07:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762851AbZE0LQ3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 07:16:29 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40675 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762906AbZE0LQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 07:16:27 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M9H7N-0004FO-Ha; Wed, 27 May 2009 13:16:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3345C795; Wed, 27 May 2009 13:16:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090527105454.GW17706@mail-vs.djpig.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120056>

Frank Lichtenheld schrieb:
> On Mon, May 25, 2009 at 09:33:20AM +0200, Johannes Sixt wrote:
>> Frank Lichtenheld schrieb:
>>> --- a/perl/Git.pm
>>> +++ b/perl/Git.pm
>>> @@ -185,7 +185,7 @@ sub repository {
>>>  
>>>  		if ($dir) {
>>>  			$dir =~ m#^/# or $dir = $opts{Directory} . '/' . $dir;
>>> -			$opts{Repository} = $dir;
>>> +			$opts{Repository} = abs_path($dir);
>> Unfortunately, this change breaks MinGW git because the absolute path that
>> this produces is MSYS-style /c/path/to/repo, but git does not understand
>> this; it should be c:/path/to/repo. This value is ultimately assigned to
>> GIT_DIR, but the path name mangling that usually happens when an MSYS
>> program (like perl) spawns a non-MSYS program (like git) does not happen.
>>
>> Your commit message is quite vague about the problems that you have seen.
>> I vote to revert this change.
> 
> Note that abs_path is already used twice in the same function. Why are those
> usages not problematic? I would be happy to work with you on finding a patch
> that doesn't break, but I have to admit that I have no idea of the
> Windows<->Perl<->git interactions.

The result of abs_path() three lines below the cited context is never
passed to git; only its trailing part is ever used. This does not seem to
be problematic on Windows, according to the test suite.

The other use if abs_path() is about bare repositories and that is
certainly problematic, but nobody uses the tools written in perl in a bare
repository on Windows, obviously, otherwise we would have heard complaints. ;)

> As for the problems, a part of the public API of the module simply doesn't work
> (i.e. wc_chdir) which I fixed. If we can't fix it we should at least not pretend
> that it works.

Since you keep repeating "does not work", without any specifics, I can't
help (and I'm not going to find out myself what "does not work").

-- Hannes
