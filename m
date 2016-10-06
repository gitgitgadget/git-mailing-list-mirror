Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957BF20986
	for <e@80x24.org>; Thu,  6 Oct 2016 07:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbcJFHVx (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 03:21:53 -0400
Received: from mx6-phx2.redhat.com ([209.132.183.39]:41299 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbcJFHVx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 03:21:53 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u967LnRj052964;
        Thu, 6 Oct 2016 03:21:49 -0400
Date:   Thu, 6 Oct 2016 03:21:49 -0400 (EDT)
From:   Josef Ridky <jridky@redhat.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <1214659824.1976049.1475738509473.JavaMail.zimbra@redhat.com>
In-Reply-To: <e3306f5a-1fb3-bd66-48ac-72b75fc7681c@kdbg.org>
References: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com> <1499287628.1324571.1475653631366.JavaMail.zimbra@redhat.com> <e3306f5a-1fb3-bd66-48ac-72b75fc7681c@kdbg.org>
Subject: Re: Feature Request: user defined suffix for temp files created by
 git-mergetool
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.4.141]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF48 (Linux)/8.0.6_GA_5922)
Thread-Topic: Feature Request: user defined suffix for temp files created by git-mergetool
Thread-Index: EzKs5iPhG+22gQ06GVmFwHQAiYHtKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

thank you very much for this reply.

| Sent: Wednesday, October 5, 2016 11:04:17 PM
| 
| Am 05.10.2016 um 09:47 schrieb Josef Ridky:
| > Add support for user defined suffix part of name of temporary files
| > created by git mergetool
| 
| Do I understand correctly that your users have problems to identify
| which of the "_BASE_", "_LOCAL_", "_REMOTE_" and "_BACKUP_" files they
| must edit? I agree that there is some room for improvement.
| 
| The goal is that you want the user to see the label, e.g., "_EDIT_THIS_"
| instead of "_LOCAL_". Now you have to teach your users that they have to
| pass --local=_EDIT_THIS_. Why don't you just teach your users to edit
| the file labeled "_LOCAL_"?

The goal of this request is not to teach our users, how to change labels using git mergetool.
The point is, that git mergetool is used by several of our packages in specific use-case. 

If I understand well, git mergetool expecting comparing LOCAL changes against REMOTE status in git repository.
We use git mergetool to compare LOCAL OLD version of package with LOCAL NEW version of package.

In this use-case is really nonsense to label old version of package as LOCAL and new version of package as REMOTE.
This is point of confusion. This is the reason, why I am asking for the possibility to change the suffix of temporary files, which are shown to user for comparison.

And as well, users do not open these files themselves, these files are automatically opened by our packages, so users are not responsible for the name of temporary files. They just see the results.

| 
| Therefore, I think that your patch as written does not help to reduce
| the confusion. It may be a building block for further improvement, but
| if you stop here, it is pointless.
| 

I agree, that this patch is written as general as possible and can possibly bring more confusion than benefits.
I will make new version of this patch, where will be just simple switch between LOCAL/REMOTE and NEW/OLD.
 
| >  SYNOPSIS
| >  --------
| >  [verse]
| > -'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
| > +'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [--local=<name>]
| > [--remote=<name>] [--backup=<name>] [--base=<name>] [<file>...]
| >
| >  DESCRIPTION
| >  -----------
| > @@ -79,6 +79,30 @@ success of the resolution after the custom tool has
| > exited.
| >  	Prompt before each invocation of the merge resolution program
| >  	to give the user a chance to skip the path.
| >
| > +--local=<name>::
| > +	Use string from <name> as part of suffix of name of temporary
| > +	file (local) for merging. If not used or is equal with any
| > +	other (remote|backup|base), default value is used.
| > +	Default suffix is LOCAL.
| > +
| > +--remote=<name>::
| > +	Use string from <name> as part of suffix of name of temporary
| > +	file (remote) for merging. If not used or is equal with any
| > +	other (local|backup|base), default value is used.
| > +	Default suffix is REMOTE.
| > +
| > +--backup=<name>::
| > +	Use string from <name> as part of suffix of name of temporary
| > +	file (backup) for merging. If not used or is equal with any
| > +	other (local|remote|base), default value is used.
| > +	Default suffix is BACKUP.
| > +
| > +--base=<name>::
| > +	Use string from <name> as part of suffix of name of temporary
| > +	file (base) for merging. If not used or is equal with any
| > +	other (local|remote|backup), default value is used.
| > +	Default suffix is BASE.
| 
| 
