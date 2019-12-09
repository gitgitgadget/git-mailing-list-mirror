Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32EC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C925120637
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DCadPY2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIWWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:22:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52056 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIWWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 17:22:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B97D2AA858;
        Mon,  9 Dec 2019 17:22:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nh/DGO4C9GLVLsGwVPF99xEWIDo=; b=DCadPY
        2Gwj4w0TiNfZGGnjb8d8vbaci3vrxJSeiOahFBF4j+xR4F0D56SvqlpK+vaMpumD
        F+w7AkiH3/5ouMg637LFykcjXA4tcpdAoPoxv5DkBOpNojM6EINT+qbX3ILAKroN
        TzFQJn9NpBNHkpqjtnaZbjG/Z0d9H0VN5PQGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R2czJyMqLd8zaiGVEt+PzMiO28oAI3jX
        xFDKOnwvspJ0q5ec1TJ76LHHITDtyBDaCE5zjmayg/V9oTLre0BYett3dfjsNl8l
        mUNBiOKOIKWrutgIzqjy6mDFYCIpYzT2wqBZfTw9vkHhDfnmf+XGx1q2wl38yiGu
        xAdY5zEjx0M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2760AA857;
        Mon,  9 Dec 2019 17:22:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D5818AA855;
        Mon,  9 Dec 2019 17:22:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH 2/3] git-p4: [usability] RCS Keyword failure should suggest help
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
        <d608f529a0e01e99c97e895ab483000da068a7ac.1575901009.git.gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:22:44 -0800
In-Reply-To: <d608f529a0e01e99c97e895ab483000da068a7ac.1575901009.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Mon, 09 Dec 2019 14:16:48
        +0000")
Message-ID: <xmqqa781t9zf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D62D374-1AD2-11EA-8F24-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> When applying a commit fails because of RCS keywords, Git
> will fail the P4 submit. It would help the user if Git suggested that
> the user set git-p4.attemptRCSCleanup to true.
>
> Change the applyCommit() method that when applying a commit fails
> becasue of the P4 RCS Keywords, the user should consider setting

s/becasue/because/

> git-p4.attemptRCSCleanup to true.

The above explains the new "else:" clause really well.  The
original's logic was to

 - tryPatchCmd to apply a commit, which might fail,
 - when the above fails, only if attemptrcscleanup is set, munge
   the lines with rcs keywords and rerun tryPatchCmd

but your new "else:" gives a suggestion to use the (experimental?)
attemptRCSCleanup feature.

However, it does not explain the change to the "if :" clause.  I can
see that patchRCSKeywords() method does want to raise an exception,
and it is a good idea to prepare for the case and clean up the mess
it may create.  At least that deserves a mention in the proposed log
message---I actually think that the new try/except is an equally
important improvement that deserves to be a separate patch.

> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>  git-p4.py | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 0fa562fac9..856fe82079 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1950,8 +1950,23 @@ def applyCommit(self, id):
>                      # disable the read-only bit on windows.
>                      if self.isWindows and file not in editedFiles:
>                          os.chmod(file, stat.S_IWRITE)
> -                    self.patchRCSKeywords(file, kwfiles[file])
> -                    fixed_rcs_keywords = True
> +                    
> +                    try:
> +                        self.patchRCSKeywords(file, kwfiles[file])
> +                        fixed_rcs_keywords = True
> +                    except:
> +                        # We are throwing an exception, undo all open edits
> +                        for f in editedFiles:
> +                            p4_revert(f)
> +                        raise
> +            else:
> +                # They do not have attemptRCSCleanup set, this might be the fail point
> +                # Check to see if the file has RCS keywords and suggest setting the property.
> +                for file in editedFiles | filesToDelete:
> +                    if p4_keywords_regexp_for_file(file) != None:
> +                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
> +                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
> +                        break
>  
>              if fixed_rcs_keywords:
>                  print("Retrying the patch with RCS keywords cleaned up")
