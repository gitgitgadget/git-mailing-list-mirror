From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] pathspec: cache string length when initialize
 pathspec
Date: Mon, 27 Sep 2010 15:19:51 -0700
Message-ID: <7v62xqx20o.fsf@alter.siamese.dyndns.org>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
 <1284938514-16663-4-git-send-email-pclouds@gmail.com>
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
	id 1P0M3N-0006aW-Ir
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 00:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760193Ab0I0WUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 18:20:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab0I0WT7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 18:19:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93771DA377;
	Mon, 27 Sep 2010 18:19:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=x6zzp8lI2atPFwpoVhGT98rm/
	Og=; b=hYO41nAJLGSeZdVagKsskGjHGh/2BJOQHyYRZjj62SuX3YpLWy57BfRrf
	OsRD1Bdg82yt2Dvvz+WmjxanoOVhfp6VwNXjcY9PSOqDd9oEPQ+zpw2X0icIt48A
	cgmylhki4PeUXQ7arKy5wLNBODvGOfd9zvygQWJIQLMIn+Drx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ONVEJda821p2tPCc6LN
	7Vaaw3g/AI1QKvmvNOHiyO7HkXFXOISmlGw/d8U7mbFhl1GG2IwXnzxHTpB/+pVf
	5JPZOB3RIQGPEiHSroS9G5na2BgAcW+vlI80dBN3BYXbGeaishy+MN0EySO6xFsl
	i+xaTnADBDq9S0YrZhzqIxB0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F4FADA375;
	Mon, 27 Sep 2010 18:19:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82825DA372; Mon, 27 Sep
 2010 18:19:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5BC67A46-CA85-11DF-884E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157372>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Subject: Re: [PATCH 3/6] pathspec: cache string length when initializ=
e pathspec

s/initialize/initializing/;

> This field will be used when tree_entry_interesting() is converted to
> use struct pathspec. Currently it uses pathlens[] in struct
> diff_options to avoid calculating string over and over again.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  cache.h |    3 +++
>  dir.c   |   11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 6227ddb..045c9fc 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -495,6 +495,9 @@ extern int ie_modified(const struct index_state *=
, struct cache_entry *, struct
>  struct pathspec {
>  	const char **raw;
>  	int nr;
> +	struct pathspec_item {
> +		int len;
> +	} *items;

Hmm... I would have expected to see

        struct pathspec_item {
                const char *pattern;
                int len;
        };
	struct pathspec {
        	struct pathspec_item *items;
		int nr;
	};

as you would be allocating a structure anyway, but persumably many plac=
es
take their input as a NULL terminated "char **" array, and keeping such=
 an
array around as the "raw" field may be easier in refactoring.
