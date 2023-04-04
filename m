Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16836C7618D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 02:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjDDCcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 22:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjDDCcB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 22:32:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB7CF
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 19:31:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso34699887pjb.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 19:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680575516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwisBNhG3K4qGHZB9Yu3UfiqpmVyuaAe7uTFrr56kZk=;
        b=Vg2C072kQKAF3iGSjoxBl4UrTClNEvm8HJs5Qfb3oCygcfR5R6KlPXwETebghvtMa+
         Zt5LnJQbF99VKwBEJPjDRq6Fpmhx91+hGlRFvC79gaYUcQ9bIRnowgStYyHJbAv78ZUO
         fEgiKfyFw0vMr9vWbijbBJ9vbXzwPBLKaSf9Y/oHAz+HsGCvYzrv1JLg3Er31k4QZyHy
         uxk2Z624N1T5B1XfQyGwc+huD7XpdPSPX4vMEXp8O6j+0RQkOG2SFa84Ht5ECpuWewYi
         a18c4dR0fldOYgZXEQRXOEwmFqkwANK97Ow7kPT92K5nDf/lUbB97fUd2e4zU162HRep
         yaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680575516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwisBNhG3K4qGHZB9Yu3UfiqpmVyuaAe7uTFrr56kZk=;
        b=XIIYsuXLxCKsGtO1FuiX+5DjaKcLHGd5zy2W4VhI0cYBQxFfRa1t7v5TgAOaQToMvc
         ccDZGQqovTDFi5hLFRGpLA2Yer8+jKCgNoktvlSbyARVmCNcnWQeoSuMkAkM1zWhtrdK
         VMVX8ghRLqebgfuWwp7IBRTWQ0CVVHVSmzqItkYqemCiWlhvoxZnucCdvm43FwngV4ia
         7A2vlWb+uqZMT30IvsJ9WY0L/KnXG0F2JSNs3KsOirFnoPzvqVpbT0YG3IeCW4+iP2i2
         AHr65DwQBZraPC4nRXvw4rSl57p714dfvM6BGjFhV8+5k4QGqsgK6YPvSNEf3mX45Qwx
         TGXg==
X-Gm-Message-State: AAQBX9cbAu9gVl3Nl9Uq5mGPtypqwoWgJXQtHyJyoytM9gFXGJYgaZre
        IpgZPls5dOsCLWr7NfI5iXfEdhfBNUYBT/Kg
X-Google-Smtp-Source: AKy350ZJHVD8Pr/zePNZSfz25q/0Nulle6IzPdeo6/QkLKWb/lbkdhXabtma6He7aMHpXI//ECuO8Q==
X-Received: by 2002:a17:902:cece:b0:19f:1c69:54b5 with SMTP id d14-20020a170902cece00b0019f1c6954b5mr1370721plg.12.1680575516164;
        Mon, 03 Apr 2023 19:31:56 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.145.200])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b001963bc7bdb8sm7164382plr.274.2023.04.03.19.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 19:31:55 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        five231003@gmail.com
Subject: [GSoC][Proposal v2] Unify ref-filter formats with other --pretty formats
Date:   Tue,  4 Apr 2023 08:01:49 +0530
Message-Id: <20230404023149.11867-1-five231003@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230330172052.10680-1-five231003@gmail.com>
References: <20230330172052.10680-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Christian for reviewing the previous version of this
proposal. I have made the changes that you mentioned about
in your review.

This proposal can also be read at
https://docs.google.com/document/d/1JBznA5n0WdWsbEskCeXxOnQuaa0urD89VtprxstLPzo/edit?usp=sharing

Unify ref-filter formats with other --pretty formats

Personal Info
=============
Full Name: Venkata Sai Sri Kousik Sanagavarapu
E-mail: five231003@gmail.com
Ph. No.: +91 6304308245
Alt. Ph. No.: +91 9704654555

Education: Vasavi College of Engineering, Hyderabad
Year: II / IV
Semester: IV / XIII
Degree: Bachelor of Engineering in
	    Electronics and Communication Engineering

Github: https://github.com/five-sh

Overview
========
Git has an old problem of duplicated implementations of some logic.
For example, Git has at least 4 different implementations to format
command output for different commands.

The goal of this project is to reduce these duplications and work
towards a single implementation to format command output. There is
more than one way to do this and there has been work done on this
by GSoC students and Outreachy interns before me.

