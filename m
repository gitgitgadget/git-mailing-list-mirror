Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2CE20A40
	for <e@80x24.org>; Sat,  2 Dec 2017 16:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbdLBQ7b (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 11:59:31 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:47352 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbdLBQ7a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 11:59:30 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id LB8Tev9vKCbAZLB8Te5iUj; Sat, 02 Dec 2017 16:59:29 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=P6fCD_2VmIZcDERzNXUA:9 a=wPNLvfGTeEIA:10
Message-ID: <712DB157C1E642E79755350820CEAB29@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jonathan Nieder" <jrnieder@gmail.com>,
        "Vitaly Arbuzov" <vit@uber.com>
Cc:     "Jeff Hostetler" <git@jeffhostetler.com>,
        "Git List" <git@vger.kernel.org>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com> <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com> <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com> <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com> <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley> <CANxXvsM-q-MH3y94=tW8GmbWNjvrskPoGEhOkyAzsbZd8RrRbg@mail.gmail.com> <CANxXvsNuEmo+uaRY8t44csqzXAk3rS+D9E=LMvaLcZeg-aLvRw@mail.gmail.com> <20171201025106.GD20640@aiede.mtv.corp.google.com>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
Date:   Sat, 2 Dec 2017 16:59:27 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171202-2, 02/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfESF6VcQfdhdAJ83jbF+aMvUloXQs0RfvoqBUbQ/khG8CHuDZ8HX/pJm13MYW3WLPynQ0tUpvHM6+rwKoL6I5Hbg+W68MXoDgP7ff/bIHhv+NT+PuHo3
 tyuIcT0YTM2cBSJ/MQ6MTcuqvnpHtBk1Lhau04KxipzEswaj+WcLP+p/uJe5SypnTGzOvK4ZoaAqyq37RkcAEKjccN/KBkAB4X3btAcPtyrKUdJUUfMUdED/
 uzNM6sYbpyDTWZd8b4GWRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Thanks for the outline. It has help clarify some points and see the very 
similar alignments.

The one thing I wasn't clear about is the "promised" objects/remote. Is that 
"promisor" remote a fixed entity, or could it be one of many remotes that 
could be a "provider"? (sort of like fetching sub-modules...)

Philip

From: "Jonathan Nieder" <jrnieder@gmail.com>
Sent: Friday, December 01, 2017 2:51 AM
> Hi Vitaly,
>
> Vitaly Arbuzov wrote:
>
>> I think it would be great if we high level agree on desired user
>> experience, so let me put a few possible use cases here.
>
> I think one thing this thread is pointing to is a lack of overview
> documentation about how the 'partial clone' series currently works.
> The basic components are:
>
> 1. extending git protocol to (1) allow fetching only a subset of the
>    objects reachable from the commits being fetched and (2) later,
>    going back and fetching the objects that were left out.
>
>    We've also discussed some other protocol changes, e.g. to allow
>    obtaining the sizes of un-fetched objects without fetching the
>    objects themselves
>
> 2. extending git's on-disk format to allow having some objects not be
>    present but only be "promised" to be obtainable from a remote
>    repository.  When running a command that requires those objects,
>    the user can choose to have it either (a) error out ("airplane
>    mode") or (b) fetch the required objects.
>
>    It is still possible to work fully locally in such a repo, make
>    changes, get useful results out of "git fsck", etc.  It is kind of
>    similar to the existing "shallow clone" feature, except that there
>    is a more straightforward way to obtain objects that are outside
>    the "shallow" clone when needed on demand.
>
> 3. improving everyday commands to require fewer objects.  For
>    example, if I run "git log -p", then I way to see the history of
>    most files but I don't necessarily want to download large binary
>    files just to print 'Binary files differ' for them.
>
>    And by the same token, we might want to have a mode for commands
>    like "git log -p" to default to restricting to a particular
>    directory, instead of downloading files outside that directory.
>
>    There are some fundamental changes to make in this category ---
>    e.g. modifying the index format to not require entries for files
>    outside the sparse checkout, to avoid having to download the
>    trees for them.
>
> The overall goal is to make git scale better.
>
> The existing patches do (1) and (2), though it is possible to do more
> in those categories. :)  We have plans to work on (3) as well.
>
> These are overall changes that happen at a fairly low level in git.
> They mostly don't require changes command-by-command.
>
> Thanks,
> Jonathan 

