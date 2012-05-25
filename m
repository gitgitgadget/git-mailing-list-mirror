From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fmt-merge-message: add empty line between tag and signature verification
Date: Fri, 25 May 2012 10:20:10 -0700
Message-ID: <CA+55aFwwUzErbcCGa597N4G7i-_mYso+aJO_0aRq0jNBOi9=ew@mail.gmail.com>
References: <alpine.LFD.2.02.1205250850001.19607@i5.linux-foundation.org> <7vtxz4tcmn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 19:20:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyBp-0004Ct-NA
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab2EYRUd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 13:20:33 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48916 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab2EYRUc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 13:20:32 -0400
Received: by wibhj8 with SMTP id hj8so7145486wib.1
        for <git@vger.kernel.org>; Fri, 25 May 2012 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0eE3FLekCTB2q53+moU9RthwBC6YVJMVocgOWbyOPfk=;
        b=W923h3FipkJNjnkH/nMDkjSbElMaGu5sYTGUHIAVYpgFhgP8/aw+QLnNF/xBQkngmI
         0VNsGW/cpQi/U872b+depIItPWKdjpkazFhzmsW9gK5sk0IAmHWRrRobHGYz5W2I7sct
         A8NqIknWxmjUaYwZIlkoQcywht93xBs4t3tYHmm/21oWPiFRZxoZ5Qe8DUIdoHEHQhn3
         ggBAv+We41RL5iWMbiGY8s+meSnUbtqYH++VnrVfQ3HeoVy1515sgfWudqqFXIqu8ox8
         YTRUhGoUrRBk/RPCiIUqxlhy/Yz1tGNFNR3nIGjhi1v6QCVfv/biOhBzIbaFyZ5a5cPr
         1oAQ==
Received: by 10.216.218.220 with SMTP id k70mr2126295wep.165.1337966431143;
 Fri, 25 May 2012 10:20:31 -0700 (PDT)
Received: by 10.216.225.99 with HTTP; Fri, 25 May 2012 10:20:10 -0700 (PDT)
In-Reply-To: <7vtxz4tcmn.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: PR2WegK2uh_NVVQaxDES1WtEPNc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198486>

On Fri, May 25, 2012 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
>> Btw, I'd also like to see the merge notes (notably the conflict file=
 list)
>> before the generated shortlog, but that seems to really not work wit=
h the
>> current fmt-merge-message model. =A0Oh well.
>
> Postponing to assess if such a change is feasible, I am not sure if t=
hat
> ordering makes more sense than the current one. =A0Is the objective t=
o more
> strongly motivate people to explain what happened to the conflicts?

Yes. Right now, the conflict line is hidden way at the bottom, and
I've actually overlooked it several times (and I don't think I'm the
only one - do "git log --grep=3DConflicts:" on the kernel tree and
you'll see a lot of people just leaving them be).

And even when I *don't* overlook it, it's actually annoying to go to
them and edit them. They're not at the very end (that's the big
comment about merging), and due to the shortlog the conflicts are
usually listed at least one screenful down.

And if you *don't* edit them, they end up pretty ugly and useless. I
like to at the very least make them a bit more compact and readable,
ie something like

    Fix up trivial conflicts in arch/arm/mach-ux500/{Makefile,board-mop=
500.c}

instead of listing them individually, but preferably actually talk
about what the conflicts were about, eg

    Fix up add-add onflicts in arch/x86/xen/enlighten.c due to addition=
 of
    apic ipi interface next to the new apic_id functions.

which I think makes it more worthwhile to talk about the conflicts.

In fact, I think that if you *don't* edit them at all, you might as
well just leave the conflict data out entirely, and it might be worth
making the automatic conflict information be commented by default. But
then it *really* needs to be above the shortlog so that it's not
hidden away.

That said, this is all "minor tweaking". The current thing certainly
works. I just think it could be better. Clearly a lot of people do not
edit the conflict information even when it is right there (see the
same "git log --grep" above), and it looks like I'm sadly alone in
trying to make good merge messages.

                   Linus
