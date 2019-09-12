Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E354D1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 18:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfILSko (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 14:40:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60773 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfILSkn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 14:40:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6396795FB;
        Thu, 12 Sep 2019 14:40:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ECTYTZRgIo5zs/K7TVSP6Tez9o=; b=gcrOPP
        FPLumMdazsjNpQ/F0cJNIpkaupoG0ArjvFMN2SjHlIZFNxrM2yZkN5Evh75hMnh3
        YiHy2xu/g+Flu8diGPr3WNjqyxSGFLGULSygphcqTfsYB+xnDZNtT6liKmRzZAPV
        7qQDNHPZXlMf2t7kHvYFi+pAieKpWkfIrFmoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gcdY9huDfeSrE29C2Wl9RDnf99i7Ng5z
        TqM03iu0EeAzhrEZUe5PVOj2ngZ78p43wnML/uy0h1I2ZlpZlWkYBzCTzNX/GySt
        cQKi4LxhS3SrMipIEhcDuyaqJyKv8poG9X5smwpU/nyncFizKSg6h+ZjvvIuvzTo
        dqud0n3HWlw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE1FF795FA;
        Thu, 12 Sep 2019 14:40:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D74DE795F7;
        Thu, 12 Sep 2019 14:40:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Makefile: run coccicheck on more source files
References: <cover.1568101393.git.liu.denton@gmail.com>
        <cover.1568309119.git.liu.denton@gmail.com>
        <89b7e17469e19c9dca8afa729ec1a70f4e06a2b7.1568309119.git.liu.denton@gmail.com>
Date:   Thu, 12 Sep 2019 11:40:36 -0700
In-Reply-To: <89b7e17469e19c9dca8afa729ec1a70f4e06a2b7.1568309119.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 12 Sep 2019 10:28:34 -0700")
Message-ID: <xmqqtv9hfjdn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0EF539E-D58C-11E9-8AFE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> +COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FIND_C_SOURCES))

The former is somewhat misnamed.  FIND_SOURCE_FILES is *not* a list
of source files---it is a procedure to list source files to its
standard output.  FIND_C_SOUCRES sounds as if it is a similar
procedure, which would be implemented much like

	FIND_C_SOURCES = $(FIND_SOURCE_FILES) | sed -n -e '/\.c$/p'

but that is not what you did and that is not what you want to have.
Perhaps call it FOUND_C_SOURCES?

I wonder if we can get rid of FIND_SOURCE_FILES that is a mere
procedure and replace its use with a true list of source files.
Would it make the result more pleasant to work with?

Perhaps something like the attached patch, (which would come before
this entire thing as a clean-up, and removing the need for 2/3)?

I dunno.

Using a procedure whose output is fed to xargs has an advantage that
a platform with very short command line limit can still work with
many source files, but the way you create and use COCCI_SOURCES in
this patch would defeat that advantage anyway, so perhaps we can get
away with an approach like this.  Having a list of things in $(MAKE)
variable has a longer-term benefit that we could exploit more
parallelism if we wanted to, too.

 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index f9255344ae..9dddd0e88c 100644
--- a/Makefile
+++ b/Makefile
@@ -2584,7 +2584,7 @@ perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	pod2man $< $@
 
-FIND_SOURCE_FILES = ( \
+SOURCE_FILES = $(patsubst ./%,%,$(shell \
 	git ls-files \
 		'*.[hcS]' \
 		'*.sh' \
@@ -2599,19 +2599,19 @@ FIND_SOURCE_FILES = ( \
 		-o \( -name 'trash*' -type d -prune \) \
 		-o \( -name '*.[hcS]' -type f -print \) \
 		-o \( -name '*.sh' -type f -print \) \
-	)
+	))
 
 $(ETAGS_TARGET): FORCE
 	$(RM) $(ETAGS_TARGET)
-	$(FIND_SOURCE_FILES) | xargs etags -a -o $(ETAGS_TARGET)
+	etags -a -o $(ETAGS_TARGET) $(SOURCE_FILES)
 
 tags: FORCE
 	$(RM) tags
-	$(FIND_SOURCE_FILES) | xargs ctags -a
+	ctags -a $(SOURCE_FILES)
 
 cscope:
 	$(RM) cscope*
-	$(FIND_SOURCE_FILES) | xargs cscope -b
+	cscope -b $(SOURCE_FILES)
 
 ### Detect prefix changes
 TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\




