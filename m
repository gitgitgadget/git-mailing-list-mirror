From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Tue, 28 Apr 2015 23:58:07 +0200
Organization: <)><
Message-ID: <20150428215807.GE1433@camelia.ucw.cz>
References: <553CD3DA.9090700@web.de> <xmqqzj5uxhls.fsf@gitster.dls.corp.google.com> <20150427061115.GB2766@camelia.ucw.cz> <553E86BD.7030401@kdbg.org> <553E91CD.9060205@web.de> <553FD48B.1010608@kdbg.org> <xmqq7fswuj1s.fsf@gitster.dls.corp.google.com> <553FEB4F.7050409@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	sandals@crustytoothpaste.net
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:58:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnDWB-0007kk-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 23:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030901AbbD1V6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 17:58:12 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56125 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030811AbbD1V6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 17:58:10 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (82-73-239-109.cust.centrio.cz [109.239.73.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 87EA21C00E8;
	Tue, 28 Apr 2015 23:58:08 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id t3SLw8up001797;
	Tue, 28 Apr 2015 23:58:08 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id t3SLw7Vw001796;
	Tue, 28 Apr 2015 23:58:07 +0200
Content-Disposition: inline
In-Reply-To: <553FEB4F.7050409@kdbg.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267946>

Hello Hannes,

let me correct my previous statement:

On Mon, Apr 27, 2015 at 08:58:05PM +0200, Johannes Sixt wrote:
> When I commit my C source code files with CRLF into the repository  
> (because I do not set any line ending options or configurations or any  
> 'text' attributes or similar), do I then commit binary files or text  
> files? Should I expect not to see any diffs?

Of course, you can see diffs.  The files are not binary in that
sense.

Johannes Sixt <j6t@kdbg.org> writes:
> I set none of these. But I do commit CRLF and expect to get CRLF
> back. [...]

That works.  You will not encounter any problem.  (Supposing you
do not change the line ending options, of course.)

Finally, let me explain my previous statement:
> Am 27.04.2015 um 08:11 schrieb Stepan Kasal:
>> Git does not support CRLF as the internal line separator.

I'm often asked: "How do I set up git so that it uses CRLF in text
files in the repository and checks them out with CRLF on Windows and
with LF on unixy systems?"

My answer to that question always was that you cannot configure the
internal line separator in git repo, it is always LF.  Your only
chance to support both line endings is to have LF in the repo and
configure the Windows client to do the conversion.

>> If you commit file in binary mode with CRLF, you are on your own.

OK, scratch the word "binary".  The files in the repo are actually
text files.  But each text line is contains one more char than you
would think.  From time to time, this lurks:

1) Does "git grep ';$' HEAD" find anything?
2) What about "git grep ';.$' HEAD" ?
   Or "git grep `printf ';\r$' HEAD"  ?

3) If you try things like
       git diff HEAD^^..HEAD^ >outfile.diff
   and then open outfile.diff with a suitable editor (e.g. vim), you
   can see an extra ^M at the end of some lines (the content ones).

This is why I tell users that they are on their own if they decide to
use the setup you described.

Have a nice day,
	Stepan
