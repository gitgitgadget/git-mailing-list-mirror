From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Maybe there should be a git-grep plumbing interface for ack et al.
Date: Sun, 9 Jan 2011 23:17:09 +0100
Message-ID: <AANLkTi=E0x55-RUz5CJXL_LJ6hPr--Nupp-Ti72kpNv=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: perl5-porters@perl.org, Andy Lester <andy@petdance.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 09 23:17:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pc3Ze-00040J-5C
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 23:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab1AIWRM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jan 2011 17:17:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59868 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab1AIWRL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jan 2011 17:17:11 -0500
Received: by fxm20 with SMTP id 20so18331051fxm.19
        for <git@vger.kernel.org>; Sun, 09 Jan 2011 14:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=Je/FO1fWq22x15Z8KTSABeBvTWRvV738072InGiPoZ4=;
        b=yH1OTz4rZuEqzOWmat7SlZhGBV4q6tbB5N3SXkNKqcemlWRhohgzZ6swqT3qlIZIQs
         7I41swPNW48EslIeUPNmEIq7P7iL5JWvFds/OP8r+9zz9/j9jgFOyIk/63k7lq+cGHwT
         1XGXrg2tOdaHbPz4Xfl4Rf+UOogWUBZsvOJEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=DZCvqrjVRCEFS7S/jKV0LEwfDzeU5+rACYoyoB3qU6+pcafBRt6n6de9l6kAydaXWU
         NKBVtCyuJv2C4+0OqGU2aCIB6XGbDTIxWwpgss42e9e9T0kvVwsPN72qZrLTZnrQf9V/
         ZIPkWGBHQL167Eu8xDyakcoZIs1NAib1zanec=
Received: by 10.223.103.4 with SMTP id i4mr2489435fao.123.1294611429657; Sun,
 09 Jan 2011 14:17:09 -0800 (PST)
Received: by 10.223.86.204 with HTTP; Sun, 9 Jan 2011 14:17:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164864>

On Sun, Jan 9, 2011 at 18:17, Aristotle Pagaltzis <pagaltzis@gmx.de> wr=
ote:

[CC'd Andy & the Git list in case they're interested]

> * Aaron Crane <perl@aaroncrane.co.uk> [2011-01-09 13:10]:
>> AFAICT, the most important reason for the speed of `git grep`
>> is that (in recent versions, at least) it uses multiple
>> threads. [=E2=80=A6] I believe that ability should be reasonably eas=
y
>> to reimplement in a Perl grep-a-like
>
> I assumed, on no factual basis, that one of the reasons is that
> it uses the object store whenever possible instead of the working
> copy, which would speed up `git grep` in much the same way it
> makes `git checkout` faster than `cp -R`. (Compression and linear
> pack files reduce I/O.) I don=E2=80=99t know if that=E2=80=99s actual=
ly the case,
> though. But such an avenue is not open to generic grep clones.

Yes, this is correct. git-grep(1) is fast because it doesn't have to
do the I/O that grep(1) and ack(1) have to do. It can just read the
git tree/object files.

Incidentally (since I also work on git.git) one idea for a project I
had was to add a new plumbing command that does the grep-like things
git-grep(1) does but allow someone to implement their own
grep-er. I.e. just spew out filename/line pairs on stdout.

Then e.g. ack(1) could use this new plumbing command to read files
when in a git repository, but could provide Perl's regex features and
other things it has.

But last I looked Ack was fairly unmodularized, so adding that sort of
stuff might be hard. But that might have changed.
