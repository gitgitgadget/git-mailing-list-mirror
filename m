From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH v2 1/3] git-svn: Support retrieving passwords with 
	GIT_ASKPASS
Date: Fri, 26 Feb 2010 16:55:58 +0800
Message-ID: <1976ea661002260055l63a9ea53x8dc4dfd90cbac199@mail.gmail.com>
References: <1267142845-3040-1-git-send-email-lznuaa@gmail.com>
	 <7vzl2wa4m0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davvid@gmail.com, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:56:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkvzQ-0000QT-Nr
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 09:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935594Ab0BZI4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 03:56:00 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36463 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935584Ab0BZIz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 03:55:59 -0500
Received: by gyh20 with SMTP id 20so1738894gyh.19
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 00:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=teTowlj09Sv5zlIx/6gCyUce2usdjoCR0qvUEZFLlCY=;
        b=unUFk5hagHPAZYokaqrJEetIAmQEDwhFcLX5YX9GpFdfoDEzhH7g9y2o2Vh6OTu7Jg
         zmTFfNKc8lQxvQfHXtPJsSVV5Oizi61YVtuMwtq6jH/GEYCJZ7wM7smeDqMVN7oNjsuv
         mi6dPOPeQ7wKmaIjuRtVCTJwtpjms20JbuZHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RhDIgFn6XPlUo/eKAcjGhEWsVKMengJ4Jad67u2vKcNyWC4Xyk7ikvy5UvTgVEXb/q
         +Jn8I+GBMKc2MN3F8Jb7bkGF6zoOIyWoG8X1iqZfMoKnyhWaIvScONCdj2cedFSbXPVG
         dPmHVt/zV1jajvtTY7X/O858RBR8nG9wmY86w=
Received: by 10.151.88.22 with SMTP id q22mr202900ybl.208.1267174558356; Fri, 
	26 Feb 2010 00:55:58 -0800 (PST)
In-Reply-To: <7vzl2wa4m0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141115>

2010/2/26 Junio C Hamano <gitster@pobox.com>:
> Frank Li <lznuaa@gmail.com> writes:
>
>> +if (! exists $ENV{GIT_ASKPASS}) {
>> + =A0 =A0 if (exists $ENV{SSH_ASKPASS}) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 $ENV{GIT_ASKPASS} =3D $ENV{SSH_ASKPASS};
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($^O eq 'msys') {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$ENV{GIT_ASKPASS} =3D=
~ s/\\/\\\\/g;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$ENV{GIT_ASKPASS} =3D=
~ s/(.*)/"$1"/;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 }
>> +}
>
> I've seen this code before, and you may not be the best person to ans=
wer
> this question, but this worries me and puzzles me a bit.

Yes, I copy it from fall back SVN_SSH from GIT_SSH at git-svn.perl.

I guess it seems related with windows path using space, such as
c:\program files\bin\xxx.
perl Open ('$ENV{GIT_ASKPASS} |") will be changed to open("c:\program
files\bin\xxx |").
Perl will think c:\program as application, files\bin\xxx as first param=
eter.

So add ".  it equal to open ( "\"c:\program files\bin\xxx\" |"). perl
can run correct application.

>
> On msys (and nowhere else), SSH_ASKPASS can be used as given by the u=
ser
> to launch the prompter, but GIT_ASKPASS must be quoted in some funny =
way.
>
> Why is that? =A0Does this mean they must be given differently by the =
end
> user? =A0In other words, if the end user wants to set GIT_ASKPASS him=
self,
> s/he needs to do this funny quoting, that is different from SSH_ASKPA=
SS.

I should add code to check if there are a space at GIT_ASKPASS,
if there are space in prompter path, add quote.
So end user set GIT_ASKPASS and SSH_ASKPASS at the same ways,  NO quoti=
ng.

>
> I also notice that git-gui has support for SSH_ASKPASS (and its own
> implementation). =A0Does it have the same quoting issues on msys?

I think no because msys add prompter to PATH environment and needn't
set full path.

>
> The reason I am asking is because:
>
> =A0(1) if SSH_ASKPASS and GIT_ASKPASS cannot be specified exactly the=
 same
> =A0 =A0 way, then [PATCH 3/3] would probably need a similar quoting m=
agic?

SSH_ASKPASS and GIT_ASKPASS is the same.  C code needn't quoting
because start_command think $GIT_ASKPASS is full path and don't split
$GIT_ASKPASS to
application and parameter by space.

>
> =A0(2) With [PATCH 3/3], with quoting magic if necessary, we wouldn't=
 need
> =A0 =A0 the above hunk, as it has already be done by the "git" potty.
>

quoting magic is not necessary at PATCH 3/3.
