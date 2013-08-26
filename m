From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after non-dumb push
Date: Mon, 26 Aug 2013 10:48:50 +0200
Message-ID: <vpqhaeckfbh.fsf@anie.imag.fr>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
	<CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
	<vpqbo4o3jba.fsf@anie.imag.fr>
	<CAMP44s281qkdMXUM-2P6T+emFajASX6Jyj4nk8_cU5xYJYvdLA@mail.gmail.com>
	<vpq8uzr5y4v.fsf@anie.imag.fr>
	<xmqq61uumnsz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 10:49:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDsTz-0002Lf-6S
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 10:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab3HZItC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 04:49:02 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49829 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555Ab3HZItA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 04:49:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7Q8moaI024820
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Aug 2013 10:48:52 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VDsTj-0001XN-0i; Mon, 26 Aug 2013 10:48:51 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Aug 2013 10:48:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7Q8moaI024820
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378111732.79403@rREBXSCRL7tZM45PsT2bgQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232987>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> How would I do that? The update to the remote namespace is done by Git,
>> not by the remote-helper.
>>
>> OK, I'm now convinced that my solution is the right one. The
>> alternatives are far more complex and I still fail to see the benefits.
>
> Sounds like a plan, even though it smells like the "update is done
> by Git" that does not have any way to opt-out may be the real design
> mistake and your "solution" is a work-around to that.
>
> Would it be a possibility to make it tunable, perhaps by introducing
> a capability on the remote-interface side that allows you to tell it
> not to mess with the remote namespace?

Ideally, it would be possible to ask for a non-update without a fatal
error on old Git versions, but this is not possible (hence, my fix is
the "portable" one, that works on Git 1.8.4).

But that's probably the best we can do now.

> If we were doing this from scratch, I would suspect that we would have
> made the capability work the other way around (Git does not do the
> update by default, but helpers c an ask Git to do so).

Not updating was the default until 664059fb62 (i.e. until 1.8.4), so the
default already changed once. I tend to agree with Felipe that doing the
update by default makes sense.

git-remote-mediawiki is kind of a special case, as the remote side uses
a very different data model, hence it can make sense to export+reimport
to get locally what the remote side received. But when interacting with
something closer to Git (bzr, hg, ...), the mapping should be close to
1-1 and re-importing wouldn't make sense.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
