From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v2 5/5] send-email: refactor address list process
Date: Tue, 9 Jun 2015 00:12:11 +0200 (CEST)
Message-ID: <415871115.284559.1433801531886.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433609976-1868-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1433609976-1868-5-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpqk2ve9tfm.fsf@anie.imag.fr> <xmqq8ubuavze.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:11:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z25Gf-00066W-R9
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 00:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbbFHWLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 18:11:38 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:45100 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752966AbbFHWLg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 18:11:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id AF7B948858;
	Tue,  9 Jun 2015 00:11:34 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aytPl70N7x1K; Tue,  9 Jun 2015 00:11:34 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 90FF5487DB;
	Tue,  9 Jun 2015 00:11:34 +0200 (CEST)
In-Reply-To: <xmqq8ubuavze.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: refactor address list process
Thread-Index: Ycp0k2UQFaUYcE4kVLCZxrTTwbYhZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271140>

Junio C Hamano <gitster@pobox.com> writes

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
> >
> >> Simplify code by creating a function to transform list of email lists
> >> (comma separated, with aliases ...)  into a simple list of valid email
> >> addresses.
> >
> > I would have found the series easier to read if this refactoring came
> > earlier (and then PATCH 2/5 would fix the bug as a positive side effect
> > of the refactoring).
> 
> I agree that doing 5/5 sooner would make 4/5 a lot clearer.  
> 
> Introducing the helper of 5/5 before 2/5 happens, and then replacing
> two calls to validate-address-list with process-address-list would
> hide the nature of the change, i.e. fixing a bug, so it is better to
> see it done before the refactoring of 5/5, provided if it is indeed
> a bug that these were not expanded.

Ok thanks, I submit it again soon. Also I think we should swap the
lines 'sanitize_address_list(...)' and 'expand_aliases(...)',
i.e. first sanitize addresses and then expand aliases.

We could then remove leading and trailing whitespaces in the
sanitize_address_list function as aliases file formats supported by git
send-email doesn't take these whitespace into account anyway:

Example which currently can't work:

git send-email --to=" alias" ...

Moreover I think it's more natural to do that so.

I'll do it right after the refactoring patch introducing
process_address_list or maybe I should avoid changing this patch now ?
