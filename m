From: solsTiCe d'Hiver <solstice.dhiver@gmail.com>
Subject: Re: [bash-completion] syntax error near unexpected token '<' on
 line 123 in bash_completion.d/git
Date: Tue, 27 Jul 2010 11:24:15 +0200
Message-ID: <1280222655.9955.32.camel@soho.example.org>
References: <1280056320.7883.9.camel@soho.example.org>
	 <4C4C982C.20904@pileofstuff.org> <1280096368.7211.2.camel@soho.example.org>
	 <4C4E00AE.7010904@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 11:24:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdgOj-0004wf-Us
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 11:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813Ab0G0JYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 05:24:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39624 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab0G0JYX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 05:24:23 -0400
Received: by wyf19 with SMTP id 19so2856002wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=dVenMlLXnxdb1Nr7iGWYBt4HbdwTwv2Z0IhaULSjLPs=;
        b=wCUdh0qF/rFxwIM5bu9N/nyUayOEnFOLszQtg3XiLtXwySV40vHwM9v0gf6m0P9czH
         26pWh12DtylNyzyKL39J/rBIhRFja+mq/xwHFSssNEhweYWvtTlY10ye24rI+qT539/C
         C/21Y7fCgb+ItLHS5munulJnnzmbRVZyKa28I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=urjwOVGwBEto1w2wIIHV2/gvCRzBVRkCQUFcPIvT0ynDRH46eGrngot7/qZpAm9Dfq
         2YmWK8jsxxSHb+Oceu+Xcw6PLX3TklR/YOxHY1LTQ+wvizQI1e4NeSN+YXJVIaixG+95
         QaQmwbZ22VSx1wGBr6WrcZQLr43tnCA6dVswM=
Received: by 10.227.147.204 with SMTP id m12mr8569269wbv.131.1280222661946;
        Tue, 27 Jul 2010 02:24:21 -0700 (PDT)
Received: from [192.168.0.50] (ARennes-553-1-38-213.w86-214.abo.wanadoo.fr [86.214.125.213])
        by mx.google.com with ESMTPS id o84sm2542223wej.13.2010.07.27.02.24.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 02:24:18 -0700 (PDT)
In-Reply-To: <4C4E00AE.7010904@pileofstuff.org>
X-Mailer: Evolution 2.30.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151922>

Le lundi 26 juillet 2010 =C3=A0 22:39 +0100, Andrew Sayers a =C3=A9crit=
 :=20
> This time, could you tell me what the following debug messages print:
>=20
> echo $BASHOPTS -- $SHELLOPTS -- $POSIXLY_CORRECT
> tr '\0' ' ' < /proc/$$/cmdline ; echo
>=20
cmdhist:expand_aliases:extglob:extquote:force_fignore:interactive_comme=
nts:progcomp:promptvars:sourcepath -- braceexpand:hashshell:interactive=
-comments:posix -- y
/bin/sh /usr/sbin/gdm

> Could you also have a look at /bin/sh and any other files that might =
be
> (incorrectly?) symlinked to bash?
>=20
I have included gdm in the DAEMON list in my /etc/rc.conf. I tried to
run it from inittab in a more usual way and get the same ?!

When I looked at /usr/sbin/gdm, I found the cause of this problem, look
at that

#!/bin/sh
#
# A script so that
#    1) we read the standard system env vars
#    2) syadmins/integrators can add their own private options etc...

test -f /etc/profile && . /etc/profile

# Make sure LANG is set
#
if [ -z "$LANG" ]
then
  if [ -f /etc/sysconfig/language ]
  then
    LANG=3D`. /etc/sysconfig/language; echo $RC_LANG`
    export LANG
  fi
fi

exec /usr/sbin/gdm-binary "$@"

Note: it's not a custom archlinux script. This is straight from gdm
release 2.30.4

so it's a non-login shell (sh) script that source /etc/profile and
breaks standard behavior. no wonder that bash_completion stuff is run
there
