From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9r2 1/2] add `config_set` API for caching config-like files
Date: Thu, 17 Jul 2014 10:12:26 -0700
Message-ID: <xmqq1ttjrjt1.fsf@gitster.dls.corp.google.com>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>
	<1405434571-25459-3-git-send-email-tanayabh@gmail.com>
	<xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>
	<53C665A0.2060705@gmail.com> <vpqvbqxjzfx.fsf@anie.imag.fr>
	<53C66E70.3050507@gmail.com> <vpqha2h9tjw.fsf@anie.imag.fr>
	<53C6ABEB.3060205@gmail.com> <vpqzjg9z115.fsf@anie.imag.fr>
	<53C6C2BD.3030703@gmail.com> <vpqvbqwpalt.fsf@anie.imag.fr>
	<vpqy4vsme4w.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 17 19:12:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7pEX-0008KE-Ll
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 19:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426AbaGQRMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 13:12:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61379 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757292AbaGQRMf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 13:12:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA355295B0;
	Thu, 17 Jul 2014 13:12:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FflhUgjo7QUzV9as4G5Ix9o24vk=; b=WTv5fV
	q/ZwNKgmTGnbUm/s4BFkhI0zVRyiGD9sV7Dgr6ybscMzn2xZyAGfmsfmLODTLNJq
	NGIYHqHML36u00pdMGOOCpa5D4cxb6YJ3OcGCI8AqzZnyJqcdvB0CD1CP3a66MtA
	hW8zhlmKH5Zd6/lIx8TlRJ0XfT3Hnm7R1QvPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SK0gHG1lVwLJeKY0aZ5l5CllzPaQ12T7
	6VMEc3zhYPm2KZj7svJ7DoM3Vm/nK41WUnisagEZ1CqEo3U+Ns3pJqlHgwrOhYut
	D/qOGZz5NFgDdhPOUlvNcV4PP3d9p0BnjP8/EaI2/6BNdMpT4Lfz9ElBkbYJ+In5
	MiMWhdQYtMw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD344295AF;
	Thu, 17 Jul 2014 13:12:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 18B0F295A8;
	Thu, 17 Jul 2014 13:12:28 -0400 (EDT)
In-Reply-To: <vpqy4vsme4w.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	17 Jul 2014 13:13:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 878A52E6-0DD5-11E4-A5C1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253761>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>
>>> I have a question about renaming git_config() to git_config_raw().
>>> I was working on a patch and I am getting stuck here.
>>> It fails in t1001, t1020 & t4018. The reason for the last test failure
>>> is unknown right now. For the first two, it boils down to this,
>>>
>>> 		git init --bare bare-ancestor-aliased.git &&
>>> 		cd bare-ancestor-aliased.git &&
>>> 		echo "[alias] aliasedinit = init" >>config &&
>>> 		mkdir plain-nested &&
>>> 		cd plain-nested &&
>>> 		git aliasedinit
>>
>> Git tries to read .git/config relative to the current directory, and
>> tries to resolve aliases from it. The problem is: if one tries to do
>> this from a subdirectory inside the repo, .git/config is not the right
>> path, and the alias lookup fails.
>>
>> I'll investigate more later.
>
> This fixes the first two tests (it should be squashed into your PATCH 1
> regardless of the rename git_config -> git_config_raw):
>
> commit 42315d10e21a1273b73671a3f8c9f7640c4feb44 (HEAD, config-v9)
> Author: Matthieu Moy <Matthieu.Moy@imag.fr>
> Date:   Thu Jul 17 13:12:21 2014 +0200
>
>     clear the config cache in setup_git_dir
>
> diff --git a/setup.c b/setup.c
> index 0a22f8b..c0d31f5 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -625,6 +625,15 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
>         int one_filesystem = 1;
>  
>         /*
> +        * We may have read an incomplete configuration before
> +        * setting-up the git directory. If so, clear the cache so
> +        * that the next queries to the configuration reload complete
> +        * configuration (including the per-repo config file that we
> +        * ignored previously).
> +        */
> +       git_config_clear();

Very sensible.


> +       /*
>          * Let's assume that we are in a git repository.
>          * If it turns out later that we are somewhere else, the value will be
>          * updated accordingly.
