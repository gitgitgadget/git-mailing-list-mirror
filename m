From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Tue, 30 Jun 2015 09:33:55 -0700
Message-ID: <xmqqy4j16tqk.fsf@gitster.dls.corp.google.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<CACsJy8BYeYq-fQX=M1h2r4daQSsemXQT4Y+ww2Z3Y54brUS3QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:34:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9yTy-0008UZ-TP
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 18:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbbF3Qd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 12:33:58 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33135 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbbF3Qd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 12:33:58 -0400
Received: by ieqy10 with SMTP id y10so16373082ieq.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cUDz7rkobYFVCgSZlqMxRhJzitjUKYZKGANPNupJ1E4=;
        b=0f1W/L/0ypY7H3UXRlo0L/fu0PaFeB64gKTKdldilnb3ueR2EmM0w+26ScxOg7MycO
         idxBdQ8maZIx+T1rJzFhwfjTOHDhMmhEZo/fg2O/SvJJwLHZLwcw1gCzeCAdjX8s/Iwd
         7/D2VXi2iDM791jCj+5Xn3FKJRFcTPHWk70shJR0ENwkyvZX8uB4Kvfalob3qfZdjtFw
         QHWd2NICnudTehzTLEIBYrWP9rIfzGroE8h/hQC3m67hjDGrPLyRiMv21YlqcmTC2V09
         g+TGxVwNEoFUq6egiaeqkm/Gis7WpcDkgQJt1o7R8F6O9mAMgsaj9KGHIv/5kDukx97v
         lg7Q==
X-Received: by 10.107.137.41 with SMTP id l41mr20327112iod.60.1435682037227;
        Tue, 30 Jun 2015 09:33:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id rj5sm8068774igc.2.2015.06.30.09.33.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 09:33:56 -0700 (PDT)
In-Reply-To: <CACsJy8BYeYq-fQX=M1h2r4daQSsemXQT4Y+ww2Z3Y54brUS3QQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 30 Jun 2015 16:23:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273080>

Duy Nguyen <pclouds@gmail.com> writes:

> I think this is like "git checkout -b" vs "git branch". We pack so
> many things in 'checkout' that it's a source of both convenience and
> confusion. I never use "git branch" to create a new branch and if I
> had a way to tell checkout to "move away and delete previous branch",
> I would probably stop using "git branch -d/-D" too. "--to" is another
> "-b" in this sense.

I didn't know "checkout --to" included "create a worktree elsewhere
and chdir there"; if that "and chdir there" is not something you are
doing, then I do not think "checkout -b" vs "branch" analogy applies.

> "git worktree new" definitely makes sense (maybe stick with verbs like
> "create", I'm not sure if we have some convention in existing
> commands), but should we remove "git checkout --to"?

I'm in favor of removing "--to" before it escapes the lab.

I am ambivalent about "new", but that is only because I know about
the 'new-workdir' in contrib/.  If I pretend to be a naive end user,
I'd think a verb subcommand would be more in line with the rest of
the system than "new".

I however do not think "create" is a good verb.

Wouldn't "git worktree $the-command-in-question" be a management
command that adds a new worktree to the existing collection, like
"remote add", "notes add", etc. do?  Perhaps "git worktree list" and
"git worktree remove $that_one" would be in its future?

That suggests "add" may be a better choice for "worktree".

The only subcommand that I can think of offhand that says "create"
is "bundle"; after generates a new bundle, its presence is not known
to the repository the bundle was created out of, so not using "add"
but calling the operation "create" is fine for "bundle".
