From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: git-am: less strong format "mbox" detection
Date: Tue, 14 Jul 2009 14:23:54 +0200
Message-ID: <20090714122354.GA13806@vidovic>
References: <bb3a84e2b817268a88832dc7043383e4b91a3df3.1247553623.git.ni.s@laposte.net> <cb7bb73a0907140016r4807c008h9c98f76200e9c3a5@mail.gmail.com> <20090714082059.GA13808@vidovic> <7v8wirirki.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 14:24:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQh3J-0006iz-L2
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 14:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbZGNMYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 08:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbZGNMYC
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 08:24:02 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:50485 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbZGNMYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 08:24:01 -0400
Received: by ewy26 with SMTP id 26so3216317ewy.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Cs9/igt7JOonwVJyersWqzakUlibaWX/nrT0EK+Afh8=;
        b=n4wrMVuVTZLOOAkgIt62CTkAJxyB/HL5UI8SiPlPD1HgSzs2vWyd5RbAwBOxA7Y5JP
         i69R0qJ2xCSFw5dTChiG3wsDw+vth6t8ojs3YD4ojaNjFw48N8k/Y0dKvDgZ4W+FGluj
         sLNuaHyFKs7NkSC7heYEI/m6EH6fsfoCHINEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LoJzL8JeNzHklmeJ5FNjia8Pscw5HLfXu5IpU18XwPaJ6AZuqmDuI0YIJRySm+skHR
         5ycMEL/5NQTqkBcq/yZ1xTGupDpEutcc59NBp800AC1innGVoZpBIPevIrWoWx4UhbCt
         R2T621QnS+ahc8Cg3Z2xibwDC8fZRNAatmxe4=
Received: by 10.211.178.12 with SMTP id f12mr7718728ebp.83.1247574239908;
        Tue, 14 Jul 2009 05:23:59 -0700 (PDT)
Received: from @ (91-165-132-96.rev.libertysurf.net [91.165.132.96])
        by mx.google.com with ESMTPS id 7sm543759eyb.25.2009.07.14.05.23.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Jul 2009 05:23:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8wirirki.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123241>

The 14/07/09, Junio C Hamano wrote:

> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> 
> > And why should we accept "From "?
> 
> You are going totally in a wrong way around with this.
> 
> Berkeley mbox format is what we support, and "From " is the _only_
> delimiter between pieces of e-mail in the file.  We happen to allow "From:
> " in order to merely be extra nice for people who create mbox looking file
> by hand; I think it is an improvement not to require an optional SP after
> the colon there, but that is totally an independent issue.

I see, thank you.

> I cannot offhand say if allowing anything but "From:" is necessarily an
> improvement, or making the format detection unnecessarily risky of
> misidentification.  I do not particularly like the idea of allowing only
> some randomly selected fields like Return-Path and Delibered-To and not
> accepting others, let alone totally nonstandard X-Foo fields.

I'll look at the source closer to know how it can be done the smart way.

As the manual of git-am says it accepts maildir format too (checked
now), we have a regression since

	a5a6755a1d4707bf2fab7752e5c974ebf63d086a

in case of maildir _and_ "verbatim" emails starting with anything else that
"From " or "From: ".

I think the RFC doesn't require any fixed order for the header fields
(will check). So, I'm not very optimist because format detection starts
with

	read l1
	read l2
	read l3

wich doesn't help to make a difference between mailbox and maildir.


-- 
Nicolas Sebrecht
