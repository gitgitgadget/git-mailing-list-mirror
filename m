Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB208EE801F
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 16:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbjIHQnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 12:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjIHQnj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 12:43:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84CA19B6
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 09:43:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so2203961f8f.1
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694191414; x=1694796214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XD1/XbCowMcvEl/VBInh+E4JS8PNooJAVJXndsTdQjE=;
        b=g1OrUKQpqkxOX3ghzzucLmHghGgVF311/5M8+3AUgA31LcNgsohWPwz9d4JDraAm1Z
         +Ff+lLA3SOWAZzOKz1Kp7DGuYHFeM03oNWlxpxeWSiOBrbGRQHU27oYvgY643NnY6eYg
         SDeCG/79VyWHGQTlpGxuTkGJ9AJZQAHbjwmF3x5n1Sv60bRLRvV3z/5sNO+34V3Jlv80
         CIlGRi3kLkb5apHTcG6edAWioXsl9XilExzeVyE3vyO77PLOKL68/gBIw4/pGwkpvGRY
         3krjvWzTU2RAXCHrlNMK8+pka1jS+9XGgOJ7tbWv11mLQKid0qeTxPFquDJWO0awSKwr
         FPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694191414; x=1694796214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XD1/XbCowMcvEl/VBInh+E4JS8PNooJAVJXndsTdQjE=;
        b=C+A4H6LX0Th7XftXaDeEAaEbpOA1PQ+dxgiA8OkpiqdnxL9vNfEkbTnTBvvzBgErv4
         W8aWO1zsfgW9DVJaUUjxf8HEESrdwcWt+PDD4rhorc/7lFVox9xVEn1GHRPj4s5sc/fj
         9jc0AnHvby9wBLwLa9wL5f8gwormmiuOwj6zASyNdQeSBzLoIegghxRSOGE7zAMIfjQE
         XmAqKYAg52mBEsQ+Xez40EbftEKpgZvSTvmj/iaA7HpZDJTBmAQbsFn1eBzv4oJdW/VW
         fz1JtbVqyu6DX/MmSmqrrHkV0KN7s45jGDLaVO4sUwpMiEiAOYR4B7rS4zYlOOY6SLay
         o7Kw==
X-Gm-Message-State: AOJu0Yx8CRQ6UVX2tbuUEVmldMwf9x79/EBJmUmHsyk8OUyBaMvv747N
        xqN49QQLLqeYH+1jbVSywqE=
X-Google-Smtp-Source: AGHT+IFt/9ORzMs02LF8jPmhX94C0+oSroLHK8rYk5wtM12Tl5fkgdjmaaacmGmkeKPxMHKnwCmoSg==
X-Received: by 2002:adf:ec88:0:b0:317:18a8:5fa1 with SMTP id z8-20020adfec88000000b0031718a85fa1mr2335082wrn.69.1694191413847;
        Fri, 08 Sep 2023 09:43:33 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b0031ddf6cc89csm2496756wrx.98.2023.09.08.09.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 09:43:33 -0700 (PDT)
Message-ID: <376d3ea0-a3eb-4b25-8bf2-ca40c4699e26@gmail.com>
Date:   Fri, 8 Sep 2023 17:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] start_command: reset disposition of all signals in child
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1582.git.1694167540231.gitgitgadget@gmail.com>
 <xmqqedj8vfht.fsf@gitster.g> <ba69ab35-3204-4360-a36d-3253680b2479@gmail.com>
 <xmqqmsxwtyy3.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqmsxwtyy3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09/2023 17:24, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 08/09/2023 16:42, Junio C Hamano wrote:
>>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> [3] This is really a work-around for not moving the child into its own
>>>>       process group and changing the foreground process group of the
>>>>       controlling terminal.
>>> I am puzzled, as I somehow thought that "does the user conceive a
>>> subprocess as external and different-from-git entity, or is it
>>> merely an implementation detail?  many use of subprocesses in our
>>> codebase, it is the latter." from Peff was a good argument against
>>> such isolation between spawning "git" and spawned subprocesses.
>>
>> It is and in those cases we do not ignore SIGINT and SIGQUIT in the
>> parent when we fork the subprocess. What I was trying to say is that
>> in the few cases where we do ignore SIGINT and SIGQUIT in the parent
>> when we fork a subprocess we're working round the child being in the
>> same process group at the parent.
> 
> Hmph, but picking a few grep hits for 'sigchain_push.*SIG_IGN' at
> random, the typical pattern seem to be (this example was taken from
> builtin/receive-pack.c):
> 
> 	code = start_command(&proc);
> 	if (code) {
> 		...
> 		return code;
> 	}
> 	sigchain_push(SIGPIPE, SIG_IGN);
> 	while (1) {
> 		...
> 	}
> 	close(proc.in);
> 	sigchain_pop(SIGPIPE);
> 	return finish_command(&proc);
> 
> The way we spawn an editor in editor.c looks the same:
> 
> 		p.use_shell = 1;
> 		p.trace2_child_class = "editor";
> 		if (start_command(&p) < 0) {
> 			strbuf_release(&realpath);
> 			return error("unable to start editor '%s'", editor);
> 		}
> 
> 		sigchain_push(SIGINT, SIG_IGN);
> 		sigchain_push(SIGQUIT, SIG_IGN);
> 		ret = finish_command(&p);
> 
> IOW, we do not ignore then spawn.  We spawn and ignore only in the
> parent, so there shouldn't be any reason to worry about our child
> inheriting the "we the parent git process do not want to be killed
> by \C-c" settings, should there?

Oh I should have looked more carefully at the existing uses. It looks 
like it is only my sequencer patch that does

	sigchain_push(SIGINT, SIG_IGN);
	sigchain_push(SIGQUIT, SIG_IGN);
	res = run_command(...);

In that case the existing behavior is a problem but maybe I should 
change those call sites to use start_command() and finish_command() 
instead if we decide that other patch is a good idea.

> I have a vague recollection that the "propagate what was already
> ignored to be ignored down to the child, too" was not about signals
> we ignored, but inherited from the end-user who started git with
> certain signals ignored, but it is so old a piece of code that the
> details of the rationale escapes me.

The comment

	/* ignored signals get reset to SIG_DFL on execve */

in start_command() makes it look like the code assumes ignored signals 
will be reset to SIG_DFL by execve() which is not what happens. Maybe 
that comment is just wrong and there is a good reason for the current 
behavior.

Best Wishes

Phillip
