From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: option to disable renames
Date: Tue, 16 Feb 2016 14:10:41 -0800
Message-ID: <xmqq60xomhlq.fsf@gitster.mtv.corp.google.com>
References: <1455583834-4796-1-git-send-email-felipegassis@gmail.com>
	<xmqqegccmikn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Felipe =?utf-8?Q?Go?= =?utf-8?Q?n=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 23:10:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVnpY-00027l-HT
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 23:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074AbcBPWKp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 17:10:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751375AbcBPWKo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 17:10:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DC81445BB;
	Tue, 16 Feb 2016 17:10:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EN/DQjpFR3UN
	pr3zhbtPRN9fl1U=; b=DgS1HepVPEM1cpX5sKSPSnCKSrTTf3l81UMyjlm6V7bA
	d5/3Lr3Y0eLtc6y/jLmRGAtsCP4/1tcp5OchVhw2JyF//zx2fJONsRtLAZceYHC3
	z8Kc3gyf84saX45Gc9iX26qsss+jyaNU+2CJN07o31qqX91iRhfqDJ9IDLU2m4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qILhGq
	i29nKS5nbRnH8wMOdwDS6DY3KSncenozmMMsyiW1MytTG9Sy26o+hdIcdpd0R4VZ
	KB3psxWLWT2aaz5Y2wMVVSSGxZj6uOoW/WsSH2yFKCCTEEmSrqEjRQq4ADYzwA9g
	HDQzV2Dh2yXkvOP9xAav8XF2QAmV6GTRY2LdM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55A11445BA;
	Tue, 16 Feb 2016 17:10:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CB72E445B9;
	Tue, 16 Feb 2016 17:10:42 -0500 (EST)
In-Reply-To: <xmqqegccmikn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 16 Feb 2016 13:49:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1ECF0BF0-D4FA-11E5-BE58-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286441>

Junio C Hamano <gitster@pobox.com> writes:

> "Felipe Gon=C3=A7alves Assis"  <felipeg.assis@gmail.com> writes:
>
>> +no-renames;;
>> +	Turn off rename detection.
>> +	See also linkgit:git-diff[1] `--no-renames`.
>
> Even though by default for merge-recursive the rename detection is
> on, if we are adding an option to control this aspect of the
> behaviour from the command line, it should follow the usual pattern,
> i.e.
>
>  (1) the code to parse options would allow an earlier "--no-renames"
>      on the command line to be overridden with a later "--renames"; a=
nd
>
>  (2) the description in the documentation would be headed by
>      "--[no-]renames", describes which one is the default, etc.
>
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 8eabde2..ca67805 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -1839,9 +1839,16 @@ int merge_trees(struct merge_options *o,
>> =20
>>  		entries =3D get_unmerged();
>>  		record_df_conflict_files(o, entries);
>> -		re_head  =3D get_renames(o, head, common, head, merge, entries);
>> -		re_merge =3D get_renames(o, merge, common, head, merge, entries);
>> -		clean =3D process_renames(o, re_head, re_merge);
>> +		if (o->detect_rename) {
>> +			re_head  =3D get_renames(o, head, common, head, merge, entries);
>> +			re_merge =3D get_renames(o, merge, common, head, merge, entries)=
;
>> +			clean =3D process_renames(o, re_head, re_merge);
>> +		}
>> +		else {
>> +			re_head  =3D xcalloc(1, sizeof(struct string_list));
>> +			re_merge =3D xcalloc(1, sizeof(struct string_list));
>> +			clean =3D 1;
>> +		}
>
> Yup, this is much nicer than butchering diffcore-rename.c for no
> good reason ;-).

Thinking about this a bit deeper, you are already passing o to
get_renames, so I think the right place to decide "Oh, I can just
return an empty list" is inside that function.  That is, the meat of
the change in this patch should be just these three lines instead, I
think.  You'd of course need to have addition of that new field,
option parsing, and documentation update in addition to that.

Thanks.


 merge-recursive.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8eabde2..69fb947 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -482,6 +482,9 @@ static struct string_list *get_renames(struct merge=
_options *o,
 	struct diff_options opts;
=20
 	renames =3D xcalloc(1, sizeof(struct string_list));
+	if (!o->detect_rename)
+		return renames;
+
 	diff_setup(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
