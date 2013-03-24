From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Sat, 23 Mar 2013 22:19:36 -0700
Message-ID: <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Mar 24 06:20:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJdLj-0003CU-H7
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 06:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab3CXFTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 01:19:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970Ab3CXFTi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 01:19:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 177088B84;
	Sun, 24 Mar 2013 01:19:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pradREFMbF5ceTFcsRamsExWIBE=; b=kcLuui
	hAhoIW1CikhJ6NXQ8fpfH2qRoSH9ciS5sd3jCSHeDSTlZyh4VQ4on/oZF3O2SnsP
	ETwcgczsqfn+0d1yEYAzt4RnezkvWtEHfhFD1fl3e7mZTksJWEVZ1xS3nVqITFTK
	XApR/yzpTfHj5q8dYk1eeXlJAVlqdQJ7PKdqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TMbPqNytD+skEAzyZiBWgUmjwI7R7XMv
	AKkKOjT69ZSLxumS9SfiSWJutKyFX+6K3NVySWJf4zDkfv4DsiI9rh0auPnno4Hj
	v6+cUA9tdYvJ3FzTJYbW1BQJA43tbpIPapwDdsiptLVf4cjmEMlxEaAw5C0daHEO
	T379+wMXxoE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BE158B83;
	Sun, 24 Mar 2013 01:19:38 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D9C08B82; Sun, 24 Mar 2013
 01:19:37 -0400 (EDT)
In-Reply-To: <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
 (John Keeping's message of "Sat, 23 Mar 2013 13:31:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BF61C12-9442-11E2-80A7-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218935>

John Keeping <john@keeping.me.uk> writes:

> When 'git difftool --dir-diff' is using --no-symlinks (either explicitly
> or implicitly because it's running on Windows), any working tree files
> that have been copied to the temporary directory are copied back after
> the difftool completes.
>
> Because an earlier test uses "git add .", the "output" file used by
> tests is tracked by Git and the following sequence occurs during some
> tests:
>
> 1) the shell opens "output" to redirect the difftool output
> 2) difftool copies the empty "output" to the temporary directory
> 3) difftool runs "ls" which writes to "output"
> 4) difftool copies the empty "output" file back over the output of the
>    command
> 5) the output files doesn't contain the expected output, causing the
>    test to fail
>
> Instead of adding all changes, explicitly add only the files that the
> test is using, allowing later tests to write their result files into the
> working tree.

Good.

> In the longer term, difftool probably needs to learn to warn the user
> instead of overwrite any changes that have been made to the working tree
> file.

Questionable.

Admittedly I do not use difftool myself, and I have long assumed
that difftool users are using the tools to _view_ the changes, but
apparently some of the tools let the user muck with what is shown,
and also apparently people seem to like the fact that they can make
changes.  So I've led to believe the "update in difftool, take the
change back to working tree, either by making symbolic links or
copying them back" behaviour was a _feature_.

It is possible that this is not universally considerd as a feature,
but if that is the case, I think the right way to do this is to tell
the tools _not_ to let the user to modify contents they show in the
first place, not letting the user modify and then warning after the
fact.

> Signed-off-by: John Keeping <john@keeping.me.uk>
>
> ---
> Changes since v1:
> - Fix the actual cause of the issue in the test instead of masking it by
>   moving the output file under .git/
>
>  t/t7800-difftool.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index e694972..a0b8042 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -314,7 +314,7 @@ test_expect_success PERL 'setup change in subdirectory' '
>  	git commit -m "added sub/sub" &&
>  	echo test >>file &&
>  	echo test >>sub/sub &&
> -	git add . &&
> +	git add file sub/sub &&
>  	git commit -m "modified both"
>  '
