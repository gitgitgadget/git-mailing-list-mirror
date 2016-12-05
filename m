Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A4F61FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 21:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbcLEVYk (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 16:24:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54569 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751618AbcLEVYj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 16:24:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19279538EA;
        Mon,  5 Dec 2016 16:24:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8B0N2AHR7kMqBTxM4wBAPOEvSho=; b=tn96Gs
        +a9ttTNkb+iVL2pNczn51l9+zk2v/btpEsFDJaYQyVfnUTre2LnPrwZ+GSLLwVXa
        1LLklKycfbEe+EITgY2HxaQJb3lbLdJMpQLF48pZvlHlE61TfCyerkyOCBi/IjuL
        vCRsI0vxJ0NuTLRfLUj+cSqysxHf7APzGSKy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fUD+1tTID0gUKB3bXhMhk7/XYS9qV7gW
        b8WI7M5h34G2mY6cnd6QLejEna0p0CzURX7KOuQ0G7iWey3zkYwMEaxJ77Q8z3OE
        HxfKdCjOAdtwGl8vVnyrVD4NJ41Pb7pyK/Z4MkGR0zkLhbDo8h0ARAGOK48nqSaA
        idoA9Ubwk3c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A3A3538E9;
        Mon,  5 Dec 2016 16:24:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EE17538E8;
        Mon,  5 Dec 2016 16:24:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCHv1 1/2] git-p4: support git-workspaces
References: <20161202224319.5385-1-luke@diamand.org>
        <20161202224319.5385-2-luke@diamand.org>
        <xmqq8tru3xom.fsf@gitster.mtv.corp.google.com>
        <CAE5ih78Y_AbfgtW_6zMKLC8NzBxCKSagrgrjtfWZVOEwaAg6ZA@mail.gmail.com>
Date:   Mon, 05 Dec 2016 13:24:36 -0800
In-Reply-To: <CAE5ih78Y_AbfgtW_6zMKLC8NzBxCKSagrgrjtfWZVOEwaAg6ZA@mail.gmail.com>
        (Luke Diamand's message of "Mon, 5 Dec 2016 21:13:22 +0000")
Message-ID: <xmqq4m2i3w8b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39836464-BB31-11E6-B20D-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On 5 December 2016 at 20:53, Junio C Hamano <gitster@pobox.com> wrote:
>> Luke Diamand <luke@diamand.org> writes:
>>
>>> Teach git-p4 about git-workspaces.
>>
>> Is this what we call "git worktree", or something else?
>
> Ah, I think you're right!

Then I'll queue it like the attached.

HOWEVER.

How fast does isValidGitDir() function need to be?  The primary one
seems to check HEAD (but it does not notice a non-repository that
has a directory with that name), refs and objects (but it does not
notice a non-repository that has a non-directory with these names),
and this new one uses a test that is even more sloppy.

What I am trying to get at is if we want to use a single command
that can be given a path and answer "Yes, that is a repository"
here, and that single command should know how the repository should
look like.  I offhand do not know we already have such a command we
can use, e.g. "git rev-parse --is-git-dir $path", but if there isn't
perhaps we would want one, so that not just "git p4" but other
scripted Porcelains can make use of it?

-- >8 --
From: Luke Diamand <luke@diamand.org>
Date: Fri, 2 Dec 2016 22:43:18 +0000
Subject: [PATCH] git-p4: support secondary working trees managed by "git worktree"

Teach git-p4 about them.

Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-p4.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index fd5ca52462..b3c50ae7e5 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -566,6 +566,12 @@ def isValidGitDir(path):
     if (os.path.exists(path + "/HEAD")
         and os.path.exists(path + "/refs") and os.path.exists(path + "/objects")):
         return True;
+
+    # secondary working tree managed by "git worktree"?
+    if (os.path.exists(path + "/HEAD")
+        and os.path.exists(path + "/gitdir")):
+        return True
+
     return False
 
 def parseRevision(ref):
-- 
2.11.0-222-g22b1346184

