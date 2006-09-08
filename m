From: Timur Tabi <timur@freescale.com>
Subject: Re: Problem with send-email
Date: Fri, 08 Sep 2006 17:57:27 -0500
Organization: Freescale
Message-ID: <4501F557.7050103@freescale.com>
References: <4501DA6D.9020104@freescale.com> <edsqjo$gh3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 09 00:58:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLpIS-0004K2-MX
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 00:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWIHW5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 18:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWIHW5h
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 18:57:37 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:53693 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751257AbWIHW53 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 18:57:29 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id k890GkiI004828
	for <git@vger.kernel.org>; Fri, 8 Sep 2006 18:16:46 -0600 (MDT)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k88MvRcM020699
	for <git@vger.kernel.org>; Fri, 8 Sep 2006 17:57:27 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
To: git@vger.kernel.org
In-Reply-To: <edsqjo$gh3$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26722>

Jakub Narebski wrote:
> Timur Tabi wrote:
> 
>> Everything works.  However, if I do this:
>>
>> git-send-email --from timur@freescale.com --to  \
>>    --smtp-server remotesmtp.freescale.net patchfile 
>>
> 
> What do you expect when you specify _empty_ To: header?

Sorry, that was a bad cut-and-paste.  I don't know what happened.  That line is supposed to read:

git-send-email --from timur@freescale.com --to timur@tabi.org --smtp-server remotesmtp.freescale.net patchfile

The error message I get is the same:

(mbox) Adding cc: Timur Tabi <timur@freescale.com> from line 'From: Timur Tabi <timur@freescale.com>'
(sob) Adding cc: Timur Tabi <timur@freescale.com> from line 'Signed-off-by: Timur Tabi <timur@freescale.com>
'
5.0.0 <Timur Tabi <timur@freescale.com>... Unbalanced '<'

I do have some news.  This problem goes away if I don't specify the --smtp-server parameter.

> 
> I use git-send-email from time to time; I always specify From:, 
> either entering it when prompted, or using --from parameter.
> The fact that it didn't fill default value from committer/author
> core.author+core.email is I guess a bug...

Like I said, I think the bug is in the call to readline().  Like I said, I don't know Perl, but from the documentation I have read, I don't think readline() takes two parameters.

     do {
         $_ = $term->readline("Who should the emails appear to be from? ",
             $from);
     } while (!defined $_);

     $from = $_;

$from does contain the correct value when readline() is called.  The problem is that $_ contains nothing, which causes $from to be erased.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
