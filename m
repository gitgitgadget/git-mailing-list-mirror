From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge no longer handles add/add
Date: Mon, 19 Nov 2007 11:25:11 -0800
Message-ID: <7vabpanilk.fsf@gitster.siamese.dyndns.org>
References: <46a038f90711181918s2743137amc6a827db6d1a6a0@mail.gmail.com>
	<46a038f90711181929x4bf0794eue73a5dbac8e2688a@mail.gmail.com>
	<7vtznipweu.fsf@gitster.siamese.dyndns.org>
	<46a038f90711191033s4bc5ab50kd3e4f30d6b301e43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"git list" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 20:26:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuCFW-0005ZW-JN
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 20:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbXKSTZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 14:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbXKSTZT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 14:25:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56223 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbXKSTZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 14:25:18 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BB8E6320;
	Mon, 19 Nov 2007 14:25:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 28BE297829;
	Mon, 19 Nov 2007 14:25:35 -0500 (EST)
In-Reply-To: <46a038f90711191033s4bc5ab50kd3e4f30d6b301e43@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 20 Nov 2007 07:33:27 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65490>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On Nov 19, 2007 7:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> As far as the point of the merge is concerned, that's an add/add
>> of _different_ contents, and we have always left the conflict to
>> resolve for you since day one.  The only case we handle without
>> complaining is the accidental *clean* merge.  Both branches adds
>> the path *identically* compared to the common ancestor.
>
> Even if the 2 paths did have matching content at one point? In fact,
> the 2 files here get added with identicaly content and one of them is
> later modified...

A merge does not look at the history.

It _does_ look at the history to figure out what the common
ancestors are, but after finding them out, the "file history" is
not examined by following each step in the ancestry chain (that
would have been the "blame merge").

>> The very initial implementation of merge may have used the total
>> emptyness as the common ancestor for the merge, and later we
>> made it a bit more pleasant to resolve by computing the common
>> part of the file from the two branches to be used as a fake
>> ancestor contents.  But the fact we left the result as conflict
>> for you to validate hasn't changed and will not change.
>
> In this case, if you use the common part (100%) as the ancestor, then
> you get a _clean_ merge. The file is added on both sides identically,
> and then it changes on one side.

Exactly.  We may keep conflict markers in the file left in the
work tree to highlight which lines are unique to the side that
added more (iow, one group of lines delimited by <<< === >>> is
empty while the other is not) but this is currently treated as
"fishy, needs human validation" to catch mismerges.
