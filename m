From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Thu, 17 Jan 2013 07:09:16 -0600
Message-ID: <CAEUsAPYAL6TD_nzu-YumRK_b-kFy7mNz1VivmSxGeuFYVxVL4g@mail.gmail.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
	<DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
	<7vsj61xez2.fsf@alter.siamese.dyndns.org>
	<7vobgpxeel.fsf@alter.siamese.dyndns.org>
	<CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com>
	<7vehhkuwg5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 14:09:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvpDv-0007bw-L1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 14:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258Ab3AQNJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 08:09:19 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:62260 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955Ab3AQNJS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 08:09:18 -0500
Received: by mail-la0-f49.google.com with SMTP id fk20so2625009lab.36
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 05:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=qzbW+YZ8e9khzFUNSptANaDNFBRLyZ9wjlUhDvK/B0A=;
        b=jPeCM96ixD9Qzdz5dbD/ZXtjkHvHP5UErHAbzbmpLqJ4q/Szo8H0UrnHmQyaAu4E0Q
         AOaa2ibWsa3lGnpza9hzh26RRRZIecKc0Jl7bJJaL1X4VElSPk/L8f0nzgk7gvkqITmd
         +9lgbSLJ42abD7dQpUIjjrKjqaZCVR5UE23KdjbRLArQ2EN54RH8S1WJ4NsSTfB/MLT5
         j7LNcds7CaDmubyrglnTUoHqrQ+auyyga2PHzmp/TM0bxHWaQ7dn2cnRyOGEGcbA6PtO
         /3SbTG9d0RyE/8h1MdYW0I52/m/bQR2HOkWUYCiBzriPmjbCofG+oQRFLKtAvFwiSOjJ
         X/OA==
X-Received: by 10.112.50.205 with SMTP id e13mr2185991lbo.57.1358428156993;
 Thu, 17 Jan 2013 05:09:16 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Thu, 17 Jan 2013 05:09:16 -0800 (PST)
In-Reply-To: <7vehhkuwg5.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: QRK7kXvoyHhXmGKVj6ToHTaP9po
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213851>

On Thu, Jan 17, 2013 at 12:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Rorvick <chris@rorvick.com> writes:
>
>> On Wed, Jan 16, 2013 at 10:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> It is fine when pushing into "refs/tags/" hierarchy.  It is *NOT*
>>> OK if the type check does not satisfy this function.  In that case,
>>> we do not actually see the existence of the destination as a
>>> problem, but it is reported as such.  We are blocking because we do
>>> not like the type of the new object or the type of the old object.
>>> If the destination points at a commit, the push can succeed if the
>>> user changes what object to push, so saying "you cannot push because
>>> the destination already exists" is just wrong in such a case.
>>
>> So the solution is to revert back to recommending a merge?
>
> Of course not, because at that point you may not even have what you
> were attempting to overwrite.  Nobody says it is even something you
> could merge.

I was referring to your concern about rejecting based on type.  A push
causing a reference to move (for example) from a commit to a blob is
rejected as "already exists" with this patch.  You emphatically state
this is not OK and your solution is to revert back to behavior that
advises a merge.

Clearly the bug regarding an 'old' unknown to the client should be
fixed.  This is a obvious test case I should have covered and it's
unfortunate it made it into master.  But I don't understand why
is_forwardable() was misguided (maybe poorly named) nor why
ref_newer() is a better place to solve the issues it was addressing.

Chris
