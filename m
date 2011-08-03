From: Dov Grobgeld <dov.grobgeld@gmail.com>
Subject: Re: Why do some commits not appear in "git log"?
Date: Wed, 3 Aug 2011 08:47:46 +0300
Message-ID: <CA++fsGGhzVkXTPLui+DfTFcjve7w80Kud4RxC0p=5AenOcBSDw@mail.gmail.com>
References: <CA++fsGGG7pLt4xoeJozGnYEwOrs6NuzStYPKF_L5k49uzFB-4A@mail.gmail.com>
	<CA++fsGEht+UDp9EnFyfvn-uT1DYPcnhpwmPy_H4PTWvsvUceAQ@mail.gmail.com>
	<CAMOZ1Bt+Z4XDPNBQyUeVk30aEOuXFAuh8jhdhFke-CDZt2pEDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 07:49:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoUKJ-0001ch-Sl
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 07:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab1HCFrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 01:47:49 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35886 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab1HCFrr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 01:47:47 -0400
Received: by yia27 with SMTP id 27so285923yia.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 22:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=f66CJkMbl8ooqjMwqaWbfQLHjzl6XV4DTNvYBibCpPI=;
        b=kHKL/b2d9pnoP9HfBvQd2xknyiSKP4VeMr6oLxfFb8tuCe6RPZ3c+RnVC0tAGVk6Ub
         KIZEH5DJSCUtSW8eHCb7U/aARGmXsnE73Ylnp72cXYtpkMkEKmMLeqeV0kaKwfGxqMpg
         4b1IFYg/Qq0Iap7gQMaUwC++pw75tabEj01Dw=
Received: by 10.42.150.136 with SMTP id a8mr3045121icw.42.1312350466376; Tue,
 02 Aug 2011 22:47:46 -0700 (PDT)
Received: by 10.42.217.66 with HTTP; Tue, 2 Aug 2011 22:47:46 -0700 (PDT)
In-Reply-To: <CAMOZ1Bt+Z4XDPNBQyUeVk30aEOuXFAuh8jhdhFke-CDZt2pEDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178544>

--full-history indeed made the missing commits show up! So why was the
commit pruned? It contains some substantial source changes as may be
seen by the following commands:

1. Commit history for entire project:

> git log --full-history --pretty=3Doneline  -5 --abbrev-commit   | ~/s=
cripts/crop
e86d3b1 Merge remote-tracking ...
05e7103 Made the system conver...
2de7375 Fixed compilation unde...
b520873 Error handling!!
73110bd New Group manager for ...

2. Diff of a single file between two commits show that 05e7103
contains a substantial change for the file.

> git diff 05e7103 2de7375 Apps/SolarJet/Project/qt/SysScripts/init.py =
| wc
    105     389    5336

3. Full history of the file includes 05e7103

> git log --full-history --pretty=3Doneline  -5 --abbrev-commit Apps/So=
larJet/Project/qt/SysScripts/init.py  | ~/scripts/crop
05e7103 Made the system conver...
84a60b7 avoid CarouselSimulati...
c40df74 git-svn-id: svn://swte...
0bdf4b6 Group manager for mult...
0536a0d git-svn-id: svn://swte...

4. But the default "pruned" history of the file does not contain 05e710=
3

> git log  --pretty=3Doneline  -5 --abbrev-commit Apps/SolarJet/Project=
/qt/SysScripts/init.py  | ~/scripts/crop
84a60b7 avoid CarouselSimulati...
c40df74 git-svn-id: svn://swte...
0536a0d git-svn-id: svn://swte...
a720b61 Add full line wafer pr...
08b366b git-svn-id: svn://swte...

5. Here is the project graph:

> git log --graph --abbrev-commit --pretty=3Doneline -20 | ~/scripts/cr=
op
*   e86d3b1 Merge remote-track...
|\
| * 026fec8 Stop all the jobs ...
| * 84a60b7 avoid CarouselSimu...
| * c40df74 git-svn-id: svn://...
| * fee6808 git-svn-id: svn://...
| * 047e697 Automatic Theta Ca...
* | 05e7103 Made the system co...
* | 2de7375 Fixed compilation ...
* | b520873 Error handling!!
* | 73110bd New Group manager ...
* |   dce3ae9 Merge branch 'Mu...
|\ \
| * \   25dff3c Merge branch '...

=46inally, a few more questions. Is it possible to make gitk use the
--full-history option when running 'gitk file'? Is there any
configuration flag that always turns on "full history"?

Thanks!
Dov

On Tue, Aug 2, 2011 at 18:56, Michael Witten <mfwitten@gmail.com> wrote=
:
> On Tue, Aug 2, 2011 at 15:38, Dov Grobgeld <dov.grobgeld@gmail.com> w=
rote:
>> git log --pretty=3Doneline --abbrev-commit | head -20
>
> Try `--full-history' maybe? Also, rather than `head -20', you can
> limit the output directly with `-20':
>
> =C2=A0git log --pretty=3Doneline --abbrev-commit --full-history -20
>
> It's hard to know what's going on in your particular example; perhaps
> give us the output of `git log' when using the `--graph' option.
>
