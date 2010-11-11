From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Sparse checkouts
Date: Thu, 11 Nov 2010 18:56:51 +0700
Message-ID: <AANLkTi=Mz3PjxBUJvRafBjNdpDmPukvdhD40mJkpn8Gk@mail.gmail.com>
References: <loom.20101107T030122-536@post.gmane.org> <AANLkTi=7jeeEw58SQOWmWUx54epWinTuTJE_h=bxcYvO@mail.gmail.com>
 <AANLkTikahpqj-R7bjEJnPG0FU8Bg26R7Jtf4Lt6JSE+t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 12:57:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGVmO-00034Y-16
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 12:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab0KKL5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 06:57:15 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65168 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab0KKL5O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 06:57:14 -0500
Received: by wyb28 with SMTP id 28so600314wyb.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 03:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=d8Iph8huq4j3GifRas49qYE+fOOdUZyKQG4KeUVuL30=;
        b=fDBUljV/Oo9nztbtwXiaer5qATVAfyr3ncx652AKfldtGVumze2Aq3bKRCTp75Ua6w
         qgT9rDO662tS+Z7MkyoD1TnZ95f1mvxTM7j6fi+JDE24xGYIgZ/wUN/zP3hqOqGSBDi3
         P8CF2NWzCJxWQE1IamdWGf3QS8+hN4s6wd8iE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EbSXfI5XwRL7kXJYvWosv3UpkgGeu8eFHAiaG3jbFgxm/PB93VM7mHLAuGlB94D6fY
         3vsrWAFbK9uceWat8hv0e6v11dDeXclB1hohhqJBfeOppVCeiI2Rvqreyn5FIor0Jsfr
         zorq+Hn8e/WPveL7zzJth1KwCd4c/V0yGOim0=
Received: by 10.216.182.75 with SMTP id n53mr1787328wem.41.1289476632047; Thu,
 11 Nov 2010 03:57:12 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Thu, 11 Nov 2010 03:56:51 -0800 (PST)
In-Reply-To: <AANLkTikahpqj-R7bjEJnPG0FU8Bg26R7Jtf4Lt6JSE+t@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161229>

On Mon, Nov 8, 2010 at 11:29 PM, Uri Moszkowicz <uri@4refs.com> wrote:
> Thanks for the reply. "git checkout" does seem to work. The exact com=
mands
> that I used are shown below:
>> =C2=A0git clone -n <dir>
>> =C2=A0git config core.sparsecheckout true
>> =C2=A0echo "<dir>/" > .git/info/sparse-checkout
>> =C2=A0git read-tree -m -u HEAD
>
> It would be nice if sparse checkout mode were more intuitive. A start=
 would
> be making it on by default. I don't know why the config bit has to be=
 set.

Because there is overhead in this feature and I guess only a tiny
percent of users needs it. So it's not enabled by default. When I make
the overhead really small, maybe I can convince Junio to enable it by
default.

> Second, when it is enabled, then checkout commands could add the give=
n
> directories to the sparse checkout list. A checkout command with no s=
parse
> checkout file would result in "*" being added to the file.

Earlier versions of sparse checkout supported that, sparse rules were
much simpler back then. But because you can now set complex rules in
sparse checkout file (keep directory a, but not a/b, but keep a/b/c,
for example), command line support to edit the file automatically may
give unexpected result.

But I think command line support to just clear sparse checkout file
and replace it with "*" is good.

> Third, when
> directories are removed it would be nice if they were removed from th=
e
> sparse checkout file. I don't know if you can trap "rm" or if you nee=
d to
> add a new command like "git remove".

That can't be done reliably. If you put pattern "a/*" in sparse
checkout file, then remove a/b, git is not smart enough to put "!a/b"
in sparse checkout file.

> Third, other commands should try to
> bring the tree in sync with the sparse checkout list. read-tree and c=
heckout
> should remove directories which aren't in the list, perhaps throwing =
an
> error if there were changes in those directories.

Let me think about this. Not all commands should try to sync, but
perhaps some of them should.

Thank you for your feedback.
--=20
Duy
