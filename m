From: Mark Junker <mjscod@web.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 19:09:43 +0100
Message-ID: <478F99E7.1050503@web.de>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:10:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZBt-0006q9-UT
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbYAQSJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbYAQSJn
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:09:43 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:49309 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbYAQSJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 13:09:42 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5811BCAE6F45
	for <git@vger.kernel.org>; Thu, 17 Jan 2008 19:09:41 +0100 (CET)
Received: from [80.146.179.234] (helo=mark-junkers-computer.local)
	by smtp07.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JFZBN-0005TK-00
	for git@vger.kernel.org; Thu, 17 Jan 2008 19:09:41 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
In-Reply-To: <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
X-Sender: mjscod@web.de
X-Provags-ID: V01U2FsdGVkX18H+qVrCUvJUzaAqqp7K+mabKQvSqq6DyGLVvDN
	xyEFGnEn6IoqG4S9rtgVXtMgQYi2t2ueX2P/gNFwn0zIfXG4p7
	yGngBluiE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70887>

Linus Torvalds schrieb:

> In other words, on a bog-standard UNIX (and yes, in this case, I bet OS X 
> works fine too for this test), just try this
> 
> 	filename1=$(echo -e "hello\002there")
> 	filename2=$(echo -e "hello\003there")
> 	echo Odd file > "$filename1"
> 	echo Another odd file > "$filename2"
> 
> and now you have a filename that is actually rather hard to type on the 
> command line. In fact, for me they even *look* the same:
> 
> 	[torvalds@woody ~]$ ll hello*
> 	-rw-rw-r-- 1 torvalds torvalds  9 2008-01-17 08:23 hello?there
> 	-rw-rw-r-- 1 torvalds torvalds 17 2008-01-17 08:23 hello?there
> 
> See?

Sorry, but you're using different characters that look the same. But 
Kevins point was that it's a different thing if you use two characters 
that look the same or the same character with different encodings. This 
makes this HFS-specific problem different from the "look the same"- or 
the "case-insensitivity"-issues.

BTW: I also read about your argument that you wouldn't convert file data 
to normalized UTF-8 (I agree with you that this would be nonsense) and 
therefore filenames shouldn't be converted too. This is something where 
I have to disagree because a filename (like ctime, mtime, atime, ...) 
are meta data (while file contents isn't) and - until now - I would've 
guessed that you agree on this point because git doesn't care about 
filenames but contents.

IMHO it would be the best solution when git stores all string meta data 
in UTF-8 and converts it to the target systems file system encoding. 
That would fix all those problems with different locales and file system 
encodings ...

However, I have to agree that the enforced character set conversion 
causes more problems than it solves.

Regards,
Mark
