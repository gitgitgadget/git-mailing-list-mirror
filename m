From: Karthik R <karthikr@fastmail.fm>
Subject: Re: [PATCH][resend] git-svn: Respect GIT_SSH setting
Date: Tue, 18 Aug 2009 00:48:38 -0500
Message-ID: <4A8A40B6.80209@fastmail.fm>
References: <4A89E185.2010307@fastmail.fm> <7vzl9ykovh.fsf@alter.siamese.dyndns.org> <4A89EC07.2010402@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 07:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdHYq-0004xZ-Ko
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 07:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbZHRFse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 01:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbZHRFse
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 01:48:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54692 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751358AbZHRFsd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 01:48:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CD36154A99;
	Tue, 18 Aug 2009 01:48:33 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 18 Aug 2009 01:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=HUDaOpQMRuDnjJ3+/kCgZ7LwBpY=; b=pfL6TyaNchsn6/ec0LaZigm1GZQibs3W+Dg7JKmT5uUwSb5Cdoe2jo8NBH2SORwhxHJn/kYNCZ/iGoaHBi4fc3rvxLPwCUd7ndmb0IZbOwfrqkGWV4LYAFvqDy3HpouCDPsUIJB/uByJr4ybuYdJBEOVkOsjaQ29itSeaRIOzxc=
X-Sasl-enc: hnobp2dXK2Xe51/E45R7Erk4/Kf9oUMtpmRxUZIxLBIb 1250574513
Received: from [192.168.10.12] (99-156-81-160.lightspeed.austtx.sbcglobal.net [99.156.81.160])
	by www.fastmail.fm (Postfix) with ESMTPSA id 3A9D99A8C;
	Tue, 18 Aug 2009 01:48:33 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <4A89EC07.2010402@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126349>

Karthik R wrote:
> Junio C Hamano wrote:
>> Karthik R <karthikr@fastmail.fm> writes:
>>
>>  
>>> +# If GIT_SSH is set, also set SVN_SSH...
>>> +$ENV{SVN_SSH} = $ENV{GIT_SSH} if defined $ENV{GIT_SSH};
>>> +# ... and escape \s in shell-variable on Windows
>>> +if ($^O eq 'MSWin32' || $^O eq 'msys') {
>>> +       $ENV{SVN_SSH} =~ s/\\/\\\\/g if defined $ENV{SVN_SSH};
>>> +}
>>> +
>>>     
>>
>> Two questions.
>>
>>  - What if a user has SVN_SSH exported _and_ wants to use a different 
>> one
>>    from the one s/he uses for git?  Naturally such a user would set both
>>    environment variables and differently, but this seems to override the
>>    value in SVN_SSH;
>>   
> Do you mean user wants to use a different one with "git svn ... 
> svn+ssh://" (than the one with "git clone ssh://") ?
> In this case
> - defining SVN_SSH, but not GIT_SSH will still work (with this patch, 
> GIT_SSH overrides)
> - but SVN_SSH needs to have \\s.
> So unless the user already knew of this quirk, we'll only see 
> unescaped \s - so it *does* make sense to escape the \s (if the user 
> knew, then too many escaped \s still work).
>>  - Can a user have SVN_SSH exported, on MSWin32 or msys, and use svn
>>    outside git?  If so, what does the value of SVN_SSH look like?  
>> Does it
>>    typically have necessary doubling of backslashes already?
>>   
> With subversion for Windows, these \\s are not needed (but doesn't 
> cause any break). The doubling is something to do with the bash (in 
> msys) I think.
I was wrong... the \\ seems to be a subversion issue. This s/\\/ line in 
this patch would at best be a work-around (necessary because GIT_SSH 
doesn't have this bug).
http://subversion.tigris.org/issues/show_bug.cgi?id=3454 (GIT_SSH would 
look like the last one in the list - and with this patch, SVN_SSH can 
also look the same)