The expected project size is 175 hours or 350 hours and the difficulty
level is medium.

Pre GSoC
========
I first got into Git’s source code around October, 2022 and have been
going through code of topics that I found interesting whenever I had
some time away from my college work. The following are the patches that
I submitted, from earliest to the latest:

[PATCH] repository-version.txt: partialClone casing change
Status: merged into master
Commit: 29c550f0a
Merge Commit: 859899ddc (branch: ks/partialclone-casing)
Description:
This was my first patch to Git. I had found that the configuration
variable extensions.partialClone had a typo in the way it was documented,
while reading the documentation surrounding partial clones. Now that I
look at it again, it seems that the patch was kind of noisy because the
config variable would have still worked with no emphasis on the case but
I guess it’s good to have everything going in one pattern, for the sake
of documentation.

Mailing list:
https://lore.kernel.org/git/20221110160556.29557-1-five231003@gmail.com/

[RFC][PATCH] object.c: use has_object() instead of
		       repo_has_object_file()
Status: Peff and others took off from here
Description:
This again was kind of a search-and-replace type of patch. I wasn’t
really sure of the code and made this change as a result of the
comment surrounding repo_has_object_file() which says that this and
related functions are deprecated (hence the RFC). Peff reviewed the
patch and explained about this function and the use of it in the
particular case where I made the change, which was really helpful
and added to my knowledge. Peff also realized that there were changes
to be done to the logic of parse_object() (the function in which I
made the change) and submitted patches, which were in turn reviewed
by Ævar and he submitted changes in response to that.

I now think that I should have replied to the review and taken part
in the discussion, leading to me learning something more, but I was
so overwhelmed that I didn’t do it. I corrected this in my later patches.

Mailing list:
https://lore.kernel.org/git/20221116163956.1039137-1-five231003@gmail.com/

[PATCH] merge: use reverse_commit_list() for list reversal
(Microproject)
Status: Discontinued
Description:
This was a change I did to address the issue #1156 on gitgitgadget.
This was however not a correct change logic wise because the
reverse_commit_list() function modifies the list in-place (that is,
uses the elements of the original list to make the reversed list)
such a modification could break merge if we had multiple merge strategies.

Mailing list:
https://lore.kernel.org/git/20230202165137.118741-1-five231003@gmail.com/

[PATCH] commit: warn the usage of reverse_commit_list() helper
Status: Discontinued
Description:
This change was made based on the preceding patch but according to the
review it seems that such an addition to the comment was unnecessary
as the original comment was clear enough.

Mailing list:
https://lore.kernel.org/git/20230207150359.177641-1-five231003@gmail.com/

[PATCH v4] index-pack: remove fetch_if_missing=0
Status: Discontinued
Description:
This change strove to remove the use of fetch_if_missing in index-pack
by replacing has_object_file() with has_object() which does not
lazy-fetch when an object is missing in a partial clone. A test was
also added to make sure that this change did not lazy-fetch.

This patch was discontinued because it was decided as a result of
discussion that it would be better to check all the cases where
fetch_if_missing is set to 1 and make changes there so that we either
fetch efficiently or not fetch at all. By doing this, in the final
world-view, we can remove fetch_if_missing from index-pack as it
would be set to zero everywhere.

Mailing list:
https://lore.kernel.org/git/20230317175601.4250-1-five231003@gmail.com/

Proposed Project
================
Goal
====
The goal of this project is, as the title says, unifying ref-filter
formats with other pretty formats. It would be great to have a single
interface, which took care of all the formatting and not have different
logic to implement different formatting options. Quoting from the mailing
list discussion

https://lore.kernel.org/git/CAL21BmnU2aTT_8iqejurgKeHXk-kmmGK1tmXLcVh7G12rwRPOw@mail.gmail.com/

“For example, 'short' in pretty means 'commit %(objectname)%0aAuthor: %(author)'
in ref-filter”

Previous Work
=============
There has been much work done in the past in this area. It majorly comes
from previous Outreachy interns and GSoC students.

Olga Telezhnaia <olyatelezhnaya@gmail.com> did work in this area in the
fields of `cat-file` and `ref-filter` as a part of her Outreachy Internship
titled “Unifying Git’s format languages”. This work and also the work done
after that helped take ref-filter to a more general setting. She blogged
about her work here

