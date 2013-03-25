From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Mon, 25 Mar 2013 09:43:23 -0400
Message-ID: <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
References: <20130324183133.GA11200@sigill.intra.peff.net> <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 14:49:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK7mI-0006ap-BU
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 14:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758045Ab3CYNtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 09:49:01 -0400
Received: from mail-qe0-f54.google.com ([209.85.128.54]:37896 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757818Ab3CYNs7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Mar 2013 09:48:59 -0400
Received: by mail-qe0-f54.google.com with SMTP id i11so3299303qej.13
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=EbdSY5w/Xry86xkmiHYu4QZRuMAlDQiqkATHGTQcZSY=;
        b=SzJnM8gxIRuCup9eFWXNEKnUdbf1Ndpl1q0iDU9UYPWHsi7hAuS6/D/w9y04e28yZ3
         o3STLWn3c/EC7QLEdPlGKwrqn/dKdqg4Nqu02dLGHn8sdnro5q1INwHDnAwKzpHFHf8B
         YkqauYwtMdb3Jm0VVSRCFMJjDo3pxN707Fh1MckEEP1cR+x24Mtydb+u2vJfaI95q0F2
         QOvDnFH6MCaKECc6cUM5BSYGyP/Oq+UlPpkCw7ZICsUa5cZ66szv0G4Ng6+ttjIw9eie
         9HwIvutpf5wQalusrhk+DvM/RwSYo51Zl6RGVRSKuF8A5LRTuql7gyf6qzY1z4ogQmRw
         XXsw==
X-Received: by 10.224.221.81 with SMTP id ib17mr3134294qab.62.1364219023240;
 Mon, 25 Mar 2013 06:43:43 -0700 (PDT)
Received: by 10.49.110.164 with HTTP; Mon, 25 Mar 2013 06:43:23 -0700 (PDT)
In-Reply-To: <20130324192350.GA20688@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219032>

On Sun, Mar 24, 2013 at 3:23 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 24, 2013 at 08:01:33PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> On Sun, Mar 24, 2013 at 7:31 PM, Jeff King <peff@peff.net> wrote:
>> >
>> > I don't have details on the KDE corruption, or why it wasn't detec=
ted
>> > (if it was one of the cases I mentioned above, or a more subtle is=
sue).
>>
>> One thing worth mentioning is this part of the article:
>>
>> "Originally, mirrored clones were in fact not used, but non-mirrored
>> clones on the anongits come with their own set of issues, and are mo=
re
>> prone to getting stopped up by legitimate, authenticated force pushe=
s,
>> ref deletions, and so on =E2=80=93 and if we set the refspec such th=
at those
>> are allowed through silently, we don=E2=80=99t gain much. "
>>
>> So the only reason they were even using --mirror was because they we=
re
>> running into those problems with fetching.

With a normal fetch. We actually *wanted* things like force updates
and ref deletions to propagate, because we have not just Gitolite's
checks but our own checks on the servers, and wanted that to be
considered the authenticated source. Besides just daily use and
preventing cruft, we wanted to ensure that such actions propagated so
that if a branch was removed because it contained personal
information, accidental commits, or a security issue (for instance)
that the branch was removed on the anongits too, within a timely
fashion.

> I think the --mirror thing is a red herring. It should not be changin=
g
> the transport used, and that is the part of git that is expected to
> catch such corruption.
>
> But I haven't seen exactly what the corruption is, nor exactly what
> commands they used to clone. I've invited the blog author to give mor=
e
> details in this thread.

The syncing was performed via a clone with git clone --mirror (and a
git:// URL) and updates with git remote update.

So I should mention that my experiments after the fact were using
local paths, but with --no-hardlinks. If you're saying that the
transport is where corruption is supposed to be caught, then it's
possible that we shouldn't see corruption propagate on an initial
mirror clone across git://, and that something else was responsible
for the trouble we saw with the repositories that got cloned
after-the-fact. But then I'd argue that this is non-obvious. In
particular, when using --no-hardlinks, I wouldn't expect that behavior
to be different with a straight path and with file://.

Something else: apparently one of my statements prompted joeyh to
think about potential issues with backing up live git repos
(http://joeyh.name/blog/entry/difficulties_in_backing_up_live_git_repos=
itories/).
Looking at that post made me realize that, when we were doing our
initial thinking about the system three years ago, we made an
assumption that, in fact, taking a .tar.gz of a repo as it's in the
process of being written to or garbage collected or repacked could be
problematic. This isn't a totally baseless assumption, as I once had a
git repository that I was in the process of updating when I had a
sudden power outage that suffered corruption. (It could totally have
been the filesystem, of course, although it was a journaled file
system.)

So, we decided to use Git's built-in capabilities of consistency
checking to our advantage (with, as it turns out, a flaw in our
implementation). But the question remains: are we wrong about thinking
that rsyncing or tar.gz live repositories in the middle of being
pushed to/gc'd/repacked could result in a bogus backup?

Thanks,
Jeff
