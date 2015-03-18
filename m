From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: Re: [v3 PATCH 1/2] reset: add '-' shorthand for '@{-1}'
Date: Wed, 18 Mar 2015 15:17:20 -0400
Message-ID: <87egomm7y7.fsf@gmail.com>
References: <1426667384-26288-1-git-send-email-dyoucme@gmail.com>
	<87iodym82z.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 20:17:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYJSq-00041G-0f
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 20:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933386AbbCRTRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 15:17:08 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35433 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933379AbbCRTRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 15:17:06 -0400
Received: by qgez64 with SMTP id z64so46161089qge.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lNfvvYHrky/mXlQ6BPudrHAmk3A8Ut2AWBKGKmi7whs=;
        b=I4PsWS/g1cFnL38voGzZvUCwNFK+3wmy/wbUJveW0Lhd4E5yRMP05TXXcQAa9MXsXk
         4F6vMcshC8mkLkjRmg3Ya1/mLaY8MT4vDDNo5GSU75qKk3tyCYJI1nRyx599UzMQogsJ
         E77+y6TFguX3iRChf1Px91+xrPB1DBnmPN0SruuQwUegVw+eSgymT/6UI+9PJfLypaJi
         ZcZIuiEmm4bgxbmIzBN+wnl7pSFQxLdjzgWxJxDtr/5F/E7EzvQLx4G/bT51rSuk673N
         q9+OWUukD+EfcJoz4D3sUblsIv8NaKUSAlShCoTKvWMFG3SnuQHQpj2mh0yxIJCbQH9N
         T7lQ==
X-Received: by 10.55.55.12 with SMTP id e12mr96779868qka.50.1426706225659;
        Wed, 18 Mar 2015 12:17:05 -0700 (PDT)
Received: from fujitsu ([132.205.236.24])
        by mx.google.com with ESMTPSA id p18sm12414961qkh.10.2015.03.18.12.17.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 12:17:04 -0700 (PDT)
In-Reply-To: <87iodym82z.fsf@gmail.com> (Kenny Lee Sin Cheong's message of
	"Wed, 18 Mar 2015 15:14:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265750>

On Wed, Mar 18 2015 at 04:29:44 AM, Sundararajan R <dyoucme@gmail.com> wrote:
> Teaching reset the - shorthand involves checking if any file named '-' exists.
> check_filename() is used to perform this check.
>
> When the @{-1} branch does not exist then it can be safely assumed that the
> user is referring to the file '-',if any. If this file exists then it is reset or else
> a bad flag error is shown.
>
> But if the @{-1} branch exists then it becomes ambiguous without the explicit 
> '--' disambiguation as to whether the user wants to reset the file '-' or if 
> he wants to reset the working tree to the previous branch. Hence the program dies
> with a message about the ambiguous argument.
>
I might be wrong but I think any pathspec that begins with "-" needs to
be preceded by either a "--" marker or be specified as "./-filename",
else verify_filename just die. Therefore you would need to do something
like git reset ./- if you wanted to reset a file. I don't know if given
simply "-" as filename is desired since options starts with "-".

I don't know if you saw but Junio posted a while ago about about
allowing "-" as a stand-in everywhere a revision was allowed. He updated
a version on pu : "d40f108d"

> On Tue, Mar 17 2015 at 02:49:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> 	if (try to see if it is a revision or regvision range) {
>>         	/* if failed ... */
>> 		if (starts with '-') {
>>                 	do the option thing;
>>                         continue;
>> 		}
>> 		/* args must be pathspecs from here on */
>>                 check the  '--' disambiguation;
>>                 add pathspec to prune-data;
>> 	} else {
>> 		got_rev_arg = 1;
>> 	}
>>

See $gmane/265672
