From: Quint Guvernator <quintus.public@gmail.com>
Subject: Re: [PATCH 1/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 19:46:12 -0400
Message-ID: <CALs4jVGxmirDdO03kaKco7=NrTaXBinY=1U71=fYwX1mbqNDOA@mail.gmail.com>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
 <1395093144-6786-2-git-send-email-quintus.public@gmail.com> <xmqqob14a14s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 00:46:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPhF8-000663-BN
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 00:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbaCQXqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 19:46:34 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:64794 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaCQXqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 19:46:34 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so2967232wiw.12
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 16:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QblxoiVkXOelS3scbGs4x5Dlqwst8VNq4aSNudeMho8=;
        b=aprTpBTS+y7NQS6pFIyyMtNSPOW9UBnWD924BfQ7ikGlpsY/MVr+x//ckdeNu/aX+k
         HFU5/mnQKqueiaZC0QVjU4UWHJO+gJItxHQQ7F1jPNAtNOIs5dpu6rsMYABqWnOmSYjP
         UhsVKpm8oLUjx+DOezvLGglmHP/+lm3yunv6lxpDKh/voxRHeGuHnsYzJzI3Jm0L2ibp
         ErWquHBtq+21C0GW3r/+WAWnZfbxF6slwkCr8dH/HvmpXQb7iNLW1662m/4JXG8mn40k
         c2CeqWmNaKbBzK4bGua0Xu4kJobh5giX2b/3LuHpPssdIlcXa5Mt8HMoqGlJYikDSnW9
         Nmqw==
X-Received: by 10.181.13.15 with SMTP id eu15mr11799407wid.38.1395099992972;
 Mon, 17 Mar 2014 16:46:32 -0700 (PDT)
Received: by 10.216.231.138 with HTTP; Mon, 17 Mar 2014 16:46:12 -0700 (PDT)
In-Reply-To: <xmqqob14a14s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244313>

2014-03-17 18:52 GMT-04:00 Junio C Hamano <gitster@pobox.com>:
> Thanks.  This probably needs retitled, though (hint: "replaces"?
> who does so?) and the message rewritten (see numerous reviews on
> other GSoC micros from Eric).

I found some messages [1] by Eric concerning imperative voice ("simplify"
rather than "simplifies/ed").

Other than the change of verb, what sort of changes are you looking for in
the description? It doesn't look much different than, for instance, this
[2] commit in the log.

[1]: http://article.gmane.org/gmane.comp.version-control.git/243848
[2]: https://github.com/git/git/commit/0eea5a6e91d3da6932c13f16fdf4b4e5ed91b93c

> I sense that there is a bonus point for an independent follow-up
> patch to unify the conflicting definitions of what an incomplete
> line should look like.  Hint, hint...

I'll try to make the time to follow up on that, if I can think of a good
clear solution for the conflict. I'm also a full-time student, but I will
certainly give it a shot.

>> @@ -1673,7 +1673,7 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
>>       unsigned long oldlines = 0, newlines = 0, context = 0;
>>       struct fragment **fragp = &patch->fragments;
>>
>> -     while (size > 4 && !memcmp(line, "@@ -", 4)) {
>> +     while (size > 4 && starts_with(line, "@@ -")) {
>
> If there were a variant of starts_with() that works on a counted
> string, and rewriting this using it to
>
>         while (starts_with_counted(line, size, "@@ -")) {
>
> would make perfect sense, but as written above, I do not think it is
> an improvement.

This still feels to me like an improvement from the !memcmp line, but if
you think we need to wait for a full helper-function revamp, let's drop it.

>> @@ -66,7 +66,7 @@ static int verify_tag(char *buffer, unsigned long size)
>>               return error("char%"PRIuMAX": could not find next \"\\n\"",
>>                               (uintmax_t) (type_line - buffer));
>>       tag_line++;
>> -     if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
>> +     if (!starts_with(tag_line, "tag ") || tag_line[4] == '\n')
>>               return error("char%"PRIuMAX": no \"tag \" found",
>>                               (uintmax_t) (tag_line - buffer));
>
> Not quite.  I suspect that what actually makes this strange and
> tricky is that this "no tag found" check is misplaced.  It found the
> type line, expects that the next line is a tag line, and instead of
> validating the remainder of type line, it does this thing, and then
> verifies the actual type string, and for that, it needs tag_line
> variable to stay where it is.
>
> If we flipped the order of things around the codepath a bit, then we
> should be able to first validate the type line, and then use
> skip-prefix to skip the "tag " part (while validating that that line
> actually begins with "tag ") and check the tag name is a non-empty
> string that consists of a good character.  All of that is a topic
> for a separate patch.

That's tricky. Okay, let's definitely drop this hunk.

Shall I submit a new [PATCH v5] with these changes to the mailing list or
directly to you, or is everything in order?

Thanks for taking the time to review this. I really appreciate the
feedback.

Quint
