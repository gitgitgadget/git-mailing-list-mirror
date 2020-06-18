Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6188C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 21:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE5B208B8
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 21:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgFRVhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:37:45 -0400
Received: from elephants.elehost.com ([216.66.27.132]:64446 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgFRVho (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 17:37:44 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05ILbdHU041881
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Jun 2020 17:37:39 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Riddell, Matthew A'" <mriddell@paychex.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <MN2PR02MB66232254F5F4BE27F21C441CD89B0@MN2PR02MB6623.namprd02.prod.outlook.com> <xmqqsgesns22.fsf@gitster.c.googlers.com> <022601d645af$45d0e640$d172b2c0$@nexbridge.com> <MN2PR02MB66237FBAE6695D80B1182BA5D89B0@MN2PR02MB6623.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB66237FBAE6695D80B1182BA5D89B0@MN2PR02MB6623.namprd02.prod.outlook.com>
Subject: RE: Git config command ignores explicitly set file permissions
Date:   Thu, 18 Jun 2020 17:37:33 -0400
Message-ID: <023601d645b8$b06f46f0$114dd4d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIGtzZYQAdvEZ0Lx+m5fkirg6t9UwJ0Pw7DAkEoab0BHeS+vahPZy6A
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 18, 2020 4:57 PM, Matthew wrote:
> > "Riddell, Matthew A" <mriddell@paychex.com> writes:
> > > I noticed while working with Git that the file permissions on the
> > > gitconfig file is ignored and the parent folder permissions are used
> > > instead to update the file.  An example is as follows:
> > >
> > > Before running git config ensure the user running the command is not
> > > able to edit the file but has read access to the file. Ensure the
> > > User has full access to the parent folder.  After running any git
> > > config command the user previously without edit permissions on a
> > > file can now edit the config file.
> 
> >>Forgive me to asking, but is this an attempt at replicating what other
VCS
> systems do? ClearCase is an example where files are forced to read-only
and
> if the user wants to modify it, then they have to ask nicely for a >>lock
on the
> file. The use of "read only" is a semi-guarantee that a user will not
modify
> code and interfere with other users. In git, the rules are quite
different,
> where modification resolution occurs later in the process.
> 
> We have had problems in our continuous integration environment with builds
> modifying the global configuration of tools. I came across this issue
trying to
> lock down our git global configuration for the local user running our
builds.
> The workaround I found is creating a symlink from the user home directory
> to another folder (which has read only permissions) which contains the
> actual gitconfig file.

As a suggestion, you might want to add a git status -uno --porcelain to key
parts of your scripts to find the conditions where that is occurring and
fail the job if the output is not empty. CI tools and applications should
not change configurations unexpectedly and that would be a pipeline stage
failure - in my books anyway.

