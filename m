Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7B0C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 22:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589B660F56
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 22:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbhHaWCh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 31 Aug 2021 18:02:37 -0400
Received: from elephants.elehost.com ([216.66.27.132]:54323 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhHaWCg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 18:02:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17VM1bI5030206
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 31 Aug 2021 18:01:37 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Caleb Dougherty'" <caleb_dougherty@keysight.com>,
        <git@vger.kernel.org>
References: <BN6PR17MB31854E1EB7F8D358266B2AA8FECC9@BN6PR17MB3185.namprd17.prod.outlook.com> <BN6PR17MB3185652B92D61670BC92ABA5FECC9@BN6PR17MB3185.namprd17.prod.outlook.com>
In-Reply-To: <BN6PR17MB3185652B92D61670BC92ABA5FECC9@BN6PR17MB3185.namprd17.prod.outlook.com>
Subject: RE: Git stash certain files
Date:   Tue, 31 Aug 2021 18:01:31 -0400
Message-ID: <058f01d79eb3$c5001310$4f003930$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEQy6+we6USkL4eG85BiLgcwVafXAHHbHjZrQ2Uh9A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 31, 2021 5:18 PM, Caleb Dougherty wrote:
>Let me know if I should post this somewhere else, but having used git now for a couple years in my work environment, and having
come
>from years of TFS usage, I still find that I want the ability to "shelve" certain file changes for later.
>
>My workflow is to create a personal branch and make changes to different parts of our codebase, and then stage certain files (not
all) that
>are ready, and then commit them.  Sometimes I need to undo certain files in my working directory but keep the changes for later.
>
>Git stash will kind of allow that, but it is messy since it snapshots all my checked out files and I have to do several commands to
get the
>operation of "just stash these few files."
>
>Here is my "shelve" command.  Stage the files you want to shelve and then:
>                git commit -m '%1'
>                git switch -C shelveset/%username%/!shelvename!
>                git switch @{-1}
>                git reset --keep HEAD~
>
>Here is my "unshelve" command:
>	set branch=shelveset/%username%/%1
>	git cherry-pick %branch%
>	git reset HEAD~
>	git branch -D %branch%
>
>It would be nice if this were built into the stage command as an option (to only stash staged files), or perhaps a new
shelve/unshelve set of
>commands could be added.  The additional niceties of shelve/unshelve is that it is on a branch that can be pushed to a remote (so I
don't
>lose it in a moment of absentmindedness or computer failure) and potentially unshelved by someone else ("Hey Joe, take a look at my
>code on shelveset xyz").
>
>P.s. I cannot easily use the usual git workflow where you only do X feature change on X feature branch.  I work on multiple
features in
>parallel and cannot be switching branches frequently or I will incur too much overhead (not only running the commands to do the
switch).

Have a look at git stash push -- <pathspec>... I think that might do what you want.
-Randall

