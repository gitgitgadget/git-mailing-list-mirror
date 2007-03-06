From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git's is_inside_git_dir too strict?
Date: Tue, 6 Mar 2007 22:46:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703062232570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <fcaeb9bf0703060741l7cbfd0f3ue443730176606db6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 22:46:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOhUV-00013D-II
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 22:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbXCFVqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 16:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbXCFVqd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 16:46:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:55595 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030250AbXCFVqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 16:46:32 -0500
Received: (qmail invoked by alias); 06 Mar 2007 21:46:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 06 Mar 2007 22:46:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2TLBqDQv2wFRBpBw1+eLQCoJpXptR9aqQSsSrCT
	nTDHegse7eV3n/
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <fcaeb9bf0703060741l7cbfd0f3ue443730176606db6@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41594>

Hi,

On Tue, 6 Mar 2007, Nguyen Thai Ngoc Duy wrote:

> I have a working directory separated from its git repository. When I
> work on this directory, I specify --git-dir argument (actually all
> happens in script so I don't have to type that much). It used to work
> but no longer since git 1.5.0.

Yes, we tried to make sure a few common errors were harder to make.

> Complaints include "cannot be used without a working tree" and "This 
> operation must be run in a work tree". Can I have the former behaviour 
> back in some ways?

Well, there is a real problem with "This operation must be run in a work 
tree". What operation is that? We tried to make it hard to overwrite 
things in $GIT_DIR by running Git operations meant for the working tree, 
and it seems like you are running one of them.

However, I think that is_bare_repository() really should check if 
$GIT_DIR is a prefix of $(pwd). Because if it is not, we are likely to run 
in a detached work tree.

If you agree, then is_inside_git_dir() might actually be a better way to 
ask if the repo is bare than is_bare_repository().

Comments?

Ciao,
Dscho
