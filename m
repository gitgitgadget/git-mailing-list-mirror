From: Brian Riehman <briehman@gmail.com>
Subject: git stash syntax error under AIX 5.3
Date: Wed, 3 Nov 2010 09:05:38 -0500
Message-ID: <AANLkTimSpPLfqv07+Tmcj-iM0W+p86V2-HRrq71Umdtr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 15:05:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDdyC-0001V7-GV
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 15:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab0KCOFk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 10:05:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53229 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab0KCOFi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 10:05:38 -0400
Received: by ywc21 with SMTP id 21so468634ywc.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=1bqxaV8sJcFcHcXQfkOIBv9IHaLiEX4pFcSbcXK8NKU=;
        b=PUQ21IDRmeUqW+XLFEzG9IvABQmp8aHAIQuyuxT5dfSlX6xsmP/hDmFJO+ERoeEQuJ
         XqFNgtOeiQj2zTcAs+xoQ8Ru188mJwn7atgFcOxFkD1xqI/w9E6QA5Ac2RbKD+jO2pLj
         dDG0Cjq0QUPGRVW3LItZjXRFaExuua4HMnnbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=cOSXWMcT6uXXZaikcIBsmkmiQWoUhiQ+IES7BMUm6lI/TKWOBtHt+wYQt61bBsYTEd
         ZjDdwRy5ZEim2xCvXR3SKN3FXWxb7WZZrQirFlc2ZfN/wMvto4KfBdAsgayM7z/DyO9+
         s6/c3N4wG66L6aai3CtlAxUODSDETLM2Y1+dY=
Received: by 10.150.199.10 with SMTP id w10mr1315478ybf.203.1288793138271;
 Wed, 03 Nov 2010 07:05:38 -0700 (PDT)
Received: by 10.150.95.8 with HTTP; Wed, 3 Nov 2010 07:05:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160599>

The stash command relies on bash-specific shell scripting techniques
when the shebang line lists Bourne shell. =A0This was introduced in
b0f0ecd97924ee775e7f3b29366133448f4f8e15. =A0The error was noticed when
running under AIX 5.3:

$ /bin/sh -n git-stash.sh
git-stash.sh[63]: syntax error at line 498 : `"' unmatched
$ /bin/sh -n git-stash-modified.sh
$ diff git-stash.sh git-stash-modified.sh
314,321c314,321
< =A0 =A0 =A0 if test "${REV}" !=3D "${REV%{*\}}"
< =A0 =A0 =A0 then
< =A0 =A0 =A0 =A0 =A0 =A0 =A0 # maintainers: it would be better if git =
rev-parse indicated
< =A0 =A0 =A0 =A0 =A0 =A0 =A0 # this condition with a non-zero status c=
ode but as of
1.7.2.1 it
< =A0 =A0 =A0 =A0 =A0 =A0 =A0 # it did not. So, we use non-empty stderr=
 output as a
proxy for the
< =A0 =A0 =A0 =A0 =A0 =A0 =A0 # condition of interest.
< =A0 =A0 =A0 =A0 =A0 =A0 =A0 test -z "$(git rev-parse "$REV" 2>&1 >/de=
v/null)" ||
die "$REV does not exist in the stash log"
< =A0 =A0 =A0 fi
---
> # =A0 =A0 if test "${REV}" !=3D "${REV%{*\}}"
> # =A0 =A0 then
> # =A0 =A0 =A0 =A0 =A0 =A0 # maintainers: it would be better if git re=
v-parse indicated
> # =A0 =A0 =A0 =A0 =A0 =A0 # this condition with a non-zero status cod=
e but as of 1.7.2.1 it
> # =A0 =A0 =A0 =A0 =A0 =A0 # it did not. So, we use non-empty stderr o=
utput as a proxy for the
> # =A0 =A0 =A0 =A0 =A0 =A0 # condition of interest.
> # =A0 =A0 =A0 =A0 =A0 =A0 test -z "$(git rev-parse "$REV" 2>&1 >/dev/=
null)" || die "$REV does not exist in the stash log"
> # =A0 =A0 fi
$ head -1 git-stash.sh
#!/bin/sh

Removing the code from that commit causes the stash command to work
properly. =A0I am not sure if other systems have /bin/sh symbolically
linked to /bin/bash, but in AIX the /bin/sh fails to properly parse
the default git-stash.sh.

I am not sure how to correct this logic since Bourne shell does not
have an equally powerful search and replace variable substitution
operator nor do I know exactly what this is meant to filter out of the
variable. =A0For now, I have simply patched the source to comment out
those lines.

Brian Riehman
