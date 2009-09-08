From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] post-receive-email: do not call sendmail if no mail was generated
Date: Tue, 08 Sep 2009 22:12:58 +0100
Message-ID: <h86hcs$in2$1@ger.gmane.org>
References: <20090908185555.GA3858@lars.home.noschinski.de> <1252436418-7660-1-git-send-email-lars@public.noschinski.de> <7v4ord19da.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 23:13:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml80M-0000UO-4e
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 23:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbZIHVNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZIHVNW
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 17:13:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:55511 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbZIHVNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 17:13:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Ml80A-0000Qr-Gu
	for git@vger.kernel.org; Tue, 08 Sep 2009 23:13:22 +0200
Received: from 91.84.15.31 ([91.84.15.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 23:13:22 +0200
Received: from andyparkins by 91.84.15.31 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 23:13:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91.84.15.31
User-Agent: KNode/4.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128038>

Thanks for CCing me in - I don't monitor the list closely enough these days 
:-)

Junio C Hamano wrote:

> If generate_email results in an empty output in this codepath:
> 
> # Check if we've got anyone to send to
> if [ -z "$recipients" ]; then
> ...
> echo >&2 "*** $config_name is not set so no email will be sent"
> echo >&2 "*** for $refname update $oldrev->$newrev"
> exit 0
> fi
> 
> shouldn't we rather receive an error e-mail than let the
> misconfiguration go undetected?

I don't know if it's still the case, but when I wrote it, anything that went 
to standard error appeared on the client terminal, however, it could 
probably do with being a better description of who is generating the 
message, otherwise it'll be some anonymous error during a push, giving the 
user no clue as to how to fix it.

> Before this check, I do not see anywhere generate_email would return nor
> exit, and after this check, there is a call to generate_email_header and
> that guarantees that the output from the generate_email function is not
> empty, so it looks to me that triggering this check is the only case your
> patch would change the behaviour of the script.

There is also a check for the validity of the update type above the 
recipients check.

I'm wondering actually if all of these should be "return"s rather than 
"exit"s.  Better still would be if there were some sort of exception 
throwing mechanism in shell script - anyone know if there is?



Andy

P.S. Hope you're all keeping well.

-- 
Dr Andy Parkins
andyparkins@gmail.com
