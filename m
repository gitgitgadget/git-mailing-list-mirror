From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Fri, 28 Jan 2011 23:01:11 +0100
Message-ID: <4D433CA7.9060200@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com> <4D4063EC.7090509@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 23:01:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiwNx-0002G3-QM
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 23:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab1A1WBh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 17:01:37 -0500
Received: from india601.server4you.de ([85.25.151.105]:52198 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab1A1WBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 17:01:36 -0500
Received: from [192.168.2.104] (p4FFD9AF7.dip.t-dialin.net [79.253.154.247])
	by india601.server4you.de (Postfix) with ESMTPSA id 4670A2F8091;
	Fri, 28 Jan 2011 23:01:35 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D4063EC.7090509@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165644>

Am 26.01.2011 19:11, schrieb Ren=E9 Scharfe:
> - Make git grep report non-matching path specs (new feature).

This is a bit complicated because grep can work on files, index entries
as well as versioned objects and supports wildcards, so it's not that
easy to tell if a path spec matches something or is a rather typo.  But
it's not impossible either, of course.

What you can do until someone implements it is to simply omit the doubl=
e
dash.  Path specs are then looked up as revs and files and you'll get a=
n
error if they can't be found:

	# In the Linux kernel repo; we enter the wrong directory:
	$ cd drivers
	$ git grep blacklist_iommu v2.6.27 intel-iommu.c
	fatal: ambiguous argument 'intel-iommu.c': unknown revision or path no=
t in the working tree.
	Use '--' to separate paths from revisions

	# Now we enter the right one and try again:
	$ cd pci
	$ git grep blacklist_iommu v2.6.27 intel-iommu.c
	v2.6.27:intel-iommu.c:static int blacklist_iommu(const struct dmi_syst=
em_id *id)
	v2.6.27:intel-iommu.c:		.callback =3D blacklist_iommu,

This won't work in bare repos or with wildcards, but it's better than
nothing.  And it saves you a few keystrokes.

Ren=E9
