From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] t6006 (rev-list-format): don't hardcode SHA-1 in
 expected outputs
Date: Thu, 24 Jan 2013 12:29:15 -0800
Message-ID: <7v38xqba04.fsf@alter.siamese.dyndns.org>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
 <cee3610fde1626c2854eb5b821529ab22a06e4bf.1359018188.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 21:29:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyTQn-0003xW-2d
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 21:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555Ab3AXU3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 15:29:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791Ab3AXU3T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 15:29:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 406ECB0C6;
	Thu, 24 Jan 2013 15:29:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XwsyS35FRD6/
	IUOsfuAifhqdn2g=; b=YK52mtUHmqlAgZLOyP5VCpttsR4ykBc+ffvKbMLgauk0
	oF0IV6xUsWgJsn2g69RU/bp4AMDIiOoJfI4xg5BvVPUkgQL387IBJCezJUTq1tih
	vD6ps5P1wMa4LuMvvISGs9dh9vKLi3nn9/XI2nLtAuJEt7nSXbdIRtL6mP9NxFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hQRX0+
	gpE/igDecE+JAHyuGGOOVBNSRoPtm+5xXPFxKnP177TyoMmR19zLruYb1hgCKIJ1
	1kVz0yFPRfUqpSnhi0y2sehG9wNlAFTHQdMGAz/v5gVyFvqy+7L2V7E2arM9Tb+E
	eqo7qi9uuk/bBSwTs7UOBtFf39UElyJVsh+Vc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30A53B0C5;
	Thu, 24 Jan 2013 15:29:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CEA2B0C3; Thu, 24 Jan 2013
 15:29:17 -0500 (EST)
In-Reply-To: <cee3610fde1626c2854eb5b821529ab22a06e4bf.1359018188.git.Alex.Crezoff@gmail.com> (Alexey Shumkin's message of "Thu, 24 Jan 2013 13:10:25 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9CD791E-6664-11E2-A31B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214452>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> The expected SHA-1 digests are always available in variables.  Use
> them instead of hardcoding.
>
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> ---
>  t/t6006-rev-list-format.sh | 130 +++++++++++++++++++++++++----------=
----------
>  1 file changed, 72 insertions(+), 58 deletions(-)
>
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index f94f0c4..c248509 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -6,8 +6,19 @@ test_description=3D'git rev-list --pretty=3Dformat t=
est'
> =20
>  test_tick
>  test_expect_success 'setup' '
> -touch foo && git add foo && git commit -m "added foo" &&
> -  echo changed >foo && git commit -a -m "changed foo"
> +	touch foo &&

This is inherited from the original, but these days we try to avoid
touch, unless it is about setting a new file timestamp.  The
canonical (in the script we write) way to create an empty file is:

    : >foo

with or without ": ", it does not matter that much.

> +	git add foo &&
> +	git commit -m "added foo" &&
> +	head1=3D$(git rev-parse --verify HEAD) &&
> +	head1_7=3D$(echo $head1 | cut -c1-7) &&

Why do we want "whatever_7" variables and use "cut -c1-7" to produce
them?  Is "7" something we care deeply about?

I think what we care a lot more than "7" that happens to be the
current default value is to make sure that, if we ever update the
default abbreviation length to a larger value, the abbreviation
shown with --format=3D%h is consistent with the abbreviation that is
given by rev-parse --short.

    head1_short=3D$(git rev-parse --short $head1)

perhaps?

> +	echo changed >foo &&
> +	git commit -a -m "changed foo" &&
> +	head2=3D$(git rev-parse --verify HEAD) &&
> +	head2_7=3D$(echo $head2 | cut -c1-7) &&
> +	head2_parent=3D$(git cat-file -p HEAD | grep parent | cut -f 2 -d" =
") &&

Do not use "cat-file -p" that is for human consumption in scripts,
unless you are testing how the format for human consumption should
look like (we may later add more pretty-print to them), which is not
the case here.

Also be careful and pay attention to the end of the header; you do
not want to pick up a random "parent" string in the middle of a log
message.

    head2_parent=3D$(git cat-file commit HEAD | sed -n -e "s/^parent //=
p" -e "/^$/q")

would be much better.

> +	head2_parent_7=3D$(echo $head2_parent | cut -c1-7) &&
> +	tree2=3D$(git cat-file -p HEAD | grep tree | cut -f 2 -d" ") &&

Likewise.

> +	tree2_7=3D$(echo $tree2 | cut -c1-7)

Likewise.

> @@ -131,39 +142,42 @@ This commit message is much longer than the oth=
ers,
>  and it will be encoded in iso8859-1. We should therefore
>  include an iso8859 character: =C2=A1bueno!
>  EOF
> +
>  test_expect_success 'setup complex body' '
> -git config i18n.commitencoding iso8859-1 &&
> -  echo change2 >foo && git commit -a -F commit-msg
> +	git config i18n.commitencoding iso8859-1 &&
> +	echo change2 >foo && git commit -a -F commit-msg &&
> +	head3=3D$(git rev-parse --verify HEAD) &&
> +	head3_7=3D$(echo $head3 | cut -c1-7)
>  '

Likewise.

Thanks.
