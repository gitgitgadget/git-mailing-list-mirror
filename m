From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 3/5] Add automatic git-mergetool invocation to the 
	new infrastructure
Date: Mon, 16 Mar 2009 15:03:09 +0000
Message-ID: <b0943d9e0903160803y25eb3f45y96d68e734b22e5f9@mail.gmail.com>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
	 <20090312120907.2992.81035.stgit@pc1117.cambridge.arm.com>
	 <20090313021751.GC15393@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 16:04:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjEMt-00026N-9R
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 16:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbZCPPDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 11:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbZCPPDN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 11:03:13 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:37944 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbZCPPDN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 11:03:13 -0400
Received: by fxm24 with SMTP id 24so3523019fxm.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CUXco5caY9VBCxtw4DaqE1hz89c/B/2CsrEhGUzr2Uk=;
        b=P1tqD2aGd1aTBOFp2BGilECChU9jJjOEwDY3mQUqUfT7YW8Mvh5RXZqu+zoR+i3WOj
         auNQVdaq8dYYra+iAvHAUbU41Vmz99f1JSBfZWZBgcM1zAkvVhHAPufloZIMDuXMeDey
         OS1hXg52eb9xlb1GMIKYv+u0ISFTuocVM9BXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OXaeOuzCjzBmqQ7YDbIUhTC4UYmp0TVYCdDHH8JGagc1JuFkM/GnYrCqloWJ+cQqIs
         sJ1YS2QrFwen5wJokTaOeCeLTUS1wADM323lJr3FxmoNi6L2TRGz+MZ4v7pOjPXLM/uE
         zMiaNb3R0H2BWlKZnXBw1j/NJycyHFQ000III=
Received: by 10.204.77.73 with SMTP id f9mr1662069bkk.66.1237215789870; Mon, 
	16 Mar 2009 08:03:09 -0700 (PDT)
In-Reply-To: <20090313021751.GC15393@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113332>

2009/3/13 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-03-12 12:09:07 +0000, Catalin Marinas wrote:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# There were conflicts
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conflicts =3D [l for l in output if=
 l.startswith('CONFLICT')]
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raise MergeConflictException(confli=
cts)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if interactive:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.mergetool()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conflicts =3D [l for l in o=
utput if l.startswith('CONFLICT')]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raise MergeConflictExceptio=
n(conflicts)
>
> Does the merge tool always resolve all conflicts? If it doesn't, the
> two lines in the "else" branch should probably be run unconditionally=
=2E
[...]
>> + =A0 =A0 =A0 =A0# check for unmerged entries (prepend 'CONFLICT ' f=
or consistency with
>> + =A0 =A0 =A0 =A0# merge())
>> + =A0 =A0 =A0 =A0conflicts =3D ['CONFLICT ' + f for f in self.index.=
conflicts()]
>> + =A0 =A0 =A0 =A0if conflicts:
>> + =A0 =A0 =A0 =A0 =A0 =A0raise MergeConflictException(conflicts)
>> + =A0 =A0 =A0 =A0elif err:
>> + =A0 =A0 =A0 =A0 =A0 =A0raise MergeException('"git mergetool" faile=
d, exit code: %d' % err)
>
> Ah, you take care of conflicts here too. Hmm. I guess that's fine too=
,
> though there is some code duplication. Maybe a helper function that
> takes output as a parameter, and raises MergeConflictException if
> necessary?

The non-interactive path assumes that there are conflicts if "git
merge-recursive" returned an error and it simply splits the output if
this command. The mergetool path has to run "git ls-files --unmerged"
to check if there were any left conflicts. I wouldn't call "git
ls-files" in the first case as we already have the information.

--=20
Catalin
