From: Andreas Ericsson <ae@op5.se>
Subject: Re: Overwriting untracked working tree files (when identical)
Date: Mon, 01 Dec 2008 10:28:37 +0100
Message-ID: <4933AE45.4050400@op5.se>
References: <alpine.DEB.2.00.0811290018340.15382@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 10:30:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L756x-0003vJ-Op
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 10:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbYLAJ3P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2008 04:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbYLAJ3P
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 04:29:15 -0500
Received: from mail.op5.se ([193.201.96.20]:58344 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbYLAJ3N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 04:29:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8D14A1B814FC;
	Mon,  1 Dec 2008 10:25:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vfW2T-EUHOdd; Mon,  1 Dec 2008 10:24:57 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 2F8E91B80052;
	Mon,  1 Dec 2008 10:24:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
In-Reply-To: <alpine.DEB.2.00.0811290018340.15382@vellum.laroia.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102010>

Asheesh Laroia wrote:
> I was using git earlier today and got the familiar error:
>=20
>     "Untracked working tree file 'filename=E2=80=99 would be overwrit=
ten by merge"
>=20
> As it happens, I know that filename in my local filesystem and filena=
me=20
> in the remote git branch have the same contents.
>=20
> Would it make sense for git to check for this possibility, and if the=
=20
> working tree file is the same as the file being merged in with that=20
> filename, allow the overwrite?
>=20

That depends. git uses the work-tree to merge things. If one file is th=
e
same as that about to be written, it *might* make sense to clobber it,
but what if it's identical to the expected merge-result? Git can't know
that, but it's almost certainly a much saner approach than the other
case, where the merge can go wahoonie-shaped at a later stage and thus
require conflict resolution (which might well end up with the user
getting fed up and doing "git reset --hard" to start over). For such
cases, the file would appear to disappear, and that's a bad thing.

Overall, I think it's best if this is left as-is. The code would be too
complex for the gain it provides.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
