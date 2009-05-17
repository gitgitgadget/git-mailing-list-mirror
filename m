From: Ammon Riley <ammon.riley@gmail.com>
Subject: Re: [PATCH] Fix minor memory leak in init-db
Date: Sun, 17 May 2009 09:09:17 -0700
Message-ID: <cd3664ac0905170909l3184c286s7f7d61e108fd5b05@mail.gmail.com>
References: <cd3664ac0905141522s3ad78411o9f015d2e7720c8b5@mail.gmail.com>
	 <7vzldclt33.fsf@alter.siamese.dyndns.org>
	 <cd3664ac0905162107t7ebca943p1722685a8484f08e@mail.gmail.com>
	 <7veiuojoqy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 18:09:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5ivZ-0008AJ-QC
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 18:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbZEQQJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbZEQQJU
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 12:09:20 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:32376 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbZEQQJT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 12:09:19 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1684485yxj.1
        for <git@vger.kernel.org>; Sun, 17 May 2009 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v2iMPXDX5GwqoH5Oi5gHvFAKry7xQrkYCAWFI0CEbdM=;
        b=PyGDPQd8+FwIgD9lYcSGYhebMVTjTYRopeX6lHx3At2JfJGhraODRw2jb03jJXI3Dd
         cpD+8ehyGfzLLMPGHLszyhQONWl+ThgixekoxHXkO/gMi82lgvjEKZXKq1JAoZL4Kn//
         LINrfcpNUd7nL/Yi8B9NEAubMT20FrQm09na8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tCyOylj7LLAYrNFznFN/wjaDVocY88BA9qTBnnI75TzdnQfqxlaiRSqJeGHV0teaeh
         VquUrRgtGBf5HIH9bWmQJLt0KOGOD2HPs2jiJsVhAx9Yd687khWr6woHbEJGO4vvOHaI
         t8cWq9OJy2XQsMVltLGatry10tDOLUz9L3zXQ=
Received: by 10.100.10.15 with SMTP id 15mr6994714anj.8.1242576558584; Sun, 17 
	May 2009 09:09:18 -0700 (PDT)
In-Reply-To: <7veiuojoqy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119399>

On Sat, May 16, 2009 at 10:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ammon Riley <ammon.riley@gmail.com> writes:
>
>> On Sat, May 16, 2009 at 12:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Ammon Riley <ammon.riley@gmail.com> writes:
>>>
>>>> There was an xmalloc() for path, but I didn't see a corresponding free().
>>>> Does it happen somewhere else that I'm not expecting?
>>>
>>> It implicitly happens in exit() in git.c:handle_internal_command()
>>> after cmd_init_db() returns the control to it.
>>
>> Ah. Naturally. :)
>>
>> So if I were to write a long-lived application (such as a custom UI) that
>> links to libgit, and bypasses those functions to call init_db() (and other
>> functions) directly, all those implicit free-on-exit() turn into memory
>> leaks.
>
> Correct, and there are other much larger issues to worry about.
>
> That's why there is a separate libgit2 effort in progress.

Okay, cool! I wasn't aware of that -- I'll take a look at it. In the meantime,
are small patches for this type of issue welcome if I run across others,
or would you prefer I let them lie?

Cheers,
Ammon
