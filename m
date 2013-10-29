From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Tue, 29 Oct 2013 07:23:40 +0100
Message-ID: <CAP8UFD1eTmUGt7dWAP-Ws17op=z98hOvBa_g8_y=xS8WQ1dRMg@mail.gmail.com>
References: <20131024122255.GI9378@mwanda>
	<20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com>
	<20131027013402.GA7146@leaf>
	<526CA7D4.1070904@alum.mit.edu>
	<20131027071407.GA11683@leaf>
	<874n83m8xv.fsf@linux-k42r.v.cablecom.net>
	<20131027092019.GB13149@leaf>
	<CALKQrgc7a+p5eebJErcGdA3QDyvdHEaef36RhZocQp9LjDUeeg@mail.gmail.com>
	<CAP8UFD3MZJKWUbdZqrSwoatpnx73MTpiwSkxPHYDagGjMSqJNw@mail.gmail.com>
	<CALKQrgcgfimZRJL7WyS-brqEZnHJkJjK_0cqe6-7HWkuCW6Dzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git mailing list <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 29 07:23:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb2iP-00041p-P7
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 07:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab3J2GXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 02:23:42 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:39911 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3J2GXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 02:23:41 -0400
Received: by mail-vb0-f52.google.com with SMTP id f13so5924030vbg.25
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 23:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8oxaaqMJ0BCTgMfqnVWqtvTjYtaLFfwcWgSSsWt0xJQ=;
        b=1JJBFO0UoHrbwUd9zV4PkD8mvv8nIB+03GPou6KbZa8vlaF9TywNxZd2jpVNUpO6Gj
         i0BUyoPaJfM7PvMvOXcSFMJAxXddzvISG995dl1hwmS1uy+he6ZgojHPBKxyzZeFL9qC
         p5/EkPLM4eTWllf2iAIlu6NjJ9Xb6YZIgtbI3V5ecFGdVyvdQfjG2uhfihHqBwxaOV2c
         o2NIk5rMMogCRW4uLu5B/jKa/0j4H8mmxLv/+4dU7JWjB98jTtW1u/KLOAynaw955jJV
         y8p5gUV3oZsHxgQhAjbxrJRtHRft9vO4E+qNw8rxrA2rLrLzkAiZ0AesCL5/j/va8ERL
         RVfg==
X-Received: by 10.220.203.195 with SMTP id fj3mr2855064vcb.21.1383027820552;
 Mon, 28 Oct 2013 23:23:40 -0700 (PDT)
Received: by 10.58.253.136 with HTTP; Mon, 28 Oct 2013 23:23:40 -0700 (PDT)
In-Reply-To: <CALKQrgcgfimZRJL7WyS-brqEZnHJkJjK_0cqe6-7HWkuCW6Dzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236895>

On Mon, Oct 28, 2013 at 3:46 AM, Johan Herland <johan@herland.net> wrote:
> On Sun, Oct 27, 2013 at 8:04 PM, Christian Couder <christian.couder@gmail.com> wrote:
>>
>> If "git commit" processes these arguments and puts the result in the
>> commit message file that is passed to the
>> prepare-commit-msg hook, then this hook can still get them from the
>> file and process them however it wants.
>>
>> And in most cases the processing could be the same as what is done by
>> the commit-msg hook when the user changes the "Fixes: xxx" and
>> "Stuffed-by: yyy" lines in the editor.
>>
>> So it would probably be easier for people customizing the
>> prepare-commit-msg and commit-msg if "git commit" processes the
>> arguments instead of just passing them to the prepare-commit-msg hook.
>>
>> And it will be better for people who don't set up any *commit-msg hook.
>> Even if there is no commit template, "-f Acked-by:Peff" and "-f
>> Fixes:security-bug" could still work.
>> I suspect most users don't setup any hook or commit template.
>
> Hmm. I'm not sure what you argue about which part of the system should
> perform which function. Let's examine the above options in more
> detail. Roughly, the flow of events look like this
>
>   git commit -f ack:Peff -f fix:security-bug
>     |
>     v
>   builtin/commit.c (i.e. inside "git commit")
>     |
>     v
>   prepare-commit-msg hook
>     |
>     v
>   commit message template:
>     Fixes: security-bug
>     Acked-by: Peff

Here it could already be:

     Fixes: 1234beef56 (Commit message summmary)
     Acked-by: Jeff King <peff@peff.net>

Because builtin/commit.c hook could already have expanded everything.

