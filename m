From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/18] remote-bzr: massive changes
Date: Wed, 1 May 2013 01:36:02 -0500
Message-ID: <CAMP44s3zf0Hbx4-KHVH7+wCm_czTigJo2y=wqD5Ai-9cKxZcug@mail.gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
	<7vppxb8d9k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 08:36:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXQeO-0000bR-FW
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 08:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab3EAGgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 02:36:08 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:55881 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3EAGgE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 02:36:04 -0400
Received: by mail-la0-f46.google.com with SMTP id fs13so1112888lab.33
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=v/OETaEsxDLR7a8+DoRj36PgBXsofs6bcvxBh9RWqZA=;
        b=PLQHdnhXzqduzO3bW+KhL37CxnUW0T97RPKRoYJeMOLyUHXlDen1MDvivoXqk6nHt6
         l7yHfD5uTZ9J2yTLKwob3bUk8IjIyN8C0+ZuONuuNHUvV7GAiXL9RgLp0jbhXqxO0YZn
         1NZSOgyucXr163sM+yPnWui2hVVHi2wCR2I91ovDa9INeq/SknJC/GOojNRwtyqom9WV
         lzO61SyD9YEmEqCzuPNNDCWvplAREDAKklkWhFwuKMKwMmQOGK0Vvj5StOb1WYLDT3/5
         D6NEQmZE7mvVFarM8ibjKdlaWYtVwGf4JSO/DjxDp6eIqNrn43vazO4WBCk2FM41R6QT
         4U9A==
X-Received: by 10.152.19.10 with SMTP id a10mr539396lae.8.1367390162963; Tue,
 30 Apr 2013 23:36:02 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 23:36:02 -0700 (PDT)
In-Reply-To: <7vppxb8d9k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223071>

On Wed, May 1, 2013 at 12:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> After being contacted by the emacs developers and others who are stuck with
>> Bazaar, which at this point seems to be utterly abandoned, I realized the
>> current implementation is too crude.
>> ...
>> That is of course, if pushing actually worked (which in many cases doesn't).
>>
>> In short, our support for real-world projects suck.
>>
>> These patches fix all the issues I encountrered.
>> ...
>> Finally, after all these changes I was finally able to clone the whole emacs
>> repository, all 130685 commits, and 56 branches without running out of memory
>> in my modest laptop.
>
> Yay ;-)
>
> I assume that the trees at a handful of key points (e.g. releases)
> were verified to be identical with the original history and the
> conversion result.

Not really. I don't think the users are that interested in the history
being identical at this point, merely that they can use it as a proxy
to interact with bazaar repositories.

People have found discrepancies, so I assume they have compared at
least the tip of the branches, and found them. This probably means
that the history is correct, since bazaar deals with changesets (git
is one of the few DSCMs that don't).

Also, there's further news on this, pushes seem to work correctly to
the emacs' repo[1].

>> I'll ask the emacs developers to give them a try, and let's see
>> how it goes.
>
> Yeah, that's the least we can do for both existing and future users.
>
> Generally speaking, post -rc0 is too late for "if no issues are
> found", simply because no existing user has enough time to find
> corner case regressions in her work using the new software (I do
> not expect a trivial bug that can be uncovered in a few weeks of use
> would remain in a version that has successfully converted the Emacs
> history; but real world users always have different needs than what
> we anticipate).
>
> I however am finding myself moderately receptive to this series.
> That is primarily because this series touches only two files that
> are totally isolated from the rest of the system.  Even if they did
> not work at all, there is no risk for the remainder of Git.  Nobody
> other than existing users of remote-bzr will even notice if we
> merged this by the final.
>
> For existing users of remote-bzr that we shipped in 1.8.2, the story
> is a bit different, though.  If this series makes things worse in a
> way your tests did not reveal, and if such a regression is not
> reported and/or cannot be fixed by 1.8.3 final, that will mean a
> real regression in the released version for them.
>
> If that ever happens, that would be the time for us to regret the
> hasty decision to merge remote-bzr in 1.8.2, justifying that with a
> "There wasn't anything working for interoperating with bzr, and here
> is one to do so; anything is better than nothing", and learn from
> that mistake (it is not an option to say "the 1.8.2 users chose to
> use contrib/ material that are clearly marked as sub-par quality
> with their own risk".  If we did not ship it in 1.8.2, they did not
> have to get burned with any regression and could have kept working
> with bzr a bit longer.  "Anything" is not necessarily better than
> "nothing").

Fortunately there seem to be at least some users that find what is in
1.8.2 working to some extent, not in all the repositories, and not all
the features, but at least something, which is much better than the
alternatives, even the best one has been blocked for years, even when
a solution is known[2].

> Hopefully, such a regression will not have to happen (for one thing,
> I would expect that the existing 1.8.2 remote-bzr user base would be
> very small).  Also I somehow have a feeling that it is very unlikely
> to happen, especially given your report:
>
>  (1) the series converts Emacs history without barfing; and
>
>  (2) you have some confidence in the conversion result after
>      inspecting at least a handful of key release points and trees
>      and metainformation match between the original and the
>      converted history.
>
> So let's go ahead and apply these directly on top of 'master', once
> we hear from Emacs folks and they are happy with it.  I'll queue it
> on 'pu' so that I do not have to go back to the list archive when it
> happens.

I already heard that everything seems to be working correctly, except
one feature, the biggest change, which I screwed up with a one-liner
commit. That's why I added a test. Anyway, I've fixed it in my github
branch and in this patch series, and I've told them to try the fix.

Let's see.

Cheers.

[1] http://bzr.savannah.gnu.org/lh/emacs/xwidget/revision/101292
[2] https://bugs.launchpad.net/bzr/+bug/541626

-- 
Felipe Contreras
