From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailinfo: better parse email adresses containg
 parentheses
Date: Mon, 21 Jul 2008 20:16:43 -0700
Message-ID: <7v63qyr4kk.fsf@gitster.siamese.dyndns.org>
References: <1216647269-12287-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 05:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL8Ob-00045F-1Z
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 05:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbYGVDQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 23:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbYGVDQu
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 23:16:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbYGVDQu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 23:16:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CAF936295;
	Mon, 21 Jul 2008 23:16:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 837C836294; Mon, 21 Jul 2008 23:16:46 -0400 (EDT)
In-Reply-To: <1216647269-12287-1-git-send-email-book@cpan.org> (Philippe
 Bruhat's message of "Mon, 21 Jul 2008 15:34:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9F8D8DA4-579C-11DD-8618-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89430>

"Philippe Bruhat (BooK)" <book@cpan.org> writes:

>     When using git-rebase, author fields containing a ')' at the last
>     position had the close-parens character incorrectly removed
>     because the From: parser incorrectly matched it as
>
>         user@host (User Name)
>
>     (removing parentheses), instead of
>
>         User Name (me) <user@host>
>
> Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>

Hmm, tests?

By the way, that second form parses like this:

	mailbox =
        name-addr =
        display-name angle-addr = "User Name (me) <user@host>"

        display-name =
        phrase = "User Name"
        
        angle-addr = CFWS "<" addr-spec ">" = "(me) <user@host>"

So strictly speaking, shouldn't we be stripping the whole (me) as garbage?
It is not even part of the display-name but is a whitespace equivalent
comment.


        
