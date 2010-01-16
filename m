From: Michael Poole <mdpoole@troilus.org>
Subject: Re: Integration-Manager Workflow
Date: Sat, 16 Jan 2010 14:06:16 -0500
Message-ID: <87r5ppx42f.fsf@troilus.org>
References: <201001161849.32211.aribao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Adri=C3=A1n?= Ribao =?utf-8?Q?Mart=C3=ADnez?= 
	<aribao@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 20:13:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWE5n-00039G-BE
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 20:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab0APTNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 14:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429Ab0APTNq
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 14:13:46 -0500
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54832 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755970Ab0APTNp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 14:13:45 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jan 2010 14:13:45 EST
Received: from source ([74.125.92.147]) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS1IP6flCjGpbk75vdRqcUKOi7wzBKCbA@postini.com; Sat, 16 Jan 2010 11:13:45 PST
Received: by qw-out-1920.google.com with SMTP id 9so22656qwj.30
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 11:13:44 -0800 (PST)
Received: by 10.224.44.164 with SMTP id a36mr3273350qaf.149.1263668780257;
        Sat, 16 Jan 2010 11:06:20 -0800 (PST)
Received: from graviton.troilus.org (pool-72-83-66-147.washdc.east.verizon.net [72.83.66.147])
        by mx.google.com with ESMTPS id 2sm992048qwi.57.2010.01.16.11.06.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 11:06:19 -0800 (PST)
In-Reply-To: <201001161849.32211.aribao@gmail.com> (=?utf-8?Q?=22Adri?=
 =?utf-8?Q?=C3=A1n?= Ribao =?utf-8?Q?Mart=C3=ADnez=22's?=
	message of "Sat, 16 Jan 2010 18:49:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137250>

Adri=C3=A1n Ribao Mart=C3=ADnez writes:

> What happens if they accidentally work in the develop branch instead =
of creating a new one? What should we do?
> I think I should never fetch from teamx.myserver.net to avoid this pr=
oblem and instead track the branch like in step 2. Is this correct?

It is simpler than that.

If you just use "git remote add teamx teamx.myserver.net:/...." (rather
than cloning your integration repository from one of those
repositories), it will leave all your local branches alone -- any
changes to teamx.myserver.net's "develop" branch will only show up in
the teamx/develop tracking branch.

The reason is that a fetch or pull only merges into your develop branch
if your branch.develop.merge git-config entry specifies an upstream
branch -- more detail can be found in the git-config man page under
branch.<name>.remote and branch.<name>.merge.

Those entries are set up when you clone from a repository, and through
some other commands, but if teamx clones from the integration server,
they can only mess up their own develop branch.  If/when you push into
teamx's repository from yours, you can forcibly overwrite any of those
accidental changes.  (Normally, though, the push would only do a
fast-forward merge -- so if teamx made such a mistake, the merge will
fail until you address the mismatch.)

Michael Poole
