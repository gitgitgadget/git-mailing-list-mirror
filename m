From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Error:non-monotonic index after failed recursive "sed" command
Date: Mon, 14 Jan 2013 13:06:16 +0100
Message-ID: <vpq38y42clj.fsf@grenoble-inp.fr>
References: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: George Karpenkov <george@metaworld.ru>
X-From: git-owner@vger.kernel.org Mon Jan 14 13:06:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuioO-0004v1-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 13:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120Ab3ANMGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 07:06:24 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43113 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756103Ab3ANMGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 07:06:23 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0EBtf5Q020708
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 14 Jan 2013 12:55:41 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Tuinw-0004AZ-E1; Mon, 14 Jan 2013 13:06:16 +0100
In-Reply-To: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com>
	(George Karpenkov's message of "Mon, 14 Jan 2013 22:40:31 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 14 Jan 2013 12:55:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0EBtf5Q020708
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1358769343.78604@bciutgqOWvJaQx1JRgD40g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213483>

George Karpenkov <george@metaworld.ru> writes:

> Hi All,
>
> I've managed to corrupt my very valuable repository with a recursive
> sed which went wrong.
> I wanted to convert all tabs to spaces with the following command:
>
> find ./ -name '*.*' -exec sed -i 's/\t/    /g' {} \;

Clearly, this is a dangerous command as it impacts .git/. However, Git
partially protects you from this kind of error, since object files and
pack files are read-only by default.

My obvious first advice is: make backups of your corrupted repository.
Yes, I said backup_s_, better safe than sorry.

Then, the errors you get are in *.idx files, which are basically index
for pack files, for quicker access. You can try removing these files,
and then running "git index-pack" on each pack file, like

$ rm .git/objects/pack/pack-*.idx
$ git index-pack .git/objects/pack/pack-4745076928ca4df932a3727b8cc25e83574560bb.pack                        
4745076928ca4df932a3727b8cc25e83574560bb                                                              
$ git index-pack .git/objects/pack/pack-c74a6514f653d0269cdcdf9c1c102d326706bbda.pack
c74a6514f653d0269cdcdf9c1c102d326706bbda

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
