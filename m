From: Steven Michalske <smichalske@gmail.com>
Subject: Re: [PATCH] Use strncpy to protect from buffer overruns.
Date: Wed, 9 Jun 2010 11:25:44 -0700
Message-ID: <34152ED6-ACCC-467B-9076-1A742612AC75@gmail.com>
References: <1276078921-25429-1-git-send-email-smichalske@gmail.com> <AANLkTikID-cEqdDD8XEEYmClSYEkcxdAU-rjYA2LoRVe@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 20:35:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMQ7E-00048n-BT
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 20:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757031Ab0FISe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 14:34:58 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:65350 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530Ab0FISe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 14:34:57 -0400
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2010 14:34:57 EDT
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out3.apple.com (Postfix) with ESMTP id CF5F8970E8CC;
	Wed,  9 Jun 2010 11:25:44 -0700 (PDT)
X-AuditID: 11807136-b7be8ae00000485f-8f-4c0fdca82ddb
Received: from monopole.apple.com (monopole.apple.com [17.205.37.84])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay15.apple.com (Apple SCV relay) with SMTP id 08.E0.18527.8ACDF0C4; Wed,  9 Jun 2010 11:25:44 -0700 (PDT)
In-Reply-To: <AANLkTikID-cEqdDD8XEEYmClSYEkcxdAU-rjYA2LoRVe@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148804>


On Jun 9, 2010, at 5:44 AM, Alex Riesen wrote:

> On Wed, Jun 9, 2010 at 12:22, Steven Michalske <smichalske@gmail.com> wrote:
>> is_git_directory() uses strcpy with pointer arithmitic, protect it from
>> overflowing.  Even though we currently protect higher up when we have the
>> environment variable path passed in, we should protect the calls here.
> 
> Why? The function is static.
> 
The code might be locally constrained.

I always assume that a bit of code can be overwritten from other portions of code.

A small vulnerability is discovered that lets an attacker remove the length check or edit the pointer in the function call, but could not squeeze in the full shell code snippet.  But the now edited function here lets you put in arbitrarily long code.

>> -       strcpy(path, suspect);
>> +       path[sizeof(path) - 1] = '\0';
>> +
>> +       strncpy(path, suspect, sizeof(path) - 1);
> 
> And we have strlcpy for such things.

It is not portable.