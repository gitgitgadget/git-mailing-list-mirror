From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git confused by rename
Date: Fri, 10 Oct 2008 08:54:50 -0700
Message-ID: <7v3aj4momt.fsf@gitster.siamese.dyndns.org>
References: <fb6605670810100741k7cff25c7y4df66834cf7482a0@mail.gmail.com>
 <7vabdcmp4n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael P. Soulier" <msoulier@digitaltorque.ca>
X-From: git-owner@vger.kernel.org Fri Oct 10 17:56:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoKLc-0008K6-C9
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 17:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758852AbYJJPy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758748AbYJJPy7
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 11:54:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758596AbYJJPy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 11:54:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C96E46DBF7;
	Fri, 10 Oct 2008 11:54:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 418066DBF5; Fri, 10 Oct 2008 11:54:51 -0400 (EDT)
In-Reply-To: <7vabdcmp4n.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 10 Oct 2008 08:44:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C8973804-96E3-11DD-AF9F-9364E785EAEE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97944>

Junio C Hamano <gitster@pobox.com> writes:

> "Michael P. Soulier" <msoulier@digitaltorque.ca> writes:
>
>> #       renamed:    templates/scrc/index.html -> templates/scrc/cres_taps.html
>> #       modified:   templates/scrc/index.html
>>
>> Looking at the last two lines here, there is obviously an issue.
>
> I am puzzled.

Not anymore.

> Looking at wt-status.c "renamed: A -> B" will be shown only when A and B
> are similar enough *and* there is no A remaining in the final result, and
> in such a case, "modified: A" should not be shown.

Except for one case.

> Because git does not
> care how you created B (IOW, it does not matter if B was typed from
> scratch with copying and pasting, or created by copying and editing), the
> "renamed: A -> B" entry itself is not surprising nor look like a bug at
> all,...

The above observation of mine is correct, but I forgot that "git status"
(and the comment in the commit template from "git commit") is generated
internally with "diff-index -B -M".  So if

 (0) had A but not B in the HEAD commit;
 (1) you created B that is very similar to the original A; and
 (2) you modified A beyond recognition;

then git will say "A was modified and B was created by renaming A".

> ... but its presense at the same time as "modified: A" does feel very
> fishy.

So this is not fishy anymore.

This however makes me wonder if "diff-index -B -M" should say B is copied
(instead of being renamed) from A and A is modified in such a case.  I do
not think we would want to make such a change without thinking things,
through.