https://medium.com/@olyatelezhnaya


Hariom Verma <hariom18599@gmail.com> did work in this area as his GSoC
project titled “Unify ref-filter formats with other --pretty formats”.
This is the major work done in this area and the final report can be
read at

https://harry-hov.github.io/blogs/posts/the-final-report

This work is very useful as this serves as a kind of documentation
and starting point to work towards the goal.

ZheNing Hu <adlternative@gmail.com> has done major work under his GSoC
project titled “Use ref-filter formats in git cat-file” in the area of
git cat-file, but more relevant to this project are the changes done to
ref-filter. This work was a continuation of Olga’s work and made some
changes to ref-filter logic. His final report can be read here

https://github.com/adlternative/adlternative.github.io/blob/gh-pages/blogs/gsoc/GSOC-Git-Final-Blog.md

Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com> did work in
this area where he implemented an equivalent atom of`signature` of pretty
in ref-filter, so that in the future we can remove duplicate implementations.
This work can be read here

https://lore.kernel.org/git/20230311210607.64927-1-nsengiyumvawilberforce@gmail.com/

Difficulties
============
A major difficulty is backward compatibility, so any changes made to
remove the duplicated logic would need to be done so very carefully.
Any new tests added must also be very precise so as to efficiently
test the changes that are made.

There are also minor difficulties, such as the older tests failing
because of the changes made, so the work will have to be in such a way
that those tests are successful and the duplicated logic is refactored.

The Plan
========
I think Hariom’s final report of his GSoC project is a good starting
point for working on the project. The report lists the work which is
left in the “WHATS LEFT?” section, so I think the first issue to work
on would be his branch

https://github.com/harry-hov/git/commits/pretty-lib-2.0.2

Also carefully look for stuff in this branch that have potential and
discuss them with my mentors.

I can take the approach similar to what others did before me, that is
by starting off with re-implementing atoms that are in pretty, in
ref-filter which will help our end goal of removing duplicated logic
wherever possible. 

Estimated Timeline
==================

Misc
April 5 to May 3
- Continue to work on git and get more familiar with the code.

- Find and fix stuff.

- Work on stuff that interests me.

Community Bonding
May 4 to May 28
- Get myself familiar with the code of ref-filter.{c, h} and
  pretty.{c, h}.

- Communicate with my mentors about the approaches that can
  be taken to get to the goal.

- Reading Hariom's branches [1] and discussing with mentors
  about the possible approaches that can be taken and also if
  there could be work done on his branches or taken from his
  branches for future work.

Coding Phase I
May 29 to July 14
- Re-implement atoms that are in pretty in ref-filter.

- Update existing tests and add new tests.

- Update documentation.

Coding Phase II
July 14 to August 21
- Further convert formatting options to reuse ref-filter formatting
  logic and teach pretty to handle them.

- Update existing tests and add new tests.

- Update documentation.

Final Coding Phase
August 21 to August 28
- Wrap up and fix bugs (if any).

- Update about the remaining stuff (if any).

- Make a final report outlining future work.

[1]: https://github.com/harry-hov/git/commits/pretty-lib-2.0.3
     https://github.com/harry-hov/git/commits/fix-graph3

Blogging about Git
==================
I think blogging is one of the important parts of any project. It
helps other people understand what one is doing and helps the person
get to a better understanding of their work. I will blog about the
project every week, the blogs can be read at

https://five-sh.github.io/

Availability
============
I will be having my semester mostly throughout the summer and so will
be able to work 35-40 hours per week. I will always be able to dedicate
more time towards the project on the weekends.

I will be in contact through my email and my phone.

I am also open to calls and online meets.

Post GSoC
=========
I love being a part of the Git community. The whole process of getting
to work on git’s code, submitting patches and getting reviews is a new
and great experience for me. I plan to continue in the community after
GSoC too and will continue contributing to git and will continue learning
from all of you.

I am also open to co-mentoring or mentoring if ever given the chance.

I also am very interested in partial clones and I hope to work in that
area.

Closing (optional)
==================
Ever since I first got into git’s code and its community back in 2022,
it has evolved into a very unique and great experience for me. I have
learned so much in the past few months and will continue to do so from
all of you here at git.

Hariom's proposal has been a great resource in writing this proposal.

Thanks & Regards,
Kousik Sanagavarapu
