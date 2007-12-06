From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH] hg-to-git: do not include the branch name as the first line of commit msg
Date: Thu, 6 Dec 2007 14:36:43 +0000
Message-ID: <2faad3050712060636i5eab2169vc4588c075fcd73f1@mail.gmail.com>
References: <4751A036.1080209@gmail.com>
	 <7vsl2jcl32.fsf@gitster.siamese.dyndns.org>
	 <1196949043.5388.18.camel@galileo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Mark Drago" <markdrago@gmail.com>, git@vger.kernel.org
To: "Stelian Pop" <stelian@popies.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 15:37:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Hqg-0001fL-Qe
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 15:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbXLFOgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Dec 2007 09:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbXLFOgq
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 09:36:46 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:40503 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbXLFOgp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Dec 2007 09:36:45 -0500
Received: by wr-out-0506.google.com with SMTP id c49so196778wra
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ghyFkCVagnLFy1Ju0HSPDPGiBxyG+V0THltC/l5DwJk=;
        b=OO4NHd9qFIRBMTt+y7GyjY8sa8ZqFz58/pWqVkDC4/iafA4dp65zhYucFjmkPmHxYwUPPpca83TCFybvGQG6r1nAVW4CvdDUY4To+RA/NgASLkClwTagJyGCe2kFLyjH8gVYC40Ur8z6ieiQWjnZorwS5oYsLKlgtPg3hXCVl98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cFXU+oIscZ7F2ABpaC7D3FFPYG1GGyJbQ98pqfw0U842TiQgBM3OejOCSk0bmR8vd74GSfd0iNN1ItWCF8ttlh8IHSuspYPlSS3JPUve/IqiovrBXCREIm6oJCFK6+q1uLcyyqr1RuW1jNbpWmN2lKrN16842BWBw2x9KRbm7GE=
Received: by 10.142.12.14 with SMTP id 14mr1612007wfl.1196951804022;
        Thu, 06 Dec 2007 06:36:44 -0800 (PST)
Received: by 10.142.157.1 with HTTP; Thu, 6 Dec 2007 06:36:43 -0800 (PST)
In-Reply-To: <1196949043.5388.18.camel@galileo>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67291>

On Dec 6, 2007 1:50 PM, Stelian Pop <stelian@popies.net> wrote:
>
> Le lundi 03 d=E9cembre 2007 =E0 17:20 -0800, Junio C Hamano a =E9crit=
 :
>
> > >      (fdcomment, filecomment) =3D tempfile.mkstemp()
> > > -    csetcomment =3D os.popen('hg log -r %d -v | grep -v ^changes=
et: | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^file=
s: | grep -v ^description: | grep -v ^tag:' % cset).read().strip()
> > > +    csetcomment =3D os.popen('hg log -r %d -v | grep -v ^changes=
et: | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^file=
s: | grep -v ^description: | grep -v ^tag: | grep -v ^branch:' % cset).=
read().strip()
> > >      os.write(fdcomment, csetcomment)
> > >      os.close(fdcomment)
> >
> > Isn't this one of the ugliest lines in the whole git.git project, I=
 have
> > to wonder?
>
> It probably is, and I take full resposibility for the original
> version :). Incremental development woes.
>
> > I also wonder missing colon after "date" is a bug from the original
> > version, and assuming that it is,
>
> It is indeed a bug.
>
> > how about doing something less error
> > prone like this?
> >
> >         def included(line):
> >             keywords =3D ('changeset', 'parent', 'user', 'date', 'f=
iles',
> >                         'description', 'tag', 'branch')
> >             for kw in keywords:
> >                 if line.startswith(kw + ':'):
> >                     return 0
> >             return 1
> >
> >         hglog =3D os.popen('hg log -r %d -v' % cset).read();
> >         csetcomment =3D '\n'.join(filter(included, hglog.split('\n'=
))).strip()
>
> Seems great to me.
>
> > If you are excluding _all_ of the <word>: header lines, the "includ=
ed"
> > function may have to become cleverer but much simpler by doing some=
thing
> > like:
> >
> >       import re
> >       header_re =3D re.compile(r'^\w+:')
> >       def included(line):
> >               return not header_re.match(line)
>
> I'm afraid something like this will be much more prone to false
> positives.
>
> Maybe an even better alternative, given the way mercurial outputs the
> changeset information, is to search for the '^description:' tag and t=
ake
> all the text that follows.

Would it not be better to use hg log --template to output only the
information needed?
eg

date =3D os.popen('hg log -r %d --template "{date|isodate}"' %
cset).read().strip()
=2E.. or even just create a template to pull in everything needed in a
single popen.

-Baz

>
> --
> Stelian Pop <stelian@popies.net>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
