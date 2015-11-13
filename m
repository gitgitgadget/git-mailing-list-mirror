From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: Re: [PATCH] rebase-i-exec: Allow space in SHELL_PATH
Date: Fri, 13 Nov 2015 16:25:18 +0100
Message-ID: <CABA5-zk+RVBxfmuLyK8CcCFUpMXEzbHRKeWWV2SKsJqjnG-nfA@mail.gmail.com>
References: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com> <20151113062534.GE32157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 16:25:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxGEQ-0003rt-US
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 16:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbbKMPZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 10:25:39 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36513 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbbKMPZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 10:25:38 -0500
Received: by oiww189 with SMTP id w189so51172591oiw.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 07:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l1Vx9ahqnk1whX0ksuMxVzumqu4OMkF266R1sckZKnk=;
        b=O8ufl/wb84lGLxuDfXbfJuj3yy4Icj7MB9QFdyRzvkprUe8CyPSnIHLX88jwE85vPt
         QwSL7m8MGyXNyj4DaMGFEcNVlbVNsZs46U8UqRzEN3pO0yzBS2iz+CiLeTnkJUixwdsN
         6k1u2rKYuVMWfOo8/B18S5rlLtULio3C1IeAnGyi3XD6itluY93AwE/NI4XpaFdwSux8
         /fncozXHAhdfeu+M0rmlc9Vim59SXNo52FW5nELZLjsAV30smXKvKEk87uEli9mza5Wi
         MMc2w8yUW8IexEo93pp7DpDhJ8Gq/tPFKaicmtx2jFPWe5Ookn8/PeTi//L+mZtcOXsv
         LFUQ==
X-Received: by 10.202.85.193 with SMTP id j184mr8911005oib.4.1447428338018;
 Fri, 13 Nov 2015 07:25:38 -0800 (PST)
Received: by 10.202.97.196 with HTTP; Fri, 13 Nov 2015 07:25:18 -0800 (PST)
In-Reply-To: <20151113062534.GE32157@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281252>

2015-11-13 7:25 GMT+01:00 Jeff King <peff@peff.net>:
> On Fri, Nov 13, 2015 at 07:03:19AM +0100, Fredrik Medley wrote:
>
>> On Windows, when Git is installed under "C:\Program Files\Git", SHELL_PATH
>> will include a space. Fix "git rebase --interactive --exec" so that it
>> works with spaces in SHELL_PATH.
>>
>> Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
>> ---
>>  git-rebase--interactive.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 30edb17..b938a6d 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -610,7 +610,7 @@ do_next () {
>>               read -r command rest < "$todo"
>>               mark_action_done
>>               printf 'Executing: %s\n' "$rest"
>> -             ${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
>> +             "${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
>
> I think this is the right thing to do (at least I could not think of a
> case that would be harmed by it, and it certainly fixes your case). It
> looks like filter-branch would need a similar fix?
>
> I think this still isn't resilient to weird meta-characters in the
> @SHELL_PATH@, but as this is a build-time option, I think it's OK to let
> people who do
>
>   make SHELL_PATH='}"; rm -rf /'
>
> hang themselves.
>
> -Peff

Okay, that's what @SHELL_PATH@ stands for. I just read the result
in the Windows installation that is something like ${SHELL:-/bin/sh}.
The shell script processor then replaces /bin/sh with
C:\Program Files\...\bin\sh.

I assume the Windows compilation does not fail in building this. I've
never tried building git for Windows, though.

/Fredrik
