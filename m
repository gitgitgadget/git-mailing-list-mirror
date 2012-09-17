From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Using Format/export-subst Howto.
Date: Mon, 17 Sep 2012 15:17:17 +0200
Message-ID: <505722DD.3000806@drmicha.warpmail.net>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov> <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net> <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov> <50534FC6.2040207@viscovery.net> <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com> <7vfw6k2t8w.fsf@alter.siamese.dyndns.org> <7v7grw2qcu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Mestnik\, Michael J - Eagan\, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:26:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDbLK-0006Zc-5D
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 15:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab2IQN0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 09:26:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51598 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752658Ab2IQN0U (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 09:26:20 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2012 09:26:20 EDT
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7B7E0204BA;
	Mon, 17 Sep 2012 09:17:19 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 17 Sep 2012 09:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=n68FDppzEIyoTsxhZ0Nqvd
	qP2pc=; b=jQJrY4Ur+XHwGjqh7K4htKiBrpV24UrrOXiaB+JUOogZMg8SURPOQu
	EgjJl3bJQfBJ3hRPPLQm5NUsCOI4wKF5ow0plALlUCfLnCNR0BEvuqVmg4j7d0av
	Jr0dwCPV+9kChBQ9j1rP+oyCQvTB0cUZGVtS7MHpWIlvWpJDvksS4=
X-Sasl-enc: gFaTJdYkiFQvcuD5yJ2giRhlcUK5b4yvaK09nDtoL4mF 1347887839
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C3EB08E01F4;
	Mon, 17 Sep 2012 09:17:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7v7grw2qcu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205687>

Junio C Hamano venit, vidit, dixit 14.09.2012 23:23:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> you need to "rm file && git checkout file"). If the user has to
>> update $Id$ to match the current sha1 (by remembering to do a more
>> forceful checkout than checkout -f) then one half of that feature
>> is useless.
> 
> As if there is any value in "$Id$" _feature_.  It's a checkbox item, 
> nothing more ;-).

It's your favorite feature^Wcheckbox item, I know ;)

I wouldn't mind dropping it or making it export-only, but the current
state of that item is quite confusing. I seem to remember this has been
brought up before.

Junio C Hamano venit, vidit, dixit 15.09.2012 00:26:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> you need to "rm file && git checkout file"). If the user has to
>>> update $Id$ to match the current sha1 (by remembering to do a
>>> more forceful checkout than checkout -f) then one half of that
>>> feature is useless.
>> 
>> As if there is any value in "$Id$" _feature_.  It's a checkbox
>> item, nothing more ;-).
> 
> Having said that, I think you could do something along this line (I 
> am thinking aloud, so there may be leaps in the logic below).
> 
> * Introduce a new on-disk flag in the index.  Call it X.  After 
> entry.c:write_entry() writes it out to the working tree, this flag is
> cleared.  And this codepath is the only place that clears this flag.
> 
> * When applying a clean filter (from here on, everything that breaks
> byte-for-byte identity between the copy on the working tree and the
> contents that is hashed and stored in the object store are considered
> "clean filter", including CRLF->LF and ident), internally apply the
> corresponding smudge filter to the cleaned result and compare it with
> the original input we obtained from the working tree.  If they
> differ, flip the X bit on for the path in the index.
> 
> * When "checkout" and any potential callers of write_entry() decide 
> whether it is worth calling write_entry() [*1*], consider any path
> with the X bit on as "dirty" and call write_entry().
> 
> You have to be very careful when designing the third point, though. 
> There will now be two kinds of "the working tree file is different 
> from the version registerd in the index" once you do the above. 
> Different only because of "clean->smudge" roundtrip comparison, and 
> different because it does have a real local modification.  The former
> must be considered "no local modification" for the purpose of merges
> and branch switching (otherwise you will get "cannot merge, you have
> local modifications" error).
> 
> 
> [Footnote]
> 
> *1* This currently is done primarily with ie_match_stat(), that 
> essentially is "Does the result of applying 'clean' to the working 
> tree contents match what is registered to the index?  Do not bother 
> doing this check over and over again once you checked this until the
> file in the working tree is modified again".
> 

You've convinced me not to try this in-core...

Maybe a post-commit hook is enough for Id. It's just that we also have
no in-core way of doing a forceful enough checkout on those files. But I
wouldn't mind making Id export-only (export-subst). Really, most people
who look at Id really want something like VERSION_GEN (without having to
use a build script/make/...).

Michael
