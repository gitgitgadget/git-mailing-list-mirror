From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] branch: fix funny-sounding error message
Date: Tue, 5 May 2015 13:42:11 -0600
Message-ID: <CAMMLpeTYhLwGmy11uGzZAVugQPO6qN6F6pxZ6BiUZKeKnir+zw@mail.gmail.com>
References: <1430536360-21901-1-git-send-email-alexhenrie24@gmail.com> <xmqq8ud5usi6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: pclouds@gmail.com, Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 21:42:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypijm-0002rk-FC
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 21:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbbEETme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 15:42:34 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35412 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbbEETmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 15:42:33 -0400
Received: by widdi4 with SMTP id di4so175014246wid.0
        for <git@vger.kernel.org>; Tue, 05 May 2015 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/aVyLgJIxBy8eUq8zKr6lQ2hsMcQDsztHj3OYsKiugo=;
        b=Iu130zvPcmVBYXhsV7JcaB8m9+AKOfC46JLAzWREJ9zUT4Iolib5DdlJSeDPNPv+cw
         gEa82t6oiDGOkoiipF76X58ldSA1ooU1fLwK2sw6ULn6sYc34MsL1a+/U5XocuQ60V3l
         pJRvX5YZF4B0pbH7JSCNCvgrR2bNwOatF9eDOfZz+6OKm87anBAMa4v66AGKPqjqpipW
         0HLqgtve++4mYTGnhN6eZgcu6AI6b9tcFRsGGl+191YGnldFuJ1levWTBqL8VpTEAdn4
         womihbNXLGWl9sa+9z3wytLbLA2oOwnaxbxN5Y52P/laLy+ENOyRdfi/g9j80dhIiMMS
         YGJQ==
X-Received: by 10.180.91.77 with SMTP id cc13mr1172471wib.88.1430854951858;
 Tue, 05 May 2015 12:42:31 -0700 (PDT)
Received: by 10.28.182.84 with HTTP; Tue, 5 May 2015 12:42:11 -0700 (PDT)
In-Reply-To: <xmqq8ud5usi6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268420>

2015-05-03 17:54 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>> ---
>>  builtin/branch.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 1d15037..c0b4bae 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -972,7 +972,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>
>>               if (!branch) {
>>                       if (!argc || !strcmp(argv[0], "HEAD"))
>> -                             die(_("could not set upstream of HEAD to %s when "
>> +                             die(_("could not set upstream of HEAD to %s because "
>>                                     "it does not point to any branch."),
>>                                   new_upstream);
>>                       die(_("no such branch '%s'"), argv[0]);
>
> Thanks.
>
> To me neither sounds so funny, but both sound somewhat awkward,
> primarily because it is unclear in the first reading what "it" in
> "it does not point at any branch" refers to.
>
> Perhaps if you explain in the log message to illustrate why you
> found it funny (and the update text is not), it might help, e.g.
>
>     "git branch", ran with <this and that options>, when the current
>     branch is <in what state>, dies with
>
>         fatal: could not set upstream of HEAD to frotz when it does not
>         point to any branch.
>
>     which is funny <because of such and such reasons>.  Saying "because"
>     makes it <better beause of such and such reasons>.
>
> I suspect that this message is about a nonsense attempt to set an
> upstream for a detached HEAD perhaps?  Then
>
>     fatal: cannot set upstream for a detached HEAD
>
> may be shorter and more directly points at the root cause of the
> error?

I don't really understand what this code is doing. It just sounds
funny to use "when" to join a phrase in the past tense with a phrase
in the present tense.

This error message can be triggered by running `git branch
--set-upstream-to=origin/master` from a detached head. But if running
from a detached head is the only way to trigger the error message, why
does the code use strcmp instead of if (detached) { ... } as other
code in that function does?

Also, I missed the complementary error message "could not unset
upstream of HEAD when it does not point to any branch." We should
either change the "when" to a "because" in the second message too or
rewrite both of these messages entirely.

-Alex
