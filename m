From: Peter <vmail@mycircuit.org>
Subject: Re: gitignore: how to exclude a directory tree from being ignored
Date: Thu, 01 Oct 2009 18:26:58 +0200
Message-ID: <4AC4D852.8000502@mycircuit.org>
References: <4AC48D5F.6060401@mycircuit.org> <4AC4A310.8000507@viscovery.net> <4AC4A7EF.9030002@mycircuit.org> <4AC4AD25.5010708@viscovery.net> <4AC4C125.10609@mycircuit.org> <4AC4C9DB.2090907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 01 18:27:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtOUm-0004h7-Kl
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 18:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbZJAQ06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 12:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965AbZJAQ06
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 12:26:58 -0400
Received: from mailfe11.tele2.ch ([212.247.155.72]:49627 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752382AbZJAQ05 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 12:26:57 -0400
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=L3Mu2x56dNAA:10 a=vWKxTcPCt1ggqAQrsOHYvw==:17 a=0LeESPBJFmKeVGxx8cQA:9 a=_wQltjX-fWZVbkZhZH4A:7 a=-02lmN1T92WHYqAhE_nnzyHY-2kA:4
Received: from mail.mycircuit.org (account cxu-8g8-ypb@tele2.ch [188.155.226.135] verified)
  by mailfe11.swip.net (CommuniGate Pro SMTP 5.2.16)
  with ESMTPA id 1143634939; Thu, 01 Oct 2009 18:26:59 +0200
Received-SPF: none
 receiver=mailfe11.swip.net; client-ip=188.155.226.135; envelope-from=vmail@mycircuit.org
Received: from [192.168.1.193] (unknown [192.168.1.193])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "p_email", Issuer "192.168.2.2" (verified OK))
	by mail.mycircuit.org (Postfix) with ESMTP id 79ECDCFA43;
	Thu,  1 Oct 2009 18:26:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
In-Reply-To: <4AC4C9DB.2090907@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129398>

Johannes Sixt wrote:
> Peter schrieb:
>   
>>>> 1) I can't have just one .gitignore file in the root dir, if I want to
>>>> _recursively_ inverse the exclude pattern for a sub dir tree.
>>>>     
>>>>         
>>> No, it's not the inversion of the pattern, but the slash (if it is not at
>>> the end) that makes the pattern non-recursive.
>>>
>>>   
>>>       
>> from the gitignore manpage:
>>     
>>>> If the pattern ends with a slash, it is removed for the purpose of
>>>>         
>> the following description, but it would only find a match with a
>> directory. In other words, foo/ will match a directory foo and paths
>> underneath it, but will not match a regular file or a symbolic link foo
>> (this is consistent with the way how pathspec works in general in git). <<
>>
>> Doesn't this mean, that if I say:
>> vendor/
>> matches the directory and ( recursively ) the paths underneath it.?
>>     
>
> The paragraph you are citing is talking about *what* the pattern matches,
> but it says nothing about *where* the pattern matches.
>
> When I was saying "recursively", then I was refering to the "where"
> aspect, not the "what" aspect.
>
> If you have directories
>
>    src/bar/vendor/
>    src/foo/bar/vendor/
>    src/vendor/
>
> and you have the file src/.gitignore with the single pattern
>
>    vendor/
>
> then it applies to recursively ("where") these directories:
>
>    src/bar/vendor/
>    src/foo/bar/vendor/
>    src/vendor/
>
> and everything ("what") below them.
>
> But if the same src/.gitignore has only this pattern:
>
>    bar/vendor/
>
> then it will not match ("where") recursively and only apply to
>
>    src/bar/vendor/
>
> and everything ("what") below it, but will not apply to
>
>    src/foo/bar/vendor/
>
>   
>> And, consequently:
>> !vendor/
>> inverse the exclusion for vendor ( that is: include ) and everything
>> that is contained in it ? ( This is obviously not the case, but this is
>> what I would expect )
>>     
>
> You should update your expectations. ;-)
>
> You think that git starts with the .gitignore files, and somehow applies
> the rules that it finds to all files (perhaps recursively).
>
> But it does not work like this; rather it is in the oppsite direction: git
> starts with a file name, and then checks the rules in the .gitignore files
> that it has available.
>
> For example, take the path "src/vendor/foo.exe". git finds the file
> src/.gitignore and there it sees the pattern "*.exe". The pattern matches,
> and so git obeys the rule (ignores the file). But the pattern "!vendor/"
> does not match (because the path ends with "foo.exe", not "vendor").
>
> Before git had seen the path "src/vendor/foo.exe", it had already seen
> "src/vendor". This time the pattern "!vendor/" did match (because the name
> is identical *and* it is a directory, as per the cited paragraph) and git
> obeyed the rule (which was not to ignore the directory).
>
> -- Hannes
>   

Ok, In fact, my problem therefore derives from the fact that I can't 
specify *what* and *where* for one item in the same .gitignore file. ( 
all *.o files - what - underneath vendor - where )


*.o
!vendor/

The *.o refers to the *what* and !vendor/ to the *where* and this does 
not work. And this seems to be the reasons why we need to split the 
rules over different .gitignore files:

in the root .gitignore:
*.o
and in the vendor/.gitignore:
!*.o
does exactly what I want.

To me , the *where* aspect relates indeed to recursion but the *what* 
aspect perhaps more to pattern matching...

You should update your expectations. ;-)

Done !
At revision 1238945761623511 :-(

Thanks a lot !
Peter
