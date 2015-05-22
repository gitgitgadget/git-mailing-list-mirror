From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6 2/2] mergetools: add winmerge as a builtin tool
Date: Fri, 22 May 2015 12:58:03 -0700
Message-ID: <20150522195802.GA26066@gmail.com>
References: <1432112843-973-1-git-send-email-davvid@gmail.com>
 <1432112843-973-2-git-send-email-davvid@gmail.com>
 <20150520130929.Horde.vYwOuIDRpi6hr15rOUbW1w7@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 22 21:58:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvt5C-0000FN-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 21:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411AbbEVT6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2015 15:58:10 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33450 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048AbbEVT6J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 15:58:09 -0400
Received: by padbw4 with SMTP id bw4so27536164pad.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rilUYAqGHqhAOkbown83JK9on1etzZyh98aeqw8qHWs=;
        b=KE0LGVG1QD/OXYc2SyqW77/lSmGIexqgl+Npc+iaIFnOds8vGFrT9/5REHM8DFqcNZ
         7yeRpZAa3jotYXK2lF2UzZCl3kV6nSRiDQodJmTaMObO9zZ7C/1c4JL6A5V0BaONKNtD
         B/QoPgoBZLN00SxXv1uZHYX2+9yB7QrXNFCxvWEQ2HWIUsuEMiqK57Dz/hT+QCXjkVIr
         TP3BUPNBRAXA5qvbgM5cwFDby0SrJ68DTWiRRlt0aGSWGDIFN0V9gsSj8HWyKmRIilrH
         3KVuuxQuGEZjVZFhEM7U/jHNinRR2cGJtcVAeY3ghfr4Px/eH8wWFGGPYso/c1+7Z5zZ
         4M9A==
X-Received: by 10.70.53.99 with SMTP id a3mr18454106pdp.169.1432324688646;
        Fri, 22 May 2015 12:58:08 -0700 (PDT)
Received: from gmail.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPSA id b10sm2930179pdj.0.2015.05.22.12.58.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 12:58:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150520130929.Horde.vYwOuIDRpi6hr15rOUbW1w7@webmail.informatik.kit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269754>


[just wrapping up the unaswered questions in this thread]

On Wed, May 20, 2015 at 01:09:29PM +0200, SZEDER G=C3=A1bor wrote:
>=20
> Quoting David Aguilar <davvid@gmail.com>:
>=20
> >+translate_merge_tool_path() {
> >+	# Use WinMergeU.exe if it exists in $PATH
> >+	if type -p WinMergeU.exe >/dev/null 2>&1
> >+	then
> >+		printf WinMergeU.exe
> >+		return
> >+	fi
> >+
> >+	# Look for WinMergeU.exe in the typical locations
> >+	winmerge_exe=3D"WinMerge/WinMergeU.exe"
>=20
> This variable is not used elsewhere, right?  Then you might want to
> mark it as local to make this clear.


"local" is a bash-ism, otherwise that'd be a good idea.


> >+	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=
=3D' |
> >+		cut -d '=3D' -f 2- | sort -u)
> >+	do
> >+		if test -n "$directory" && test -x "$directory/$winmerge_exe"
> >+		then
> >+			printf '%s' "$directory/$winmerge_exe"
> >+			return
> >+		fi
> >+	done
> >+
> >+	printf WinMergeU.exe
>=20
> Please pardon my ignorance and curiosity, but what is the purpose of
> this last printf?
> It outputs the same as in the case when winmerge is in $PATH at the
> beginning of the function.  However, if we reach this printf, then
> winmerge is not in $PATH, so what will be executed?


This function maps what we call the tool (winmerge) to the actual execu=
table.
That last printf provides the following behavior:

	$ git difftool -t winmerge HEAD~
=09
	Viewing (1/1): 'mergetools/winmerge'
	Launch 'winmerge' [Y/n]:
	The diff tool winmerge is not available as 'WinMergeU.exe'
	fatal: external diff died, stopping at mergetools/winmerge

It ensures that the user sees 'WinMergeU.exe' in the error message.
That way the user can resolve the problem by e.g. adjusting their $PATH=
,
or realizing that they don't have WinMergeU.exe installed.
--=20
David
