From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH 2/4] git-shell-commands: Add a command to list bare repos
Date: Mon, 26 Jul 2010 16:28:41 -0700
Message-ID: <AANLkTi=WNQ1=dx3hssgs_8Vkj6gEmrn7Z+KKdELnq+Ad@mail.gmail.com>
References: <1279602972-1264-1-git-send-email-gdb@mit.edu>
	<1279602972-1264-3-git-send-email-gdb@mit.edu>
	<7vlj96m4mc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j.sixt@viscovery.net, git@vger.kernel.org, avarab@gmail.com,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 01:28:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdX6L-00016A-9a
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 01:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab0GZX2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 19:28:46 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:56887 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755322Ab0GZX2p convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 19:28:45 -0400
X-AuditID: 12074425-b7bfeae000000a0d-67-4c4e1a2eead0
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 3E.02.02573.E2A1E4C4; Mon, 26 Jul 2010 19:28:46 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o6QNShYk021142
	for <git@vger.kernel.org>; Mon, 26 Jul 2010 19:28:43 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6QNSgEv029855
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 26 Jul 2010 19:28:43 -0400 (EDT)
Received: by iwn7 with SMTP id 7so3147900iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 16:28:42 -0700 (PDT)
Received: by 10.231.173.9 with SMTP id n9mr2741107ibz.146.1280186921695; Mon, 
	26 Jul 2010 16:28:41 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Mon, 26 Jul 2010 16:28:41 -0700 (PDT)
In-Reply-To: <7vlj96m4mc.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAhVGFPIVRtIh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151903>

>> @@ -0,0 +1,5 @@
>> +#!/bin/sh
>> +set -eu
>> +
>> +print_if_bare_repo=3D'[ "$(git --git-dir=3D"$1" rev-parse --is-bare=
-repository)" =3D true ] && echo "${1#./}"'
>
> That's a very long line you have here. =A0It might be better to do sp=
lit the
> line perhaps like this for readability:
>
> print_if_bare_repo=3D'
> =A0 =A0 =A0 =A0if "$(git --git-dir=3D"$1" rev-parse --is-bare-reposit=
ory)" =3D true
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf "%s\n" "${1#./}"
> =A0 =A0 =A0 =A0fi
> '
Sure, this seems reasonable.  Done in the latest version of my patch
series.  I also added a 2>/dev/null to the 'find' to discard
unnecessary error output.

> It is unclear why it limits its listing only to bare repositories. =A0=
"It's
> my design decision" is a perfectly acceptable answer, but no matter w=
hat
> the reasoning is, it needs to be documented as a part of "How to use =
this"
> insn to the users. =A0A separate file README in contrib/git-shell-com=
mands
> that reads like:
>
> =A0 =A0 =A0 =A0Any bare repository whose name ends with ".git" under =
your home
> =A0 =A0 =A0 =A0directory is visible by "list" extended command (no ot=
her git
> =A0 =A0 =A0 =A0repositories are visible).
>
> would probably be a good start.
Yes, basically "it's my design decision" is the answer here.  I now
include a contrib/git-shell-commands/README, which contains the
following text regarding 'list':
"""
list: Displays any bare repository whose name ends with ".git" under
user's home directory.  No other git repositories are visible,
although they might be clonable through git-shell.  'list' is designed
to minimize the number of calls to git that must be made in finding
available repositories; if your setup has additional repositories that
should be user-discoverable, you may wish to modify 'list'
accordingly.
"""

>> +find -type d -name "*.git" -exec sh -c "$print_if_bare_repo" -- \{}=
 \; -prune
>
> Also do you need "set -eu" at the beginning? =A0I don't see it servin=
g a
> useful purpose (other than being a development aid, that is).
Yeah, it's was just a development aid.  I've removed the "set -eu" line=
=2E
