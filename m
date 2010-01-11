From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Remove empty directories when checking out a commit with fewer submodules
Date: Mon, 11 Jan 2010 10:32:45 +0100
Message-ID: <201001111032.45637.johan@herland.net>
References: <1263178794-3140-1-git-send-email-peter@pcc.me.uk> <alpine.DEB.1.00.1001110954410.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Collingbourne <peter@pcc.me.uk>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 10:33:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUGeT-0006X9-D9
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 10:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab0AKJdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 04:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854Ab0AKJdO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 04:33:14 -0500
Received: from smtp.opera.com ([213.236.208.81]:39815 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab0AKJdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 04:33:13 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id o0B9TnmV017446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 11 Jan 2010 09:29:55 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.1001110954410.4985@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136625>

On Monday 11 January 2010, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 11 Jan 2010, Peter Collingbourne wrote:
> > Change the unlink_entry function to use rmdir to remove submodule
> > directories.
>
> NAK.  We should not even try to _unlink_ submodule subdirectories; it
> would be _way_ too easy to lose data that way.  Remember, submodules
> are a totally different beast from regular files.  They can contain
> valuable, yet uncommitted data, that is not even meant to be
> committed.
>
> So you say if the submodule directories are empty, it is safe?  Not
> so. They will never be empty: there is always .git/, and _that_ can
> contain valuable information that you do not want to throw away, too.
>  Think of unpushed branches, for example.  That would be _fatal_ if
> you rmdir() that for me.
>
> So please, no,

I believe what Peter is referring to is the _empty_ directories (and 
that includes no .git/) that are placeholders for submodules that are 
deliberately not cloned/checked out. This lets you do things like:

	git clone url:to/some/project
	cd project
	git checkout some-other-branch-with-different-submodules
	git submodule update --init

Of course, once you clone/checkout a submodule, there will be contents 
in that directory (including the .git/), and Git should not try to 
remove it.


Have fun! :)

...Johan



-- 
Johan Herland, <johan@herland.net>
www.herland.net
