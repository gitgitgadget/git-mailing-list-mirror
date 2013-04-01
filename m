From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/5] merge/pull: verify GPG signatures of commits
 being merged
Date: Sun, 31 Mar 2013 19:47:00 -0700
Message-ID: <7vsj3bm0gr.fsf@alter.siamese.dyndns.org>
References: <20130331144452.GF2286@serenity.lan>
 <cover.1364742659.git.jaseg@physik-pool.tu-berlin.de>
 <51585E10.8090505@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, john@keeping.me.uk
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Mon Apr 01 04:47:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMUmg-00079Y-FU
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 04:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137Ab3DACrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 22:47:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785Ab3DACrE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Mar 2013 22:47:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29D42E6DC;
	Mon,  1 Apr 2013 02:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Os/mAqdSAZoNjGtTaBsN0BXkA
	Ps=; b=Me4YEUD0q8aF5i/Lly0yFGQ16HM40g5fxP8QO6/Hawmca/d3ciLLMHt6/
	4Ok9QW67Nn7k6edku1J2CL6DwA1q1hhlf3pwe7sCzSsQluI313r/Or0+bV+JCjn0
	oQG4CYJnzc8mCrqsGIA0Fg6cTEehqcc2HwvlTDAYe2n8wat1J4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=IadZCftLliJV5W+0J9j
	HvVWStO/Bc6+OLJ+f6vXra8JBC7aEJ78y5eq79s4os8E5x5dDjoAEr+Wlkf/61t0
	AhCShi40YoY/00a5tUkAB/icYjQMJhxTZ4gIktf7J6O1rP41QfeVogFWZVpHeU6+
	NJAlpefsxkBdN/Gnj9tcaiKk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CF68E6DB;
	Mon,  1 Apr 2013 02:47:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D8ACE6D8; Mon,  1 Apr 2013
 02:47:02 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E765C38-9A76-11E2-901B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219659>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> +	if (verify_signatures) {
> +		for (p =3D remoteheads; p; p =3D p->next) {
> +			struct commit *commit =3D p->item;
> +			char hex[41];
> +			struct signature_check signature_check;
> +			memset(&signature_check, 0, sizeof(signature_check));
> +
> +			check_commit_signature(commit, &signature_check);
> +
> +			strcpy(hex, find_unique_abbrev(commit->object.sha1, DEFAULT_ABBRE=
V));
> +			switch(signature_check.result){
> +				case 'G':
> +					break;
> +				case 'B':
> +					die(_("Commit %s has a bad GPG signature allegedly by %s."), he=
x, signature_check.signer);
> +				default: /* 'N' */
> +					die(_("Commit %s does not have a GPG signature."), hex, hex);

Count %s and number and arguments.

> +			}

Style.

        switch (expr) {
	case 'G':
		do_something_for_G();
		break;
		...
	}

Also avoid overlong lines.

I'll squash in something like the following and push out the result
on 'pu' tonight.  Please check to see if I made silly mistakes while
doing so.

Thanks.

 builtin/merge.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 7a33d03..e57c42c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1245,16 +1245,18 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 			check_commit_signature(commit, &signature_check);
=20
 			strcpy(hex, find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV)=
);
-			switch(signature_check.result){
-				case 'G':
-					break;
-				case 'B':
-					die(_("Commit %s has a bad GPG signature allegedly by %s."), hex,=
 signature_check.signer);
-				default: /* 'N' */
-					die(_("Commit %s does not have a GPG signature."), hex, hex);
+			switch (signature_check.result) {
+			case 'G':
+				break;
+			case 'B':
+				die(_("Commit %s has a bad GPG signature "
+				      "allegedly by %s."), hex, signature_check.signer);
+			default: /* 'N' */
+				die(_("Commit %s does not have a GPG signature."), hex);
 			}
 			if (verbosity >=3D 0 && signature_check.result =3D=3D 'G')
-				printf(_("Commit %s has a good GPG signature by %s\n"), hex, signa=
ture_check.signer);
+				printf(_("Commit %s has a good GPG signature by %s\n"),
+				       hex, signature_check.signer);
=20
 			free(signature_check.gpg_output);
 			free(signature_check.gpg_status);
