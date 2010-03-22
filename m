From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: Fix display of copyright symbol in non-utf-8
 locales
Date: Mon, 22 Mar 2010 18:45:17 -0500
Message-ID: <20100322234517.GB2168@progeny.tock>
References: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
 <1268418709-4998-2-git-send-email-patthoyts@users.sourceforge.net>
 <1268418709-4998-3-git-send-email-patthoyts@users.sourceforge.net>
 <20100320061452.GA26224@progeny.tock>
 <87pr2wc6bo.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Mar 23 00:45:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtrJH-00077R-FM
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 00:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134Ab0CVXpW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 19:45:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36706 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab0CVXpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 19:45:21 -0400
Received: by gyg8 with SMTP id 8so2922979gyg.19
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 16:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Tcvp84G9PX0BmNg7qyGr8T0Llj6dyv8D2IormzZfwBA=;
        b=FL+yWzZcLjnwvQmehYTrcG6YrgKk8SBdMof6Emu4EpPy18/S1beOwbk4zgAZY/NWDK
         vNjgvnCgTKq56Ugs+ZKfOA+mq9XA/GoE8qrR9KSlcYZPBUWHhe7Eqghd3eX/TAbIlDRd
         HCiJJStwhX7ndUFQba50aIpgeWGH8B/UQgu3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=T17nO64bEBhmdf7mJKNBz82EI9ZjDxqH3OTUFi7TUZdnFVhrjoYzvvX2qs/XZMzwu8
         e+rUGjoogSNqrShg0adw5H3xre+Ls1nG1NAjgech3/EdUA2RVXRNlMtK4hshtfYK9FbV
         5C9mUappP4xj71XDxOgmHodZmqp1Cxq5Y+AzE=
Received: by 10.100.55.20 with SMTP id d20mr5518099ana.66.1269301520422;
        Mon, 22 Mar 2010 16:45:20 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm5419383iwn.2.2010.03.22.16.45.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 16:45:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87pr2wc6bo.fsf@fox.patthoyts.tk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142977>

Pat Thoyts wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/gitk
>> +++ b/gitk
>> @@ -1,6 +1,6 @@
>>  #!/bin/sh
>>  # Tcl ignores the next line -*- tcl -*- \
>> -exec wish "$0" -- "$@"
>> +exec wish -encoding utf-8 "$0" -- "$@"
[...]
> I would much rather see any fault in the makefile fixed than use
> source -encoding in all the various places this script might get
> loaded from.

Good point: git-gui.sh does not use =E2=80=98source=E2=80=99 but runs t=
he moral
equivalent of
=20
 set wish [info executable]
 eval exec $wish gitk $revs "--" "--"

to avoid starting a shell.  Is it really so expensive to start a
shell?  This means that, for example, if some insane person were to
rewrite gitk in C, then git gui would have to be adjusted before the
result could be used.

> THere are two characters in this file that are not ASCII
> and one of them is in a comment. We could even just use (c) to
> simplify this. However, \u00a9 is the correct unicode escape sequence
> for tcl to get a copyright character into the script in a way that is
> independent of the encoding. The escape sequence should be passed
> through unchanged in any translations - tcl wants to see exactly
> \u00a9 and everyone is using a copyright glyph here.=20

So we should fix the Makefile.  The problem is that everything
Tcl-related seems to assume files it sees will be in either the
current locale=E2=80=99s encoding or ISO-8859-1 unless told otherwise, =
as far
as I can tell.  The entire gitk source tree, on the other hand, is in
UTF-8.

Ideas?
Jonathan
