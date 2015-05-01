From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Improving code base readability
Date: Fri, 1 May 2015 11:59:46 -0700
Message-ID: <20150501185946.GV5467@google.com>
References: <CAKB+oNvB322hyX3UbGBPETDc0zEdC39PdeM=GG=rVf_WYGq_OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 20:59:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoGAH-0003yQ-EB
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 20:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbbEAS7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 14:59:54 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38004 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbEAS7t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 14:59:49 -0400
Received: by igbhj9 with SMTP id hj9so45154721igb.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kXRgBqpx3TWwXASrL5PSEDiSPOFltEj3/QSX5VwG1xM=;
        b=0v0m8HLRpfUNhwpNoAtbj4lPrRpx5QXRRdlDN2zRtwc4h2ZUwDLMCtYkFzywnLBclb
         31pKVTAQ+CIkVQVoVHRm6Idi7YR0++IjfWA8ZyTVkVKM12WDgHM+/UV9FBOyLrZAjK3M
         0D+oDySBqDvGrJLi8YTV4EPP5VIFYK9DuBSExK9MW2mGKjqP/2mRAM/p2qV+qlg1N9At
         lLAwdmm/eEt2Ku6bT86zfWWnbgviLgOv8JC79vxvGkcWTbZmjd+XacP5EF3i5ojzt9gs
         v6pOs2udLFZX36y3i+ZoPRgJyRn5+cQo80Oxmx1sRS7RqkB+RKvHKXxnk3h9VJE5F2cL
         y7RQ==
X-Received: by 10.107.47.163 with SMTP id v35mr13825748iov.86.1430506788986;
        Fri, 01 May 2015 11:59:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:78ee:62b:39f1:c708])
        by mx.google.com with ESMTPSA id v4sm4026153ioi.40.2015.05.01.11.59.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 May 2015 11:59:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKB+oNvB322hyX3UbGBPETDc0zEdC39PdeM=GG=rVf_WYGq_OA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268173>

Hi,

Alangi Derick wrote:

> This is an example of what i am talking about or what i am trying to
> demonstrate. This is the patch:

Thanks for giving an example.

[...]
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -102,7 +102,7 @@ static int stream_blocked(const unsigned char *sha1)
> 
>   st = open_istream(sha1, &type, &sz, NULL);
>   if (!st)
> - return error("cannot stream blob %s", sha1_to_hex(sha1));
> + return error("Cannot stream blob %s", sha1_to_hex(sha1));

This is not about code readability but about the program's output, no?

Habit is to use lowercase for error messages, to be brief, and to not
include a period at the end since they are not sentences.  For
example:

	$ nonexistent-command
	bash: nonexistent-command: command not found

Git tends to follow that practice, too, though it is not completely
consistent about it.

As a first contribution, I don't think this is a good project to
embark on.  It would touch a lot of code, meaning it is difficult to
time to avoid interfering with other patches.  It is relatively
low-impact or the impact is hard to demonstrate: consistency is
pleasant, but the capitalization does not seem to be interfering with
the program's usability.  Once the work is done, it is easy to
backslide unless there is an automated test to avoid that, which makes
the work more technically complicated.

If you'd like a project that involves touching a large part of the
codebase, one ongoing project has been to mark human-readable strings
for translation.  See "Marking strings for translation" in po/README
for hints about how that works.

The same timing issues about avoiding conflicting with other people's
work apply there, too, but I'd be happy to help as you go.  And the
impact can be pretty big, both in consistency (a mixture of English
and native language output due to incomplete i18n is not a great
experience) and usability (for some, being able to interact with git
in their native language makes using git much easier).

A search with

	git grep --cached -F -e 'error("'

finds many files with untranslated strings.

Such work might lead you to discover unclear code, unclear messages,
or aspects of git's behavior that you'd like to change, which can also
lead to other patches that go in other directions.

What do you think?

Thanks,
Jonathan
