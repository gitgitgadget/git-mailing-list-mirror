From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [HELP] Corrupted repository
Date: Sun, 23 Jun 2013 19:48:17 +0200
Message-ID: <vpqwqpk4t26.fsf@anie.imag.fr>
References: <CALkWK0mQj+x3bxbxWKuwpeMj8E8bfvyK-c2bAWna6a9Xe=nBOQ@mail.gmail.com>
	<7v7ghno2lz.fsf@alter.siamese.dyndns.org>
	<CALkWK0mTZqtGFp-BW9XBjX4Cm2hCZ1=P5M0a4cMBuE0v__LpZw@mail.gmail.com>
	<7vzjujl267.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 19:48:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqoOv-00038T-Ut
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 19:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab3FWRs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Jun 2013 13:48:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60495 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab3FWRs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 13:48:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5NHmFJN001540
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 23 Jun 2013 19:48:15 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UqoOf-0002Ns-LJ; Sun, 23 Jun 2013 19:48:17 +0200
In-Reply-To: <7vzjujl267.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 21 Jun 2013 12:00:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 23 Jun 2013 19:48:15 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228747>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>>>   $ ~/src/git
>>>>   error: object file
>>>> .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f is empty
>>>>   error: object file
>>>> .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f is empty
>>>>   fatal: loose object 8e6a6dda24b017915449897fcc1353a9b848fd2f (st=
ored
>>>> in .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f) is corr=
upt
>>>
>>> So fsync() and close() thought that the filesystem stored this loos=
e
>>> object safely, but it turns out that the data is not on disk.
>>
>> Where should I start digging if I want to fix this?  Actually you ju=
st
>> need to tell me how to build reduced-case corruptions to test: I can
>> trace and figure out the rest.
>
> That is a trip in the kernel source, isn't it?  I cannot be your
> guide there.

Not necessarily. AFAICT, Git won't fsync object files by default, but
does for pack files (to make sure the pack is written before unlinking
the object files being packed):

       core.fsyncobjectfiles
           This boolean will enable fsync() when writing object files.

           This is a total waste of time and effort on a filesystem tha=
t
           orders data writes properly, but can be useful for
           filesystems that do not use journalling (traditional UNIX
           filesystems) or that only journal metadata and not file
           contents (OS X=E2=80=99s HFS+, or Linux ext3 with "data=3Dwr=
iteback").


--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
