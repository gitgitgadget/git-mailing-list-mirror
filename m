From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 1/2] Add a basic idea section for git-blame.
Date: Thu, 8 Apr 2010 22:11:55 -0700
Message-ID: <x2z41f08ee11004082211g6ae76f38ic1ee65e508b16343@mail.gmail.com>
References: <1270709490-19163-1-git-send-email-struggleyb.nku@gmail.com>
	 <1270709490-19163-2-git-send-email-struggleyb.nku@gmail.com>
	 <7vmxxe74s2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:12:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O06Vy-0003vk-5E
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab0DIFMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 01:12:00 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:38156 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab0DIFL5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 01:11:57 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1079963qwh.37
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 22:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h16huxL8iARzHS+t9nKdLEFJhbkufNFrxo2q+/wHzmE=;
        b=eFgGj7zISXm5U8JZqSFe2KVyKBuIYhpVN2Wk2wiYmFt/4/tXZQopXC3OmNEQLdsiBp
         +SFAT4qfzixvWziiEU7w51TcZRpzdcI0EHDUQ/fCoHaZNfgkcR4zuBp7JS47vQrtDnMH
         pLPx7CtS7+dsRf7YxHgSVRQaa2+rkv7/p43pI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ghwLDPxGJSd8xqThxpihhpAKXJbCsI2KZGNSmQ9wTfFPTvKnIsx1D0sJSKka9GSIzj
         zGTJSodIVmPZd6tFkSli7G2jyrXarKlPXsGt+QwBRyr88Yp6NyQrXq2J69vJSEcB4wsY
         JU8nslHWX0kL+YswS/GrgMSN5rzhL+6R8yLb4=
Received: by 10.229.95.147 with HTTP; Thu, 8 Apr 2010 22:11:55 -0700 (PDT)
In-Reply-To: <7vmxxe74s2.fsf@alter.siamese.dyndns.org>
Received: by 10.229.190.213 with SMTP id dj21mr929940qcb.66.1270789916053; 
	Thu, 08 Apr 2010 22:11:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144402>

Hi Junio,
On Thu, Apr 8, 2010 at 1:00 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> The name of the game is not "take blame by looking at the diff to see=
 what
> we introduced"; it is "avoid taking blame at all cost, by looking at =
the
> diff to see what we might have inherited from our parents".
>
> A description closer to the truth would be:
>
> =A0- Look at output of "git diff <rev>^$n <rev>" for each parent ($n =
runs
> =A0 from 1 to number of parents);
>
> =A0- Ignore all +/- lines. =A0The context ' ' lines and lines outside=
 of diff
> =A0 hunks are known to have been inherited from $n-th parent and they=
 are
> =A0 not our fault. =A0We can happily pass blame for these lines to ou=
r
> =A0 parent.
>
> =A0- Do the above for all the parents. =A0We (grudgingly) take blame =
for lines
> =A0 that we failed to find corresponding lines in our parents.
>
> The -M option affects what happens between the second and the third s=
tep.
> We try to see if the lines that we did not pass blame to <rev>^$n mig=
ht
> have come from <rev>^$n by running diff between the remainder and the=
 blob
> in <rev>^$n *again*. =A0This lets us catch code movement within the b=
lob,
> hence the name of the option -M.

I think here, not only the code movement, but also the copies will be f=
ound too.
Please correct me if I am wrong here. :-)

> The -C option affects the choice of the blob in <rev>^$n. =A0Usually,=
 we
> internally run an equivalent of "git diff -M <rev>^$n <rev>" to notic=
e
> that the file F that we are analyzing used to be called F' in $n-th
> parent, and run the diff against it, but -C allows us to check with p=
aths
> other than that, and additional -C enlarges the search space. =A0This=
 is to
> notice code movement (with a single -C) or copies (with more -Cs) acr=
oss
> paths.
>
> For illustrated description, read the classic:
>
> =A0 =A0http://thread.gmane.org/gmane.comp.version-control.git/28826

Thanks a lot for providing this reference. It really helps me too much
to understand how blame works. I will try to re-read the whole code
according the description here. ;-)

Regards!
Bo
