From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-remote: replace unnecessary sed invocation
Date: Wed, 30 Mar 2011 19:31:48 -0700
Message-ID: <7vlizwkokr.fsf@alter.siamese.dyndns.org>
References: <1301474920-6718-1-git-send-email-bebarino@gmail.com>
 <AANLkTikBD4T3hdyT2h=2dzw-QO1BnBp3eT=WGj5s5dC3@mail.gmail.com>
 <AANLkTin3R8ApTZ97Cw67dN7_s_ycX8sQThypMq2N6eJi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 04:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q57gB-0002Ct-6I
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 04:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739Ab1CaCcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 22:32:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729Ab1CaCcE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 22:32:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D5DF49E6;
	Wed, 30 Mar 2011 22:33:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T0wC0O+9RDLATUA6aTmk0GCK8gs=; b=biFnIo
	8dUxHOwQnBut3oeA3osLbuZe33ZxZv6zzsTUrhwFU6fi5z43IvBfR7LjpErsk4Vr
	FktP1AYiwkHydNCKhua9sasjg5RNwyjXK6sjS24AZnsH4B0CctVEgfO7kM3UIzWk
	y140WR62a5ADw0+zG9hRWp0SY2WQEQ0CS/Uy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lOo1a+iCXZk80LjBK/HwwTy1vqtp5g9v
	T9dm7Cx4biIj8bV9FLtXAeYk7w0OCLXfAwjx5d7a9SBU5Z2xJE5gyZrD+v0bWcqp
	yAXuFO3i0WznKdG07RvibRZrMmZD2QQAwzhMGhjn+MPxe4flbr0TEt6G9Fc6UhK2
	UrrwFdPrJmc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F04CB49DD;
	Wed, 30 Mar 2011 22:33:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 94EFE49D4; Wed, 30 Mar 2011
 22:33:39 -0400 (EDT)
In-Reply-To: <AANLkTin3R8ApTZ97Cw67dN7_s_ycX8sQThypMq2N6eJi@mail.gmail.com>
 (Stephen Boyd's message of "Wed, 30 Mar 2011 18:02:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CB3B7BC-5B3F-11E0-B4CE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170451>

Stephen Boyd <bebarino@gmail.com> writes:

> On Wed, Mar 30, 2011 at 11:31 AM, Michael Schubert <mschub@elegosoft.com> wrote:
>>> +       curr_branch=$(git symbolic-ref -q HEAD)
>>> +       curr_branch="${cur_branch#refs/heads/}"
>>                                           ^^^
>
> Ah! How did this pass the test suite... Anyway, looks like Junio
> applied this patch to maint already :-( Sorry.

Heh, I was wondering what those three carets under ads in "#refs/heads/"
was pointing at, and didn't see you had only one R in the variable name.

Thanks for a correction, and Michael, please be a bit more specific (and
point the correct part with your carret) when you send your messages.

> Junio, please apply this (probably word wrapped since this is gmail
> interface) and drop your trust level of me by a few points.
>
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 9168879..ea093d2 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -6,7 +6,7 @@ GIT_DIR=$(git rev-parse -q --git-dir) || :;
>
>  get_default_remote () {
>         curr_branch=$(git symbolic-ref -q HEAD)
> -       curr_branch="${cur_branch#refs/heads/}"
> +       curr_branch="${curr_branch#refs/heads/}"
>         origin=$(git config --get "branch.$curr_branch.remote")
>         echo ${origin:-origin}
>  }
