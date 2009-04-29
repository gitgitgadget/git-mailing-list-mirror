From: Augie Fackler <durin42@gmail.com>
Subject: Re: [PATCH] Don't crash if ai_canonname comes back as null
Date: Wed, 29 Apr 2009 18:32:02 -0500
Message-ID: <A85E96CC-CF0B-40F9-9960-00485285E6ED@gmail.com>
References: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com> <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com> <6B7EA51D-8412-4E6A-BA7B-156FD5B755E8@gmail.com> <81b0412b0904291504k3261df5fl692d09c6c761887e@mail.gmail.com> <C2AC0D7A-3E11-4A3A-8447-5D7582547B13@gmail.com> <7v63gn59mw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Benjamin Kramer <benny.kra@googlemail.com>,
	Jon Loeliger <jdl@jdl.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzJGD-0005X7-8x
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 01:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbZD2XcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 19:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbZD2XcI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 19:32:08 -0400
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:35845 "EHLO
	spunkymail-a14.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753650AbZD2XcH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 19:32:07 -0400
Received: from [172.16.17.71] (adsl-99-147-234-187.dsl.chcgil.sbcglobal.net [99.147.234.187])
	by spunkymail-a14.g.dreamhost.com (Postfix) with ESMTP id 565C5190E2D;
	Wed, 29 Apr 2009 16:32:03 -0700 (PDT)
In-Reply-To: <7v63gn59mw.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117979>


On Apr 29, 2009, at 6:21 PM, Junio C Hamano wrote:

> Augie Fackler <durin42@gmail.com> writes:
>
>> Fixes a weird bug where git-daemon was segfaulting
>> when started by sh(1) because ai_canonname was null.
>> ---
>> Fixed based on feedback.
>
> Hmm.
>
> I've been waiting for feedback to a patch proposed earlier in the same
> area, which is <49F5BA55.3060606@googlemail.com> ($gmane/117670).  How
> does this new one relate to it?

I can't comment much on the correctness of the code - my patch was the  
minimal change to have it not crash.

The other patch also works for me to prevent the crash, and looks like  
it might be a little more correct in terms of having a meaningful  
hostname.

>> daemon.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/daemon.c b/daemon.c
>> index 13401f1..ae21d92 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -459,7 +459,7 @@ static void parse_extra_args(char *extra_args,  
>> int
>> buflen)
>> 				inet_ntop(AF_INET, &sin_addr->sin_addr,
>> 					  addrbuf, sizeof(addrbuf));
>> 				free(canon_hostname);
>> -				canon_hostname = xstrdup(ai->ai_canonname);
>> +				canon_hostname = ai->ai_canonname ?
>> xstrdup(ai->ai_canonname) : NULL;
>> 				free(ip_address);
>> 				ip_address = xstrdup(addrbuf);
>> 				break;
>> --
>> 1.6.2.GIT
>
