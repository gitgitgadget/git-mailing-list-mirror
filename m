From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/4] git-credential-store: support multiple credential files
Date: Sun, 15 Mar 2015 12:44:06 +0100
Message-ID: <vpqbnju7aex.fsf@anie.imag.fr>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
	<1426056553-9364-2-git-send-email-pyokagan@gmail.com>
	<20150313061530.GA24588@peff.net>
	<CACRoPnR9pTc2LC87Vf0bMAgTj-FnbsRBpjn+3RCxCP6yrzsCkw@mail.gmail.com>
	<xmqqfv97w7k5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 12:44:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX6yD-0005nL-JA
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 12:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbbCOLo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 07:44:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44370 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbbCOLoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 07:44:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2FBi5vZ011737
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 15 Mar 2015 12:44:05 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2FBi6Mi008031;
	Sun, 15 Mar 2015 12:44:06 +0100
In-Reply-To: <xmqqfv97w7k5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 14 Mar 2015 15:14:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 15 Mar 2015 12:44:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2FBi5vZ011737
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427024649.19422@NvUAJKR4z/cUjDO2OF4Siw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265489>

Junio C Hamano <gitster@pobox.com> writes:

> Paul Tan <pyokagan@gmail.com> writes:
>
>>> I think you could even get away without passing default_fn here, and
>>> just use the rule "the first file in the list is the default". Unless
>>> you are anticipating ever passing something else, but I couldn't think
>>> of a case where that would be useful.
>>
>> Even though in this case the store_credential() function is not used
>> anywhere else, from my personal API design experience I think that
>> cementing the rule of "the first file in the list is the default" in
>> the behavior of the function is not a good thing. For example, in the
>> future, we may wish to keep the precedence ordering the same, but if
>> none of the credential files exist, we create the XDG file by default
>> instead.
>
> I am not sure if this is not a premature over-engineering

I would say so if having this default_fn made the code more complex, but
here the code is basically

+	if (default_fn)
+		store_credential_file(default_fn, c);

and

-		store_credential(file, &c);
+		store_credential(&fns, &c, fns.items[0].string);

Taking the first element in the list wouldn't change much.

I'm personally fine with both versions.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
