From: Stefan Beller <sbeller@google.com>
Subject: Re: deadlock git upload-pack command when GIT_TRACE is enabled
Date: Mon, 9 May 2016 10:54:21 -0700
Message-ID: <CAGZ79kZ35Dz7ky7XHUc=uXBiWcVTWQnU4aeogERxvO9gKdXBNQ@mail.gmail.com>
References: <CAJNyVBAr7dJFxXA2+dXCJUMs=mB9u3-Ja7r4wemk9C_HBZ3W2A@mail.gmail.com>
	<CAGZ79kbhbLZpXe+Af+6PXioM-0xLz7S02=KAUavfuUSL6xM+jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eugene Petrenko <eugene.petrenko@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 19:54:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azpO1-0006WY-0W
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbcEIRyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:54:24 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35952 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbcEIRyW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:54:22 -0400
Received: by mail-io0-f181.google.com with SMTP id u185so209126361iod.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=X/REHj+9rbKEXebq2y8Hldni38wXVtG84EVMq2REPn8=;
        b=g1PWmPAfIDxTM+vC+1Ncvx2aWqz2kOjJFqQgdk5M+c02W/geJ3w09XK2u1GEYGCNFB
         ZhmAAQS+fSoixmjz41aL8/oGOzJcrXQYSd/vZUSXnTWU4h1wbe/IpoblSth2oe1RiJkB
         ENppeqt1CDsYY5N3SsI61gsKAj/FLYnjd7KqBhQ6LRipnXJmd6vQv84M9/U1ZK+hT2Gz
         cvAwraZOh8tYivYOWX9a29KyqyvB1CYLwt6/YHyO5zWKuC5PMVqqHiFugcJqsJkiafaL
         pzzm1rXIzQyrB6QRjMEMmqJp+W0rm8djuvDp6ajMpUWpY/bwMzG68TCgcRLmNTH2dNvS
         y9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=X/REHj+9rbKEXebq2y8Hldni38wXVtG84EVMq2REPn8=;
        b=mkGpLRQExelI3AYs4VXOswYEbcsuXV5quShlvCdSuooLnRw5L6sGsvNBi+1t7cGkL6
         Df0n+tQOkor8ZBIgfaD/GOnNVvW7IJrEm3lgEe7ZTeXSchRPB8/IMWOnTHXnw28Od+yj
         gbKtixXX1IAWuZmzk+kq8ETHN2KNb0624WiTzWDUVSUhelzM8JtlGHmzMojar6PH0BJt
         1QWehQDl94X2Yh3lqNIN5lbI6xHdZbX8et0tCU1Scqj51zUR/eqlpMVstFZuJMMOOYRp
         beKZa8SglkGx5AeddXCjhEPBdDVGBVFMz4MpT8SJ07gsd/wpyzF8HzSbIDmcY95rhruu
         qFZQ==
X-Gm-Message-State: AOPr4FUUbz6xoycnpmKNAI+RcJF9vdRrLD9ZpwjxwhtqUu2K4oTjhGXYHX6YLn1LKdFksn142DE/zO8eIvwuBGID
X-Received: by 10.107.53.204 with SMTP id k73mr38027974ioo.174.1462816461097;
 Mon, 09 May 2016 10:54:21 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 9 May 2016 10:54:21 -0700 (PDT)
In-Reply-To: <CAGZ79kbhbLZpXe+Af+6PXioM-0xLz7S02=KAUavfuUSL6xM+jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294031>

On Mon, May 9, 2016 at 10:53 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, May 9, 2016 at 10:49 AM, Eugene Petrenko
> <eugene.petrenko@gmail.com> wrote:
>> Hello,
>>
>> I stuck around the deadlock inside git when running git upload-pack .
>> command. A debugging shown that the bottom process (it starts several
>> processes to implement the task) hangs writing to stderr. I managed to
>> reproduce the issue with a tiny bash script. The repository and the
>> script is found here
>> https://github.com/jonnyzzz/git-upload-pack-deadlock
>>
>> I saw the issue reproducing both under Windows and Linux/Mac.
>
> GIT_TRACE=true GIT_TRACE_PACKET=true GIT_TRACE_PACK_ACCESS=true
>
> What do you mean by true?
>
>
>            If this variable is set to "1", "2" or "true" (comparison
> is case insensitive), trace messages will be printed to stderr.

Oh dang. I should read what I quote.




>
>            If the variable is set to an integer value greater than 2
> and lower than 10 (strictly) then Git will interpret this value as an
> open file descriptor and will try to write the trace
>            messages into this file descriptor.
>
>            Alternatively, if the variable is set to an absolute path
> (starting with a / character), Git will interpret this as a file path
> and will try to write the trace messages into it.
>
>            Unsetting the variable, or setting it to empty, "0" or
> "false" (case insensitive) disables trace messages.
>
>>
>> Windows thread dumps are available here
>> https://github.com/jonnyzzz/git-upload-pack-deadlock/tree/master/debug
>>
>>
>> According to those thread dumps I see the following problem around
>> upload-pack.c line 129. There the pack_objects command is executed.
>> First the wants block is pushed to the command, next the stdout
>> processing is started. This means, that pack_objects process output is
>> not processed until all output is put there. In the case I have, the
>> pack_objects process writes TRACE logging into stderr and eventually
>> (on hug repo) the OS buffer runs-out deadlocking the execution.
>>
>>
>> Best regards,
>> Eugene Petrenko
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
