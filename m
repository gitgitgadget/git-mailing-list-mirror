Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38F9F1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 10:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436840AbfJXKmd (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 06:42:33 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:49632 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436753AbfJXKmd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 06:42:33 -0400
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
        by smtp2-g21.free.fr (Postfix) with ESMTP id A008E2003CE
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 12:42:31 +0200 (CEST)
Date:   Thu, 24 Oct 2019 12:42:31 +0200 (CEST)
From:   ydirson@free.fr
To:     git <git@vger.kernel.org>
Message-ID: <479118979.-772834452.1571913751603.JavaMail.root@zimbra39-e7>
In-Reply-To: <717060483.-772858077.1571913448492.JavaMail.root@zimbra39-e7>
Subject: [BUG] "git rebase -r" lacks sanitation on merges with arbitrary
 reference syntax
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.118.38.73]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have a branch which does successive merges from a vendor branch, like:

 git merge vendor/poky-intercepts^{/warrior}'
 git merge vendor/poky-intercepts^{/zeus}'

Now if I try to use "rebase -r" across such a merge, the result is:

 error: refusing to update ref with bad name 'refs/rewritten/vendor/poky-intercepts^{/warrior}'
 hint: Could not execute the todo command
 hint: 
 hint:     label vendor/poky-intercepts^{/warrior}
 hint: 
 hint: It has been rescheduled; To edit the command before continuing, please
 hint: edit the todo list first:
 hint: 
 hint:     git rebase --edit-todo
 hint:     git rebase --continue

If I manually sanitize the label name, everything's fine.
