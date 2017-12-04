Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BCA920954
	for <e@80x24.org>; Mon,  4 Dec 2017 21:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbdLDVjm (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 16:39:42 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:50969 "EHLO
        homiemail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752538AbdLDVjm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2017 16:39:42 -0500
Received: from homiemail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTP id 74565314C069;
        Mon,  4 Dec 2017 13:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:content-type:mime-version:
        content-transfer-encoding; s=novalis.org; bh=XlAEC4x3hfd4p5jxQ/v
        +lwe4l0w=; b=QcHYbju8HAERg/wrzYffcejvjwaGRESvICYdpAsWEH3TbXhFZdk
        lsAPD5yue+1WDJ7/Cmk/SO40mN5bHimD2B81ffaUcQMn8ocdvhSMVsTtbBGR8lOB
        f0JKD/RB+qzAcTboxsioRkknmuaZzq1cTz6FcBtW8etLwiX5fjAgpoJU=
Received: from corey (unknown [38.27.161.17])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTPSA id 1FED9314C066;
        Mon,  4 Dec 2017 13:39:41 -0800 (PST)
Message-ID: <1512423580.9882.405.camel@novalis.org>
Subject: submodule modify/delete wrong message
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org
Cc:     brock.peabody@gmail.com
Date:   Mon, 04 Dec 2017 16:39:40 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When merging with a submodule modify/delete conflict (i.e. I've deleted
the submodule, and I'm merging in a branch that modified it), git lies
about what it is doing:

"CONFLICT (modify/delete): submodule deleted in HEAD and modified in
submodules. Version submodules of submodule left in tree at
submodule~submodules.
Automatic merge failed; fix conflicts and then commit the result."

In fact, the working tree does not contain anything named
'submodule~submodules'.  

In addition, I would ordinarily resolve a conflict like this by using
'git rm'. Here, this gives a warning:

$ git rm submodule
submodule: needs merge
rm 'submodule'
warning: Could not find section in .gitmodules where path=submodule

Git's behavior here is significantly better than liggit2's (which tries
to check out 'submodule' as if it were a blob, and fails to do so), but
it's still confusing.

It's not clear to me what the correct behavior is here.  Maybe it's
sufficient to just fix the message?
