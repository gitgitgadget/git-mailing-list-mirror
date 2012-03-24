From: Andrew Wong <andrew.w-lists@sohovfx.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick failed
Date: Sat, 24 Mar 2012 16:03:39 -0400
Message-ID: <4F6E289B.4020104@sohovfx.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com> <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com> <7vk42gbkl1.fsf@alter.siamese.dyndns.org> <4F679E67.4080708@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 21:25:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBXWQ-0003fd-Qp
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 21:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219Ab2CXUZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 16:25:04 -0400
Received: from smtp03.beanfield.com ([76.9.193.172]:59295 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab2CXUZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 16:25:03 -0400
X-Greylist: delayed 1277 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Mar 2012 16:25:03 EDT
X-Spam-Status: No
X-beanfield-mta03-MailScanner-From: andrew.w-lists@sohovfx.com
X-beanfield-mta03-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta03-MailScanner: Found to be clean
X-beanfield-mta03-MailScanner-ID: 1SBXBc-0002qY-TM
Received: from [24.246.58.202] (helo=ZanarkandMac.local)
	by mta03.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w-lists@sohovfx.com>)
	id 1SBXBc-0002qY-TM; Sat, 24 Mar 2012 16:03:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:11.0) Gecko/20120313 Thunderbird/11.0
In-Reply-To: <4F679E67.4080708@sohovfx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193845>

On 12-03-19 5:00 PM, Andrew Wong wrote:
> On 03/19/2012 12:51 PM, Junio C Hamano wrote:
>> Isn't the real solution *not* to create the CHERRY_PICK_HEAD in the
>> sequencer when it is not know if it is needed, instead of the current code
>> which seems to create first and then selectively try to unlink() it?
>>
> Though if the additional flag in "cherry-pick" and additional option in
> sequencer could be useful elsewhere, I could do it that way too.
I looked into adding a "no-state" flag in 'cherry-pick' to not create 
the CHERRY_PICK_HEAD, but 'commit' actually has several dependencies on 
CHERRY_PICK_HEAD, such as recording reflog message, 'prepare-commit-msg' 
hook, and formatting a user message. So if we want to continue to pursue 
this path, we'd have to preserve those behaviors in 'commit' as well. 
It's probably not a good idea to make all these changes in  
'cherry-pick' and 'commit' just to avoid a simple cleanup in 'rebase 
-i'. So I still prefer the patch I submitted earlier.
