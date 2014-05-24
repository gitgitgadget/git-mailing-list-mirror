From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] Add an explicit GIT_DIR to the list of excludes
Date: Sat, 24 May 2014 08:41:02 +0700
Message-ID: <CACsJy8CDeTn8h8uUn_=6ek7BJueN_1i01TB_AeH03RKnf6tNSw@mail.gmail.com>
References: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 03:41:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo0xt-0008RK-Gk
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 03:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbaEXBle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 21:41:34 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36240 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaEXBld (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 21:41:33 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so9416916qcy.31
        for <git@vger.kernel.org>; Fri, 23 May 2014 18:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4+KKVLUTvOaApPfxfIEtw/bQC03rZcxgVnpyDU1dJO0=;
        b=svXFaOYdBkAb5Bm5M9YFS02hfFLF+QZzT3EZHClIvqiqIm5sg9vstifdn9qAc+goqE
         X3Az/URhz/nCG3khaHEUcD7q6UGWa4WLagWsv3wzfgK0LuUf82EgAudPvDMOUu0nNQ+h
         IcapbErCVVAkWkeO1RzFsdPZVLp/k+zILm0U0we9Gmft1/H6FMBYUoaUF6cNb0eI2rFT
         XPrntAb98jHMrVnbZPqMaXNBp5KW/Mdx85q74LQKWitlcnzq5YkqHIxkZRSCkAiGor+J
         dYGoOUbvcf3Y7K7xBVKZqIouWemVhX/PQpCGalGSgk4/y2PISpGXijL7etE47WzwQDzU
         gBzQ==
X-Received: by 10.224.138.3 with SMTP id y3mr12261264qat.78.1400895693074;
 Fri, 23 May 2014 18:41:33 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 23 May 2014 18:41:02 -0700 (PDT)
In-Reply-To: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250051>

On Sat, May 24, 2014 at 12:33 AM, Pasha Bolokhov
<pasha.bolokhov@gmail.com> wrote:
> When an explicit '--git-dir' option points to a directory inside
> the work tree, git treats it as if it were any other directory.
> In particular, 'git status' lists it as untracked, while 'git add -A'
> stages the metadata directory entirely
>
> Add GIT_DIR to the list of excludes in setup_standard_excludes(),
> while checking that GIT_DIR is not just '.git', in which case it
> would be ignored by default, and that GIT_DIR is inside GIT_WORK_TREE
>
> Although an analogous comparison of any given path against '.git'
> is done in treat_path(), this does not seem to be the right place
> to compare against GIT_DIR. Instead, the excludes provide an
> effective mechanism of ignoring a file/directory, and adding GIT_DIR
> as an exclude is equivalent of putting it into '.gitignore'. Function
> setup_standard_excludes() was chosen because that is the place where
> the excludes are initialized by the commands that are concerned about
> excludes

I like this approach. A search of "exclude-standard" in Documentation/
gives git-grep.txt and git-ls-files.txt. I don't know if we need to
add something about this extra exclude rule to those .txt. If it's so
obvious that this should be the expected behavior, then probably not.

The case of "git grep --exclude-standard" is interesting because it's
intended to work without a repository. First reaction was would
get_git_dir() return NULL in that case. But it should return ".git" so
we're good.
-- 
Duy
