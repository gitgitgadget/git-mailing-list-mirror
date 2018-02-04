Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3821F404
	for <e@80x24.org>; Sun,  4 Feb 2018 15:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeBDP5Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 10:57:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:44841 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbeBDP5P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 10:57:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13D7FAD28;
        Sun,  4 Feb 2018 15:57:14 +0000 (UTC)
Subject: Re: [PATCHv2] tag: add --edit option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <e99947cf-93ba-9376-f059-7f6a369d3ad5@suse.com>
 <CAPig+cT8vKyhq6DvFMz-0CPRO-Y7R4EE_JhN6yuiSUNXW8-Yww@mail.gmail.com>
 <fa3f512a-bd77-80c7-4fec-071639f62d26@suse.com>
 <CAPig+cTDHsBSPZ+o+jh9bDvJ7NcZ3DGe+penppPwyupCJzmhAA@mail.gmail.com>
 <52737deb-a5dc-27d6-3c0c-0d8b8de991c5@suse.com>
 <CAPig+cQF2HzmtVdHqtQcOf0B-yA8Kpj-CZbPmdQotGwtdYpxvw@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Message-ID: <670db556-59f4-8236-be2f-e0c901e8df68@suse.com>
Date:   Sun, 4 Feb 2018 16:57:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQF2HzmtVdHqtQcOf0B-yA8Kpj-CZbPmdQotGwtdYpxvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 02/02/2018 à 20:16, Eric Sunshine a écrit :
> On Fri, Feb 2, 2018 at 11:48 AM, Nicolas Morey-Chaisemartin
> <nmoreychaisemartin@suse.com> wrote:
>> What message do you suggest ?  As I said in a previous mail, a
>> simple "Editor failure, cancelling {commit, tag}" should be enough
>> as launch_editor already outputs error messages describing what
>> issue the editor had.
>>
>> I don't think suggesting moving to --no-edit || -m || -F is that
>> helpful.  It's basically saying your setup is broken, but you can
>> workaround by setting those options (and not saying that you're
>> going to have some more issues later one).
> If it's the case the launch_editor() indeed outputs an appropriate
> error message, then the existing error message from tag.c is already
> appropriate when --edit is not specified.

I don't fully agree with the current message. The right thing to do is to fix the editor, not to hide the issue.
A better message would be "Editor failed. Fix it, or supply the message using either..."
At least we suggest the right way to do it first.

>  It's only the --edit case
> that the tag.c's additional message is somewhat weird. And, in fact,
> suppressing tag.c's message might be the correct thing to do in the
> --edit case:
>
>     static void create_tag(...) {
>         ...
> if (launch_editor(...)) {
>    if (!opt->use_editor)
>        fprintf(stderr, _("... use either -m or -F ..."));
>             exit(1);
> }
>
> I don't feel strongly about it either way and am fine with just
> punting on the issue until someone actually complains about it.

The test should be opt->message_given && opt->use_editor.
If just --edit is provided but no -m/-F, --edit does not have any effect and it should be the same error message as when no option is given.

Nicolas
