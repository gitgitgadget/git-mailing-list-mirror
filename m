From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Add struct pathspec
Date: Mon, 27 Sep 2010 15:19:45 -0700
Message-ID: <7vbp7ix20u.fsf@alter.siamese.dyndns.org>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
 <1284938514-16663-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 00:20:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0M3N-0006aW-25
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 00:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760144Ab0I0WTz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 18:19:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0I0WTy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 18:19:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15514DA374;
	Mon, 27 Sep 2010 18:19:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=kYKu/Jt4aZkTMQ7eE3wvui8NB
	Ic=; b=v5HtHJcf/ma3od+/tPwx4NaIUZUJdcxlxVP2ML6EvTwc9sWrzrRxbc7r7
	c0AHg5E3XK04jzMPBP59ZW60jsu7VurbygQsC2DMmLCneTS5g+/LyDj9L4ceNN9g
	+mV7f/iStsOw+lpd1fqPTZLHGQgdkz/6Ia51TjeCQ7LgLfvcZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=NpGTD99qImTrFdwMKWc
	MHvV0Pc/ksYpgOFV0cjZUeLVH+vn+3TWVPCXReoK4Y7zcofB3t8shGrw4fApsC/N
	BP9yjFNYoS1Iux2uvR4TUwT+SqbW5LCItJXM6Z8aZgXGpe4S7mo5f+bWGPHg8yk7
	xihQ24wYK2h/NgLEmxe7zAXs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6548DA371;
	Mon, 27 Sep 2010 18:19:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF44BDA36C; Mon, 27 Sep
 2010 18:19:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 587DCC4A-CA85-11DF-B929-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157371>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This struct for now is just a wrapper for the current pathspec form:
> const char **. It is intended to be extended with more useful
> pathspec-related information over time.
>
> The data structure for passing pathspec around remains const char **,
> struct pathspec will be initialized locally to be used and destroyed.
> Hopefully all pathspec related code will be gradually migrated to pas=
s
> this struct instead.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  cache.h |    7 +++++++
>  dir.c   |   18 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index eb77e1d..6227ddb 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -492,6 +492,13 @@ extern int index_name_is_oth
> ...
> +struct pathspec {
> +	const char **raw;
> +	int nr;
> +};
> +
> +extern int init_pathspec(struct pathspec *,const char **);

s/,/, /;

> +extern void free_pathspec(struct pathspec *);
>  extern int ce_path_match(const struct cache_entry *ce, const char **=
pathspec);
>  extern int index_fd(unsigned char *sha1, int fd, struct stat *st, in=
t write_object, enum object_type type, const char *path);
>  extern int index_path(unsigned char *sha1, const char *path, struct =
stat *st, int write_object);
> diff --git a/dir.c b/dir.c
> index 133f472..5815b64 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1071,3 +1071,21 @@ int remove_path(const char *name)
> ...
> +void free_pathspec(struct pathspec *pathspec)
> +{
> +	/* do nothing */
> +}

I'd prefer making this more explicit by saying

	{
        	; /* do nothing */
	}
