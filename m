From: Steven Michalske <smichalske@gmail.com>
Subject: Re: [PATCH] Use strncpy to protect from buffer overruns.
Date: Wed, 9 Jun 2010 13:42:31 -0700
Message-ID: <1E40D9E3-5459-4D29-9D6D-A6528FF8407F@gmail.com>
References: <1276078921-25429-1-git-send-email-smichalske@gmail.com> <AANLkTikID-cEqdDD8XEEYmClSYEkcxdAU-rjYA2LoRVe@mail.gmail.com> <34152ED6-ACCC-467B-9076-1A742612AC75@gmail.com> <AANLkTikQpJa9gzj1riKF79MflGAKv9IqJVXpICgHLXAG@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 22:42:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMS6j-0005hb-0e
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 22:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104Ab0FIUmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 16:42:32 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:53301 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757899Ab0FIUmc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 16:42:32 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id 91E159714847;
	Wed,  9 Jun 2010 13:42:31 -0700 (PDT)
X-AuditID: 1180711d-b7b98ae000002f4b-54-4c0ffcb71ce9
Received: from monopole.apple.com (monopole.apple.com [17.205.37.84])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay13.apple.com (Apple SCV relay) with SMTP id 2B.E7.12107.7BCFF0C4; Wed,  9 Jun 2010 13:42:31 -0700 (PDT)
In-Reply-To: <AANLkTikQpJa9gzj1riKF79MflGAKv9IqJVXpICgHLXAG@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148811>


On Jun 9, 2010, at 12:31 PM, Alex Riesen wrote:

> On Wed, Jun 9, 2010 at 20:25, Steven Michalske <smichalske@gmail.com> wrote:
>>> On Wed, Jun 9, 2010 at 12:22, Steven Michalske <smichalske@gmail.com> wrote:
>>>> is_git_directory() uses strcpy with pointer arithmitic, protect it from
>>>> overflowing.  Even though we currently protect higher up when we have the
>>>> environment variable path passed in, we should protect the calls here.
>>> 
>>> Why? The function is static.
>>> 
>> The code might be locally constrained.
>> 
>> I always assume that a bit of code can be overwritten from other portions of code.
>> 
>> A small vulnerability is discovered that lets an attacker remove the length check
>> or edit the pointer in the function call, but could not squeeze in the full shell code
>> snippet.  But the now edited function here lets you put in arbitrarily long code.
> 
> Eh?
> 
Basically the protection is not robust against malicious code.  It's armored with leather, not the modern full body armor.

>>>> -       strcpy(path, suspect);
>>>> +       path[sizeof(path) - 1] = '\0';
>>>> +
>>>> +       strncpy(path, suspect, sizeof(path) - 1);
>>> 
>>> And we have strlcpy for such things.
>> 
>> It is not portable.
> 
> Git has its own copy of the function:
> 
>  $ git ls-files *strlcpy.c
> 
>  $

Good to know, I could refactor with this.