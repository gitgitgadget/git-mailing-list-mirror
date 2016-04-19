From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/2] git-p4: fix Git LFS pointer parsing
Date: Tue, 19 Apr 2016 13:30:11 -0700
Message-ID: <xmqqtwixz6i4.fsf@gitster.mtv.corp.google.com>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
	<1461096530-82448-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 19 22:30:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ascIB-0001k3-Gf
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 22:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003AbcDSUaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 16:30:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932106AbcDSUaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 16:30:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BFA612F4A;
	Tue, 19 Apr 2016 16:30:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZeYqYH4n+zektz8QXkPiXAeFN7A=; b=G3zHea
	rDrCZ0zLZEvyy1/br3og4Ns0dxKV9u3G/nDsvOi2jnuSC8AKR7h0gLv7kW0fsPaS
	eZNVo2p31BNpoE9HtIKVBaSObcoSXNJXQ3rRduem8H4HBFFZ0+f04k8HFo8iRckU
	j5bFbmBfltAYuogXyL3+7LFF4CJoBYwun6KPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nRGFao28laaVUJnRHDEnLQclj3I7cCZN
	R+eXIIjrFDRNq0CiivrQ1soA6N0hC5645AXbVnNYxT8J0q3UQF9zS/eAFjU5eRlQ
	8XfvkM7o1cpDeEoJtJ1kX3edlYPT8bJ6YqergDPaGllOATbevbtHC2o04qSjZn3O
	YhNtQnZk3nE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 74B5912F49;
	Tue, 19 Apr 2016 16:30:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2EFF12F48;
	Tue, 19 Apr 2016 16:30:12 -0400 (EDT)
In-Reply-To: <1461096530-82448-3-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Tue, 19 Apr 2016 22:08:50
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84BAD8BE-066D-11E6-BC8F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291922>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Git LFS 1.2.0 removed a line from the output of the 'git lfs pointer'
> command [1] which broke the parsing of this output. Adjust the parser
> to the new output and add minimum Git LFS version to the docs.

Hmph, adjust to operate with both, or drop the support for the old
one?



>
> [1] https://github.com/github/git-lfs/pull/1105
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/git-p4.txt | 3 ++-
>  git-p4.py                | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 88ba42b..b862cb9 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -522,7 +522,8 @@ git-p4.largeFileSystem::
>  	that large file systems do not support the 'git p4 submit' command.
>  	Only Git LFS is implemented right now (see https://git-lfs.github.com/
>  	for more information). Download and install the Git LFS command line
> -	extension to use this option and configure it like this:
> +	extension (minimum version 1.2.0) to use this option and configure it
> +	like this:
>  +
>  -------------
>  git config       git-p4.largeFileSystem GitLFS
> diff --git a/git-p4.py b/git-p4.py
> index 527d44b..d2be574 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1064,8 +1064,8 @@ class GitLFS(LargeFileSystem):
>          if pointerProcess.wait():
>              os.remove(contentFile)
>              die('git-lfs pointer command failed. Did you install the extension?')
> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
> -        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
> +        oidEntry = [i for i in pointerFile.split('\n') if i.startswith('oid')]
> +        oid = oidEntry[0].split(' ')[1].split(':')[1]
>          localLargeFile = os.path.join(
>              os.getcwd(),
>              '.git', 'lfs', 'objects', oid[:2], oid[2:4],
> @@ -1073,7 +1073,7 @@ class GitLFS(LargeFileSystem):
>          )
>          # LFS Spec states that pointer files should not have the executable bit set.
>          gitMode = '100644'
> -        return (gitMode, pointerContents, localLargeFile)
> +        return (gitMode, pointerFile, localLargeFile)
>
>      def pushFile(self, localLargeFile):
>          uploadProcess = subprocess.Popen(
> --
> 2.5.1
