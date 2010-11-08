From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1020-subdirectory: test alias expansion in a
 subdirectory
Date: Mon, 08 Nov 2010 12:25:39 -0800
Message-ID: <7v7hgnpnp8.fsf@alter.siamese.dyndns.org>
References: <627dc7921dc64a16063e77d542cf9edb22631ddd.1289205059.git.git@drmicha.warpmail.net> <20101108102056.GA12366@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 21:26:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFYI0-0001IL-Up
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 21:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab0KHUZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 15:25:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658Ab0KHUZv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 15:25:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FAA73E32;
	Mon,  8 Nov 2010 15:25:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x+liEETw7HHc/+hSxF5fwIffT+c=; b=nyDisZ
	XfB5OkgHuEkEeKdeMngwWr2qdeyyGSfRn5NFg+4M74P0vw1lLrYhmlBkzaBynoWt
	6PrMieseHDZSLMxe4FNiIjB90CKzj6nnP3bdAjhOE+ev6J/4VWCFICfqWLQgS7H1
	Q5apdywCAMPiFaAp9ScQ57lf71xlOsttWKEGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=At/a123KQtzn9wV1UWzNv+QOC5dMNiEp
	3wfYm0fC9FKEAbD9r1NPBZYE/33jzQJSfOBK248RUZ3LwCsxHfgx429s/O0pxJrH
	pEnHrPBVeS9W8wg9vSf4xcIQQzPfzn48vL+gnY41O3q+1tdf2XwA0jBneg1F/8AH
	UAudLenEh7U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 004BA3E31;
	Mon,  8 Nov 2010 15:25:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BC2443E2E; Mon,  8 Nov 2010
 15:25:43 -0500 (EST)
In-Reply-To: <20101108102056.GA12366@do> (Nguyen Thai Ngoc Duy's message of
 "Mon\, 8 Nov 2010 17\:20\:56 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F296B1E-EB76-11DF-874E-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160985>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Nov 08, 2010 at 09:32:03AM +0100, Michael J Gruber wrote:
>> Add a test for alias expansion in a subdirectory of the worktree.
>> 
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> 
>> ---
>>     65f3a9e (Remove all logic from get_git_work_tree(), 2010-11-01) breaks this test,
>>     which is why I am adding it.
>
> How about squashing this in?
>
> --8<--
> Subject: Allow set_git_work_tree() to be called more than once
>
> Usually one of the setup functions is called once. However alias
> handling code needs to look ahead in $GIT_DIR/config for aliases. So
> set_git_work_tree() may be called twice: once when alias is searched,
> once when the actual command is run.
>
> Loosen the condition and let it through. We can stricten it back when
> alias handling is fixed.

Sounds like sweeping something under rug.  

Without this hack, alias does not work, but if your plan is to rework this
part right when alias is fixed, then what's the point of loosening it?
Either way your alias is broken, no?

Shouldn't it at least make sure that the function is giving a consistent
picture to the outside world between the time it was called for the first
time and the second time?  E.g.  the second time around new-work-tree must
be the same as whatever was given the first time, or something.

> ---
> diff --git a/environment.c b/environment.c
> index 6db00da..f0d0b07 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -128,8 +128,6 @@ const char *get_git_dir(void)
>  	return git_dir;
>  }
>  
> -static int git_work_tree_initialized;
> -
>  /*
>   * Note.  This works only before you used a work tree.  This was added
>   * primarily to support git-clone to work in a new repository it just
> @@ -137,9 +135,7 @@ static int git_work_tree_initialized;
>   */
>  void set_git_work_tree(const char *new_work_tree)
>  {
> -	if (git_work_tree_initialized)
> -		die("internal error: work tree has already been set");
> -	git_work_tree_initialized = 1;
> +	free(work_tree);
>  	work_tree = xstrdup(make_absolute_path(new_work_tree));
>  }
>  
> --8<--
> -- 
> Duy
