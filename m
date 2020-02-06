Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D8C33CAC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 18:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DC720659
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 18:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x1ML/MId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBFS0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:26:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52381 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFS0P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 13:26:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7EE443476;
        Thu,  6 Feb 2020 13:26:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kFc3My7Euft0nMVH1RAaoVOd6sE=; b=x1ML/M
        IdRmVWTBYa4Tt8RP/BRINb+jak37Hm4dyv4ZG8SBBxJNdFi2laecUxKWE00jLCvw
        VCrRNDNz2rKKx8N/93ixtFvurV+/jC3PhHORprOj7xrWPIEHmVvE3hTETPr98wcz
        IWpXx3T556gTB96Z5nOKCFgiO2NkNUg0YC4VE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W4xih0Cl9xPUFBKwOdrtGnGDT+U2KMMR
        rjVA5w7AA5dJOXCOBaROlNPlIKRXTjW9IJU/meZVPok1ZS5TboMnpcLMCqqe38CY
        TSC6c5QJrP28U6FODcvpptL6/Q3S4IgjdWg4yG7O+BDbiKITgTUw9lbQWn0cMEJi
        FlKyr5aZzb0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82F8143475;
        Thu,  6 Feb 2020 13:26:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7010343474;
        Thu,  6 Feb 2020 13:26:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Keene <seraphire@gmail.com>
Cc:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] git-p4: create new method gitRunHook
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
        <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <f1f9fdc542353196612f8dd6b996d4fbd1f76c73.1580507895.git.gitgitgadget@gmail.com>
        <xmqqr1za6q83.fsf@gitster-ct.c.googlers.com>
        <ac44531e-b02d-5a98-3e25-a305b1250cf6@gmail.com>
        <xmqq36bohfsi.fsf@gitster-ct.c.googlers.com>
        <9cf8790e-6d13-4653-cddc-f5328f22b0df@gmail.com>
Date:   Thu, 06 Feb 2020 10:26:09 -0800
In-Reply-To: <9cf8790e-6d13-4653-cddc-f5328f22b0df@gmail.com> (Ben Keene's
        message of "Thu, 6 Feb 2020 09:00:17 -0500")
Message-ID: <xmqq8slffu7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26A3003E-490E-11EA-BD2F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Keene <seraphire@gmail.com> writes:

> On 2/5/2020 4:42 PM, Junio C Hamano wrote:
>> Ben Keene <seraphire@gmail.com> writes:
>>
>>>>> +        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
>>>> This assumes that the process when his function is called (by the
>>>> way, even though the title of the patch uses the word "method", this
>>>> is not a method but a function, no?), it is always at the top level
>>>> of the working tree.  Is that a good assumption?  I don't know the
>>>> code well, so "yes it is good because a very early thing we do is to
>>>> go up to the top" is a good answer.
>>> ...
> As best as I understand the mechanics, and I haven't examined the
> source code of git, this is just experimental,...

As I already said that I do not know the code well, it is useless
for you to also speculate.  One of us must read the code before
speaking further ;-)

I just scanned "def main()", and it seems that it always goes to the
top-level of the working tree by doing chdir(cdup), where cdup is
learned from "git rev-parse --show-cdup", i.e. "tell me how to chdir
up to the top-level of the working tree".

I am assuming that nobody runs "git p4" in a bare repository, so
under that assumption, I think it would be safe to say that we can
assume we are always at the top.  Also, GIT_DIR is exported from
there, so it probably is a good idea to make sure that the run-hook
helper just uses os.environ.get("GIT_DIR") and barfs if the environ
is not set (i.e. there is something funny going on) without
pretending that it is prepared to deal with such a case, which is
what the "[, default]" parameter to .get method is doing.

I.e.

	hooks_path = os.path.join(os.environ["GIT_DIR"], "hooks")
    
> Does this prompt the need to search the hierarchy if we don't find
> the directory?

No, we just saw that it is done early in "def main()".  It is done
by "rev-parse --git-dir" and "rev-parse --show-cdup".
