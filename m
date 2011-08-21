From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Merge after directory rename ?
Date: Sun, 21 Aug 2011 23:53:34 +0000
Message-ID: <CAMOZ1Bt8cP146xiDXfSA-naSOaS3AC8pUZgW12=3TMg2JGCD=w@mail.gmail.com>
References: <j2ru2h$cd$1@dough.gmane.org> <CAMOZ1BukGPZt8gJh0J4EHRrPHv5teAdnkNT+gZJa9mX=2ohFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 01:54:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvHqK-0005N7-UL
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 01:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab1HUXyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 19:54:07 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:50574 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab1HUXyF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 19:54:05 -0400
Received: by iye16 with SMTP id 16so9323713iye.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=maSeVl1qQ5+gGcePXOzRivXQc77eiL2r/CL0gk2nUyw=;
        b=XWQ7ALef8sX5SQOCaLfRm9b44QYFABaJbcdlVDivXvJ9UkW4LbS9M6labDN+wDKqfz
         1LlmxjrEV9KN+E7gQylYch9IzuZPJp9tWBlIrLDhlAF2XI9wJWVerUQvtxT1ixLWwWo4
         9kEDTkjSMKnH1FCYk+YdvIB3XdiypeTFfoars=
Received: by 10.43.44.195 with SMTP id uh3mr2029835icb.196.1313970844117; Sun,
 21 Aug 2011 16:54:04 -0700 (PDT)
Received: by 10.42.174.129 with HTTP; Sun, 21 Aug 2011 16:53:34 -0700 (PDT)
In-Reply-To: <CAMOZ1BukGPZt8gJh0J4EHRrPHv5teAdnkNT+gZJa9mX=2ohFOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179825>

2011/8/21 Michael Witten <mfwitten@gmail.com>:
> 2011/8/21 Marcin Wi=C5=9Bnicki <mwisnicki@gmail.com>:
>> Is it possible to merge files after performing directory renames in =
such
>> way that new files will end up in renamed directories ?
>>
>> For example:
>> 1. [master] =C2=A0add dir1/file1
>> 2. [branch1] branch from master
>> 3. [branch1] add dir1/file2
>> 4. [master] =C2=A0rename dir1 to dir2
>> 5. [master] =C2=A0merge branch1
>>
>> Where it should notice that dir1=3D>dir2 and therefore {dir1=3D>dir2=
}/file2.
>>
>> Currently I end up with dir1/file2 which is undesirable as it breaks
>> refactorings and requires a lot of manual effort to clean-up.
>
> Part of the assumption for someone working on `branch1' might be that
> `dir1/file2' is in fact in `dir1'. The rename via `master' conflicts
> with that assumption. In this case, a full-blown conflict might be
> useful.
>
> However, suppose that the author who is working with `master' doesn't
> need `dir1', but the author who is working with `branch1' does need i=
t
> INDEPENDENTLY:
>
> =C2=A01. [master] =C2=A0add dir2/file1
> =C2=A02. [branch1] branch from master
> =C2=A03. [branch1] add dir1/file2
> =C2=A04. [master] =C2=A0add dir1/file3
> =C2=A05. [master] =C2=A0rename dir1/file3 to dir3/file3
> =C2=A06. [master] =C2=A0merge branch1
>
> In that case, you'd want `dir1/file2' from the `branch1' work to be
> silently created rather than automatically renamed to `dir3/file3'.
> This should not result in a conflict or a rename.
>
> So, from your grievance, I suppose that git currently assumes the
> latter case (and hence, gives no indication of a possible conflict).
> Perhaps git could be improved here at least in terms of a warning.
> Perhaps the merger could request that directory renames be considered
> conflicts or enforced, but this would have to involve the intent of
> the merger me thinks (using command line flags).

Importantly, note that I used only file names in my example, specifical=
ly:

  5. [master]  rename dir1/file3 to dir3/file3

rather than mirroring your example by writing:

  5. [master]  rename dir1 to dir3

This is because git fundamentally tracks content, and paths are just
one kind of content associated with another blob of content.
Consequently, git really knows next to nothing about directories, so
it's not too surprising that git doesn't bother finding such a
DIRECTORY rename anyway (at most, git would detect a FILE rename, and
your FILE `dir1/file2' has nothing to do with, say, the FILE
`dir1/file1' being renamed `dir2/file1').

Still, some command line switches could be useful to help the user
express to git what should be going on in a case such as yours.
