From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [RFC] File system difference handling in git
Date: Tue, 22 Jan 2008 10:52:30 +0000
Message-ID: <3f4fd2640801220252q6a6557cdma4ca0a2c41223593@mail.gmail.com>
References: <3f4fd2640801220121w60cb9a69u8519a7ceb81d3414@mail.gmail.com>
	 <7vtzl6qhtk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 11:53:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHGkX-0006Qc-FK
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 11:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039AbYAVKwc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2008 05:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756879AbYAVKwc
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 05:52:32 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:37409 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620AbYAVKwb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 05:52:31 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2091785rvb.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 02:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OIUn9GDMfaRtPhdJwb9y3wreXTSbgK8Ov/2W3FLSlkw=;
        b=xGLls51Xb7ibNgY642c1y2v1wMhiewFxc595XLXVYbFCuVpB5mmyWq/ZOUtcjmzaPdeZ0EJJMq0tc0J6XQBormTsgRFb6nZUItwpXVzE4SNFTehdFdXszkhzG/6uYVUsJWsNXNCT2Kz6BSijHqtol+Pweq9lbeQ5UHI+0TWe8Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KShziyLPZ+OLL5Wrp0F0tZ9bxJLEjbpRTWI0f+Hj7KYFe8dkh4ozNAV+clL7bx+mMBrMqvymQT78SrWoJtrGihpQlzVr9G0P63n4hiXJSzEXReJZIe/GUw6Ofc+dmqxj7qFIzw4Zz6+SMGj7ulNWicgTQSDnQj2ZiaekVp4MFaA=
Received: by 10.141.162.16 with SMTP id p16mr5262577rvo.243.1200999150492;
        Tue, 22 Jan 2008 02:52:30 -0800 (PST)
Received: by 10.141.123.8 with HTTP; Tue, 22 Jan 2008 02:52:30 -0800 (PST)
In-Reply-To: <7vtzl6qhtk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71444>

On 22/01/2008, Junio C Hamano <gitster@pobox.com> wrote:
> "Reece Dunn" <msclrhd@googlemail.com> writes:
>
> >   1.  File name representation
> >
> > For Linux file systems ...
> > Therefore, you have:
> >
> >    os_to_git_path( const NATIVECHAR * ospath, strbuf * gitpath );
> >    git_to_os_path( const char * gitpath, const NATIVECHAR * ospath,=
 int oslen );
>
> It is not that simple, I am afraid.  Legacy encodings can be
> used in pathnames.  With bog-standard traditional UNIX pathname
> semantics, all pathnames are sequences of non-NUL, non-slash
> bytes, separated with slashes, so if you do not allow choices
> (which is a very sensible ideal world scenario), you can declare
> that the "git" encoding is UTF-8 and always check things out
> as-is.

So the upshot of this is that you need to use a platform (Operating
System, filesystem, locale, etc.) that match what the git repository
was created in, otherwise there are going to be issues when
interpreting paths correctly.

The locale issue asside, can the above proposal help users working on
Mac, Linux and Windows interoperate with each other?

I understand that there is not going to be a universal magic fix; what
I'm interested in is minimising the differences between Operating
Systems. This may be a futile effort, as it is likely you will need
some knowledge of the properties of the filesystem being used (as
filesystems with different properties can be used on the same
Operating System).

> >   2.  Case (in)sensitivity
> >
> > Here, you have the following cases:
> > ...
> >   3.  git says that the files are different, but the filesystem say=
s
> > that the files are the same.
> >
> > Allow the move, updating the git directory tree only.
>
> Sorry, I cannot really tell what you are talking about.  You
> seem to imply, with "Allow the move", that you are describing a
> scenario that involves a move of one existing file to another,
> but it is not clear.  E.g. did you mean, by 3, "When the user
> says 'move a b', and if git says a and b are different but if
> the filesystem says a and b are the same, then..."?

This is what I am saying. For example, if you say:

   git mv myfile.H myfile.h

on a case sensitive filesystem (e.g. ext3), this will work, however on
a case insensitive filesystem (e.g. ntfs) git would complain that the
files are the same.

The workaround is to say:

   git mv myfile.H myfile.h.tmp
   git mv myfile.h.tmp myfile.h

but this is not ideal, especially if you are automating some move opera=
tions.

This also applies to the VCS importers (e.g. git-p4) that can delete a
file that is a case-only move on case insensitive filesystems.

The question then becomes what happens on Mac (with the Unicode
decomposing behaviour) if they differ in the way they are stored (e.g.
in Linus' '=E4' vs 'a=A8' example)?

- Reece
