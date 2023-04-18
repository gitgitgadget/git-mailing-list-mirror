Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F2DC6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 16:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjDRQRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 12:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjDRQR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 12:17:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E161A273
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 09:17:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s23-20020a17090aba1700b00247a8f0dd50so31137pjr.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681834643; x=1684426643;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1xpn3hxURjETa/fUb60Q7SjgL89WpW8vIyZXhvWycY=;
        b=jRgYi1L1MHTlZrmkB3hEW0RTa3CGC9vpQS0khdycKBmJsO/+I6LdmChywAvD6/PW9J
         yFTtzaQqiFmojNIGy1SC1m08mBr7uHhMa+BbvPFc+VIegQi3TfYrPD1jtZrpu71WvqX4
         duXhukK8TuXjNu7OZQd+hoyXZ65wdo4NKbrctovtdPRrmRCiC8md+JIdmyuryVWEao6w
         vUnoANBy7NYfOnuARwI7fiyLGEiwsBAogJ810d0yXMjYsrOcjlpP8MupR2IxkJwy3YxG
         KxRZzAJEhAJEiuyARwfqh6aWUTOBIN+2uQeQ95EN0ZrFkDcGru4O+/U1m0LDKD1MrOku
         RzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834643; x=1684426643;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K1xpn3hxURjETa/fUb60Q7SjgL89WpW8vIyZXhvWycY=;
        b=TnFf52teQ3/QmsXlnWUS+Ht88BEIdvU+PnyufgzLuIjzDM/lFRsuw0An0ru0lLsXYN
         MOAoZ20Hv32ybpuxQoXNXORGZP8CbrG15c36P12La93lcJZzKnNtOrFN0OEpVoxQml+r
         esmVqId00GOlFLmUnHR6O3tmQymdT6SteyqpaoRe/AXk4qOU2w8zRaj7K9pNvZs+IuK8
         klJXQlnw1rYN6KmQldKQEmJVKsNgLZdSnylMgG1xDeTYgAj631YDjhiQpFy78QdIA5A6
         DJKNe9ES7LD+y3s84eY4YPqFx7NohbiCbLfZx9ozGmPYLQou4mz8lNqGgzYvngxwvqzM
         yeWQ==
X-Gm-Message-State: AAQBX9dJ3q8ec3Un77ixKqEqbH8Z3GbD92zsJgjBs+RsBpt+1zUpdpAg
        dnzxUsUK0yWRpBei7cJJieL59irEBIE=
X-Google-Smtp-Source: AKy350baWueXzOTtYLZGi6SzAmfTajLKPvO/J3TNe8OwO3652rlP7/AySK1SBHCPPe90TD7YprdIHg==
X-Received: by 2002:a05:6a21:3282:b0:f0:2222:8b58 with SMTP id yt2-20020a056a21328200b000f022228b58mr431425pzb.12.1681834642460;
        Tue, 18 Apr 2023 09:17:22 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id j27-20020a63fc1b000000b0050f9b7e64fasm9054803pgi.77.2023.04.18.09.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:17:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     git@vger.kernel.org
Subject: Re: gpg-related crash with custom formatter (BUG:
 gpg-interface.c:915: invalid trust level requested -1)
References: <5926995.lOV4Wx5bFT@devpool47.emlix.com>
Date:   Tue, 18 Apr 2023 09:17:21 -0700
In-Reply-To: <5926995.lOV4Wx5bFT@devpool47.emlix.com> (Rolf Eike Beer's
        message of "Tue, 18 Apr 2023 08:12:03 +0200")
Message-ID: <xmqq354xf9m6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rolf Eike Beer <eb@emlix.com> writes:

> I use this one:
>
> [format]
>         pretty = %C(yellow)commit %H%C(auto)%d%Creset%nAuthor: %an <%ae> 
> %C(yellow)% GK %GS %C(auto)[%GT% G?]%Creset%nDate:   %ad%n%n%w(0,4,4)%s%n%w(0,
> 4,4)%+b
>
> When I now run "git log" in a repository that contains commits signed by 
> people not in my keyring (e.g. the Gentoo git) I get this backtrace:

Thanks for a clearly described report.  GPG reports something like

    [GNUPG:] NEWSIG
    [GNUPG:] ERRSIG B0B5E88696AFE6CB 1 8 00 1681831898 9 E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB
    [GNUPG:] NO_PUBKEY B0B5E88696AFE6CB

but parse_gpg_output() that is responsible for setting the
trust_level member of sigc structure never responds to this report
because none among NEWSIG, ERRSIG, and NO_PUBKEY begins with
"TRUST_" that triggers a call to parse_gpg_trust_level() to set the
member.

The caller of parse_gpg_output() initializes the member to -1 and
that is left intact.  Of course, it is not one of the values that
gpg_trust_level_to_str() knows about.

The absolute minimum fix is to initialize the member to TRUST_NEVER
which is one of the values gpg_trust_level_to_str() knows about.  It
seems that SSH based signature verification codepath uses the same
approach.


 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/gpg-interface.c w/gpg-interface.c
index aceeb08336..2044e00205 100644
--- c/gpg-interface.c
+++ w/gpg-interface.c
@@ -650,7 +650,7 @@ int check_signature(struct signature_check *sigc,
 	gpg_interface_lazy_init();
 
 	sigc->result = 'N';
-	sigc->trust_level = -1;
+	sigc->trust_level = TRUST_NEVER;
 
 	fmt = get_format_by_sig(signature);
 	if (!fmt)
