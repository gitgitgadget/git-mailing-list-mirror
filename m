From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] Accept tags in HEAD or MERGE_HEAD
Date: Sun, 18 Sep 2011 14:51:31 -0700
Message-ID: <7vsjntbjto.fsf@alter.siamese.dyndns.org>
References: <1316260665-1728-1-git-send-email-pclouds@gmail.com>
 <1316260665-1728-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:51:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5PH0-0005Y6-G4
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675Ab1IRVve convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 17:51:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932255Ab1IRVvd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 17:51:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A99542D9;
	Sun, 18 Sep 2011 17:51:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=e5oOk43bd7O4ffoq472Z9Dy5L
	FY=; b=avpocClKeNslUP69kmkixscJvj7DDSB6eZESaFG0iqMygxDj4EmDP5C1a
	ZkYB1qb6HcrU4u8tCGlwdtBxhmUS0YNPll8HcQ5z9NRWaMrlHLJyJ1+XUc0T/UGV
	U27hjEer+OKR1in4NReTVz8GJiHdtjAhSwF/WMb5MYoXTZGi3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=vzYr1fOU6Lf73NmJ9y7
	TL/bQD5/khc61gIGHnqGOXcJawlWql71vxeRrfQ58k2j0f6sunNxT2G/gUwkuKMS
	UqsuXWNiz9DlNxTMSaQ13NDNOzgjKogB5wApAg0uLSl7xi+lcE0o9vy2NBv20fbr
	85yEo/rYS7nD3HAOFgbxapGA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 423F842D8;
	Sun, 18 Sep 2011 17:51:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA9C542D7; Sun, 18 Sep 2011
 17:51:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F74D15A-E240-11E0-81A3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181651>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> HEAD and MERGE_HEAD (among other branch tips) should never hold a
> tag. That can only be caused by broken tools and is cumbersome to fix
> by an end user with:
>
>   $ git update-ref HEAD $(git rev-parse HEAD^{commit})
>
> which may look like a magic to a new person.
> ...
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Nicely done.

Just a few micronits.

> diff --git a/commit.h b/commit.h
> ...
> +/*
> + * Look sha1 up for a commit, defer if needed. If dereference occurs=
,

That's s/defer/deref/;

> + * update "sha1" for consistency with retval->object.sha1. Also warn
> + * users this case because it is expected that sha1 points directly =
to
> + * a commit.
> + */
> +struct commit *lookup_commit_or_die(const unsigned char *sha1, const=
 char *ref_name);

This no longer updates sha1 now it is a pointer to a const arena.
I'll update this part as follows, and queue the result.

/*
 * Look up object named by "sha1", dereference tag as necessary,=20
 * get a commit and return it. If "sha1" does not dereference to
 * a commit, use ref_name to report an error and die.
 */

Thanks.
