From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/25] fetch-pack: use a separate flag for fetch in deepening mode
Date: Thu, 04 Feb 2016 16:03:25 -0800
Message-ID: <xmqqh9hodnw2.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:03:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTs5-0001bM-0R
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 01:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758268AbcBEAD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 19:03:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755869AbcBEAD2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 19:03:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A33EE428EC;
	Thu,  4 Feb 2016 19:03:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OFhNJsdVAuOI
	OSSmBAiiDeqmmOM=; b=TDKAgXbvX/csz2agXTKc2Qyv9vB+yepk7KLRCnTfFzKV
	oFIYOE2aE/WzIiSrEEWmmuHsi/wl6W4V/ANILJYyeP6KFipbwScW6PzZ1joJOCdV
	WkePHtPRgJrSm88tRcvSdzcIxiQa3WJr6zjN9qvWcKFiULekpKrmUCX9R8KY2ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NRVRqi
	QkBeXgggqw9RgGf0+m23FHvqZR0f+JYo69HdUK/PLcPE0a6osmuZJ6xydJkNOj3Q
	Ry5/XbIXSAo8ZOfL0j6T+7YWgz8gMOr4ixbn2Hd0lHVYtYk1Rskifj3vtDpeAdah
	qmQeZ3306as2JqCMhjWVFHfow8f6uxPsk7YNY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9916E428EB;
	Thu,  4 Feb 2016 19:03:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 10E51428EA;
	Thu,  4 Feb 2016 19:03:26 -0500 (EST)
In-Reply-To: <1454576641-29615-14-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E1A677CA-CB9B-11E5-AF4F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285528>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The shallow repo could be deepened or shortened when then user gives
> --depth. But in future that won't be the only way to deepen/shorten a
> repo. Stop relying on args->depth in this mode. Future deepening
> methods can simply set this flag on instead of updating all these if
> expressions.
>
> The new name "deepen" was chosen after the command to define shallow
> boundary in pack protocol. New commands also follow this tradition.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

OK.  Up to here things look more-or-less sensible overall.

Thanks.

>  fetch-pack.c | 14 ++++++++------
>  fetch-pack.h |  1 +
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 16917f9..e947514 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -197,7 +197,7 @@ enum ack_type {
> =20
>  static void consume_shallow_list(struct fetch_pack_args *args, int f=
d)
>  {
> -	if (args->stateless_rpc && args->depth > 0) {
> +	if (args->stateless_rpc && args->deepen) {
>  		/* If we sent a depth we will get back "duplicate"
>  		 * shallow and unshallow commands every time there
>  		 * is a block of have lines exchanged.
> @@ -348,7 +348,7 @@ static int find_common(struct fetch_pack_args *ar=
gs,
>  	packet_buf_flush(&req_buf);
>  	state_len =3D req_buf.len;
> =20
> -	if (args->depth > 0) {
> +	if (args->deepen) {
>  		char *line;
>  		const char *arg;
>  		unsigned char sha1[20];
> @@ -557,7 +557,7 @@ static void filter_refs(struct fetch_pack_args *a=
rgs,
>  		}
> =20
>  		if (!keep && args->fetch_all &&
> -		    (!args->depth || !starts_with(ref->name, "refs/tags/")))
> +		    (!args->deepen || !starts_with(ref->name, "refs/tags/")))
>  			keep =3D 1;
> =20
>  		if (keep) {
> @@ -627,7 +627,7 @@ static int everything_local(struct fetch_pack_arg=
s *args,
>  		}
>  	}
> =20
> -	if (!args->depth) {
> +	if (!args->deepen) {
>  		for_each_ref(mark_complete_oid, NULL);
>  		for_each_alternate_ref(mark_alternate_complete, NULL);
>  		commit_list_sort_by_date(&complete);
> @@ -813,6 +813,8 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
> =20
>  	if ((args->depth > 0 || is_repository_shallow()) && !server_support=
s("shallow"))
>  		die("Server does not support shallow clients");
> +	if (args->depth > 0)
> +		args->deepen =3D 1;
>  	if (server_supports("multi_ack_detailed")) {
>  		print_verbose(args, "Server supports multi_ack_detailed");
>  		multi_ack =3D 2;
> @@ -873,7 +875,7 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
> =20
>  	if (args->stateless_rpc)
>  		packet_flush(fd[1]);
> -	if (args->depth > 0)
> +	if (args->deepen)
>  		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
>  					NULL);
>  	else if (si->nr_ours || si->nr_theirs)
> @@ -940,7 +942,7 @@ static void update_shallow(struct fetch_pack_args=
 *args,
>  	int *status;
>  	int i;
> =20
> -	if (args->depth > 0 && alternate_shallow_file) {
> +	if (args->deepen && alternate_shallow_file) {
>  		if (*alternate_shallow_file =3D=3D '\0') { /* --unshallow */
>  			unlink_or_warn(git_path_shallow());
>  			rollback_lock_file(&shallow_lock);
> diff --git a/fetch-pack.h b/fetch-pack.h
> index bb7fd76..4d0adb0 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -25,6 +25,7 @@ struct fetch_pack_args {
>  	unsigned self_contained_and_connected:1;
>  	unsigned cloning:1;
>  	unsigned update_shallow:1;
> +	unsigned deepen:1;
>  };
> =20
>  /*
