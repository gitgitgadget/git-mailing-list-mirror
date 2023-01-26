Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E1C05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 15:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjAZP4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 10:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAZP4H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 10:56:07 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19548A27
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 07:56:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j5so1898894pjn.5
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 07:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbKm45+B/pTffPf+cGA8Xba1z8Pwk0Ff4480eiBN+gk=;
        b=Ai2PLPFwskOOEwfGW18nlPlS+xbQhtmaoxQGOd6TljfeXZGuP7GG9U43Xh6kfAYk9U
         bSd3xB0FhVKZeq5B94aBzwtMiHEzzOH+nuKBkWHR4lwGQD3HqNWWLP7kT/zyWriHH+iq
         VrLlf/Vn7ppH/uXbtWmE9pQ007e45rZeXAKIQdo5uG2oQxs+ZBjRPu1UydXlCVon3qoB
         Mhf2SpoV1NDzMOUwq+7CfTyewXDa/FTwypWDpDLml7IfyoZ6DEqwe+C8P+U4dXvCfE78
         N2PWYptMhrsCUX2XFiJ0vqwZoSq19CjUTmv6os6DFEKPvOT19RIFafYqbdWsS8xrNUem
         gW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vbKm45+B/pTffPf+cGA8Xba1z8Pwk0Ff4480eiBN+gk=;
        b=WD2/dTFTmXaczUfakjN7QicIX4uIS6CJsP3PPyYBB6QwCuupJrjQFkgL9zgpMHcLBi
         gNz7LpeuzMYU1fJE7ptuYgQdOhGWjuoImWvpO0o0+iRpNiZWee+TWGZ1QN/rceHz5ySD
         fOxFws5JO6qz6BQP0ukJ+lO8akxdmDWfUH1qI67EkWfgRX9XdZEoQ8c61XnTn4fWijAM
         nLxr6/2Kj+pOwv3sdxef0CiFOuLEvuldMbKvlmp7CQ7be388cyV9g8lm7H16yKh0RNgH
         w6GcSIJxF3iug3/hctTVUrvEuYSvYfxtzg3un6MtUNXtBOMiiXyLgPLBu8hlQOIeJ/mE
         YkVQ==
X-Gm-Message-State: AFqh2kqN2NJJvR8W2iONR1tkNaShGcHs3E8gnKsfDd6+eceNp7sQmgJr
        RnDzvuzDLQatjCOQqNJfBuNbehcfJwA=
X-Google-Smtp-Source: AMrXdXtj70yGDGT/pX9ruwzkeAjo8nzxIFxLKf4ml9AL+ojnJ2BkTL9x3/9vKAQndbM4Ao1znmKrnA==
X-Received: by 2002:a05:6a20:958a:b0:b8:6edc:7eac with SMTP id iu10-20020a056a20958a00b000b86edc7eacmr40634483pzb.39.1674748564115;
        Thu, 26 Jan 2023 07:56:04 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id d197-20020a6336ce000000b0042988a04bfdsm897172pga.9.2023.01.26.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:56:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Yangyang Hua <hyy_41@live.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: When using several ssh key, Git match ssh key by host, instead
 of hostname in ssh config file.
References: <OSYP286MB0215D880FA9D82B74E393DD691CF9@OSYP286MB0215.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 26 Jan 2023 07:56:03 -0800
In-Reply-To: <OSYP286MB0215D880FA9D82B74E393DD691CF9@OSYP286MB0215.JPNP286.PROD.OUTLOOK.COM>
        (Yangyang Hua's message of "Thu, 26 Jan 2023 14:46:54 +0000")
Message-ID: <xmqqk019cmss.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yangyang Hua <hyy_41@live.com> writes:

> Hi, I find when I use several ssh keys with the right config file
> and clone my private repo, git can't match the key by hostname.
> ...
> I think when git read ssh config, it uses host to match the key
> instead of hostname. Is this bug?

This useful feature is given by ssh, and Git does not deserve credit
for it.  The config file of SSH allows you to write multiple entries
that points at the same host, e.g.

    Host host1
      HostName host.example.com
      IdentityFile ~/.ssh/id_rsa_111

    Host host2
      HostName host.example.com
      IdentityFile ~/.ssh/id_rsa_222

so that you can specify which key to use for the same destination
when you have more than one user there. "ssh host1" uses id_rsa_111
while "ssh host2" uses the other one, both connections going to the
same destination host.

If host.example.com were a hosting site like github.com, you can use this
feature to say

    $ git push git@host1:/me/lesson1

to connect using id_rsa_111.  If you use

    $ git clone git@github.com:/me/lesson1

there is no clue which of the two entries you want to use.
