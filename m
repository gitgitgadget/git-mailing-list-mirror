From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix for a merge where a branch has an F->D transition
Date: Wed, 13 May 2009 08:38:53 +0200
Message-ID: <81b0412b0905122338q774454cj65edfde3d73948e3@mail.gmail.com>
References: <81b0412b0905110242u3624f0eeyc0dc9b2b987bfa2b@mail.gmail.com>
	 <20090511192536.GA1485@blimp.localdomain>
	 <7v63g57ce4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 08:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M487M-00013z-Ek
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 08:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbZEMGiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 02:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbZEMGiy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 02:38:54 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:49959 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbZEMGix convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 02:38:53 -0400
Received: by bwz22 with SMTP id 22so434970bwz.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CAZHhEf111CEsmgIrgmbQr8yH6ARQlXbIXdPMH8KUbc=;
        b=bP9JNQWQWG7Wr3181e0IP/uzJP3LQKJ3aWQM8XVwgJYtTh+DsRKitrKZbSldaj3vV0
         iCYCHKMxuQ5JVbxHI6WTnwm8cr9XbWyR4rMgeJMXrvpjFOY5Ko78ul4yekIgu3NxN7/i
         vUScpkrRYYhOEm+yBZeyO5yElxX9BpxtgC1uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DMx7Ek+pfxvaOa8IiXonXXZStD5SaF8ql13xnaTMAy7y9QoAHuGKRomN/uqHw8s15L
         7s5BQu1JkpCJbAz0HfgUTrSL13TgsmoWTpLxQYoBiRXMOX7yHHpq2aEg6V8EV+Sm70ZE
         1/+bC3SeRE3xY/c31HW2YIhbppVdImn7Wh7mg=
Received: by 10.204.31.78 with SMTP id x14mr598053bkc.3.1242196733346; Tue, 12 
	May 2009 23:38:53 -0700 (PDT)
In-Reply-To: <7v63g57ce4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118987>

2009/5/13 Junio C Hamano <gitster@pobox.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>> Frankly, I'm not really sure. The solution came largely ... empirica=
l
>> way. IOW, I tried more or less random things which looked like they
>> should fix the problem. So a review is very much appreciated. Please=
=2E
>
> I've always thought that D/F conflict logic in merge-recursive is pla=
ced
> at the wrong processing phase. =C2=A0IIRC, it enumerates potential D/=
=46
> conflicting paths before even attempting to process renames, and it i=
s
> easy to miss a path that was previously file going away as the result=
 of a
> clean merge (in which case it is ok to have a directory there as the
> result of a merge for other paths). =C2=A0This breakage could be a sm=
all
> example of it.
>
> Regardless, I think your patch is a reasonable fix to go to the
> maintenance track. =C2=A0Thanks for looking into it.

I'm afraid the fix is not that simple: the "if" branch where the change
is placed supposed to prevent updating files in the working tree
which already have the same content as the merge's output.
My change may force them to be updated regardless. I think...
Johannes, you know this area the best, could you please have
a look?
