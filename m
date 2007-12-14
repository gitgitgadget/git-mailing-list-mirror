From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 3/5] Unify whitespace checking
Date: Fri, 14 Dec 2007 08:36:09 +0100
Message-ID: <85B8B116-78F6-4D37-A9DB-30EECAB97956@wincent.com>
References: <1197552751-53480-1-git-send-email-win@wincent.com> <1197552751-53480-2-git-send-email-win@wincent.com> <1197552751-53480-3-git-send-email-win@wincent.com> <1197552751-53480-4-git-send-email-win@wincent.com> <7vd4taywfw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 08:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J356B-0001Jq-NN
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 08:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606AbXLNHgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 02:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbXLNHgV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 02:36:21 -0500
Received: from wincent.com ([72.3.236.74]:49748 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033AbXLNHgV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 02:36:21 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBE7aAjK012634;
	Fri, 14 Dec 2007 01:36:11 -0600
In-Reply-To: <7vd4taywfw.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68256>

El 14/12/2007, a las 1:03, Junio C Hamano escribi=F3:

>> -	git diff --check | grep "space before tab"
>> +	git diff --check | grep "Space in indent is followed by a tab"
>>
> Hmph.  I think with the multiple detection this rewording would make =
=20
> the
> error message very long to read.  Was the rewording really necessary?

Well, that wording came from builtin-apply.c so it wasn't really a "re-=
=20
wording" but an extraction. The other string comes from "diff.c". So I =
=20
had to pick one of them in unifying them and basically the one from =20
builtin-apply.c won because it was the site where I extracted from =20
first. So basically it was arbitrary.

If I were to actually *re-word* the message I think something like =20
this would be the compromise between clarity and conciseness:

"space before tab in indent"

And in the same spirit, the other two strings extracted from builtin-=20
apply.c into the new whitespace_error_string() function:

"Adds trailing whitespace"
"Indent more than 8 places with spaces"

Could be shortened to:

"trailing whitespace" (diff.c says "white space at end")
"indent using spaces"

But I personally have no strong conviction about this, so I'm happy =20
for it to be whatever you want.

>> +/* If stream is non-NULL, emits the line after checking. */
>> +unsigned check_and_emit_line(const char *line, int len, unsigned =20
>> ws_rule,
>> +                             FILE *stream, const char *set,
>> +                             const char *reset, const char *ws)
>> +{
>
> Honestly, I regretted suggesting this, fearing that it might make the
> checking too costly, but the code is clean, readable, and does not =20
> look
> costly at all.  Nice job.

Thanks. The check_and_emit_line function itself is fairly clean =20
internally (apart from the somewhat ugly parameter list, but that was =20
mostly inherited from the emit_line_with_ws function which it =20
replaces). It's the sites where check_and_emit_line is called that =20
look a bit ugly, but those can hopefully be cleaned up at some point =20
in the future.

Cheers,
Wincent
