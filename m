From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: 'git add' corrupts repository if the working directory is
 modified as it runs
Date: Sat, 13 Feb 2010 18:29:24 +0200
Message-ID: <20100213162924.GA14623@Knoppix>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock>
 <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Zygo Blaxell <zblaxell@gibbs.hungrycats.org>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 13 17:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgKuW-00060X-7l
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 17:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416Ab0BMQ3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 11:29:31 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:49919 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757368Ab0BMQ3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 11:29:31 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id E6CDA18CF97;
	Sat, 13 Feb 2010 18:29:29 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A02D75E3E7F; Sat, 13 Feb 2010 18:29:29 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 99E60E51B4;
	Sat, 13 Feb 2010 18:29:25 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <201002131539.54142.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139811>

On Sat, Feb 13, 2010 at 03:39:53PM +0100, Thomas Rast wrote:
> On Saturday 13 February 2010 14:39:52 Ilari Liusvaara wrote:
> > On Sat, Feb 13, 2010 at 06:12:38AM -0600, Jonathan Nieder wrote:
> > > 
> > > With the current code, write_sha1_file() will hash the file, notice
> > > that object is already in .git/objects, and return.  With a
> > > read-hash-copy loop, git would have to store a (compressed or
> > > uncompressed) copy of the file somewhere in the meantime.
> > 
> > It could be done by first reading the file and computing hash,
> > if the hash matches existing object, return that hash. Otherwise
> > read the file for object write, hashing it again and use that value
> > for object ID.
> 
> That is still racy.  The real problem is that the file is mmap()ed,
> and git then first computes the SHA1 of that buffer, next it
> compresses it.[*]

Hmm... One needs to copy the data block at time into temporary buffer
and use that for feeding zlib and SHA-1. That ensures that whatever
SHA-1 hashes and zlib compresses are consistent.

-Ilari
