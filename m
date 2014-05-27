From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: [PATCH v3] Add an explicit GIT_DIR to the list of excludes
Date: Tue, 27 May 2014 14:46:55 -0700
Message-ID: <CAKpPgvc8Ju0dWiuwk=0=_72SLcK57wAXwiRkjs_us3EW+L_jjw@mail.gmail.com>
References: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com>
 <CACsJy8CDeTn8h8uUn_=6ek7BJueN_1i01TB_AeH03RKnf6tNSw@mail.gmail.com> <xmqqd2ezgkt4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 23:47:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpPDN-0008IM-W9
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 23:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbaE0VrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 17:47:18 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:47874 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbaE0VrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 17:47:17 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy5so10017580obc.29
        for <git@vger.kernel.org>; Tue, 27 May 2014 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E5Z/nqIHRi/pyd3VA46nlnqtjpyA1+G3dOlvFC/GWd0=;
        b=xVE3ennLmiEs0+aZut45KpKO74qcN4kyK/tYoMcDELcg7ZupjJAzgFKtr9KA4Tno6d
         n4qGA80UWqex1E1fhtfuqSI3wv7XAltdg7Q9xlelL8zdWF8hwS3WWfoPp+tzH5iTTpW2
         l8lwiCg6olde94VM2ECO/i5KcvL+aeBDJV4DsYvvrdFPyKWQsLiYhojtxRcJGGH17k0y
         mZo+wQ7PvXektIMZUkxqCsKOrCbexJ4kftw4zIDpyqquwAhtT+TIPD3yfRPr7dO+TEjJ
         tnpcSmMlPng7YS8xa+XxOsL2gF0gZb2rA0wngyw4Hl9vsRODozECis6KpL2r70SSnw8k
         4Pvw==
X-Received: by 10.182.3.36 with SMTP id 4mr36900136obz.56.1401227236906; Tue,
 27 May 2014 14:47:16 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Tue, 27 May 2014 14:46:55 -0700 (PDT)
In-Reply-To: <xmqqd2ezgkt4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250241>

I've sent out version [PATCH v4] with most of the things addressed.
That one hasn't been reviewed by anyone yet


On Tue, May 27, 2014 at 11:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, May 24, 2014 at 12:33 AM, Pasha Bolokhov
>> <pasha.bolokhov@gmail.com> wrote:
>>> When an explicit '--git-dir' option points to a directory inside
>>> the work tree, git treats it as if it were any other directory.
>>> In particular, 'git status' lists it as untracked, while 'git add -A'
>>> stages the metadata directory entirely
>>>
>>> Add GIT_DIR to the list of excludes in setup_standard_excludes(),
>>> while checking that GIT_DIR is not just '.git', in which case it
>>> would be ignored by default, and that GIT_DIR is inside GIT_WORK_TREE
>>>
>>> Although an analogous comparison of any given path against '.git'
>>> is done in treat_path(), this does not seem to be the right place
>>> to compare against GIT_DIR. Instead, the excludes provide an
>>> effective mechanism of ignoring a file/directory, and adding GIT_DIR
>>> as an exclude is equivalent of putting it into '.gitignore'. Function
>>> setup_standard_excludes() was chosen because that is the place where
>>> the excludes are initialized by the commands that are concerned about
>>> excludes
>>
>> I like this approach. A search of "exclude-standard" in Documentation/
>> gives git-grep.txt and git-ls-files.txt. I don't know if we need to
>> add something about this extra exclude rule to those .txt. If it's so
>> obvious that this should be the expected behavior, then probably not.
>
> OK, so is that an Acked/Reviewed-by?
>
>>
>> The case of "git grep --exclude-standard" is interesting because it's
>> intended to work without a repository. First reaction was would
>> get_git_dir() return NULL in that case. But it should return ".git" so
>> we're good.
