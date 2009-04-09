From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Thu, 9 Apr 2009 15:59:04 -0500
Message-ID: <b4087cc50904091359q7cadc31cp150b2681775e7022@mail.gmail.com>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
	 <20090409081443.GB17221@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0904091342170.6741@xanadu.home>
	 <7vskkh1va5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 23:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls1Mw-0007ed-Tw
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 23:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759727AbZDIU7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 16:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755599AbZDIU7J
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 16:59:09 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:52799 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZDIU7H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 16:59:07 -0400
Received: by qyk16 with SMTP id 16so1734039qyk.33
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oVIFqazVqT6bAgoewVqu8cDDLqUD/AjoGklekKEotlw=;
        b=kALjv7gcpNNi4bgVNe3cpcd+DTFzbCRRc9iua14T+cXnCeoIiVwC+J+RWus7OopNxr
         +aUqru3Y+QIisidLprOFHX5SN0DoX7OAet6gTJJPgEtSs/pOcfFpMwnlq7weJYQKVyLI
         ClluKAGTyGB1rcVb2bV8D1bpW3pCtKkpDUc7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=at1kIxCa0f2VDAEQ+8T/la0fZLKDxOhqNWRMA4LVUQglLIlVIVDcug8qdNV5ptze0T
         3B+xjfdWknDGaEHVuqdwfAUi/8IqdVcp8O3skgp7vA0Iqt2OBjYVbjzAeurJ7pVzMBp4
         5UO3brMMCPOZ9H6CfsKV303HBs6tPiUQKW660=
Received: by 10.224.74.16 with SMTP id s16mr3448297qaj.320.1239310744391; Thu, 
	09 Apr 2009 13:59:04 -0700 (PDT)
In-Reply-To: <7vskkh1va5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116207>

>> My ISP doesn't allow me to send more than 20 emails at once.
>
> Hmm, I first thought you meant 20 emails in a single smtp session, bu=
t it
> appears that we create a new instance of Net::SMTP for each piece of =
email
> so it really sounds like it is time based (N pieces of e-mail within =
M
> minutes).

Actually, there is a lot of ||=3D going on in there, so it would seem
that only one
smtp session is created; the weird thing is that STARTTLS and $smtp->he=
llo() are
run each time through send_message(), which I think is probably wrong.
If it works,
then I imagine it's just superfluous.

In any case, if his ISP doesn't like him sending more than 20 emails
per session,
then it certainly won't like 1 session per email.

> Perhaps --pause=3DN,M to say "Pause N seconds for every M messages", =
where
> Michael's --delay=3DN is just a shorthand for --pause=3DN,1 is what y=
ou want?
> That is, reset the counter to 0 at the beginning, increment it after
> sending each message, and when the counter is M and if you have more =
to
> send, you wait for N seconds and reset the counter to 0. =A0Then when=
 you
> have a series smaller than 20 you won't have to suffer from any artif=
icial
> delay.

This sounds reasonable, but I would have:

    --rate=3DM/N

Michael Witten
