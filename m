From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] interpret-trailers: add option for in-place editing
Date: Mon, 11 Jan 2016 18:24:25 +0100
Message-ID: <vpqpox82fna.fsf@anie.imag.fr>
References: <1452519213-1819-1-git-send-email-tklauser@distanz.ch>
	<1452519213-1819-3-git-send-email-tklauser@distanz.ch>
	<vpqziwc3wjv.fsf@anie.imag.fr> <20160111171345.GA26950@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:31:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIgJ7-0002yV-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933347AbcAKRbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:31:00 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35303 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932690AbcAKRa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:30:59 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u0BHONBC024037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 11 Jan 2016 18:24:23 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u0BHOP6g003353;
	Mon, 11 Jan 2016 18:24:25 +0100
In-Reply-To: <20160111171345.GA26950@distanz.ch> (Tobias Klauser's message of
	"Mon, 11 Jan 2016 18:13:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jan 2016 18:24:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u0BHONBC024037
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1453137867.62724@E/ZhU8E40L+6gIxbHMClQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283680>

Tobias Klauser <tklauser@distanz.ch> writes:

> I'm using a static global in order to have it automatically zeroed out
> and according to the documentation in tempfile.h it can be reused. Also,
> all other users of struct tempfile (except for lockfile.h) are using it
> this way.

It seems I hate global variables more than other Git contributors ;-).
Anyway, OK with this.

> According to the comment in tempfile.h an atexit(3) handler is installed
> by prepare_tempfile_object() (which in turn is called by
> x?mks_tempfile_*) which will remove the file in this case. Or did I miss
> something here?

You didn't, I wasn't aware of this atexit handler.

>> It may help the user to get "could not rename temporary file %s to %s"
>> in case this happens.
>
> I think if we keep the current semantics (where the tempfile will be
> deleted by the atexit(3) handler), it doesn't make sense to mention the
> filename in the error message as the file will be gone by the time the
> user has any chance to react. I'd suggest somethin like "could not
> rename temporary file to %s".

Good. The important bit is to tell the user which file.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
