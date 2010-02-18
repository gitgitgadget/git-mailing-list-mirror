From: Avery Pennarun <apenwarr@gmail.com>
Subject: Is there something like a git format-patch --squash?
Date: Thu, 18 Feb 2010 14:45:54 -0500
Message-ID: <32541b131002181145w44d69e9eo150d08f34273cefb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 20:46:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiCKM-0005cg-Ut
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 20:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758452Ab0BRTqQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 14:46:16 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:38279 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758383Ab0BRTqO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 14:46:14 -0500
Received: by ywh35 with SMTP id 35so1351040ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 11:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=6XIlAL+RK2ED62/Dt0Bf/AP0JSvDtmacSuvxJyIOc/Y=;
        b=ACLN964f5MRXw1WRF/Lvg2w9idJxLzzXzpt79Ao+DIqT7k3B8jGUF8gHNbFnLkSo/y
         fzix5gE0sSxRqFXh1HZ/1B5iaswonXsTnxsqECtQl9Z+aUwaPn7kCFl8TMF0pICNQx5a
         QY/N8Vrf+NeKiPACwzEF5lZnq/CVaAowHf6KA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=pTrTqhbHdMcsPa9g8+qKO+R9foWfo9/O2hNhjTxBjsJgv8wq6Ch3knvoSkszunWJ/O
         CtDAYZUQjiWmkpPsrfiqUNSAp598CfHWZtTAKAGj6EJDmzES41pI5iOcLBQk2knt4QD3
         +LqKU5ObiypZaq3Ivn6EVapZk/SC+Rjo0SFf0=
Received: by 10.150.29.19 with SMTP id c19mr1775920ybc.13.1266522374173; Thu, 
	18 Feb 2010 11:46:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140364>

On Thu, Feb 18, 2010 at 1:38 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Thu, Feb 18, 2010 at 12:11 AM, Jeff King <peff@peff.net> wrote:
>> One simple strategy would be to squash all side-branch development i=
nto
>> a single commit.
>
> Something like this (replace MY_START_BRANCH with your starting
> branch, and do this in a clone of your repository so you don't destro=
y
> anything by accident):
>
> =A0 =A0 =A0 =A0parent=3D""
> =A0 =A0 =A0 =A0git rev-list --first-parent --reverse =A0| while read =
commit; do
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if [ -z "$parent" ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git checkout -f $commi=
t
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git clean -fdx
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git diff $parent $comm=
it | git apply --index
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git commit -C $commit
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parent=3D$commit
> =A0 =A0 =A0 =A0done

In the above, in the 'else' clause, what I really wanted was something =
like:

   git format-patch --stdout --squash $parent..$commit

with one big "| git am" at the end of the loop.

However, format-patch seems to have no way of just producing a single
patch with all the changes from a particular branch.  Is there some
other easy command that would do what I want?  It seems like something
that someone would have wanted before now.

Thanks,

Avery
