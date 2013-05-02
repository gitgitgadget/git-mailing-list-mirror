From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 16:33:21 +0530
Message-ID: <CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-2-git-send-email-artagnon@gmail.com> <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
 <CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
 <CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com> <CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 13:04:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXrJ3-00039W-J3
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 13:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170Ab3EBLEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 07:04:04 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:38572 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab3EBLEC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 07:04:02 -0400
Received: by mail-ia0-f179.google.com with SMTP id g4so362073iae.10
        for <git@vger.kernel.org>; Thu, 02 May 2013 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5gHbvXRP1BLfBQ00JI6qxwXru8Fy47E6Fw5KjhpYYJg=;
        b=ZEOwtODzzUlGY0Zmv/n1QF54wIqPdttNTXc7YBnJ9WyNm/38C9xgPPwvzb6ksofkBz
         qZYzNCabXKZ/EN5bdC3nCGFe6T+tcxaOXXmezQRpkz8GQOq438llMUpcLj//m6hkVggu
         yhY9pdXMHobR2OB3KVeksOiRrQ8xsgRufN7earoQN7v1eDa8RB6Fj3xyH6vO31+xmTbv
         Ohl3JiBm7mx3pPrZNtqIlwjgtxV4HkOAM7qxhx5nah9V+OgIRHkGLgPwuOEptZ0HIkgB
         a+/he3VQfm64PkScT0768XNMX8dBhip6ymfdMgIFS3JPMK/ZIVNu8pjwEZz/B50rgGQR
         9KYQ==
X-Received: by 10.50.72.65 with SMTP id b1mr3612865igv.63.1367492641839; Thu,
 02 May 2013 04:04:01 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 04:03:21 -0700 (PDT)
In-Reply-To: <CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223192>

Felipe Contreras wrote:
> But HEAD is special, @ is not. HEAD is documented, @ is not.

Your point being?  That we should document @?  Yes, I agree.

> Where is it documented that @ points to HEAD? Where is it documented
> that 'branch -u foo @' would replace @ with HEAD?
> Documentation/revisions.txt? Sorry, 'git branch -u foo' does not parse
> revisions, so that's not the answer. And there's many other places
> that don't do revision parsing either.

You're confusing parsing revisions with parsing symbolic-refs.  I've
documented @ right next to HEAD, FETCH_HEAD and the other symbolic
refs in revisions.txt.  Yes, we have to update the documentation of
commands like 'git branch -u foo' to make it clear that they can
operate on symbolic-refs (not just "HEAD") that point to branches, not
just plain branch refs.

Maybe even a fresh page on symbolic refs?

> Your approach is more like a hack,

Now you're just saying rubbish.  Neither of the approaches is more of
a "hack" than the other.  You've implemented @ as a revision, while
I've implemented it as a symbolic-ref.

Your approach requires less effort to document, and my approach yields
an implementation that is almost trivial.  That is not the basis for
determining which approach is "better".

> it has the consequences we want,
> but it has many other unintentional and undocumented consequences.

Who said it wasn't intentional?  Yes, I agree with your criticism
about it being undocumented: please help fixing this.

It's very much intentional.  I _want_ these to work:

% git symbolic-ref M refs/heads/master
% git show M@{u}
% git branch -u ram/master M

In other words, I want commands that operate on "HEAD" to also operate
on other symbolic refs similarly.  Is this an unreasonable request?

> If I find a single place where 'HEAD' is hard-coded, and your patch
> doesn't replace '@' correctly, would you then accept that there are
> unintentional consequences, and that this approach is no the best
> precisely for that reason?

You'd have found a bug then, and we must fix it.  Why are you throwing
useful features out the window simply because of difficulty of
documentation/ historical inertia?

> Ramkumar Ramachandra wrote:
>> git branch X <any
>> expression with or without a symbolic ref> works fine, and it has
>> nothing to do with my series.
>
> No, it doesn't.
>
> % git symbolic-ref TEST refs/heads/master
> % git branch -u origin/master TEST
> fatal: branch 'TEST' does not exist
> % git branch --edit-description TEST
> error: No branch named 'TEST'.

Are you reading what you're responding to?  I said:

% git branch X @{-1}
% git branch X HEAD
% git symbolic-ref M refs/heads/master
% git branch X M

Will work with or without my patch.  This is because git branch <1>
<2> runs <2> through the revision parser.

This will work with my patch:

% git symbolic-ref M refs/heads/master
% git branch -u origin/master M

precisely because:

% git branch -u origin/master HEAD

works.  And precisely because this does not:

% git branch -u origin/master @{-1}

In other words, git branch -u <1> <2> expects <2> to be a ref or
symbolic-ref (currently limited to "HEAD"), not a revision.  It
doesn't run <2> through the revision parser to check if it resolves to
a ref.

The following will not work:

% git symbolic-ref M refs/heads/master
% git branch --edit-description M

precisely because:

% git branch --edit-description HEAD

does not work.  This is because git branch --edit-description <1>
expects <1> to be a non-symbolic ref.  It doesn't even hard-code
"HEAD".

Why are you blaming my patch for existing inconsistencies in the UI?

There is one limitation worth nothing: a symbolic-ref can only point
to a ref (or another symbolic ref).  The revision parser doesn't kick
in at the resolve_ref_unsafe() stage.  So, it's quite non-trivial to
implement what Thomas asked for (git symbolic-ref U @{u}).  However, I
think my series is one step in the right direction.  I'd really love
symbolic refs I can take along with me (so M -> master can be in my
.gitconfig): we have to hook resolve_ref_unsafe() to the config API to
achieve this.

In other words, I'm thinking about the future of symbolic refs.
