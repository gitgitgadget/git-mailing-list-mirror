From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 7 Aug 2007 19:11:31 +0200
Message-ID: <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site> <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Brian Downing <bdowning@lavos.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 19:11:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IISa4-0008DF-RH
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 19:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbXHGRKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 13:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756625AbXHGRKt
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 13:10:49 -0400
Received: from mailer.zib.de ([130.73.108.11]:37098 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366AbXHGRKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 13:10:48 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l77HAed3023471;
	Tue, 7 Aug 2007 19:10:40 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l77HAdWe016415
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 7 Aug 2007 19:10:39 +0200 (MEST)
In-Reply-To: <20070807145825.GO21692@lavos.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55266>


On Aug 7, 2007, at 4:58 PM, Brian Downing wrote:

> But it only half worked.  Eventually it managed to corrupt itself  
> again,
> and worse, the test suite was completely hopeless, as all shell  
> activity
> still results in text-mode files.

Why that? Although I don't fully understand the description
of the (no)binmode CYGWIN environment variable option [1], it
sound to me as if shells might do the right thing by default.

But wait ... further down in the document there's more magic.
(no)tty might be related as well.

My question is, is there any chance to handle the shell
activity by setting the right CYGWIN options?


Here's another idea. Could git somehow check if the file
operations work as expected and if not refuse to work.
Git would at least have a well defined behaviour on cygwin,
independently of the weird binmode/textmode stuff. Either
it works, or it tells that it can't work.

Something like

fp = fopen ("tmp-test", "w"); /* no b */
fprintf (fp, "\n");
fclose (fp)

fp = fopen (tmp-test", "rb"); /* with b */
if (freads returns crap) die;

I checked a couple of cygwin installations on our machines
and the results are quite scary. Some have all binmode,
some have all textmode, and some have some parts mounted
as binmode and other as textmode. I'd not dare to recommend
using git on these machines.

	Steffen

[1] http://www.cygwin.com/cygwin-ug-net/using-cygwinenv.html
