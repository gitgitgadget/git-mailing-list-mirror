Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201F4C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B472087E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BObduzCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBDUkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:40:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53418 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgBDUkd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:40:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52B0F528CF;
        Tue,  4 Feb 2020 15:40:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LnAMmclE4MNHNgAWms9DNIkvAno=; b=BObduz
        CBAwjOPnrusSMqhptp4FpF1k7Pj7UnM+4S1eDbU39KRJ6LO47I6orVthNVtoYQT1
        9eBjuKx9Y6UMI+fA1DfRGMKC5ImisVxoiH7mF2epP9aFdkMcrrCbDc62BKazuD6/
        tqvqWNxKU2RUmqCyZLVzGgpRVJee8woBVPd0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mtHTlMKfxTu/frde/7HGaZprd8Szcb4B
        5VM3RiNa4bSnKO28KZ9FeKACDYfOY1+pW+By7kh64d8e7NfcPyAbRl+urIfYKWTJ
        MB/CEaTcJzuw9AlrJSaYQfZHhGxRKEIVtwmXGYZ6at83UiUPElTCHeCi4hvpFqQv
        TQYXTyxjvTI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 476C8528CD;
        Tue,  4 Feb 2020 15:40:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98ED2528C8;
        Tue,  4 Feb 2020 15:40:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v2 2/4] git-p4: create new method gitRunHook
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
        <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <f1f9fdc542353196612f8dd6b996d4fbd1f76c73.1580507895.git.gitgitgadget@gmail.com>
Date:   Tue, 04 Feb 2020 12:40:28 -0800
In-Reply-To: <f1f9fdc542353196612f8dd6b996d4fbd1f76c73.1580507895.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Fri, 31 Jan 2020 21:58:13
        +0000")
Message-ID: <xmqqr1za6q83.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94D9B1AA-478E-11EA-9385-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/git-p4.py b/git-p4.py
> index 7d8a5ee788..4e481b3b55 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -4125,6 +4125,35 @@ def printUsage(commands):
>      "unshelve" : P4Unshelve,
>  }
>  
> +def gitRunHook(cmd, param=[]):
> +    """Execute a hook if the hook exists."""
> +    if verbose:
> +        sys.stderr.write("Looking for hook: %s\n" % cmd)
> +        sys.stderr.flush()
> +
> +    hooks_path = gitConfig("core.hooksPath")
> +    if len(hooks_path) <= 0:
> +        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")

This assumes that the process when his function is called (by the
way, even though the title of the patch uses the word "method", this
is not a method but a function, no?), it is always at the top level
of the working tree.  Is that a good assumption?  I don't know the
code well, so "yes it is good because a very early thing we do is to
go up to the top" is a good answer.

> +    hook_file = os.path.join(hooks_path, cmd)
> +    if isinstance(param,basestring):
> +        param=[param]
> +
> +    if platform.system() == 'Windows':
> +        exepath = os.environ.get("EXEPATH")
> +        if exepath is None:
> +            exepath = ""
> +        shexe = os.path.join(exepath, "bin", "sh.exe")
> +        if os.path.isfile(shexe) \
> +            and os.path.isfile(hook_file) \
> +            and os.access(hook_file, os.X_OK) \
> +            and subprocess.call([shexe, hook_file] + param) != 0:
> +            return False
> +
> +    else:
> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file] + param) != 0:
> +            return False

Doesn't this mean that on Windows, a hook MUST be written as a shell
script, but on other platforms, a hook can be any executable?

I am not sure if it is necessary to penalize Windows users this way.
How do other parts of the system run hooks on Windows?  E.g. can
"pre-commit" hook be an executable Python script on Windows?

Even if it is needed to have different implementations (and possibly
reduced capabilities) for "we found this file is a hook, now run it
with these parameters" on different platform, the above looks a bit
inverted.  If the code in this function were

    if os.path.isfile(hook_file) and
       os.access(hook_file, os.X_OK) and
       run_hook_command(hook_file, param) != 0:
	return False
    else:
	return True

and a thin helper function whose only task is "now run it with these
parameters" is separately written, e.g.

    def run_hook_command(hook_file, params):
	if Windows:
		... do things in Windows specific way ...
	else:
		return subprocess.call([hook_file] + param)

That would have been 100% better, as it would have made it clear
that logically gitRunHook() does exactly the same thing on all
platforms (i.e. find where the hook is, normalize param, check if
the hook file is actually enabled, and finally execute the hook with
the param), while the details of how the "execute" part (and only
that part) works may be different.

> +    return True
>  
>  def main():
>      if len(sys.argv[1:]) == 0:
