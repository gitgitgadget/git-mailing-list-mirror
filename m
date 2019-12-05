Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1CFC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 13:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0A52464D
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 13:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S6HKY7EN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfLENiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:38:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60991 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfLENiI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 08:38:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C123319459;
        Thu,  5 Dec 2019 08:38:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=engR+FHraLw+2EEsSJ9RVcGNRZc=; b=S6HKY7
        ENslueSCQIGoJTI1voFJRsrm00RmBkcu11xyWChBx+oODtyrykWYSF+O9buCtPht
        umdvI1Lt2RFhS+AvuEC1l27RC5L9GmJt/saYF9cu0cq77lG3CrS0t87s7hZ3WHys
        dUKjTqbSrpWOciRJrxAZ9Jtk9Vlw2znwvz6gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XxaiHLs8uMnUyOWjoe0way5TqiXhrMjw
        8ljwzPW4MVs1nlDEx1AAUBBqX8zeisQOJpcMzVZhuVjwAKVYJw++4t9a0RKedN1q
        jwwpfGKNAsAShQrBsg3PTJyCIFGe+OXLisj+4bj+2L9p0f0qbrnWV5miDM7xPqqu
        ZAHOBAB+nH4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B782B19458;
        Thu,  5 Dec 2019 08:38:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D29119457;
        Thu,  5 Dec 2019 08:38:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v4 06/11] git-p4: Fix assumed path separators to be more Windows friendly
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <8f5752c12737fd861274609fdafac095ad95c519.1575498578.git.gitgitgadget@gmail.com>
Date:   Thu, 05 Dec 2019 05:38:03 -0800
In-Reply-To: <8f5752c12737fd861274609fdafac095ad95c519.1575498578.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Wed, 04 Dec 2019 22:29:32
        +0000")
Message-ID: <xmqqsgly28qs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76D4B39E-1764-11EA-8CAD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> When a computer is configured to use Git for windows and Python for windows, and not a Unix subsystem like cygwin or WSL, the directory separator changes and causes git-p4 to fail to properly determine paths.
>
> Fix 3 path separator errors:
>
> 1. getUserCacheFilename should not use string concatenation. Change this code to use os.path.join to build an OS tolerant path.
> 2. defaultDestiantion used the OS.path.split to split depot paths.  This is incorrect on windows. Change the code to split on a forward slash(/) instead since depot paths use this character regardless  of the operating system.
> 3. The call to isvalidGitDir() in the main code also used a literal forward slash. Change the cose to use os.path.join to correctly format the path for the operating system.

s/isvalid/isValid/;
s/cose/code/; 

Also please wrap your lines at around 72 columns (that will let
reviewers quote what you write (which adds "> " prefix and consumes
2 more columns), and would allow us a handful of exchanges (each
round adding ">" prefix to consume 1 more column) before bumping
into the right edge of the terminal at 80 columns.

> These three changes allow the suggested windows configuration to properly locate files while retaining the existing behavior on non-windows operating systems.
>
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> (cherry picked from commit a5b45c12c3861638a933b05a1ffee0c83978dcb2)

As Denton mentioned, general public do not care if you "cherry
picked" it from your earlier unpublished work.  Remove it.

Aside from these small nits, the proposed log message for this step
is quite cleanly done and easily readable.  All the decisions are
clearly written and agreeable.  Nicely done.

> ---
>  git-p4.py | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 2659531c2e..7ac8cb42ef 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1454,8 +1454,10 @@ def p4UserIsMe(self, p4User):
>              return True
>  
>      def getUserCacheFilename(self):
> +        """ Returns the filename of the username cache 
> +	    """

Inconsistent use of spaces and a tab I see on these two lines.
Intended?

>          home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
> -        return home + "/.gitp4-usercache.txt"
> +        return os.path.join(home, ".gitp4-usercache.txt")
>  
>      def getUserMapFromPerforceServer(self):
>          if self.userMapFromPerforceServer:
> @@ -3973,13 +3975,16 @@ def __init__(self):
>          self.cloneBare = False
>  
>      def defaultDestination(self, args):
> +        """ Returns the last path component as the default git 
> +            repository directory name
> +        """
>          ## TODO: use common prefix of args?
>          depotPath = args[0]
>          depotDir = re.sub("(@[^@]*)$", "", depotPath)
>          depotDir = re.sub("(#[^#]*)$", "", depotDir)
>          depotDir = re.sub(r"\.\.\.$", "", depotDir)
>          depotDir = re.sub(r"/$", "", depotDir)
> -        return os.path.split(depotDir)[1]
> +        return depotDir.split('/')[-1]
>  
>      def run(self, args):
>          if len(args) < 1:
> @@ -4252,8 +4257,8 @@ def main():
>                          chdir(cdup);
>  
>          if not isValidGitDir(cmd.gitdir):
> -            if isValidGitDir(cmd.gitdir + "/.git"):
> -                cmd.gitdir += "/.git"
> +            if isValidGitDir(os.path.join(cmd.gitdir, ".git")):
> +                cmd.gitdir = os.path.join(cmd.gitdir, ".git")
>              else:
>                  die("fatal: cannot locate git repository at %s" % cmd.gitdir)
