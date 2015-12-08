From: Sam Hocevar <sam@hocevar.net>
Subject: Re: [PATCH 1/2] git-p4: support multiple depot paths in p4 submit
Date: Tue, 8 Dec 2015 12:41:06 +0100
Message-ID: <20151208114106.GB48528@hocevar.net>
References: <20151205112203.GA15745@hocevar.net>
 <F328D5D9-754A-41CC-A7B2-993B9315ED33@gmail.com>
 <20151207185129.GA48528@hocevar.net>
 <14B51656-26D1-4805-9F07-102CBD81B387@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Pete Wyckoff <pw@padd.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 12:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Gdu-0006lz-F9
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 12:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933051AbbLHLlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 06:41:10 -0500
Received: from poulet.zoy.org ([193.200.42.166]:49057 "EHLO smtp.zoy.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932632AbbLHLlI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 06:41:08 -0500
Received: by smtp.zoy.org (Postfix, from userid 1000)
	id 2C7FF361262; Tue,  8 Dec 2015 12:41:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <14B51656-26D1-4805-9F07-102CBD81B387@gmail.com>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282155>

On Tue, Dec 08, 2015, Lars Schneider wrote:

> >   Would a refactor of lib-git-p4.sh (and probably all git-p4 tests) to
> > support multiple depots be acceptable and/or welcome? I prefer to ask
> > before I dig into the task.
> 
> Can you outline your idea a bit? Are you aware of the following way to define client specs: [1] ? Would that help?

   That's the idea, but the bug occurs when the client view looks like this:

     //depot/... //client/dir1/...
     //depot2/... //client/dir2/...

   And is then cloned with (it is not legal in Perforce to specify //...
directly to grab both depots at once):

     git p4 clone --use-client-spec //depot/... //depot2/...

   Then when a file is modified in dir2/, git p4 submit does not elect it
for the changelist. A file in dir1/ will work fine.

   Unfortunately the current test suite assumes everything is under
//depot/ so in order to write a test for this situation there are a few
things to change in lib-git-p4.sh.

Regards,
-- 
Sam.
