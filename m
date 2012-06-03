From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] fix many comment typos
Date: Sun, 03 Jun 2012 09:11:25 +0200
Message-ID: <87396ceuoy.fsf@rho.meyering.net>
References: <8762baf8do.fsf@rho.meyering.net>
	<7vmx4lz5bm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 09:11:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb4yS-0000al-HS
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 09:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab2FCHLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 03:11:34 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:56876 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117Ab2FCHLd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 03:11:33 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id A6448D4804B
	for <git@vger.kernel.org>; Sun,  3 Jun 2012 09:11:26 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 2D569600CD;
	Sun,  3 Jun 2012 09:11:25 +0200 (CEST)
In-Reply-To: <7vmx4lz5bm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 02 Jun 2012 16:01:33 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199068>

Junio C Hamano wrote:

> Jim Meyering <jim@meyering.net> writes:
>
>> Use http://github.com/lyda/misspell-check to identify many typos.
>> Culprits identified and fixed automatically using these commands,
>> converting diagnostics to single-quote-safe sed -i commands:
>>
>> git ls-files|misspellings -f -|perl -nl \
>>   -e '/^(.*?)\[(\d+)\]: (\w+) -> "(.*?)"$/ or next;' \
>>   -e '($file,$n,$l,$r)=($1,$2,$3,$4); $q="'\''"; $r=~s/$q/$q\\$q$q/g;'\
>>   -e 'print "sed -i $q${n}s!$l!$r!$q $file"' \
>>  | grep -vE '\.po$|pt_BR' > k
>>
>> Filter out s/seeked/sought/ false positives (they relate to cg-seek):
>>   grep -vE 'seeked' k > j && mv j k
>
> ??
>> diff --git a/Documentation/RelNotes/1.5.4.4.txt
>> b/Documentation/RelNotes/1.5.4.4.txt
>> index 323c1a8..83453db 100644
>> --- a/Documentation/RelNotes/1.5.4.4.txt
>> +++ b/Documentation/RelNotes/1.5.4.4.txt
>> @@ -21,7 +21,7 @@ Fixes since v1.5.4.3
>>
>>   * "git send-email" in 1.5.4.3 issued a bogus empty In-Reply-To: header.
>>
>> - * "git bisect" showed mysterious "won't bisect on seeked tree" error message.
>> + * "git bisect" showed mysterious "won't bisect on sought tree" error message.
>
> ??

Well caught.

I confess.
I manually reverted those two changes and missed the third.
30 lashes.

Perhaps a more palatable change, here and in the other two places:
s/seeked/cg-seek'd/, i.e.,

- * "git bisect" showed mysterious "won't bisect on seeked tree" error message.
+ * "git bisect" showed mysterious "won't bisect on cg-seek'd tree" error message.

Then, if someone does this again, it will be more obvious that
it is not a typo.

If you like that, I'll gladly redo the patch accordingly.
