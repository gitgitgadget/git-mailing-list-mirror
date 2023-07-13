Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C9CC001DF
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 21:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjGMVhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGMVhR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 17:37:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0CF1FC0
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:37:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F7FF1E28D;
        Thu, 13 Jul 2023 17:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lscyjvft339f7pZ2zF/4+zlXuQgNLuH7qilIOB
        iT4v4=; b=YNVSBqwmJM/AsaxzhKwE2CbEN/aSeSeRCnJLYojF0RzyhJMk943lp1
        OvI4HMKUqGKAet7Khvo/2hqyzYu3Q6Xtw0MknktkxXerzteCutiKhK1kGllo/17X
        wIu/pxBp9HTebC1NPWag7MdvBYUS7bJLK+3a5Ei70uHXyI+JYyp+0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A77E1E28C;
        Thu, 13 Jul 2023 17:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CB8691E28B;
        Thu, 13 Jul 2023 17:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Petar Vutov <pvutov@imap.cc>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] docs: highlight that .gitmodules does not
 support !command
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
        <20230713193342.1053968-1-pvutov@imap.cc>
        <a8bde495-57fc-6a70-e325-6e2a52f40552@imap.cc>
        <xmqqwmz3oacg.fsf@gitster.g>
        <9de918bc-6913-0486-02dd-5b4028a7fe1b@imap.cc>
        <xmqqa5vzo7jy.fsf@gitster.g>
Date:   Thu, 13 Jul 2023 14:37:10 -0700
In-Reply-To: <xmqqa5vzo7jy.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        13 Jul 2023 13:55:29 -0700")
Message-ID: <xmqqv8enmr21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D24A060-21C5-11EE-9501-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> After reading the original again and again, I hate more and more the
> way the original wasted too many words to refer to one thing twice
> (e.g. "arbitrary command" and then "is the custom command", "a
> single argument" and then the parenthesized explanation of it)
> without adding any clarity.

Another thing I noticed is that this section is ONLY talking about
the configuration variable, so everything both of us have been
saying misses the point.  The preamble before the choices
("checkout", "rebase", "merge", "custom" and "none") are listed read
like so:

    update [--init] [--remote] [-N|--no-f...
    +
    --
    Update the registered submodules to match what the superproject
    expects by cloning missing submodules, fetching missing commits
    in submodules and updating the working tree of
    the submodules. The "updating" can be done in several ways depending
    on command line options and the value of `submodule.<name>.update`
    configuration variable. The command line option takes precedence over
    the configuration variable. If neither is given, a 'checkout' is performed.
    The 'update' procedures supported both from the command line as well as
    through the `submodule.<name>.update` configuration are:

Then why do we even think about referring to ".gitmodules" here?  It
is because of this behaviour that is described elsewhere:

    init [--] [<path>...]::
            Initialize the submodules recorded in the index (which were
            added and committed elsewhere) by setting `submodule.$name.url`
            in .git/config. It uses the same setting from `.gitmodules` as
            a template. If the URL is relative, it will be resolved using
            the default remote. If there is no default remote, the current
            repository will be assumed to be upstream.
    +
    Optional <path> arguments limit which submodules will be initialized.
    If no path is specified and submodule.active has been configured, submodules
    configured to be active will be initialized, otherwise all submodules are
    initialized.
    +
    When present, it will also copy the value of `submodule.$name.update`.

and this description is very flawed.  It says "X is copied", but not
"X is copied from A to B".  It also does not say that even if you
have a custom command there, it does not get copied.

It copies submodule.<name>.update from the ".gitmodules" to the
configuraiton.  And that is the reason why, the configuration may
have "submodule.<name>.update" in it after running "git init" to
initialize a submodule.  And that is why the choices of update
methods listed in the part your patch touched talked about things
that can both appear in .gitmodules and the configuration.  But the
linkage is quite indirect.

So, here is another round, this time the primary change is to stop
talking about `.gitmodules` in the "update" section, but explain how
`.gitmodules` file is used in the "init" section.

 Documentation/git-submodule.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git c/Documentation/git-submodule.txt w/Documentation/git-submodule.txt
index 4d3ab6b9f9..5248840b18 100644
--- c/Documentation/git-submodule.txt
+++ w/Documentation/git-submodule.txt
@@ -95,7 +95,7 @@ too (and can also report changes to a submodule's work tree).
 init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
 	added and committed elsewhere) by setting `submodule.$name.url`
-	in .git/config. It uses the same setting from `.gitmodules` as
+	in `.git/config`, using the same setting from `.gitmodules` as
 	a template. If the URL is relative, it will be resolved using
 	the default remote. If there is no default remote, the current
 	repository will be assumed to be upstream.
@@ -105,9 +105,12 @@ If no path is specified and submodule.active has been configured, submodules
 configured to be active will be initialized, otherwise all submodules are
 initialized.
 +
-When present, it will also copy the value of `submodule.$name.update`.
-This command does not alter existing information in .git/config.
-You can then customize the submodule clone URLs in .git/config
+It will also copy the value of `submodule.$name.update`, if present in
+the `.gitmodules` file, to `.git/config`, but (1) this command does not
+alter existing information in `.git/config`, and (2) `submodule.$name.update`
+that is set to a custom command is *not* copied for security reasons.
++
+You can then customize the submodule clone URLs in `.git/config`
 for your local setup and proceed to `git submodule update`;
 you can also just use `git submodule update --init` without
 the explicit 'init' step if you do not intend to customize
@@ -143,6 +146,8 @@ the submodules. The "updating" can be done in several ways depending
 on command line options and the value of `submodule.<name>.update`
 configuration variable. The command line option takes precedence over
 the configuration variable. If neither is given, a 'checkout' is performed.
+(note: what is in `.gitmodules` file is irrelevant at this point;
+see `git submodule init` above for how `.gitmodules` is used).
 The 'update' procedures supported both from the command line as well as
 through the `submodule.<name>.update` configuration are:
 
@@ -160,9 +165,6 @@ checked out in the submodule.
 	merge;; the commit recorded in the superproject will be merged
 	    into the current branch in the submodule.
 
-The following 'update' procedures are only available via the
-`submodule.<name>.update` configuration variable:
-
 	custom command;; arbitrary shell command that takes a single
 	    argument (the sha1 of the commit recorded in the
 	    superproject) is executed. When `submodule.<name>.update`
