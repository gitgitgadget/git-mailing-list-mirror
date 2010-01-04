From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: display dirty submodule working directory in git gui and
 gitk
Date: Mon, 4 Jan 2010 10:44:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
References: <4B3F6742.6060402@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 10:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRjPc-0000wT-I4
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 10:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184Ab0ADJjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 04:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068Ab0ADJjk
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 04:39:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:53282 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752217Ab0ADJjj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 04:39:39 -0500
Received: (qmail invoked by alias); 04 Jan 2010 09:39:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 04 Jan 2010 10:39:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VtekKzCWVJaJR/2AT0w4r3YaU8KcIuz7MFiStHY
	gt6zikTWnquWBF
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B3F6742.6060402@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136104>

Hi,

On Sat, 2 Jan 2010, Jens Lehmann wrote:

> Now that we have much better output when displaying diffs of submodules 
> in git gui and gitk (many thanks to all involved!), another usability 
> issue shows up: A dirty working directory of a submodule isn't visible 
> in git gui or gitk.
> 
> So you might think a "submodule update" would be ok - as you see no 
> changes - just too see it fail because the submodules working directory 
> is dirty.
> 
> Or - even worse - you /think/ you committed your changes in a submodule 
> while you didn't. That can lead to 'interesting' problems which can be 
> pretty hard to diagnose (like breaking builds on other peoples 
> machines).
> 
> 
> A possible solution could look like this:
> 
> AFAICS, git gui and gitk use "git diff-files" both to get the file names 
> of unstaged local changes and to later display the actual differences.
> 
> If they could tell the diff core to also check the submodule working 
> directories and to output an extra line - maybe something like 
> "Submodule <name> contains uncommitted local changes" - when a 
> submodules working directory is dirty, git gui and gitk could show the 
> submodules state adequately.

The real problem is that submodules in the current form are not very well 
designed.  For example, a submodule being at a different commit than in 
the superproject's index is not as fatal as the submodule having changes.

So in the long run, IMHO a proper redesign of the submodules would not 
make only a little sense (it does not help, though, that those who 
implemented and furthered the current approach over other discussed 
approaches do not use submodules themselves -- not even now).

In ths short run, we can paper over the shortcomings of the submodules by 
introducing a command line option "--include-submodules" to 
update-refresh, diff-files and diff-index, though.

The implementation might be a bit tricky as parts of Git's source code 
still use the_index, but at least adding the submodule's object database 
is no longer that difficult.

Ciao,
Dscho
