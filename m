From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-ref: place angle brackets around variables in usage string
Date: Mon, 31 Aug 2015 09:05:08 -0700
Message-ID: <xmqqd1y3xx3f.fsf@gitster.mtv.corp.google.com>
References: <1440821924-4289-1-git-send-email-alexhenrie24@gmail.com>
	<47B9DE8756F943C0A0985F41D093340F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Alex Henrie" <alexhenrie24@gmail.com>, <git@vger.kernel.org>,
	<pclouds@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 18:05:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWRaA-0001hS-Rr
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 18:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbbHaQFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 12:05:11 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35651 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbbHaQFK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 12:05:10 -0400
Received: by pacdd16 with SMTP id dd16so143555743pac.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZJLieQkPEZH22VRaF8vosof0rqI5uSPp7zweVq4/Nko=;
        b=xVzgrfvFiilfDVXE3l2PV8Sb3fA9me9FbUUWj8uBIkhPmFpGQzSS3nKaU6sq4u+AxC
         JWKhv/YPt1+KnRxtFtHgeYZAhJuay6RzDsXpad+X2h/aC4+Qjsrmeug8+oer4G7s4wPt
         jD35bgz7Jk0wVapvJySS4WUlz02J4BdMzBs15uUcjVQPMXkf3u+GYmfoXHt8emCVuh53
         0s/4OuH1yf55ASrbA+lkJpPKDXYZOryM7z1QdmyzBy2WZJdwT6XcgmtGDbRuJVAZ311I
         eNgxdwB1fkcZN6OTRHYBOeEvv3jXWKsgkiFr8A4IDuyo8MCVf7aC3BKl5EWtLmef8x9N
         0eiw==
X-Received: by 10.66.122.97 with SMTP id lr1mr38512801pab.76.1441037110049;
        Mon, 31 Aug 2015 09:05:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id h4sm15061206pdd.91.2015.08.31.09.05.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 09:05:09 -0700 (PDT)
In-Reply-To: <47B9DE8756F943C0A0985F41D093340F@PhilipOakley> (Philip Oakley's
	message of "Sat, 29 Aug 2015 11:21:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276887>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Alex Henrie" <alexhenrie24@gmail.com>
>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>> ---
>> builtin/show-ref.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
>> index dfbc314..131ef28 100644
>> --- a/builtin/show-ref.c
>> +++ b/builtin/show-ref.c
>> @@ -8,7 +8,7 @@
>>
>> static const char * const show_ref_usage[] = {
>>  N_("git show-ref [-q | --quiet] [--verify] [--head] [-d 
>> | --dereference] [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags]
>> [--heads] [--] [<pattern>...]"),
>> - N_("git show-ref --exclude-existing[=pattern] < ref-list"),
>> + N_("git show-ref --exclude-existing[=<pattern>] < <ref-list>"),
>
> Should the '<' stdin redirection be shown?

Hmm, that actually is an interesting thought, because commands that
take their input from the standard input in practice would take the
input from upstream pipe more often than from a static file on the
filesystem, i.e.

    $ <cmd> | git show-ref --exclude-existing[=<pattern>]

would be more common, and the "input from file" would more likely
than not follow this pattern anyway:

    $ <cmd> > <file>
    $ git show-ref --exclude-existing[=<pattern>] < <file>

A quick "git grep -e ' < ' Documentation/" tells me that there
aren't that many ones that take input from stdin.

I am wondering if we can take this one as an example that is among
the cleaner and easier to understand:

(GOOD)  'git stripspace' [-s | --strip-comments] < input

and extend its idea further.  What is happening here is that "< input"
gives rather a clear sign that it is not saying that the user must
name her input file "input" --- any intelligent user can substitute it
with the name of the file she has without being told with a noisy
and unsightly

(BAD)   'git stripspace' [-s | --strip-comments] < <input>

mostly because "input" is so a generic word already.  Perhaps we
could even drop "< anything" as you suggest.

> It looks (at first glance) as if this gained a double '< <' at the
> beginning of 'ref-list', rather than being a clean indication of the
> redirection. Perhaps change 'ref-list' to 'ref-list-file' for a slight
> improvement in clarity - this it's only occurance, and the redirection
> would best match a file.

Or replace it with "< input", together with other ones.  Especially
the synopsys that says "git $cmd --stdin < <$anything>" can be
replaced with "git $cmd --stdin" without losing any clarity.

The only thing that it loses is "what is fed from the standard input
is a list of refs", but that should be left to the description of
the option that introduces this "read from the standard input"
behaviour to the command.  "git $cmd --help" for rev-list and
update-index may serve as examples; they do not have this ugly
"< <input>" business.

Hmm?
