From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 43/44] builtin-am: check for valid committer ident
Date: Mon, 29 Jun 2015 13:02:33 -0700
Message-ID: <CAGZ79kaUYS1kiiFTwTTA=Wh924JcHMLOU61mSuMZxiqZFO7PPw@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-44-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:02:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fGI-00042f-Jt
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbbF2UCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:02:35 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33307 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbbF2UCd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:02:33 -0400
Received: by ykdt186 with SMTP id t186so124847997ykd.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h3wqZ7CV+E6RvvScG9eGMqn1MP+tXyWuaE63jzZbSRQ=;
        b=hNWUoH6va+69sFXL8o2gWXBTsjTiqjhFKci9VviIblqSKoHNbF00a2Fn8+SV5yjhLV
         XajUMCWXmciY9S2J0sc+WJPNol344VS47aLAOkaIyqgwsWI/OlCt81mYY8quAZiDlmcm
         uRlB8pRsXhjt9hmQQVJkNVDFFVmtfSPPSDO3bbI7PXfr4qNwnDZcV6s3T4EzBfw+Py48
         3G5FZHf63em2wglYSLFWhfdh5FAOjJwlUpAbBE9hejZeOy7XDgpxrNUcXWBH4wiyQ1+V
         1j42jul07i04d8ouEAULLNAGWRiLT5g6wsTVVrja4pTIUhsYR1EGOCoe2voLrm7POpBQ
         TDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=h3wqZ7CV+E6RvvScG9eGMqn1MP+tXyWuaE63jzZbSRQ=;
        b=EdpCsVfFY/2QNRsKH4lhOwgHJjp6kG7tKwiL3N4idCgobfdkogPCBqhfdp9LVpw5xE
         tOIBN5xzrKDrcbcqvpBwNUvagigml09ub86k+8XbQAfU1KDLCldUhW9btInHSb25u1Ib
         eIYYiwqTIBNq9pUlYWGhEZRSJv2qOd7OZ6PydlMJoZJS5i0q+6I213cR32M+fl84o5+F
         VkMnethPah37WUEtSqB7lJMBdCcQaH+ROY5P66P4fpOzCErkTCCdWQplg1d6fJrxDIgt
         Fk2F1lhOnWu4GKlaeBu7TsZWfLnearhbMXFR/ZMjQ/j9EUtl6ypi2YVYKBr8ocitYoHE
         QJFQ==
X-Gm-Message-State: ALoCoQkbmdf9/yYjIaTN0zPm+JykTtxWFM340Nsl/oKYnTe1J/QiJTIRk+uYTLqpCV0u/xqNFcQl
X-Received: by 10.129.101.135 with SMTP id z129mr19295168ywb.81.1435608153196;
 Mon, 29 Jun 2015 13:02:33 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Mon, 29 Jun 2015 13:02:33 -0700 (PDT)
In-Reply-To: <1435500366-31700-44-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272999>

On Sun, Jun 28, 2015 at 7:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
> When commit_tree() is called, if the user does not have an explicit
> committer ident configured, it will attempt to construct a default
> committer ident based on the user's and system's info (e.g. gecos field,
> hostname etc.) However, if a default committer ident is unable to be
> constructed, commit_tree() will die(). However, at this point of git-am,

s/. However,/, but/ ?

> there will already be changes made to the index and work tree.
>
> This can be confusing to new users, and as such since d64e6b0 (Keep
> Porcelainish from failing by broken ident after making changes.,
> 2006-02-18) git-am.sh will check to see if the committer ident has been
> configured, or a default one can be constructed, before even starting to
> apply patches.
>
> Re-implement this in builtin/am.c.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/am.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index a46aa74..1cb02c8 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2268,6 +2268,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>                 fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
>                                 "it will be removed. Please do not use it anymore."));
>
> +       /* Ensure a valid committer ident can be constructed */
> +       git_committer_info(IDENT_STRICT);
> +
>         if (read_index_preload(&the_index, NULL) < 0)
>                 die(_("failed to read the index"));
>
> --
> 2.5.0.rc0.76.gb2c6e93
>
