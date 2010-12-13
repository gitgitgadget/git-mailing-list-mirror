From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] get_sha1_oneline: do not leak or double free
Date: Sun, 12 Dec 2010 22:12:01 -0800
Message-ID: <7v1v5m6w26.fsf@alter.siamese.dyndns.org>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 07:12:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS1eB-0004S6-8G
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 07:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553Ab0LMGMZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 01:12:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab0LMGMY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 01:12:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E4C83EA8;
	Mon, 13 Dec 2010 01:12:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=raksUwfH6KwV
	s6xtZLWjy3u3Tgw=; b=TtaIxC/eWcnbigsemSOLDVT3flLBqQM2kihlzH9rDaQq
	hfk4amOS7+T/9NXiArwY1zhB3VFYG6Q981LwnJMnNYlbwYm46nMKKjo2XnFLbY8G
	pRXOMGog07XpY6ydUNUhuWhxk1IZY4KTRgiG9ifsHBaP/MgeXaEc7PK+sTjuOR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pPCEp8
	q8JZdGWASLflMiXi5usRrH5Uj0G0b7ZkeLooGNkLfZ5vJ6g5gx+F6oWRNTzfmPDa
	a1bCX0/XSYyW3QiFFHcTWQiwU2S8ImFNf6WxhKGgklsMDy+FD7yZa9/0L3Y8LjzE
	TjZWtPYV0IlCq/mIEyV1g4BXVreP4hSIhqNfc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14D193EA2;
	Mon, 13 Dec 2010 01:12:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3A6003EA0; Mon, 13 Dec 2010
 01:12:29 -0500 (EST)
In-Reply-To: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 13 Dec
 2010 10\:01\:13 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD2E324E-067F-11E0-8D6C-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163514>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Double free can happen when commit->buffer =3D=3D NULL in the first
> iteration, then !=3D NULL in the next two iterations.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  sha1_name.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Thanks.  First the later hunk:

> diff --git a/sha1_name.c b/sha1_name.c
> index 2c3a5fb..13ee6f5 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -740,6 +740,7 @@ static int get_sha1_oneline(const char *prefix, u=
nsigned char *sha1)
>  	free_commit_list(list);
>  	for (l =3D backup; l; l =3D l->next)
>  		clear_commit_marks(l->item, ONELINE_SEEN);
> +	free_commit_list(backup);
>  	return retval;
>  }

This is necessary, but is unrelated to the topic, no?

> @@ -718,13 +718,13 @@ static int get_sha1_oneline(const char *prefix,=
 unsigned char *sha1)
>  		commit =3D pop_most_recent_commit(&list, ONELINE_SEEN);
>  		if (!parse_object(commit->object.sha1))
>  			continue;
> -		free(temp_commit_buffer);
>  		if (commit->buffer)
>  			p =3D commit->buffer;
>  		else {
>  			p =3D read_sha1_file(commit->object.sha1, &type, &size);
>  			if (!p)
>  				continue;
> +			free(temp_commit_buffer);
>  			temp_commit_buffer =3D p;
>  		}
>  		if (!(p =3D strstr(p, "\n\n")))

This looks very convoluted.

I think the "temp-commit-buffer with a lifetime one iteration more than
the loop body itself" is merely a misguided attempt to avoid sprinkling
many free() calls inside the loop that has irregular exit points with
continue and break.

If you rewrite the loop to have more regular structure, there is no rea=
son
to have such a temporary variable with tricky lifespan.

I think the following is easier to read and conveys what the code is
trying to do more clearly.  No?

 sha1_name.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2c3a5fb..2cc7a42 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -693,8 +693,7 @@ static int handle_one_ref(const char *path,
 static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 {
 	struct commit_list *list =3D NULL, *backup =3D NULL, *l;
-	int retval =3D -1;
-	char *temp_commit_buffer =3D NULL;
+	int found =3D 0;
 	regex_t regex;
=20
 	if (prefix[0] =3D=3D '!') {
@@ -710,37 +709,40 @@ static int get_sha1_oneline(const char *prefix, u=
nsigned char *sha1)
 	for (l =3D list; l; l =3D l->next)
 		commit_list_insert(l->item, &backup);
 	while (list) {
-		char *p;
+		char *p, *to_free =3D NULL;
 		struct commit *commit;
 		enum object_type type;
 		unsigned long size;
+		int matches;
=20
 		commit =3D pop_most_recent_commit(&list, ONELINE_SEEN);
 		if (!parse_object(commit->object.sha1))
 			continue;
-		free(temp_commit_buffer);
 		if (commit->buffer)
 			p =3D commit->buffer;
 		else {
 			p =3D read_sha1_file(commit->object.sha1, &type, &size);
 			if (!p)
 				continue;
-			temp_commit_buffer =3D p;
+			to_free =3D p;
 		}
-		if (!(p =3D strstr(p, "\n\n")))
-			continue;
-		if (!regexec(&regex, p + 2, 0, NULL, 0)) {
+
+		p =3D strstr(p, "\n\n");
+		matches =3D p && !regexec(&regex, p + 2, 0, NULL, 0);
+		free(to_free);
+
+		if (matches) {
 			hashcpy(sha1, commit->object.sha1);
-			retval =3D 0;
+			found =3D 1;
 			break;
 		}
 	}
 	regfree(&regex);
-	free(temp_commit_buffer);
 	free_commit_list(list);
 	for (l =3D backup; l; l =3D l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
-	return retval;
+	free_commit_list(backup);
+	return found ? 0 : -1;
 }
=20
 struct grab_nth_branch_switch_cbdata {
