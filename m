Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2F5C433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2072184D
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ThXFi0+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbgJIT1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 15:27:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60193 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388639AbgJIT1b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 15:27:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7923989702;
        Fri,  9 Oct 2020 15:27:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GZjGsKu/Mxi/sPUfrS2/V7OL0cQ=; b=ThXFi0
        +M+dUx20jl/GVVdEeeORDa23HEoiCnMHr4KLVjRIXMTsSYve7/V6+Q8wc/+JL2TO
        VpQDYOAUlKFKf9kU+WWsotjPPpzrQCxIZscExALBvtw9/D6bpnrMXFkcDg1w0ANT
        V1F3fHrPibeP7u/flc3I0g110VRGw+gQol41M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ppua1QGby4PXig8rzBbmRdBCf2k97gB/
        WpOMf/z0W319ic7hH+GilXic3SN+Vhbg+zC1XAR0UOePlrt5uyN8HkntSwCNN0CE
        w4PzL5a3UKcTQH18GSXFMOZibUo+NayA9rGO/VqSR0MY8L/KsYx+4SUhwPvFIJNU
        7csLXcXgds4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 709D689701;
        Fri,  9 Oct 2020 15:27:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEE40896FF;
        Fri,  9 Oct 2020 15:27:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>
Subject: [RFC] CodingGuidelines: mark external declarations with "extern"
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
        <20201009015505.GB1314@generichostname>
        <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
        <xmqqy2kfryiu.fsf@gitster.c.googlers.com>
Date:   Fri, 09 Oct 2020 12:27:28 -0700
In-Reply-To: <xmqqy2kfryiu.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 09 Oct 2020 12:26:49 -0700")
Message-ID: <xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 782692C2-0A65-11EB-BB44-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The document recommends not to write "extern" in front of a function
declaration, with justification that a decl by default is extern.

While it is true that by default decls are extern unless marked with
"static", it does not justify the choice.  It only justifies why we
could omit it if we wanted to, but does not say anything about the
reason why we would want to omit it in the first place.

Recently we saw that past mechanical conversion attempts kept a few
function decls with "extern" in front.  It seems that it was left
because the mechanical conversion tried not to touch external
declaration of pointers to functions, but the pattern used was
faulty and excluded functions that return pointers to functions.

For example, a pointer to a function may look like this:

    extern void (*default_frotz_handler)(int frotz);

We must not omit "extern" from this decl, which says "There exists a
variable whose name is default_frotz_handler, which points at a
function that takes an integer and returns nothing."  It is not a
function declaration and if written without "extern" in front,
requires the "common" extension to be correctly built.

But a function that returns a pointer to a function looks similar:

    extern void (*get_error_routine(void))(const char *message, ...);

which says "There is a get_error_routine() function that takes no
parameters, and it returns a pointer to a function that takes these
parameters and returns nothing".

The current rule tells us not to write "extern" in front, but the
earlier mechanical conversion missed it.  People when writing would
also miss it unless they are careful.

Instead of forcing contributors to spend time on on thinking if they
should or should not write "extern" in front of each of their decl
when they write new code, tell them that our external declarations
always say "extern" in front.  By doing so, we would also prevent a
mistake of not writing "extern" when we need to (i.e. decls of data
items, that are not functions) when less experienced developers try
to mimic how the existing surrounding declarations are written.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 45465bc0c9..eafe41bec8 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -433,10 +433,12 @@ For C programs:
  - Use Git's gettext wrappers to make the user interface
    translatable. See "Marking strings for translation" in po/README.
 
- - Variables and functions local to a given source file should be marked
-   with "static". Variables that are visible to other source files
-   must be declared with "extern" in header files. However, function
-   declarations should not use "extern", as that is already the default.
+ - Variables and functions local to a given source file should be
+   marked with "static". Variables that are visible to other source
+   files must be declared with "extern" in header files.  External
+   function declarations should also use "extern", while external
+   function definition should not, to make it easier to visually tell
+   them apart.
 
  - You can launch gdb around your program using the shorthand GIT_DEBUGGER.
    Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
-- 
2.29.0-rc1-92-g713508e020

