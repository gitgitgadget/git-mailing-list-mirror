From: Ricky Clarkson <ricky.clarkson@gmail.com>
Subject: Re: Case sensitivity on Windows for absolute paths.
Date: Sun, 25 Apr 2010 08:33:22 +0100
Message-ID: <j2y7eeb06461004250033ue4434a41j7b9a752dea1f5fe1@mail.gmail.com>
References: <o2v7eeb06461004230712i2c8c1e61l4c50a73a4f6c83d@mail.gmail.com> 
	<201004232146.56424.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 25 09:34:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5wLr-0001q6-38
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 09:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab0DYHdo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 03:33:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:43668 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab0DYHdn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Apr 2010 03:33:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1247092fgg.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pjvO5VPD1yyBDklv8WgvSg7RwpfWE9dj2xOmr+82DAI=;
        b=uLr0t4vgx76Qg+KSoid8GoCQsRrz16JV3Kdmfm9iaBOSOIshih1rU0FS3k2gmjyIAh
         KZgk1tzymYFMi23XTG0JXyQRMtoTCsqjTjysa8fZtr7lx1HT1WJTDp11BTMBp5LK5jSm
         nQJeYoxYY+O6mfJoJa4MBV3EmgOO9Snlk7Bxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cv15oaizw1Q4j9sgKMhT26ZEq4Cq9vgRrxHcQwkpwgxLR0exa+8hpvhtsShcJ5EIiE
         M+UG7+bTzH8M8wuguZ6Xm/a4yyMB6rmcYLzyN0FTwaNoySxI/pFKhmWMEE/qCh2c3rH5
         RzbpbMh4Gs1wpaZf2yMYO6fusot8fFHhmNAJQ=
Received: by 10.86.124.35 with SMTP id w35mr4020002fgc.49.1272180822190; Sun, 
	25 Apr 2010 00:33:42 -0700 (PDT)
Received: by 10.223.126.3 with HTTP; Sun, 25 Apr 2010 00:33:22 -0700 (PDT)
In-Reply-To: <201004232146.56424.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145719>

Hi again,

It would be good if git automatically uppercased the drive letter,
yes.  However, I found the real root of my problem.  Git Bash
(msysgit) sets the working directory to c:\foo for programs launched
if the working directory within it is /c/foo.  Like having spaces in
filenames, that just uncovers a whole myriad of small bugs and
oddities in other programs.

=46or reference, Cygwin doesn't have that problem; cd /cygdrive/c/foo &=
&
cmd, cmd gets C:\foo as its working directory.

So to make what I wanted work, I just made sure everything msysgit
installed be on the PATH, then ran everything from cmd.

I hope that this helps the next person who experiences this problem.

Thanks,
Ricky.

--
Ricky Clarkson
Java and Scala Programmer, AD Holdings
+44 1928 706373
Skype: ricky_clarkson
Google Talk: ricky.clarkson@gmail.com
Google Wave: ricky.clarkson@googlewave.com



On 23 April 2010 20:46, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 23. April 2010, Ricky Clarkson wrote:
>> I noticed that if I have a git repository at C:\foo, and there is a
>> file in there named bar, git add bar works fine, git add C:\foo/bar
>> works fine but git add c:\foo/bar does not. =C2=A0git reports that t=
he file
>> 'is outside repository'. =C2=A0Looking at setup.c it seems that stri=
ng
>> comparisons are being used to determine whether a file is within the
>> repository.
>
> Yes, we should be a bit more liberal when drive letters are compared;=
 they
> should be treated in a case-insensitive manner, but currently we are =
strict.
>
>> For my purposes I can probably make a Windows build that does it whi=
le
>> ignoring the case, but is there a more proper way that git should do
>> it? =C2=A0I'm not familiar enough with the POSIX file routines to kn=
ow.
>
> My guess is that it is sufficient that
>
> 1. the internal version of GIT_DIR is recorded with an uppercase driv=
e letter;
>
> 2. normalize_path_copy() upper-cases the drive letter.
>
> Then the comparison in prefix_path() should do the right thing.
>
> -- Hannes
>
