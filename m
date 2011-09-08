From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 08 Sep 2011 13:15:00 +0200
Message-ID: <vpq39g7gua3.fsf@bauges.imag.fr>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
	<CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
	<vpq7h5jtngj.fsf@bauges.imag.fr>
	<CALkWK0nuLHpG9xqAAVL4T21N-31m7=A3_amp7Mf0Sw9jobYDRg@mail.gmail.com>
	<CALkWK0nt4PXfBxGcAnavUkKM6AhKpZnw1NtZsNznzmGZiguFqA@mail.gmail.com>
	<CALkWK0mNBG8EwysjO8uoR+fU5ZM=Pz9es3t_+s6cFgR6NSodGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Georgi Chorbadzhiyski <gf@unixsol.org>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 13:15:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1cZh-0001OW-6g
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 13:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758316Ab1IHLPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 07:15:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53401 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758302Ab1IHLPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 07:15:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p88BDspZ020630
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Sep 2011 13:13:54 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R1cZQ-0002Uk-M5; Thu, 08 Sep 2011 13:15:00 +0200
In-Reply-To: <CALkWK0mNBG8EwysjO8uoR+fU5ZM=Pz9es3t_+s6cFgR6NSodGQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 8 Sep 2011 16:14:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Sep 2011 13:13:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p88BDspZ020630
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1316085237.21137@5QYbBjsGJS6a0eQcdXWa/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180964>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi,
>
> I mocked up a small patch to demonstrate the "special cover letter
> handling" idea.  Let me know if you think it's worth pursuing.

If it was really a problem to have to wait a few seconds/minutes more,
I'd consider it as an interesting compromise (allow [PATCH 1/2] to come
after [PATCH 2/2] but make sure they both come after the coverletter to
make sure the recipient notice they're part of the same thread).

But quite frankly, I don't think it's worth the trouble.

As you said, the normal workflow is to use "git send-email", and go back
to work after, so you can do something else while the emails are being
sent (see below [1]). I don't think bothering users with --sleep and
--initial-wait is worth the benefit of having both possibilities. People
worried about email order should be fine with --sleep.

[1] Actually, I think there's a problem with Georgi's patch. If I read
correctly, the sleep is inserted within the confirmation loop, which
means the user will have

send this email? yes
sending email
sleeping 10 seconds
send this email? yes
sending email
sleeping 10 seconds
...

while it should be

send this email? yes
ok, I'll send it later
send this email? yes
ok, I'll send it later
sending first email ...
sleeping 10 seconds
sending second email
done.

(i.e. don't force the user to wait between confirmations, and don't wait
after the last email)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
