From: Dan Loewenherz <dloewenherz@gmail.com>
Subject: Re: Does changing filename case breaks git's rename heuristic?
Date: Fri, 27 Aug 2010 07:52:11 -0700
Message-ID: <AANLkTikN_PbNNH2f4zWuk1FH+LgpKzkoZ6mYOdT9ANBj@mail.gmail.com>
References: <AANLkTinxvj85Jzb-ykK0=MmRHkz8aQzmVxexC8H+Xgno@mail.gmail.com> <4C777090.2000107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 27 16:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op0II-0003Ee-31
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 16:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab0H0Owd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 10:52:33 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39678 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0H0Owb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 10:52:31 -0400
Received: by qwh6 with SMTP id 6so2814458qwh.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HVcI57KH0gedfbmuSDUElGJFn3TE2D5RK1aV4wZkBfM=;
        b=oH7HveHnqMGK8HBD6B7XttZcoHVEMwufXcfSVZB4FPQm1jn/Q9jJ0JcA3xNhX4ONK3
         /Ch+YI2Q3IN5vlsGAK8K0xKJrFJxoXXGVXZwFZf3OLlvNQlsEZtXDUsTdXO59ykeKW5l
         XKfGgwN5wnxsGEvIKA8yweD23Ts0SswauNDxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=N/QxmqvpPcTnYTWgcY1MbpCKeEnBBJYAxUhcfMDEgXWl3UKzqU0sUbrgVNeZ04JtP8
         2a1qCuj1t40VGiUfQ2CMjQNqbbbu+Qr2ew4PA+Mz/4ltxcHdgpAva5hEUigy6B2OXns/
         3nLm+W8aiDg/2hVKl4xPcVS0eIObSabxHMpjM=
Received: by 10.224.114.89 with SMTP id d25mr496442qaq.132.1282920751131; Fri,
 27 Aug 2010 07:52:31 -0700 (PDT)
Received: by 10.224.73.140 with HTTP; Fri, 27 Aug 2010 07:52:11 -0700 (PDT)
In-Reply-To: <4C777090.2000107@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154600>

On Fri, Aug 27, 2010 at 1:00 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Dan Loewenherz venit, vidit, dixit 27.08.2010 06:57:
>> Hi all,
>>
>> I may be mistaking a design decision as a bug, but I wanted to throw
>> this out to the list to make sure. I think that re-enacting it will =
be
>> the best way to explain it.
>>
>> $ mkdir test
>> $ cd test
>> $ git init
>> $ cat > readme
>> This is a test file.
>> ^D
>> $ git commit -am "first commit"
>> [master (root-commit) fae0d05] first commit
>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>
> ? You have not added any file, so git won't commit anything (not even
> with -a). The above can't be a complete transcription. I assume you'v=
e
> added readme with the content above.

Yep, that was my mistake. I left out 'git add readme'.

>
>>
>> For personal reasons, I now want readme to be uppercase.
>>
>> $ mv readme README
>
> Here's where using "git mv" would have been the easier choice, follow=
ed
> by commit.

I agree. The instance where this actually occurred was that I had
received an updated binary file to put into my repository. icon.png ->
Icon.png. I suppose I could've run 'git mv' but I didn't realize what
would happen if I didn't!

>
>> $ cat > README
>> This is the revised README.
>
> Renaming and changing the content completely in one step will always
> trip up git's rename detection. You should rename, commit, change,
> commit, unless the change affects a small portion of the file only.

Agreed.

>
>> $ git status -sb
>> ## master
>> =C2=A0M readme
>
> Again, this can't be a complete transcript. The above would lead to
>
> =C2=A0D readme
> ?? README

This is where I didn't botch up the transcript, and where I was
actually surprised at what was going on. I'll insert a full one at the
bottom of this email that can actually be run to get the same results.

>
>> $ git add README
>> $ git status -sb
>> ## master
>> =C2=A0M readme
>>
>> At this point, I'm thinking that git is confused. Even though I've
>
> Are you possibly using a case-challenged file system? Is this maybe o=
n a
> Mac with HFS or Win with NTFS?

I'm using a Mac with a journaled filesystem and Git version 1.7.2.1.

>
> Michael
>

Transcript

dan ~ $ mkdir test
dan ~ $ cd test/
dan test $ git init
Initialized empty Git repository in /Users/dan/test/.git/
dan test (master #) $ cat > readme
This is a test file.
dan test (master #%) $ git add readme
dan test (master #) $ git ci -m "first commit"
[master (root-commit) 3237fcb] first commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 readme
dan test (master) $ mv readme README
dan test (master) $ cat > README
This is the revised README.
dan test (master *) $ git s
## master
 M readme
dan test (master *) $ git add README
dan test (master *) $ git s
## master
 M readme
dan test (master *) $ git add readme
dan test (master +) $ git s
## master
M  readme
dan test (master +) $ git ci -m "change filename"
[master 587f3f8] change filename
 1 files changed, 1 insertions(+), 1 deletions(-)
dan test (master) $ git --version
git version 1.7.2.1