>     |
>     v
>   user edits commit message (may or may not change Fixes/Acked-by lines)
>     |
>     v
>   commit-msg hook
>     |
>     v
>   commit message:
>     Fixes: 1234beef56 (Commit message summmary)
>     Acked-by: Jeff King <peff@peff.net>
>
> (The above is even a bit simplified, but I believe it's sufficient for
> the current discussion.) So, there are several expansions happening
> between the initial "git commit" and the final commit message. They
> are:
>
>  1. "fix" -> "Fixes: "
>  2. "security-bug" -> "1234beef56 (Commit message summmary)"
>  3. "ack" -> "Acked-by: "
>  4. "Peff" -> "Jeff King <peff@peff.net>"
>
> First, I think we both agree that expansions #2 and #4 MUST be done by
> the commit-msg hook. The reason for this is two-fold: (a) the
> expansion must be done (at least) after the user has edited the commit
> message (since the values entered by the user might require the same
> expansion), and (b) how (and whether) to perform the expansion is a
> project-specific policy question, and not something that Git can
> dictate.

I don't agree. Git doesn't need to dictate anything to be able to do
these expansions.
Git only needs some hints to do these expansions properly and it could
just look at the commit template, or the config, to get those hints.

For example, if there is a "Acked-by:" line in the commit template,
then Git might decide that "ack" means "Acked-by", and then that "-by"
means that "Peff" should be related to an author, and then that it is
probably "Jeff King <peff@peff.net>".

> Obviously, common functionality can be made available in the
> default hook shipped by Git, but it's up to each project to enable
> and/or customize this.
>
> Second, there is #1 and #3, the expansion of "ack" -> "Acked-by:" and
> "fix" -> "Fixes:". Is this expansion performed by the
> prepare-commit-msg hook, or directly inside builtin/commit.c?
>
> If you are arguing for the latter (and I'm not sure that you are), we
> would need to add a dictionary to "git commit" that maps shorthand
> field names ("ack") to the RFC822 -style equivalent ("Acked-by: ").

Yes, I am arguing that builtin/commit.c, or better a plumbing command
launched by builtin/commit.c, should do it.

And I don't think there is an absolute need for a dictionary.
There could be such a dictionary in the config (as Junio proposed).
But if there isn't, the plumbing command launched by builtin/commit.c
could look at the commit template to decide that "ack" means
"Acked-by:".

> I would instead argue for the former, i.e. simply forwarding "ack" and
> "fix" as-is to the prepare-commit-msg hook, and let it deal with the
> appropriate expansion. The main reason for this is that if a project
> wants to add another shorthand expansion (e.g. "bug" ->
> "Related-Bugzilla-Id: "), they can do so without hacking
> builtin/commit.c.

I agree that there should be no need to hack builtin/commit.c.
For example if "Bugzilla-Id:" is in the commit template, the plumbing
command launched by builtin/commit.c would decide that "bug" means
"Bugzilla-Id:" without any hack.

Of course this suppose that there is no other "Bugtracker:" or "Bug:"
in the commit template.
But even in this case it would mean that users have to use "-f
bugz:XXX" (or "--trailer bugz=XXX") instead of just "-f bug:XXX".

>> Supporting project specific conventions/rules would still be possible
>> by processing lines in the commit message file without changing "git
>> commit".
>>
>> If "git commit" is already able to do some processing, it only adds
>> power to what can be done by people writing hooks.
>>
>> We could even have git plumbing commands used by git commit to process
>> the -f (or whatever option) arguments and they could be reused by the
>> *commit-msg hooks if they find them useful.
>
> Can you walk through an example of such reusable functionality?

Ok, let's call the new plumbing command "git interpret-trailers".
And let's suppose that "git commit" is passed "-f ack:Peff -f
fix:security-bug" (or "--trailer ack=Peff --trailer
fix=security-bug").

"git commit" would then call something like:

git interpret-trailers --file commit_message_template.txt 'ack:Peff'
'fix:security-bug'

And this command would output:

------------------
<<<upper part of commit_message_template.txt>>>

Fixes: 1234beef56 (Commit message summmary)
Reported-by:
Suggested-by:
Improved-by:
Acked-by: Jeff King <peff@peff.net>
Reviewed-by:
Tested-by:
Signed-off-by: Myself <myself@example.com>
------------------

Because it would have looked at the commit template it is passed and
filled in the blanks it could fill using the arguments it is also
passed.

"git commit" would then put the above lines in the file that it passes
to the prepare-commit-msg hook.

Then the prepare-commit-msg could just do nothing.

After the user has edited the commit message, the commit-msg hook
could just call:

git interpret-trailers --trim-empty --file commit_message.txt

so that what the user changed is interpreted again.

For example if the user changed the "Reviewed-by:" line to
"Reviewed-by: Johan", then the output would be:

------------------
<<<upper part of commit_message.txt>>>

Fixes: 1234beef56 (Commit message summmary)
Acked-by: Jeff King <peff@peff.net>
Reviewed-by: Johan Herland <johan@herland.net>
Signed-off-by: Myself <myself@example.com>
------------------

And that would be the final commit message in most cases.

Thanks,
Christian.
