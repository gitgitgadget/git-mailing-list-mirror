Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C202C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 03:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FAA2072D
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 03:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9RU0FeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgCaDxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 23:53:17 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:34118 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCaDxR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 23:53:17 -0400
Received: by mail-pf1-f169.google.com with SMTP id 23so9711406pfj.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 20:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2453McZ1DU3uF3cN+TdCF7CDLNbOV8yMR4/AJ7+7yQM=;
        b=m9RU0FeMPs10OD9yOuW9pVum373OJ7jEZ7uLHkoojIbUkLIPhN13NS692fNyeT81Sb
         I7wApOhQwAFfAGVBBjlCtpPYIYW/GgrQCVtfyQjJMe7otXhKHtVGpRyQjRlH0k3Db7T+
         MSDAvynN74JupJoXClexTh20hLyCVlqyk7lc4nhGe7Qcxq4P8kKNJCZa3DgVp+XWn+V9
         kjGo8NousADaL+vr0EyrXfu8qrYafXcLdaOJ4KdHVLizyWnOfj85pt/X3Sg0hYIYQmwV
         2QZKmLXaoKfkUMGs5+U1inBVXV0OXC8Z7MzqKfw+DgkxMlFvOdS7OX6/f3hf/4XJsS1k
         R/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=2453McZ1DU3uF3cN+TdCF7CDLNbOV8yMR4/AJ7+7yQM=;
        b=c/dckGxW8k68U01ZQphuLKMFzFjDju3I9IzA1Qmy2n7Jqt+y7QEFD51/88doSl8VR6
         QRqp57JKJLIzPRe9L496zJB8YZd/6mqKt04VFC9mfr+TTULr9GcbaR0yMILEeEyKIJ02
         Iegfr1qL06zQj5SpCs9FBh+ganGlDEMse1ZRdrk5oIG7PzzMoD+tIfP9ZNBsXCC+lfv3
         PxAMjHQzxMGdGmvqjBPmc0gu75qz8v/DS5qLeLGQI0icbe3NCK5G2R/tdfSqTjkGYw1O
         0/JnR8bP19Y4tKK3U5x51RbxZ7RKQ3JlkXaKWtDLI3A1WBV5y6toFMWx7VduDzuSWHG0
         8OXA==
X-Gm-Message-State: ANhLgQ1cvRCE6PJDj48jweJugeikrqpGUoA15UZoVlYo/fRKbEFjv6uW
        PKzlDp9D1ayp78jkWDp6BcY=
X-Google-Smtp-Source: ADFU+vuDWNT5QTO/pZj72uGVkFOakfw/w2C58bVFRJAaLk2bUCGIl9IszCYg0p0+mOkAevNN/ukWSA==
X-Received: by 2002:aa7:998e:: with SMTP id k14mr15862352pfh.313.1585626794724;
        Mon, 30 Mar 2020 20:53:14 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:7:51b6:8571:d99:52d0:9caf])
        by smtp.gmail.com with ESMTPSA id s1sm11165796pfh.59.2020.03.30.20.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 20:53:13 -0700 (PDT)
Date:   Tue, 31 Mar 2020 09:22:06 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Angel Pan <dinoallosaurus1111@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][Proposal v1] My proposal for GSoC 2020
Message-ID: <20200331035206.GA1576@Abhishek-Arch>
Reply-To: CAFk=nY5QSWk+2_eLdyS+4Nzbm23R7i1A4NEOEVxHueCSytgBTQ@mail.gmail.com
References: <CAFk=nY5QSWk+2_eLdyS+4Nzbm23R7i1A4NEOEVxHueCSytgBTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFk=nY5QSWk+2_eLdyS+4Nzbm23R7i1A4NEOEVxHueCSytgBTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 04:39:25AM +0800, Angel Pan wrote:
> Hello everyone.
> Here is my proposal for GSoC. A review or criticism would be appreciated.
> 
> Google doc version:
> https://docs.google.com/document/d/19Nkesmet7X7U42lsvksXoiEBrnOppKicWHYKneEQsQ8/edit?usp=sharing
> 
> Best regards,
> Angel
> 
> ----------

Side note: Use the project title in the e-mail subject. This would help
mentors to understand what the project is about at a first glance.

>
> # Unify ref-filter formats with other `--pretty` formats
> 
> ## Contact Information
> 
> Full name: Yun Pan(Angel Pan)
> 
> Email: [dinoallosaurus1111@gmail.com](mailto:dinoallosaurus1111@gmail.com)
> 
> IRC: dinoallosaurus
> 
> GitHub: dinoallo
> 
> Timezone: UTC+8
> 
> ## Short Biography
> 
> I am a first year student in Computer Science at Zhejiang University
> in China. It's my first time participating in GSoC. I have had
> experience working with C/C++, shell scripts, Python, Go and Perl. I
> am interested in writing CLI or system scripts/configurations, which
> is the main reason I apply to Git project. I might be relatively new

"I am applying" instead of "I apply".

> when it comes to contributing on-line project. However, I am a quick

"on-line" project is an unusual word choice, although I understand your
sentiment. Collaborative might work better.

> and avid learner so if I don’t have enough skills to complete the job,
> I can self-learn immediately.
> 
> ## Working Environment
> 
> My operating system is Arch Linux, which I started using it about half
> an year ago. Before then I was using Debian-based systems like Ubuntu.
> And I have some experience using git on Windows as well.
> 

Nice! I use Arch too.

> I mainly use Emacs and VS Code as my editor but I can use Vim also. I
> am able to use both markdown and Org-mode on Emacs for documenting
> 
> ## Coding/Contributing Experience
> 
> C is my *native* language I like to config my computer and automate

