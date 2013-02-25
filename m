From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Mon, 25 Feb 2013 11:01:17 +0100
Message-ID: <vpqzjysiufm.fsf@grenoble-inp.fr>
References: <5104E738.602@alum.mit.edu> <vpqfw0rb25c.fsf@grenoble-inp.fr>
	<5129AAEB.5080007@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 25 11:02:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9ush-0003h0-P1
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 11:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318Ab3BYKBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 05:01:35 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54087 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309Ab3BYKBe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 05:01:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r1PA1Hmn018667
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Feb 2013 11:01:17 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U9us2-0007TV-6D; Mon, 25 Feb 2013 11:01:18 +0100
In-Reply-To: <5129AAEB.5080007@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 24 Feb 2013 06:53:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 25 Feb 2013 11:01:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1PA1Hmn018667
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362391279.90405@NFspc3rr6g+YAvNBFYiK2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217053>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I wonder whether it would be to far off the beaten path to allow glob
> patterns in the branch specification; e.g.,
>
>    [multimailhook "refs/heads/release-*"]
>          mailingList = qa@example.com

Yes, that would be even better.

> For the case of multiple glob patterns matching a branch name, there
> would probably have to be a notion of "best match", but that doesn't
> seem too difficult.

I'd rather have a simple rule here like "last one wins" or so. Saying
that foo-bar-* is a better match than foo-* may be easy, but you can
hardly avoid having corner-cases like foo-*-boz vs foo-bar-* when
matching foo-bar-boz.

> This feature could also be used to get the functionality of your
> proposal for skipRefs and onlyRefs [1] in a more general way:
>
>    [multimailhook]
>          mailingList = some@example.com
>    [multimailhook "refs/heads/user/$USER/*"]
>          mailingList = ""

Yes, I thougth about that, but it is not only "more general", but also
"less conveinient":

    [multimailhook]
          mailingList = some@example.com
          refchangelist = other@example.com
    [multimailhook "refs/heads/user/$USER/*"]
          mailingList = ""
          # Oops, forgot to override refchangelist, the mail will still
          # be sent.

So skipRefs and onlyRefs would still make sense IMHO.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
