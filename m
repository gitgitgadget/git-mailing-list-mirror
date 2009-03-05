From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: orthogonal cases of log --date option
Date: Thu, 5 Mar 2009 16:04:44 -0500
Message-ID: <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
	 <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
	 <20090305104304.GA17760@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 22:06:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKlj-0005Sc-Sn
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 22:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbZCEVEr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 16:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbZCEVEr
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 16:04:47 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:51181 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbZCEVEq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 16:04:46 -0500
Received: by rv-out-0506.google.com with SMTP id g9so130484rvb.5
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 13:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eTtE1fUct3fKQ84AuG5B1wtsC43E3wCEoPSMqmyiZ14=;
        b=gZ8j5nuA+ZNt9T4uLZPLByKKY64nU2b9pN8MpQSxC9Agk3WgjzgrfcPCLl4Qg3ze3O
         4gY2OWa63NgjXYVxTMhtNUQjstDUU5sVmaW3UBFtWYWMBu423AVZJVJ1V8j1Pquf9UYV
         fgF8gfP7vxRfF3tEngujUDd2KVLr0NkV+t5s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LL1JqvO3v7tegUbXft4yjC97odqH7XxbSBQ4zJyMUKda30pwAwOJNqI7Aky33aDW3b
         zg9geGeKfHBzT8/5T2GUotqYntLQWFcGhiNIjokLs1RHnFUhbWw/SWfQ4IdZckYpBYHV
         rMp6RjcadIH7ZJ7eAXNtgdnx5PXgamHM7Dpow=
Received: by 10.140.250.14 with SMTP id x14mr853448rvh.79.1236287084880; Thu, 
	05 Mar 2009 13:04:44 -0800 (PST)
In-Reply-To: <20090305104304.GA17760@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112344>

On Thu, Mar 5, 2009 at 5:43 AM, Jeff King <peff@peff.net> wrote:
>> But this patch may help you get started.
>
> FWIW, I think this is the wrong direction. You are working around the
> lack of orthogonality in the interface by tweaking things in the
> implementation. I think you are better to fix the interface, but supp=
ort
> --date=3Dlocal for historical reasons. IOW,
>
> =C2=A0git log --local-dates --date=3Dshort
>
> with
>
> =C2=A0git log --date=3Dlocal
>
> as a historical synonym for
>
> =C2=A0git log --local-dates --date=3Ddefault
>
> This makes the interface simpler to understand: --date remains a
> selector, and --date=3Dlocal is a special case that new people don't =
need
> to think about or understand.

I started to pick this up and I want to clarify what you meant by
interface. Was it the CLI you had an issue with? Because that I
understand and it's easy to support the CLI changes you outline above.

Or did you have a problem with how Junio was going about passing along
both bits (i.e. 1. date format; 2. local or not) in an enum? Because I
have to tell you, I started looking at what it would take to switch
the enum to something like:

struct date_mode {
	enum {
		DATE_NORMAL =3D 0,
		DATE_RELATIVE,
		DATE_SHORT,
		DATE_ISO8601,
		DATE_RFC2822,
		DATE_RAW
	} format;
	unsigned int local;
};

It's a significantly more invasive change.

j.
