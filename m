From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff --cached: do not report i-t-a entries as "new"
Date: Sat, 14 Mar 2015 23:55:09 -0700
Message-ID: <xmqqmw3evjg2.fsf@gitster.dls.corp.google.com>
References: <1425910445-27383-1-git-send-email-pclouds@gmail.com>
	<1425910445-27383-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 07:55:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX2SE-0006nD-Jv
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 07:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbbCOGzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2015 02:55:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751262AbbCOGzM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 02:55:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDEA0385D3;
	Sun, 15 Mar 2015 02:55:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EGMefG90WnHI
	E/qhQsv75SrDDMc=; b=Vpgk1qA6pgX+LNm7dn5XKXer8/SmDJuU6tuwOgQa52rn
	WibTVSwk2VbkukFbLNOb6/jmf+4mK7XFd4BhL9nlpeYRLpKkkDyG4wNQxMo6Lfbd
	G4S9l+bpAdlHRXZxETO+N4AVAEqLf+oc55b097GTDVuHHfBv6z5RgD6jDJyOWUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l6QSC0
	SI14szXCk5zSuoqL9VHbHmRM14fAsf2JvXnYmubHqiEJR5DqJj7IlkU0pY4cw4Pu
	neZmx4j1knbAUaKq/PW8bw8Nf/deplH66Z+sQGNHcOsCD/rndbRBGpcS6D7LIzxY
	2df3xF85HSSYCaVuNLPcmTcETmvKOtJm4UAcc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6F62385D2;
	Sun, 15 Mar 2015 02:55:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51D97385D0;
	Sun, 15 Mar 2015 02:55:10 -0400 (EDT)
In-Reply-To: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Mar
 2015 21:14:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 38DD9B44-CAE0-11E4-A2ED-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265481>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Paths marked by "git add -N" are simply a reminder to the user that
> these files should be staged. If the user does not stage any of them,
> "git commit" will not record them.
>
> Align the behavior of "diff --cached" and "git commit". The most
> prominent result of this patch is "git status" no longer reports i-t-=
a
> paths as "Changes to be committed".
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  diff-lib.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index a85c497..db0e6f8 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -400,6 +400,8 @@ static void do_oneway_diff(struct unpack_trees_op=
tions *o,
>  	 * Something added to the tree?
>  	 */
>  	if (!tree) {
> +		if (idx && (idx->ce_flags & CE_INTENT_TO_ADD))
> +			return;
>  		show_new_file(revs, idx, cached, match_missing);
>  		return;
>  	}

This hunk by itself feels like it is going in the right direction.
The HEAD does not have it, and even though there is idx, it merely
is an i-t-a entry.

Don't you need to special case the call to show_modified() at the
end of this function as well, though?  idx is i-t-a, and tree has a
concrete object.  Should it appear as if the path already exists in
the index, or should we pretend as if idx is not yet there?

=46or example, after this sequence:

    $ git init
    $ >void
    $ git add void
    $ git commit -m void
    $ git rm --cached void
    $ git add -N void

HEAD has "void" with an empty blob, the index has i-t-a.  I am not
sure if we should say something about path "void" when asked:

    $ git diff --cached

Perhaps something like this to cover that case?

	/*
	 * Something removed from the tree?
	 */
-	if (!idx) {
+	if (!idx || (ix->ce_flags & CE_INTENT_TO_ADD)) {
		diff_index_show_file(revs, "-", tree, tree->sha1, 1, tree->ce_mode, 0=
);
		return;
	}
