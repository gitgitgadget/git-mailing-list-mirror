Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B9EC761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjCaTgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCaTf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 15:35:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0211BFD
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 12:35:54 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h14so10692127ilj.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680291354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbV0p6No+CRRqz3jWaxAvQDfKp5kcHDhsK4ows9RSd4=;
        b=HZLRS9BpzIRekbWj5ZgMakzdCoOx28zTblIinocQsJscxU5Eg64xiE816Vt5/h460/
         LounGxZfgd1qqXtH7d+hjFhAInILfCOw6keN2IYxUklLALACPaIbbM+jh1TPUnbbOjXZ
         YHiBdA5vLoa0d9q28m3OuHb/HoNkBj1ZyrzzlhyaQfcB3l3S/+qC1kFLeHI4EH+Kf8rW
         7zCotgetjHNBlVr09mGOLeMFebwohHKVvUsoH8OQf0E07E04cFkNPWWDyS6Lm/p/sILV
         QRhej5ma/TSARUWi54sOv1AwlicznphufPUHCwLkcaoOO1UNk1TBhzpDy6uWHhXIqBZT
         SSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680291354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbV0p6No+CRRqz3jWaxAvQDfKp5kcHDhsK4ows9RSd4=;
        b=uJY3yQgH3TQ2z1VCjPjpWszJiVjAou8osHG5iE5hT8q+INIKS9F59WHBDwgRUpPkIV
         NYdX0weJXuoyNcnwTgoHRzuhKisXAX6uBY5FxbJIwDMLlR2Glt1U8gMAcEYs3x4Sx6R5
         ig9pgnL/KH/V5NBZVvoUcE6Ct35aq0jHAmR0en+BiJ6n3QdJ04jfD/G97VQDfH8JBSg2
         oZZJ+MEkGPCcBqqoIYU0i1p8RHTm8Fsql0jT2kGmC1p9W+ML8bX5ZVbGH913Qb8/D9W5
         EsKtxgNsNYT9Fw6jL1NwvGwlDeHHPwRsGZ87tBkXDRjeVQrPknRh9tOUan34guLoyWKL
         WKjA==
X-Gm-Message-State: AAQBX9ezewj36RvnLs0zxF5VbBm+gQFl8LAy7XN+k2fHvbitcae9XF6H
        CykH1mbGrhY5FMpHRHgppFKqcu7msRXbRA==
X-Google-Smtp-Source: AKy350axFPnVdVGLvdlUlToSIQA8vgQ3sSXhJam/rNx0+2YjS1doxf65llq+nNhylILlXFupTxFvJw==
X-Received: by 2002:a92:c04c:0:b0:326:588f:32dd with SMTP id o12-20020a92c04c000000b00326588f32ddmr33144ilf.26.1680291353574;
        Fri, 31 Mar 2023 12:35:53 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id dl5-20020a056638278500b003ab21c8fa84sm817782jab.121.2023.03.31.12.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:35:53 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        derrickstolee@github.com
Subject: [GSoC][PROPOSAL v2] More Sparse Index Integrations
Date:   Fri, 31 Mar 2023 15:35:25 -0400
Message-Id: <20230331193525.4420-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230328014927.5617-1-cheskaqiqi@gmail.com>
References: <20230328014927.5617-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Victoria,

Thanks for reviewing!

I have made some adjustments based on your feedback :)

And website version is there: 
https://docs.google.com/document/d/1WtoLgAJYVHY_NWNscqi358FeAY-6UBARCmpTU3BAQMs/edit#



## More Sparse Index Integrations
Personal Details

### About Me
| Name | Shuqi Liang |

| Mobile no. |  +1 (416) 272-1737|
| Email | cheskaqiqi@gmail.com|

| Github | https://github.com/Cheskaqiqi |
| Major | Computer Science |
| Blog | https://cheskaqiqi.github.io/ |
    

### Me & Git

I am a Computer Science undergraduate at Western University (Canada). I have 
learned C, Python, Java, and shell in the last two years. I have started 
exploring the Git codebase since Jan 2023.Here is some related documentation 
I have read:


# MyFirstContribution.txt   
# SubmittingPatches

*Way to make contributions to the git project.

# MyFirstObjectWalk.txt

*Way uses git's Object Walk API to traversethe git object database.
Topics such as object types and IDs.


# Hacking Git
# Understanding Git — Index 
# Git Internals
# UnderstandingGit  DataModel
# UnderstandingGit Branching
# Underlying data model of git and how it works.

*Types of git objects: blobs, trees, and commits.
*The concept of branching in Git and how it is used to manage code changes.
*Two layers of git: the low-level plumbing layer and the high-level 
porcelain layer.
*Relationship between the Index and the working directory.

# Make your monorepo feel small with 
# Bring your monorepo down to size with sparse-checkout 

*How the git sparse checkout and git sparse index feature can help make 
large monorepos feel smaller and more manageable

# Sparse-checkout.txt
# Sparse-index.txt

