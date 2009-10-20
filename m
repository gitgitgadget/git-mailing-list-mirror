From: Eugene Sajine <euguess@gmail.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 18:14:08 -0400
Message-ID: <76c5b8580910201514sc44f1cag222cf8a3710c875@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
	 <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
	 <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
	 <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
	 <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
	 <7veioxn6ee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Eugene Sajine <euguess@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 00:14:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0My8-0003zn-VB
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 00:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbZJTWOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 18:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbZJTWOG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 18:14:06 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:44991 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbZJTWOF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 18:14:05 -0400
Received: by gxk4 with SMTP id 4so5179013gxk.8
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RaOPBHT2mB4eamj0wJqovvIRJuUysn+L5hIpThL2gbs=;
        b=EMlCtJBTLnr9OYzIdvOFfsUi/w7qduizUWMr3QidfBSvb8g3MdjlsRvwQINAYaoRij
         i/rr2QBiU+WP75/IpmQ4nngcya3zDnLCBNqkw4A5wVpi5TBlHQA9SfUnKgZmMuk9TxQ/
         F+yXD8SRSpN+hYjOFKLgX+XOMLVzxeRf6xvT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jxjLPtYdhZfaLPlFFzF2uQ4XB5YgGIDRei7+VXtp79DRxKu/TuE9a6xhTH7wDBr+/u
         ACpZURBugrI4sYU9NZlz6n0u2JAk4yYnzDGT0M7+MNXNMUUMTiMGsWwuGmmBrCjcwjU6
         QUVdiWviM3cpt5FKOsYBHI4HpT1rh9sS7igDU=
Received: by 10.90.10.9 with SMTP id 9mr7510618agj.69.1256076848750; Tue, 20 
	Oct 2009 15:14:08 -0700 (PDT)
In-Reply-To: <7veioxn6ee.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130858>

> If the project is already arranged to be compiled with decent automat=
ion,
> I do not think you need any change to the workflow.
>
> You would have a version.cc file with
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static char program_version[] =3D "My Prog=
ram " VERSION_STRING;
>
> in it, and teach the build procedure how to compile and link this fil=
e.
> Something like:
>
> =C2=A0 =C2=A0version.o: version.cc
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(CXX) -o $@ -DVERSION_STRING=3D\""$(git d=
escribe HEAD)"\" $?
>

Please, correct me if I'm mistaken and forgive me if I'm not correct
in using C++ terms.

Your solution proposes to have a version file which will carry the
info about last state the program was built from.
But as I understand in case of static linking the executable will get
only obj files from a library, which are necessary and everything
irrelevant will be thrown away by linker. In this circumstances the
program comparing two executable will not notice any differences
between let's say existing production and new development version of
the executable. In case of several libraries linked this gets even
worse. That's what their basis is for keywords expansion use.

If there is no other solution in VCS terms how to understand which
particular version of file has got linked to the executable except
keywords expansion, then I'm talking about the way of reducing the
amount of keywords expanded to a minimum - 1.

If we can agree on this, then it seems that having the content/blob
hash in the file $Id$ is enough to get any other relevant info about
the file.

At least by hash you can find the path added/modified. When the path
is on hands you can easily realize the history for the file. It seems
to me that using content hash will provide unique results enough to
make conclusions, because the probability of having two files with
same hash but different content is too low, and only scenario is to
get the same hash is to get the absolute copy of the file, but such
file existence is questionable...

OTOH, Alex was right that there are situation where this is not
working as expected from the first run:
If the file was modified its blob hash is going to change, but there
will be no entry with letter A in the log. So, if

$ git log --no-abbrev --raw --all | grep "SHA-1 A"

Returns empty string then, we should do that without "A".
As I understand this *second* run should always return:

1. only one entry if this is latest hash - one path. Goal reached.
2. two entries if there was a change afterwards - One path. Goal reache=
d
3. three entries if rename was committed separately and then renamed
file was changed - two paths. Enough to make conclusion about the
files.

In any case the  goal is to get the path as correct as possible and
then proceed with matching and other stuff.


Thanks,
Eugene
