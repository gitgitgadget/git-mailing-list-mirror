From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-opt: migrate builtin-checkout-index.
Date: Sun, 19 Oct 2008 14:45:28 -0700
Message-ID: <7vr66c5kef.fsf@gitster.siamese.dyndns.org>
References: <1224292643-28704-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:14:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krg85-0003YA-ET
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 23:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbYJSVpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 17:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYJSVpn
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 17:45:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYJSVpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 17:45:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0697F7123E;
	Sun, 19 Oct 2008 17:45:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8EF5D7123D; Sun, 19 Oct 2008 17:45:35 -0400 (EDT)
In-Reply-To: <1224292643-28704-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 18 Oct 2008 03:17:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 463A11A6-9E27-11DD-911C-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98633>

Miklos Vajna <vmiklos@frugalware.org> writes:

>> > +   if (argc && read_from_stdin)
>> > +           die("--stdin must be at the end");
>>
>> Is this comment still correct?  Do the original and your version act
>> the
>> same way when the user says "checkout --stdin -f", for example?  I
>> suspect
>> the original refused it and yours take it (and do much more sensible
>> thing), which would be an improvement, but then the error message
>> should
>> be reworded perhaps?
>
> Unless I missed something, that was a limitation of the option parser.
> checkout-index --stdin -f works fine for me after removing those two
> lines, so I left them out from the updated patch.

Thanks.  I think you got what I meant and dropping the part is right.

"--stdin -f" was rejected by the original code, and you improved to take
it with the new parser.  In fact, the above quoted if() statement should
not trigger when "--stdin -f" is given, due to the way the new option
parser is structured.  The original had an explicit "break" in the loop
when it saw "--stdin".  The above would still trigger if "--stdin foo" is
given, but there is a code to catch that already, so it is not necessary.