I would like to thank Shaoxuan, the 2022 GSoC who recommended these two 
articles to me. The articles cover some of the limitations and potential 
issues with ‘sparse-checkout’ and ‘sparse-index’.


###Contributions


#Status 
wip
#Subject
[Microproject]: t4113: modernize test script
#Mail List Link
https://lore.kernel.org/git/20230215023953.11880-2-cheskaqiqi@gmail.com/

#Status 
wip
#Subject
[Aided a potential GSoC student]: trace.c, git.c: removed unnecessary 
parameter to trace_repo_setup
#Mail List Link
https://lore.kernel.org/git/20230215175510.3631-1-cheskaqiqi@gmail.com/

#Status 
wip
#Subject
check-attr: integrate with sparse-index
#Mail List Link
https://lore.kernel.org/git/20230227050543.218294-2-cheskaqiqi@gmail.com/

#Status 
wip
#Subject
diff-files: integrate with sparse index
#Mail List Link
https://lore.kernel.org/git/20230322161820.3609-2-cheskaqiqi@gmail.com/




###The Project: More Sparse Index Integrations


#What's "sparse-checkout"

When the repository has so many files at root, it causes git commands to 
slow to a crawl (e.g., git checkout, git status). Now, ‘sparse-checkout’ 
allows users to restrict their working directory to only the files they care 
about. It is supposed to make users feel like they are in a small 
repository, even though they are contributing to a large one.[1]  
If users use the "microservices in a monorepo" pattern, "sparse-checkout" 
can ensure the developer workflow is as fast as possible while maintaining 
all the benefits of a monorepo.[1]



#What's ‘git index’

In git, the index, or the staging area, is an intermediate area where 
changes to a Git repository are prepared before committing to the 
repository. The index file stores a list of every file at HEAD. This list of 
files is stored as a flat list.[2]



#What's ‘sparse-index’

Although ‘sparse-checkout’  has done very well, it still has a problem: 
the Git index is still large in a monorepo.
‘sparse-index’ allows the index to focus on the files within the 
sparse-checkout cone. The size of the sparse index will scale with the number 
of files within users' chosen directories instead of the full size of the 
repository. When enabled with a number of other performance features, this 
can have a dramatic performance improvement.[2]



#Problem when integrated with sparse index

The idea of 'sparse index' is easy to understand, but pruning the index at 
the directory level may cause a complicated result. That is because, In the 
Git codebase, numerous places directly interact with the index in various 
nuanced ways. All of them assume that each index entry refers to a blob 
object. But sparse-directory entries violate expectations about the index 
format and its in-memory data structure. Many consumers in the codebase 
expect to iterate through all of the index entries and see only files. 
Compatibility layers are made to expand a sparse index to an equivalent full
 index. So that even if the on-disk format is sparse, code paths that have 
 not been integrated and tested with a sparse index can still be used.[2]

The Git Fundamentals team first started by creating the ensure_full_index() 
method, which converts a sparse index into a full one. 

But this method takes longer to expand a sparse index to a full one than to 
read a full one from a disk. It goes against our idea of utilizing 
'sparse index' to enhance user experience. To gain the performance benefits 
of a sparse index and improve user experience, we need to optimize the 
compatibility and teach git to only expand the sparse directory entries 
only when needed. 

###Plan

Every integration will have similar steps, but the actual steps of commands
 integrated for the project will vary based on the complexity of the commands 
 chosen:

(Notice that step 1 is from ShaoXuan's GSoC 2022 Git Contributor Proposal, 
and steps 2,4-7 are from GSoC 2023 Ideas. I made some additions to the steps.)

1. Investigation around a Git command and see if it behaves correctly with 
sparse-checkout. Modify the Git command's logic to work better with 
'sparse-checkout'. Add corresponding tests.[3]

    *Step 1 does not often occur. But it is important to ensure 
    *"sparse-checkout" is compatible with the Git command to continue 
    *with  the next step.

2. Add tests to t1092-sparse-checkout-compatibility.sh for the built-in, 
with a focus on what happens for paths outside of the sparse-checkout cone.


    t1092-sparse-checkout-compatibility.sh create a repository with some 
    data shapes in it. Each test case starts by copying that repository 
    into three new repositories with different configurations. These three 
    are called 'full-checkout'  , 'Sparse-checkout' , and 'Sparse-index', 
    respectively :

    'full-checkout' is the same as the repository, without sparse-checkout.

    'Sparse-checkout' with cone mode sparse-checkout enabled.

    'Sparse-index'  with cone mode sparse-checkout and sparse index enabled. 

    Add tests for the git command we want to integrate with sparse-index to 
    t1092 without the code change. Focus on the git command, which has the 
    ability to affect full-checkout/sparse-checkout/sparse-index differently.
    The test case should run against all three repositories and have the same 
    output and it should also work when the index is expanded. After 
    integrating the git command with sparse-index, the output and behavior 
    should remain the same.  


