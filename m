Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DFDC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C617020678
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfKZP22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:28:28 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:55822 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfKZP21 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 10:28:27 -0500
Received: from [79.66.3.179] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iZclN-0006IO-BR; Tue, 26 Nov 2019 15:28:26 +0000
Subject: Re: tying files to git repository
To:     Jim Edwards <jedwards@ucar.edu>, git@vger.kernel.org
References: <CAPuR+ZhwnHCp8j76PscuBqG2rCLkgG0+6Y3WwLgNRhaoj4OR9A@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <07afaf21-9731-9068-962b-2e089ddd576c@iee.email>
Date:   Tue, 26 Nov 2019 15:28:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAPuR+ZhwnHCp8j76PscuBqG2rCLkgG0+6Y3WwLgNRhaoj4OR9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jim

This 
(https://public-inbox.org/git/CAPuR+ZhwnHCp8j76PscuBqG2rCLkgG0+6Y3WwLgNRhaoj4OR9A@mail.gmail.com/) 
has been lying around for a long while..

On 11/11/2019 15:28, Jim Edwards wrote:
> Hi,
>
> I am a developer of scientific software, as science software we expect
> and encourage users to modify source code in order to customize their
> experiments.
Sounds an ideal usage for git - giving back control to the users so they 
can easily maintain their versions.
> The mechanism which has been developed to do this
> predates having source code in git and we are trying to figure out a
> way to minimize changes to the scientists workflow, while leveraging
> the power of git to improve the process.
Good, though sounds like you will need some terminology mapping.. Is 
there a public reference to the method?
> In the workflow the
> scientist creates a 'case' using script in the repository to create a
> directory structure from which they will conduct their experiment.
In what sense do you use "case"?
  e.g. a [single] suitcase that holds a choice of clothes to wear / 
experimental methods;
Or, a long list of experimental setups, each with a name, selecting a 
'case' statement (like a software 'case' statement);
Or, a use-case that gives a half complete suggestion about how it may 
work, but with some details still to be filled in due to lack of space 
on the post-it note..?

Given that the scientists create a 'directory structure' (containing 
files?) for each experiment, this sounds very much like creating a 
'branch' (line of development) from the initial template of that 
structure, and as they develop their experiment's directory structure, 
they record their development in 'commits' on that branch (and sub 
branches if they are looking at alternatives). Finally, when they have a 
good structure ready, they can 'tag' that commit so it's easy to find.


> Part of that directory structure is a SourceMods directory where the
> user can drop modified source files that will be compiled in place of
> a file of the same name in the source tree.
This 'dropping' has a strong _conceptual_ similarity to the staging area 
or 'index', where git users 'add' files that they feel are ready to an 
area that is used (like an outbox awaiting collection) as a temporary 
holding area waiting till all the bits are ready and waiting before they 
commit the ensemble.

So this "SourceMods" is very similar to the staging area, except that in 
your case it sounds like it is a specific place, while in git it is more 
conceptual as the user will 'git add <file>', and that change is 
registered in "the index" (a local file in a hidden .git directory), 
ready for the big commit.

Behind the scenes, a copy of the file is saved (in the object store) and 
hashed ready for inclusion in the commit hierarchy . Later the files 
(objects) stored in the object store are 'packed' resulting in a very 
compact storage, particularly for source files. The git repository can 
be 'pushed' to other servers, and other repositories 'fetched' from 
servers (and mixed together if they have common ancestry).


> These files are sometimes
> long lived and passed from case to case and even user to user and it
> is not hard to have the files get out of sync with the source tree.
In Git, because the current files stay 'in place', you can start a 
branch (new experiment definition) from anywhere in any line of 
development. You/they simply checkout that particular commit and, voila, 
all the files are back as they were exactly.
> We have discussed at length removing the SourceMods capability and
> requiring scientists to create branches in git, but there is a lot of
> resistance to this in the community.
Most of that will be fear of the unknown and the unfamiliarity of the 
git terminology. There can also be confusion about how Git has changed 
the old ways of working. Because you get 100% verification and 
validation you no longer need to worry about requiring a central golden 
reference store (though usually the "organisation" will want to have a 
_copy_ ;-)
> What I would like to explore is
> allowing scientists to keep the method that they are used to but at
> the same time tying these modified files to their history in git.
The key part will be in how you map what they already do and know to the 
git commands and structure, and how you show them that it will remove a 
lot of the pain points and bottle necks.
> Is
> there a way to get the git metadata associated with an individual file
> so that we can treat that file as if it were in the repo?
>
That [mental model view] way is a Sisyphean task, a never ending up-hill 
struggle. With a few careful words (mapping out solutions to their pain 
points) you should be able to get the scientists to pester you to 
implement git sooner rather than later. Choose the lead experimenters of 
git carefully.

-- 
Philip
