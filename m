From: Stephen Kelly <steveire@gmail.com>
Subject: Re: git interactive rebase 'consume' command
Date: Mon, 21 Jan 2013 20:05:45 +0100
Message-ID: <50FD9189.8040807@gmail.com>
References: <kdgtir$apt$1@ger.gmane.org> <50FD20FA.8060906@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:06:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMh8-0006Tx-6y
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512Ab3AUTFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:05:51 -0500
Received: from mail-bk0-f51.google.com ([209.85.214.51]:55413 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704Ab3AUTFt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 14:05:49 -0500
Received: by mail-bk0-f51.google.com with SMTP id y8so861166bkt.24
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+3DHbFvOsTjBLjd9af9H+QnPSwzoGo0vnOp+daGSPTU=;
        b=KOI1W9KeWS7jKRQKN7MczCkUYpgwsY9KdRfrr7eqUxyyBxA5Z8H1CLsmDhetHYz9Ev
         HlIr9Ottp+f3Bbn+vwHII0AI+SO580GDtXngTTyy7XKtLAEx7fDbLHnC0/94hDPQ+0Ml
         qFjgS+3PugJE4J/IK/Q+1RllIVSHJo2Z9FyFMA5cIkvHmHPRR4MIt46OA4kJ8mbmqvvj
         OpFBwXGPuN42X4G1+WZSdVKMqj5Ug+5JdsP+VHCbrW4qzHU9lb1+lLyi2U9qdZvPXGCu
         oRs4bQ/93Z9cbHQXpS1MYIwMvs4HjF2VPqqQM+XQx6HDb7eZJlcYbxHb8keHmwBmMzYd
         uDkA==
X-Received: by 10.204.154.202 with SMTP id p10mr5159011bkw.29.1358795148369;
        Mon, 21 Jan 2013 11:05:48 -0800 (PST)
Received: from [192.168.1.3] (e178124029.adsl.alicedsl.de. [85.178.124.29])
        by mx.google.com with ESMTPS id i20sm9403886bkw.5.2013.01.21.11.05.46
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 11:05:47 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50FD20FA.8060906@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214142>

On 01/21/2013 12:05 PM, Michael Haggerty wrote:
> It is perverse to have to turn a well-defined and manifestly
> conflict-free wish into one that has a good chance of conflicting, just
> because of a limitation of the tool.

Yes, I agree.

>> I would prefer to be able to mark a commit as 'should be consumed', so that:
>>
>>   pick 07bc3c9 Good commit.
>>   consume 1313a5e Commit to fixup into c2f62a3.
>>   pick c2f62a3 Another commit.
>>
>> will result in
>>
>>   pick 07bc3c9 Good commit.
>>   pick 62a3c2f Another commit.
>>
>> directly.
> Excellent.  But the name is not self-explanatory.  And there is
> something different about your "consume" command:
>
> Normally, "pick" means that the commit on that line is the start of a
> new commit unrelated to its predecessors.  And in general, the command
> on one line only affects the lines that come before it, not the lines
> that come after it.  Under your proposal "consume" would change the
> meaning of the following line, namely by changing what its "pick" means.

>   It might be more consistent to require the following line to be changed
> to "squash":

I'm -1 on that. I value the simple format of the todo file. If I want to 
edit a commit, I type deif, reword - deir, fixup - deif. I'd like 
something equally simple like deic for this operation. There's also a 
'consistency' argument there, and one I prefer to your consistency 
interpretation.

The same simplicity request applies to what you write below.

Thanks,

Steve.

>      pick 07bc3c9 Good commit.
>      consume 1313a5e Commit to fixup into c2f62a3.
>      squash c2f62a3 Another commit.
>
> in which case the meaning of "consume" would be something like "pick
> this commit but not its commit message.  There would have to be a
> prohibition against generating commits with *no* commit messages, to
> prevent series like [consume, pick] or [consume, fix, pick] while
> allowing series like [consume, consume, squash, fix, fix].
>
> If this is the interpretation, the name "quiet/q" might make things clearer.
>
> Yet another approach would be to allow options on the commands.  For
> example,
>
>      pick 07bc3c9 Good commit.
>      pick --quiet 1313a5e Commit to fixup into c2f62a3.
>      squash c2f62a3 Another commit.
>
> In fact if options were implemented, then "fixup" would mean the same as
> "squash --quiet", "reword" could be written "pick --edit", and I'm sure
> the new flexibility would make it easier to add other features (e.g.,
> "pick --reset-author").
>
> Michael
>
