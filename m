From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problematic git pack
Date: Thu, 31 Aug 2006 13:15:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608311301260.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44F6A198.4040902@arces.unibo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 13:15:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIkVw-0004nC-CG
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 13:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWHaLPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 07:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWHaLPM
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 07:15:12 -0400
Received: from mail.gmx.de ([213.165.64.20]:55181 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751461AbWHaLPJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 07:15:09 -0400
Received: (qmail invoked by alias); 31 Aug 2006 11:15:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 31 Aug 2006 13:15:08 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sergio Callegari <scallegari@arces.unibo.it>
In-Reply-To: <44F6A198.4040902@arces.unibo.it>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26249>

Hi,

On Thu, 31 Aug 2006, Sergio Callegari wrote:

> Now I am going to have the fixed archive and also a new archive, which I
> restarted from the latest working copy I had of my project.
> Is there any way to automatically do real "surgery" to attach one to the other
> and get a single archive with all the history?

You can "graft" the new onto the old branch:

If <40-hex-chars-old> is the commit id of the youngest commit of the 
reconstructed branch, and <40-hex-chars-new> is the commit id of the 
initial commit of the newly started branch, you can put this line into 
.git/info/grafts:

<40-hex-chars-new> <40-hex-chars-old>

This will make git believe that the initial commit is no initial commit, 
but has the old head as single parent. And yes, AFAICT all git tools 
support this. I used this technique many times to be able to merge 
unrelated developments.

NOTE! This is the quickest way if you want to have the history _locally_.

If you want to be able to distribute it (or synchronize it between your 
laptop and PC _with git!_), you can rewrite the history by either 
git-rebase, or by using cg-admin-rewritehist if you are using cogito.

Unfortunately, I do not use cogito nor git-rebase, so if you want to walk 
that path, others have to help. (And most likely, we'd put the result into 
Documentation/howto/.)

Ciao,
Dscho

P.S.: Of course, if you do not insist on a super clean history, you can 
fake a merge. Just put <40-hex-chars-old> into .git/MERGE_HEAD and commit. 
This will pretend that your new head and your old head were merged, and 
the result is the new head. This _should_ even work with git-bisect, but 
it is slightly ugly.
