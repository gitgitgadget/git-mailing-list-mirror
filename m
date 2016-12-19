Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A4B1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 21:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbcLSV3V (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 16:29:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53337 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752339AbcLSV3U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 16:29:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4DAB5A0C2;
        Mon, 19 Dec 2016 16:29:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+zyLBtteUkrVpgJaSu0hvSdh6eY=; b=vmQqYy
        ItfDK7A8RbGwpdRljUZGdLvLVGpkg6EOOUXKiz/3p9WgznxJ5uj7u1+016qGjTW4
        NOi0zIselVOaRXE4sR4Uu3aR4NFd9Fwx5WGra8OgHJ0hOobVqZ8OmjDvJQlcHEcV
        YHppQ1YR+8wyizEUdxxtm3j4iT2LLYbP/jS6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fxDIm6w5xD+O1s4rIfB0BhxUEbb5C+Ir
        2EqCcG7GQr0nOo/Nk1WdoY0sZrs1ngmXAIDJbSIFSlkeTrV6t+ua/ozQS+gMqWX6
        vfLL0HcAKgwmM37qnPEdNnsW1OXYCmRWhhnkG9e+cFsK+qliN7aCB5H4fCP72N4e
        P2rf+Xh1f4E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC9155A0C1;
        Mon, 19 Dec 2016 16:29:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 213415A0C0;
        Mon, 19 Dec 2016 16:29:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, luke@diamand.org
Subject: Re: [PATCH v1] git-p4: fix git-p4.pathEncoding for removed files
References: <20161218175153.92336-1-larsxschneider@gmail.com>
Date:   Mon, 19 Dec 2016 13:29:17 -0800
In-Reply-To: <20161218175153.92336-1-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Sun, 18 Dec 2016 18:51:53
        +0100")
Message-ID: <xmqq37hjobf6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32A262B0-C632-11E6-AE65-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> In a9e38359e3 we taught git-p4 a way to re-encode path names from what
> was used in Perforce to UTF-8. This path re-encoding worked properly for
> "added" paths. "Removed" paths were not re-encoded and therefore
> different from the "added" paths. Consequently, these files were not
> removed in a git-p4 cloned Git repository because the path names did not
> match.
>
> Fix this by moving the re-encoding to a place that affects "added" and
> "removed" paths. Add a test to demonstrate the issue.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

Thanks.

The above description makes me wonder what happens to "modified"
paths, but presumably they are handled in a separate codepath?  Or
does this also cover not just "removed" but also paths with any
change?

Luke, does this look good?

> Notes:
>     Base Commit: d1271bddd4 (v2.11.0)
>     Diff on Web: https://github.com/git/git/compare/d1271bddd4...larsxschneider:05a82caa69
>     Checkout:    git fetch https://github.com/larsxschneider/git git-p4/fix-path-encoding-v1 && git checkout 05a82caa69
>
>  git-p4.py                       | 19 +++++++++----------
>  t/t9822-git-p4-path-encoding.sh | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index fd5ca52462..8f311cb4e8 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2366,6 +2366,15 @@ class P4Sync(Command, P4UserMap):
>                      break
>  
>          path = wildcard_decode(path)
> +        try:
> +            path.decode('ascii')
> +        except:
> +            encoding = 'utf8'
> +            if gitConfig('git-p4.pathEncoding'):
> +                encoding = gitConfig('git-p4.pathEncoding')
> +            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
> +            if self.verbose:
> +                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path)
>          return path
>  
>      def splitFilesIntoBranches(self, commit):
> @@ -2495,16 +2504,6 @@ class P4Sync(Command, P4UserMap):
>              text = regexp.sub(r'$\1$', text)
>              contents = [ text ]
>  
> -        try:
> -            relPath.decode('ascii')
> -        except:
> -            encoding = 'utf8'
> -            if gitConfig('git-p4.pathEncoding'):
> -                encoding = gitConfig('git-p4.pathEncoding')
> -            relPath = relPath.decode(encoding, 'replace').encode('utf8', 'replace')
> -            if self.verbose:
> -                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, relPath)
> -
>          if self.largeFileSystem:
>              (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
>  
> diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
> index 7b83e696a9..c78477c19b 100755
> --- a/t/t9822-git-p4-path-encoding.sh
> +++ b/t/t9822-git-p4-path-encoding.sh
> @@ -51,6 +51,22 @@ test_expect_success 'Clone repo containing iso8859-1 encoded paths with git-p4.p
>  	)
>  '
>  
> +test_expect_success 'Delete iso8859-1 encoded paths and clone' '
> +	(
> +		cd "$cli" &&
> +		ISO8859="$(printf "$ISO8859_ESCAPED")" &&
> +		p4 delete "$ISO8859" &&
> +		p4 submit -d "remove file"
> +	) &&
> +	git p4 clone --destination="$git" //depot@all &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git -c core.quotepath=false ls-files >actual &&
> +		test_must_be_empty actual
> +	)
> +'
> +
>  test_expect_success 'kill p4d' '
>  	kill_p4d
>  '
