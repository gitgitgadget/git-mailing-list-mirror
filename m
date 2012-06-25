From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4 v8] config: write to $XDG_CONFIG_HOME/git/config file if appropriate
Date: Mon, 25 Jun 2012 08:45:50 +0200
Message-ID: <vpq395jj3dt.fsf@bauges.imag.fr>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
	<1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
	<1340355806-6894-5-git-send-email-Matthieu.Moy@imag.fr>
	<7vwr2zm4bm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 08:46:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj33i-0004DA-8v
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 08:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab2FYGp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 02:45:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58081 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753339Ab2FYGp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 02:45:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5P6jIlV012816
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Jun 2012 08:45:18 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sj33X-0005iV-Dp; Mon, 25 Jun 2012 08:45:51 +0200
In-Reply-To: <7vwr2zm4bm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 Jun 2012 14:20:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 25 Jun 2012 08:45:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5P6jIlV012816
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1341211519.58045@n9gGpNUz3K3G72rz4FpaeA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200552>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> From: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
>>
>> Git will be able to write to $XDG_CONFIG_HOME/git/config, a new
>> ...
>> Advice for users who often come back to an old version of Git: you
>> shouldn't create this file.
>
> Hrm, is there a better way to give this advice to the _users_?  The
> log message is primarily for people who need to dig the development
> history of Git, and they are not the people who will be hurt by this
> change.  Perhaps the change to Documentation/git-config.txt in this
> patch needs to be a bit more detailed?

We can squash this into PATCH 1:

--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -209,7 +209,9 @@ $XDG_CONFIG_HOME/git/config::
        Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
        or empty, $HOME/.config/git/config will be used. Any single-valued
        variable set in this file will be overwritten by whatever is in
-       ~/.gitconfig.
+       ~/.gitconfig. Support for this file was added after Git
+       1.7.11, so if you sometimes use older versions of Git, it's a
+       good idea not to create this file.
 
 $(prefix)/etc/gitconfig::
        System-wide configuration file.

(If your cristal ball tells you what version number will follow 1.7.11
(1.7.12 or 1.8.0?), we can change "after 1.7.11" to "in X". Do you want
to squash it yourself, or shall I resend?

> Ideally, it would be nice if we could do the usual "advise" thing
> by detecting a possible confusion, but I do not offhand see a clever
> way to do so.

I don't see either, since the advice should be given only to people who
use various versions of Git.

Anyway, I don't think we should bother too much with this: it's really
an opt-in feature, Git will never create the new file for you (it will
only write in it if it exists). So, people potentially harmed by this
change are only those who read the documentation. If the documentation
warns them, I think it's sufficient. It's not very different from any
new feature actually.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
