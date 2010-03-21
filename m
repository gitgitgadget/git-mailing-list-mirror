From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sun, 21 Mar 2010 14:03:07 +0800
Message-ID: <41f08ee11003202303h7f3743c0j7ed0c379e1acc97c@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <alpine.DEB.1.00.1003201209260.7596@pacific.mpi-cbg.de>
	 <41f08ee11003200610n2c7c9684l6ca200cffdfdb434@mail.gmail.com>
	 <7vaau3ruhc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 07:03:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtEFz-0004Bn-Cc
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 07:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101Ab0CUGDK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 02:03:10 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:53584 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab0CUGDI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 02:03:08 -0400
Received: by qyk9 with SMTP id 9so2638177qyk.1
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 23:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Eqm1o0TldubH6F31O0iDEutYyHP//siCwCWAVLxsiyk=;
        b=JWUhm4+JjsKN54jtIz7DNLDEFIWP9xXNVy4tPAmBLVvLa9nfrHntdwlKkbtKJLVyqu
         JHnBWor/E5MV8Lk9juE5Y+vTu48N3ES3W5yJLUYb0pk0ZN4bISur6M6EvAXJJVImAz1z
         zbMF9B9BZ+X0ELonK41pHhMTUufFQ2xKpkOpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C6T0MItkmGNW23GCBu/uVFFxJksGt+SYM82MhrZ5nIFLDb8h2QB/Bar1LXj4CBTaGN
         P+2BlbZ5luMyB4Tj1dXuRK1nGABtDc7BvOPSjhclSq2cVNAynvy2X8t4Vy8Gs1gWdjCI
         NRopz8lEAAEbZV0Lp2isNMkqB5sZT4fibnY6Q=
Received: by 10.229.10.132 with SMTP id p4mr994158qcp.86.1269151387678; Sat, 
	20 Mar 2010 23:03:07 -0700 (PDT)
In-Reply-To: <7vaau3ruhc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142790>

Hi Junio,

   Thank you very much for your advice.
>
> If you are hooking into "git log", it already has "-M / -C / -C -C" a=
s a
> notion to express "different levels of digging" to find code movement=
 and
> copies, and so does "git blame". =A0You probably will save a lot of t=
ime if
> you studied the current blame implementation thouroughly before desig=
ning
> or coding.

Yes, both blame and log has such '-M/-C/-C -C/' options.  But the
meaning are not very same:
=46or 'git log': -M is used to detect file rename, -C is used to trace
code copy. Both options accept no argument.
=46or 'git blame': -M is used to trace code move, -C is used to trace
code copy. And both options accept a <num> which specify the lower
bound of the 'same code characters'.
And, I think the line-level history tool act more like 'git blame'.
So, the '-C' option for 'git log' is exactly what we need but '-M' is
not. So, I think, maybe we should add another '-m' option to 'git log'
for line-level code movement detect.

I have make a rough look over blame.c, it is really very helpful and I
find I can borrow some code from 'git blame' to make the line-level
history browser.

Thanks a lot!

>
> Two things that you need to think about carefully is why "blame" stop=
s at
> the commits it shows, and if you could "peel" these lines in its outp=
ut to
> peek what are behind the lines, what you would see. =A0This is not a =
rocket
> science topic, but it is not entirely trivial.

I think blame's purpose is to find who is responsible for which line
of code. So, it stop after it find the origin of the code. And
line-level history browser will continue back into more history on
what blame got, it will find what the line should be before this
commit, and go backward the history based on the origin line to get a
more old status and go on again. Simply, it is something like 'git
blame' recursively. :)

Thanks again for your advice, I get too much from your feedback, thanks=
!

Regards!
Bo
