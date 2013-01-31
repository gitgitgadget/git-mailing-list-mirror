From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Thu, 31 Jan 2013 08:02:06 +0100
Message-ID: <CALWbr2y8veWYRwEGrbGq-PhxZjXbBF5HMgQXrRr=1JzGQ9Y-tQ@mail.gmail.com>
References: <28799936.346521359596121253.JavaMail.weblogic@epmltmp3>
	<20130131064921.GB24660@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jongman Heo <jongman.heo@samsung.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 08:02:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0oAI-0007e7-O0
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 08:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab3AaHCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 02:02:08 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:59783 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab3AaHCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 02:02:07 -0500
Received: by mail-ea0-f174.google.com with SMTP id 1so1047313eaa.19
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 23:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RD54QFa9pPfoQaK5I1B2sr/LKn9oD1tvqaXdEfbtNso=;
        b=UPNKDrYOrBBhSl1//HKSUmX/La1NZzAGa/9gPYtJqWddmQHP/irYwutyoCqzQf2SO4
         RMelfYvUUu6AgfAXBqwal8j5A1177XbaVbPweTJqDZHVjqUEDrFOyvRpcj6dTkUjv0mQ
         kF7RAKND0PBX2t6esK0sysEjhxWfCjECTSVlEPi7SLaAXVzZsiR/TItM37Y6mAHtx6CE
         guRasvHq74WMgRmLAEi5vAaJULngE28N9GqKhpL5EYXhODrW8mabg/w/izBCXvqR5QW4
         T1obE/iQfFrsdkqWQO6uXJ6SxZVodjYNkqY20NaAtIjzi2JvxkTBeh8V4FHPKwbufJK5
         PNFQ==
X-Received: by 10.14.194.4 with SMTP id l4mr24051716een.42.1359615726235; Wed,
 30 Jan 2013 23:02:06 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 30 Jan 2013 23:02:06 -0800 (PST)
In-Reply-To: <20130131064921.GB24660@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215102>

In "clean.c" we have a "string_list" created on the stack with
"STRING_LIST_INIT_NODUP" (there are probably others, I stopped at the
first occurrence).
But, "STRING_LIST_INIT_NODUP" doesn't init the "list->cmp" pointer
which can thus be random.

I don't have much time to provide a patch right now (have to go to
work), but will tonight if still needed.

Antoine,



On Thu, Jan 31, 2013 at 7:49 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 31, 2013 at 01:35:21AM +0000, Jongman Heo wrote:
>
>> Looks like following commit causes a segmentation fault in my machine
>> (when running git pull or git fetch);
>>
>> commit 8dd5afc926acb9829ebf56e9b78826a5242cd638
>> Author: Junio C Hamano <gitster@pobox.com>
>> Date:   Mon Jan 7 12:24:55 2013 -0800
>>
>>     string-list: allow case-insensitive string list
>>
>>
>> In my case, list->cmp (at get_entry_index() function) has an invalid
>> address, obviously not an address of string comparision function,
>> instead it points to 1.
>
> Can you show us a stack trace? The string-list functions are generic and
> get called in a lot of places. It would be useful to know which list is
> causing the problem.
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
