From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cat-file: Move assignment to the buffer declaration
Date: Thu, 08 Jan 2015 11:31:46 -0800
Message-ID: <xmqq61chf4rh.fsf@gitster.dls.corp.google.com>
References: <1420741203-21107-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 20:32:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9IoQ-00035z-Pr
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 20:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173AbbAHTcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 14:32:01 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751687AbbAHTcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 14:32:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC2152E541;
	Thu,  8 Jan 2015 14:31:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G99ToQia9PLf4+O0T68FrXDNAXo=; b=Yj1jpU
	roLOaH3WQiH1Y+EZpRyT8rSzPL04m1wR8Wrtt5+L+rMxgil5zj0EaGjEe+2yOAJb
	/qOVKm+hRoEjhySqnb/inmHr8voHAtjaydE+kWDGgTOWtS/QouCSzfdhqPNUduI5
	szZdmfa9kna+n0tmn35lbMZG1gC2rvgO3HSbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YZeGu0IGBzjiC5jjUyVplKFTQb8gthod
	Ff9z7pfIT7Agq2GwNC67V7nHNRJ9d9wwcFVRCkiUWPvB3rHQntXill+hVysZjrRm
	Ccncx4gJzhSTDGw1HHNBjKeGt1kcWqK3okZ5KvnW+82oqzxg2ZF13Y286NNVZ9K7
	Pa7KcGVSDIA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D20622E540;
	Thu,  8 Jan 2015 14:31:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2B2D2E537;
	Thu,  8 Jan 2015 14:31:49 -0500 (EST)
In-Reply-To: <1420741203-21107-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Fri, 9 Jan 2015 00:20:03 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDC98BD6-976C-11E4-8D6B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262211>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Subject: Re: [PATCH] cat-file: Move assignment to the buffer declaration

"git shortlog" on recent history shows that it is conventional not
to upcase the sentence after the "<area>:" on titles.

This line not just "declares" but "defines" buf, so I'd phrase it
more like:

	cat-file: initialize buf to NULL at its definition

	This way is shorter than with a separate assignment.

or somesuch.

If two people posted two patches to add a new cat-file.c file and
one patch did it the way the current code does while the other patch
did it the way the code with this patch does, I would likely to pick
the latter, because it is more concise and it is more clear that
there is less chance that buf could be used uninitialized.

To be bluntly honest, however, it's such a minor thing that once it
_is_ in the tree, it's not really worth the patch noise to go and
fix it up.

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  builtin/cat-file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index f8d8129..840ace2 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -17,14 +17,13 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  {
>  	unsigned char sha1[20];
>  	enum object_type type;
> -	char *buf;
> +	char *buf = NULL;
>  	unsigned long size;
>  	struct object_context obj_context;
>  
>  	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
>  		die("Not a valid object name %s", obj_name);
>  
> -	buf = NULL;



>  	switch (opt) {
>  	case 't':
>  		type = sha1_object_info(sha1, NULL);
