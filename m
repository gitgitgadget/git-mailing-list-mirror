Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE0C001B0
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 07:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjGNHKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 03:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjGNHKq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 03:10:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4553D2123
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 00:10:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6E5122157;
        Fri, 14 Jul 2023 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689318638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3wOPg/cNNr+gGk1kGeopa+yBnKoLBSUPxXmnGHKe7w=;
        b=odedA3255zKLIdKiss8Ig0/TaKK4EoJ0wYqBpNg2CXvVbFP7RvCdlqaYuWoKhNghgY9uzy
        CWWJB5P9TAYqFXjwqi5+vlGfOCrM2I/hGEeewDsxeR3vcnxZp62DVeACD7g1cPCdIyPvZd
        2Jlw5SHQUCrAyfe2TDlmpu8AkmzMd7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689318638;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3wOPg/cNNr+gGk1kGeopa+yBnKoLBSUPxXmnGHKe7w=;
        b=XfFaLGpoBPXAUo1KNSRq0uENG7rmnMuJTofYjicOTuXPMjO5pq1hnbw2UeLDIjaVMo/FQC
        kJMusbPlMzr8hTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63A92138F8;
        Fri, 14 Jul 2023 07:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gP6OFe70sGQDLgAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 14 Jul 2023 07:10:38 +0000
Date:   Fri, 14 Jul 2023 09:11:30 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] configure.ac: Don't overwrite NO_EXPAT option
Message-ID: <20230714071130.GA8854@alberich>
References: <20230713074654.23957-1-aherrmann@suse.de>
 <xmqqwmz3pwx2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwmz3pwx2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2023 at 10:02:17AM -0700, Junio C Hamano wrote:
> Andreas Herrmann <aherrmann@suse.de> writes:
> 
> > Subject: Re: [PATCH] configure.ac: Don't overwrite NO_EXPAT option
> 
> Downcase "D" in "Don't" (cf. "git log --oneline --no-merges
> --since=2.months"), please.

Oops, ok.

> > Even if 'configure --with-expat=no' was run, expat support is used,
> > because library detection overwrites it. Avoid this overwrite.
> 
> As I suspect that "configure" is not used a part of any experienced
> Git developers' daily development cycle, it is unfortunately very
> understandable how this left unnoticed for so long, ever since
> 424adc50 (autoconf: Move variables which we always set to
> config.mak.in, 2006-08-08), if I am reading the patch correctly, as
> a part of the very beginning of autoconf support.
> 
> Thanks for spotting it, and the fix look straight-forward.
> 
> > (I think, configure should obey what the user has specified.)
> 
> Sure, but please rephrase this parenthesized sentence.

I'll rephrase it.

>  * if you are unsure, and leaning to negative, say that below the
>    three-dash line.  No need for (parentheses).
> 
>  * otherwise, lose the (parentheses), "I think", and in general be
>    more assertive.
> 
> The latter is more preferrable.  The sentence with "I think" is your
> proposal to make it the project policy to make sure that ./configure
> script honors what the user gave it.  If other developers disagree
> with the policy you propose there, they will object and give their
> reason during their reviews.  If we adopt it as the project policy,
> which I personally think is very sensible, it is good to have it
> stated not as a mere personal opinion of the author of a commit, but
> more as a general rule.
> 
> Having said all that, I have some further observation.
> 
> The NO_EXPAT support does not look *so* special.  It is split into
> two parts:
> 
>  * Use AC_ARG_WITH(expat) to handle "--with-expat"
> 
>  * AC_CHECK_LIB([expat]) to auto-detect NO_EXPAT
> 
> Aren't there other symbols that share the same pattern?

I'll have a look at this.

> For example, how well do NO_CURL or NO_ICONV (which I picked because
> AC_ARG_WITH(curl) comes before and AC_ARG_WITH(iconv) comes after
> AC_ARG_WITH(expat)) work?  Do they share the same issue?

> A quick "git grep AC_ARG_WITH" finds openssl, libpcre*, and tcltk
> also share the same pattern, in addition to curl and iconv.  I may
> be misreading the script but USE_LIBPCRE2 support looks OK.
> NO_OPENSSL looks iffy, though not wrong per-se.  SHA1_Init is probed
> in libcrypto and in libssl regardless of the value of NO_OPENSSL.
> 
> I do not think it is a good idea to address the same issue for some
> of these other symbols, in addition to expat, in a single patch.
> Let's have people review the current patch for NO_EXPAT first, and
> leave the other symbols for possible follow-up patches.

I agree, separate patches is the preferred way if there is more to
fix.

> Thanks.

Thanks for your comments.

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