"configure" instead of "config".

> some work on it by myself so I learned shell-scripts and other
> scripting languages.  Now I write code related to back-end for the
> student club at my university.
> 
> Since I used to develop web before, there is a small-project written
> in Python with Django on my GitHub page. From the experience of
> applying to git, I obtained much deeper knowledge about git and how it
> works. No matter what the outcome is, I am looking forward to
> contributing more to git and work with all the developers.
> 
> ### Microproject
> 
> Mailing list: https://lore.kernel.org/git/pull.595.git.1585588586605.gitgitgadget@gmail.com/T/#u
> 
> GitHub: https://github.com/gitgitgadget/git/pull/595
> 
> Status: waiting to be review.

I have reviewed the pull request. Code changes seem look good to me but
you need to write a better commit message (as harry-hov noted). Send out
a second version as soon as you are done.

The title and a one-line description of the microproject in the proposal
would be useful.

>
> ## Introduction
> 
> Currently, the placeholder used in ref-filter expansion `%(foo)` has
> not yet supported in `--pretty` format.
> 
> Using the new ref-filter formats has its own convenience.  For
> example, the format `%(foo)` is more human-readable, easy to process,
> and extensible if we want to add some options in each placeholder(like
> `%(trailers:only=bogo)`) . Hence,  users can just simply add the
> options in the placeholder if needed, reducing their frustration in
> constructing long and complex output command.
> 
> My goal is to unify the the ref-filter formats with `--pretty` formats
> and generalized them in git:

"generalize" instead of "generalized"

> 
> * Get rid of unrecognizable placeholders like `%an` to `%(authorname)`.

Removing old, short placeholders like `%an` could break existing scripts
and user flow.

Having both short and descriptive placeholders would be better.

> * Introduce format-scripting(like the one used in `git-for-each-ref`)
> to `--pretty` and even make a field in user's configuration to use
> default format-script for `--pretty`.
> 

Could you elaborate on what format-scripting means? Do you mean use of
`--format` option to configure the output format?

While the two goals you have are appreciable, the broader aim of this
project is to remove *duplicate* implementation of format command
output.

You can also read up on other proposals and previous work done on this
project idea.

> ## Deliverables/Timeline
> 
> ### ~ May 5th
> 
> * I will keep an eye on git project and make more patches to it if possible.
> * At the same time, getting to know more about the community and
> collaborating with others.
> 
> * Also I will talk to my potential mentor, to get more concrete and
> constructive advise about my project. Last, finalize my project.
> 
> ### May 5th ~ June 2nd
> 
> Community-bonding period:
> 
> After having rounded understanding about the community and all the
> past work, I would like to revise my previous ideas regarding to my
> project if there is a much better solution or other problems. Then, I
> will start to work on a part of my project:
> 
> * Carefully examine `ref-filter` related code to see what I can learn
> from(the implementation, etc...) and what to avoid doing.
> * Replace the placeholders in `--pretty` with new formats and names.
> * Commit patches to obtain reviews from the community.
> 
> ### June 2nd ~ June 10th
> 
> The cushion period. Finish the unfinished work from last phase. If all
> the job is done, add test scripts and future documentation.
> 
> ### June 11th ~ July 3rd
> 
> I will be occupied in this phase since the final exams take over. I
> might not be able to work on some actual change but is free to reply
> to anyone in the community.
> 
> ### July 3rd ~ July 17th
> 
> * Gathering all reviews and criticisms from the community and revise
> my previous patches if needed.
> 
> * Add test scripts and documentation.
> 
> ### July 17th ~ July 28th
> 
> * Implement the format-scripting in `--pretty`
> * Commit the patches to obtain reviews from the community
> 
> ### July 28th ~ August 12th
> 
> * Gathering all reviews and criticisms from the community and revise
> my previous patches if needed.
> 
> * Add test scripts and documentation.
> * [option] configuration on pretty
> 
> ### August 12th ~ August 25th
> 
> Final revision and discussion.
> 
> ### August 25th ~
> 
> Submission
> 
> *If I complete my job earlier than I plan, than I would like to come
> up with more improvements and new features in my project.*
> 
>  ### Side-note
> 
> * Before my summer vacation, I can code for 2-3 hours per working day
> and 4-6 hours on weekend.
> * My summer vacation starts from July 3rd to early September, which
> fits well with GSoC's schedule. I will be able to spend half of my day
> on my project.
> * English is not my first language so if I have grammatical or other
> errors in documentation or communication, a review will be
> appreciated.
> 

I have fixed some of grammatical errors but your English is
understandable.

I personally use Grammarly to fix my errors. It's not foolproof but
pretty close.

> 
> 
> ## Conclusion
> 
> First, I would like to say thank you to all developers that have
> helped me or replied to me in the mailing list.
> 
> I want to join an active open-source community online for a really
> long time but I was too shy before and got caught up with the college
> entrance exam. I think GSoC is a good platform to start my journey.
> Though I was not able to get the information in time and it's late for
> me to commit my submission before deadline, I still decided to apply.
> Because if I hadn't, I would regret someday.
> 

Yeah, I know the feeling. Git is one of the better communities to work
with, so you have made a fine choice.

> As I mentioned before, maybe I have little experience to
> online-contributing, but I will learn the required skills to overcome
> obstacles. My lust for knowledge is my greatest power.
> 
> Last but not least, it's a pleasure to join the open-source community.
> Let's collaborate and make the online world better.
> 
> ----------

Thanks for the proposal!

I hope you have submitted the PDF draft already. Today is the deadline
and you can always re-upload later.

Regards
Abhishek
