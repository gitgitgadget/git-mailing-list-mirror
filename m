From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: notes metadata?
Date: Mon, 8 Feb 2010 11:32:08 +0100
Message-ID: <cb7bb73a1002080232u24d74997r1ec4c9a4068b7282@mail.gmail.com>
References: <cb7bb73a1002070350j750287abl43de4d936a47acef@mail.gmail.com> 
	<201002072357.24021.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>, Jeff King <peff@peff.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 11:32:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeQuz-0007Gm-Bw
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 11:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab0BHKca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 05:32:30 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:38399 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab0BHKc3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 05:32:29 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1274469eyd.19
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 02:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tYHja8emFy2slS3CxG4FmSlIkviBMg6fr0F0cQD9g7w=;
        b=njZ59c/GR7zqrPToQg3NN5IDoUK8fVEiai6294/t1hl7hIWbBmG0dAZ5Ud/RTWGZeR
         UlkedVAmS9v+VBi6rcA3gpfQCIIt9hkrcs+aEhseC3c+/63o4kLSGUej5kPzY0OPAuBT
         1s1KGH3mNvNCouqBD91gxqKRAuql6eU0IPvAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eOf8GyrYLWhusc0D/HZ1eSE0p8QvZSEzG1QVRATwXcOMhk0kHd9MJ8RFXrGxM9kOIb
         rAuAjFhjbwWHxRVKkX2B0jrIaYkEjdfqglcFMYzfzLirurAxAK9Sw2+GJ8yVoVz2ayQj
         5kQA56BM010Kld2aWsewnss6Q6vqXiajFqK4U=
Received: by 10.213.50.67 with SMTP id y3mr2612309ebf.31.1265625148143; Mon, 
	08 Feb 2010 02:32:28 -0800 (PST)
In-Reply-To: <201002072357.24021.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139284>

On Sun, Feb 7, 2010 at 11:57 PM, Johan Herland <johan@herland.net> wrot=
e:
> On Sunday 07 February 2010, Giuseppe Bilotta wrote:
>> Hello all,
>>
>> ok, this may sound a little odd especially with the 'notes vs
>> metadata' thread going on, but I was wondering: do we store _any_ ki=
nd
>> of metadata _about_ the notes themselves? If I'm reading the code
>> correctly, we have neither author nor date information about the not=
es
>> themselves, so we don't know who added them or when. Is it too late =
to
>> suggest that this kind of metadata be added to notes? Making them
>> full-blown commit-style objects is probalby overengineered and wrong
>> under many points of view (not to mention probably incompatible with
>> current storage), but maybe we can set up a convention that notes
>> SHOULD be in pseudo-mbox format? This would mean that when a note is
>> created, the template starts with a 'From ' line including the user'=
s
>> name & =A0email and note creation date; when editing, the note is ag=
ain
>> augmented with the new author name email and date. Of course the use=
rs
>> are then free do expunge the From lines if they don't want it (just
>> commenting it would be enough, of course). How does the idea sound?
>
> NAK
>
> Notes are stored in a notes tree that is changed by making commits on=
 the
> notes ref (see commit_notes() in builtin-notes.c in 'pu'). The commit=
s on
> the notes ref are regular commits with the usual commit metadata (aut=
hor,
> date, etc.), so if you're interested in who/when a given note was wri=
tten,
> you can simply point 'git (gui) blame' at the notes tree.

Yup, I was totally overseeing the obvious thing about the notes
commit, and up until this morning I thought that settled the issue.

However, this morning I read Junio's posts about the issue of merging n=
otes
http://permalink.gmane.org/gmane.comp.version-control.git/139252 and
thought that this might be a possible solution.

Junio's root issue is basically that you can only have one note per
commit per namespace, and that normally notes from different
developers grow from different root commits and are thus unmergeable.

I see two possible solutions to this:
 * one is to allow more than one note per commit per namespace, which
moves a little towards the 'note as a tree' idea, but with severe
restrictions (the tree would be flat and each blob in it would be a
note)
* the other is to keep the notes as single files, but give them a
little bit of structure to make merging easier: my mbox-style idea
would of course only be an idea, but in general by keeping the notes
'sectioned', merging could be reduced to concatenation most of the
times. The mbox approach also has the benefit that you'd have more
information about the single section, so that you could for example
keep them sorted etc.

Just brainstorming here, so feel free to tear down this idea too 8-)

--=20
Giuseppe "Oblomov" Bilotta
