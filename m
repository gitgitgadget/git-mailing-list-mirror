From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Proposal] Clonable scripts
Date: Tue, 10 Sep 2013 03:48:32 +0530
Message-ID: <CALkWK0nk1KfL7YuTKuKJecPSxmu7gXmo67i2Ezb2QY5qmdN+rA@mail.gmail.com>
References: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Niels Basjes <Niels@basjes.nl>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:19:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ9nh-0006SU-5u
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab3IIWTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:19:13 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53069 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab3IIWTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:19:12 -0400
Received: by mail-ie0-f174.google.com with SMTP id k10so6105291iea.33
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g8EFO4KW4Xpa/opHlYSSdNRwsx/0wK6LI6kDk5Q8+PM=;
        b=j8yRVwgTJLQ85itAdoyrokYXVmO6AVq/GD+6Xi7lc5rMt2JQdbn+dG0ihWBYd9m8KA
         aND7xmI0m53mcBe8sXKf7GungCK/RcP3jayM8p/Ko7lbHNfCpAVGyBx/X9S9XNFKmd4z
         OscYsgVE5tSfrUDiVszAW72qp3TybpN09QbWPjZhB5sifrjvYuGwXxqyBboMFJJTuclL
         tdyBr1YpOvcmI8euZtCa9TrZmZy3ii8mEOAU0g5mGNTJ+TGNZEda1yF0pc6o9SF14US6
         m7yjnELwiagodI5w4Hfq3/PQ5GXfR54nGxQlX2IryOV2MJqDlg9BK0EBZ0dakMwZ2+FZ
         2tyw==
X-Received: by 10.50.97.35 with SMTP id dx3mr9599149igb.55.1378765152506; Mon,
 09 Sep 2013 15:19:12 -0700 (PDT)
Received: by 10.64.73.5 with HTTP; Mon, 9 Sep 2013 15:18:32 -0700 (PDT)
In-Reply-To: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234383>

Niels Basjes wrote:
> As we all know the hooks ( in .git/hooks ) are not cloned along with
> the code of a project.
> Now this is a correct approach for the scripts that do stuff like
> emailing the people responsible for releases or submitting the commit
> to a CI system.

More often than not, maintainers come with these hooks and they keep
them private.

> For several other things it makes a lot of sense to give the developer
> immediate feedback. Things like the format of the commit message (i.e.
> it must start with an issue tracker id) or compliance with a coding
> standard.

i.e. tracker ID. Compliance is simply a request. The developer must be
able to pick it up from surrounding style.

> Initially I wanted to propose introducing fully clonable (pre-commit)
> hook scripts.
> However I can imagine that a malicious opensource coder can create a
> github repo and try to hack the computer of a contributer via those
> scripts. So having such scripts is a 'bad idea'.

I think it's a good idea, since the contributer can look through the scripts.

> If those scripts were how ever written in a language that is build
> into the git program and the script are run in such a way that they
> can only interact with the files in the local git (and _nothing_
> outside of that) this would be solved.

GNU make.

> Also have a builtin scripting language also means that this would run
> on all operating systems (yes, even Windows).

kbuild tends to get complicated.

> So I propose the following new feature:
>
> 1) A scripting language is put inside git. Perhaps a version of python
> or ruby or go or ... (no need for a 'new' language)

make + go sounds like a good alternative.

> 2) If a project contains a folder called .githooks in the root of the
> code base then the rules/scripts that are present there are executed
> ONLY on the system doing the actual commit. These scripts are run in
> such a limited way that they can only read the files in the
> repository, they cannot do any networking/write to disk/etc and they
> can only do a limited set op actions against the current operation at
> hand (i.e. do checks, parse messages, etc).

Submodules and url.<url>.insteadOf come in handy here.

> 3) For the regular hooks this language is also support and when
> located in the (not cloned!) .git/hooks directory they are just as
> powerful as a normal script (i.e. can control CI, send emails, etc.).

I'm confused now; how can .git/hooks be as powerful as .githooks? The
former users should consider uploading their code on GitHub.

> Like I said, this is just a proposal and I would like to know what you
> guys think.

> Best regards / Met vriendelijke groeten,

Which reminds me that we need to have GitTogethers. Thanks for this!
