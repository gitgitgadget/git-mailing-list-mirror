From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 20:33:25 -0500
Message-ID: <20080123013325.GB1320@mit.edu>
References: <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 02:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHUVF-0003SX-VF
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 02:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbYAWBdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 20:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbYAWBdk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 20:33:40 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:50522 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752050AbYAWBdj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 20:33:39 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0N1XRw8007825;
	Tue, 22 Jan 2008 20:33:27 -0500 (EST)
Received: from closure.thunk.org (c-66-30-1-139.hsd1.ma.comcast.net [66.30.1.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0N1XPHs025537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Jan 2008 20:33:26 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JHUUX-0006M3-Hz; Tue, 22 Jan 2008 20:33:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71486>

On Tue, Jan 22, 2008 at 04:38:37PM -0800, Linus Torvalds wrote:
> One thing I'd like somebody to check: what _does_ happen with OS X and NFS 
> (OS X as a client, not server)? In particular:
> 
>  - Is it suddenly sane and case-sensitive?

Using a Linux server, and a OS X client, over NFS, it is in
case-sensitive.  This is not unexpected, since you can mount UFS
partitions on Mac OS X, or reformat HFS+ filesystems and make them be
case-sensitive.

>  - Does the NFS client do any unicode conversion?

Nope:

# perl -CO -e 'print pack("U",0x00C4)."\n"'  | xargs touch
# ls -l | cat -v
total 0
0 -rw-r--r--   1 nobody  nobody  0 Jan 22 20:30 M-CM-^D

It's pretty clear the Unicode conversion is being done in HFS+, not in
the VFS layer of Mac OS X.

So presumably if and when Mac OS adopts ZFS, they will be able to be
free of this mess, at least if they care about being compatible with
Solaris.

						- Ted
