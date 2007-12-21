From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't dereference NULL upon lookup_tree failure.
Date: Fri, 21 Dec 2007 15:40:58 -0800
Message-ID: <7vve6r39bp.fsf@gitster.siamese.dyndns.org>
References: <873atvwueq.fsf@rho.meyering.net>
	<7v4peb4qbj.fsf@gitster.siamese.dyndns.org>
	<87hcibveut.fsf@rho.meyering.net>
	<7vzlw33a1o.fsf@gitster.siamese.dyndns.org>
	<87bq8jvd1g.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Matthew Farrellee <mfarrellee@redhat.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat Dec 22 00:41:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5rUp-0000co-Ky
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 00:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356AbXLUXlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 18:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbXLUXlI
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 18:41:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbXLUXlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 18:41:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 820425E8A;
	Fri, 21 Dec 2007 18:41:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BB95E87;
	Fri, 21 Dec 2007 18:41:00 -0500 (EST)
In-Reply-To: <87bq8jvd1g.fsf@rho.meyering.net> (Jim Meyering's message of
	"Sat, 22 Dec 2007 00:33:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69110>

Jim Meyering <jim@meyering.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Sorry, I asked for a wrong thing.  parse_object() reads and
>> finds out the type, so type there is presumably the right type
>> of the object (which is OBJ_TREE).  Then parse_object_buffer()
>> checks if it has already seen the object of the same SHA-1 and
>> finds that somebody had earlier told that SHA-1 name is of a
>> commit object.  Either you found a SHA-1 collision (highly
>> unlikely) or the earlier caller had lied.  And I think what
>> really needs to be fixed is that lying caller.  That is not in
>> the above call chain.
>
> I presume that parsecvs is the culprit, in constructing
> an invalid repository...

Independent of who creates a "invalid repository", our tools
should be prepared to be fed bad data and not get upset.
Somebody in our code read a non-commit (or it did not read
anything) and told the object layer it is a commit.  That
codepath needs to be tightened up, no?