3. Add performance tests, so we have a baseline to measure how
   well the git command does.

    We need a baseline to measure the speed before integrating the git command 
    with sparse-index. Normally we will notice the speed is quite slow caused
     by expanding the index.



4. Disable the command_requires_full_index setting in the built-in and 
ensure the tests pass.

5. If the tests do not pass, then alter the logic to work with the 
sparse index.

    Make the code change to only expand the sparse directory entries only 
    when needed.command_requires_full_index setting guards all index reads 
    to require a full index over a sparse index.

    After suitable guards are placed in the codebase around uses of the 
    index, remove the setting. 

6. Add tests to check that a sparse index stays sparse.

    Add  ensure_not_expanded test to t1092-sparse-checkout-compatibility.sh,
    We expect the index to be expanded for out-of-cone moves. But we need to 
    ensure the index will not expand for in-cone moves.

7. Run performance tests to demonstrate speedup.


###Project Timeline


#Empty Period (Present - May 4)

    My end-semester exams begin on April 4 to  April 28. Hence I might be 
    a bit busy in this period.But I will continue to research 
    'git diff-files' in my spare time.

    After April 28, I will continue to work on 'git diff-files' and start 
    to work on ' git write-tree '

#Community Bonding Period (May 4- May 28) 

    Get familiar with the community

    I have read the related documentation about 'Sparse Index Integrations'
    and working on 'git diff-files' , one of the builtins that could be 
    integrated with the sparse index. The feedback and the advice for 
    improvement make me learn a lot. And I'm confident I can start the 
    project at the start of this period.

    Keep working on "git diff-files' and  'git write-tree ' on May 5, and 
    the expected time of completion of these two is May 28.


#Phase 1 (May 29 -June 30)

    integrate  'git diff-index' with sparse index,use steps above.

#Phase 2 (July 1 - July 30)

    integrate  'git diff-tree' with sparse index. Use the steps above.

#Phase 3 (July 31 - August 28)

    integrate 'git worktree' with sparse index. Use the steps above.


The list of builtins organized in order of least-difficult to most-difficult 
in  GSoC 2023 Ideas may not accurately reflect the complexity of the tasks 
involved. During the project, unexpected difficulties may arise. For example: 
The work done by Shaoxuan on 'git mv' has been found to function improperly 
with 'git-sparse-checkout' during the project period, and it took nearly 
three months to resolve this issue.

Taking into account these potential challenges, I may need to make 
appropriate adjustments to the proposed integration schedule when digging 
into each command.



###Blogging about Git

When I was a freshman, I hated writing summaries or other learning materials.
But then I started writing blogs for new knowledge to keep track of what I've
learned. I realized that When I  dive into a topic and want to write it down, 
I  will think much deeper about it than just learning. I also learned a lot 
and gained many skills from others' blogs. I would love to write about my 
progress and experiences with the project. In this way, I could share the 
ideas with those interested in researching this project and help them get up 
to speed more quickly.



###Availability

My semester will complete in late April, leaving me enough time to prepare 
for my GSoC project. Git is the only project for my summertime. If I am 
selected, I shall be able to work five days per week, 7 - 8 hours per day, 
dedicating around 35 -40 hrs a week on the project.  While I may participate 
in a hackathon for a few days with my friends in July, I will ensure that my 
project progress is not affected. Throughout the program, I will stay active 
on the Git mailing list and  respond to all communication daily.

The difficulty level of this project is medium, and the expected project size
is estimated to require between 175 to 350 hours of work. Based on my 
proposed commitment of 35-40 hours per week, this project aligns with my 
availability and intended workload for the GSoC period, ensuring that I have 
sufficient time to accommodate any unforeseen circumstances that may arise 
during the project.



###Post GSoC


I have received much support from many members of the Git community in recent 
months. This support has strengthened my passion for git and inspired me to 
contribute more of my code to the community. Just as others have helped me, 
I will pay it forward by assisting and encouraging new community members. I 
believe that sharing knowledge and collaborating with others is the key to 
creating great software and achieving success in the open-source world.

I am committed to delivering high-quality work and meeting the expectations 
of the community. I am eager to learn from experienced community members and 
gain new skills and knowledge that will help me become a more valuable 
contributor. I am eager to continue working with the Git community beyond the
scope of the GSOC program. I believe I have much to offer the community, 
and I am committed to contributing to its success for a long time.

I hope that the Git community will consider my application for the GSOC 
program. It would be an honor to be able to contribute to such a fantastic 
open-source project and work with such a supportive and welcoming community. 
Thank you for your time and consideration.



###References

[1] Bring your monorepo down to size with sparse-checkout.
 https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/

[2] Make your monorepo feel small with Git’s sparse index. 
https://github.blog/2021-11-10-make-your-monorepo-feel-small-with-gits-sparse-index/


[3]Step 1 in the plan is come from  shaoxuan’s proposal in 2022
https://docs.google.com/document/d/1VZq0XGl-wCxECxJamKN9PGVPXaBhszQWV1jaIIvlFjE/edit

Thanks & Regards,
Shuqi


