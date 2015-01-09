From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cat-file: add short option '-c' for 'cat-file --textconv'
Date: Fri, 09 Jan 2015 14:48:10 -0800
Message-ID: <xmqqoaq7bmfp.fsf@gitster.dls.corp.google.com>
References: <1420793279-27853-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 23:48:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9iLp-0006j6-BP
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 23:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbbAIWsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 17:48:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752747AbbAIWsM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 17:48:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB9E62D6F3;
	Fri,  9 Jan 2015 17:48:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cCrfEozLDY96Bc1EjM7bhKYq7Ng=; b=X51GcY
	DVE4030fzMa0OYL3+OFXM/DcOWt8PhcckEuXTc/VH8Ey6+8WDSp5BWQGpSBoJ1Ti
	WGzdLjveqGfUvstlO77TUeWw4vV2IQeQf39GYV24rqJBY2U1WaPfI6lmhgebiTEw
	LbU2v5tJ0Ed+o7irDjHbh3uXTArkiLb4djmMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N1GjcwRjHP6V/1F/qaDGPecTX6vIQODR
	5o9IKetD/hG4Bdc0EcCvdZGRj1t953bwNMuWg2rgWsmofq7KGqLrpS9018Ssjhjr
	D6Fj66VUYTwbDy9TVZJX/4OlGNtgMQePNzcVWWdABpfvug7J0det2HxEC0QaTNlw
	4uIsm0iLKmk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D29362D6F2;
	Fri,  9 Jan 2015 17:48:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58AAE2D6F1;
	Fri,  9 Jan 2015 17:48:11 -0500 (EST)
In-Reply-To: <1420793279-27853-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Fri, 9 Jan 2015 14:47:59 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 968F7AEE-9851-11E4-8BE5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262248>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  Documentation/git-cat-file.txt |  5 +++--
>  builtin/cat-file.c             |  4 ++--
>  t/t8007-cat-file-textconv.sh   | 10 ++++++++++
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index f6a16f4..b346a5d 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -9,14 +9,14 @@ git-cat-file - Provide content or type and size information for repository objec
>  SYNOPSIS
>  --------
>  [verse]
> -'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <object>
> +'git cat-file' (-t | -s | -e | -p | <type> | (-c | --textconv) ) <object>

Do we use "-c" for a shorthand for "--textconv" anywhere else?

Is there any other command that has "--textconv" where "-c" does not
mean "--textconv"?  Or worse yet, where "-c" already means something
completely different from "--textconv"?

Unlike end-user facing Porcelain commands, plumbing commands are
primarily meant to be used in scripts, and I am not sure how much
benefit we are getting by introducing new short options to them.

Ancient plumbing commands do have many single-letter options but
they were added back when more modern set of end-user facing
Porcelain commands did not exist.
