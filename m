Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9978C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 22:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AC9207DD
	for <git@archiver.kernel.org>; Fri,  8 May 2020 22:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oVqJ6N8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgEHW0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 18:26:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58496 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHW0O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 18:26:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76DAB4E686;
        Fri,  8 May 2020 18:26:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oE+GM30zighgMCe9mpF7WzL8gb0=; b=oVqJ6N
        8gpMlbX2TR4RhuNANZoZxDc26AC2lJVKfjyGcu/5AkfvMXixyVbLMHi+TxCXF6E/
        t9E+gS/6efhbxnHxqIRRE/sJ8sNC19VSekEQwkqNJuB+WMuCW2BZuKMODlDp6Z7C
        W+fofE582nZuzAB4mdOP6zFwqnZZ5vjD+Kp08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hQDl9Cv+GiIwqwkPkjZDUeVtmuNe2wyk
        5zqpZMnfH5rqPZ8MYc48uyiIY0dy0UIXiKjUccMdQ6gOxiRRG1mATCuiIbsoMHr5
        II8MNHVjKiEuTtB6N3RizpQ8bi6gR4WKYEc1J0HOh1ZPLdzJSdELm9DLSqCXDYSu
        LQFwb4VC/GI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D1934E684;
        Fri,  8 May 2020 18:26:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD4904E682;
        Fri,  8 May 2020 18:26:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: Preparing for a Git 2.26.3 release
References: <20200428055514.GB201501@google.com>
Date:   Fri, 08 May 2020 15:26:07 -0700
In-Reply-To: <20200428055514.GB201501@google.com> (Jonathan Nieder's message
        of "Mon, 27 Apr 2020 22:55:14 -0700")
Message-ID: <xmqqk11mvzb4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E98CA00A-917A-11EA-974D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Since then we've heard about a few related (non-security) regressions.
> I'd like to avoid giving people an excuse not to upgrade, so this
> morning[1] I promised a discussion of what I'd like to see in a 2.26.3
> release to help with that.

I will be pushing out an update to 'master' shortly, which merges
more than a handful of features that could go to 2.26.x track.  We
obviously won't be merging all of them in 2.26.3, so let me try to
give an excerpt from the draft release notes on the 'master' front.

I did not limit the following list to the ones that are related to
the recent CVEs, but I excluded many of them to limit the size of
2.26.3.

Please help to further shrink the scope of 2.26.3 by nominating ones
that should be omitted.  The absolute minimum would be just the ones
related to the credential, I guess.

 * Those fetching over protocol v2 from linux-next and other kernel
   repositories are reporting that v2 often fetches way too much than
   needed.
   (merge 11c7f2a30b jn/demote-proto2-from-default later to maint).

 * The upload-pack protocol v2 gave up too early before finding a
   common ancestor, resulting in a wasteful fetch from a fork of a
   project.  This has been corrected to match the behaviour of v0
   protocol.
   (merge 2f0a093dd6 jt/v2-fetch-nego-fix later to maint).

 * The server-end of the v2 protocol to serve "git clone" and "git
   fetch" was not prepared to see a delim packets at unexpected
   places, which led to a crash.
   (merge cacae4329f jk/harden-protocol-v2-delim-handling later to maint).

 * The more aggressive updates to remote-tracking branches we had for
   the past 7 years or so were not reflected in the documentation,
   which has been corrected.
   (merge a44088435c pb/pull-fetch-doc later to maint).

 * We've left the command line parsing of "git log :/a/b/" broken for
   about a full year without anybody noticing, which has been
   corrected.
   (merge 0220461071 jc/missing-ref-store-fix later to maint).

 * Misc fixes for Windows.
   (merge 3efc128cd5 js/mingw-fixes later to maint).

 * Parsing the host part out of URL for the credential helper has been corrected.
   (merge 4c5971e18a jk/credential-parsing-end-of-host-in-URL later to maint).

 * Validation of push certificate has been made more robust against
   timing attacks.
   (merge 719483e547 bc/constant-memequal later to maint).

 * Raise the minimum required version of docbook-xsl package to 1.74,
   as 1.74.0 was from late 2008, which is more than 10 years old, and
   drop compatibility cruft from our documentation suite.
   (merge 3c255ad660 ma/doc-discard-docbook-xsl-1.73 later to maint).

 * The build procedure did not use the libcurl library and its include
   files correctly for a custom-built installation.
   (merge 0573831950 jk/build-with-right-curl later to maint).

 * Recent update to Homebrew used by macOS folks breaks build by
   moving gettext library and necessary headers.
   (merge a0b3108618 ds/build-homebrew-gettext-fix later to maint).

 * Error and verbose trace messages from "git push" did not redact
   credential material embedded in URLs.
   (merge d192fa5006 js/anonymise-push-url-in-errors later to maint).

 * Update the parser used for credential.<URL>.<variable>
   configuration, to handle <URL>s with '/' in them correctly.
   (merge b44d0118ac bc/wildcard-credential later to maint).

 * Recent updates broke parsing of "credential.<url>.<key>" where
   <url> is not a full URL (e.g. [credential "https://"] helper = ...)
   stopped working, which has been corrected.
   (merge 9a121b0d22 js/partial-urlmatch-2.17 later to maint).
   (merge cd93e6c029 js/partial-urlmatch later to maint).

 * With the recent tightening of the code that is used to parse
   various parts of a URL for use in the credential subsystem, a
   hand-edited credential-store file causes the credential helper to
   die, which is a bit too harsh to the users.  Demote the error
   behaviour to just ignore and keep using well-formed lines instead.
   (merge c03859a665 cb/credential-store-ignore-bogus-lines later to maint).

 * The samples in the credential documentation has been updated to
   make it clear that we depict what would appear in the .git/config
   file, by adding appropriate quotes as needed..
   (merge 177681a07e jk/credential-sample-update later to maint).

 * The <stdlib.h> header on NetBSD brings in its own definition of
   hmac() function (eek), which conflicts with our own and unrelated
   function with the same name.  Our function has been renamed to work
   around the issue.
   (merge 3013118eb8 cb/avoid-colliding-with-netbsd-hmac later to maint).

