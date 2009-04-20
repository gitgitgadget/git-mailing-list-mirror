From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in
 write_entry()
Date: Mon, 20 Apr 2009 12:05:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904201205010.6955@intel-tinevez-2-302>
References: <49EC2F7C.8070209@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 12:07:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvqPD-0001R1-Kp
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 12:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbZDTKFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbZDTKFm
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:05:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:47442 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753199AbZDTKFl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:05:41 -0400
Received: (qmail invoked by alias); 20 Apr 2009 10:05:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp056) with SMTP; 20 Apr 2009 12:05:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Nu3Vsri9Nj/ZPL+24N6ONomvl1dfwYsuU8s7jhg
	DSTAVvm4ucFjYr
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49EC2F7C.8070209@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116959>

Hi,

On Mon, 20 Apr 2009, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> Commit e4c72923 (write_entry(): use fstat() instead of lstat() when file
> is open, 2009-02-09) introduced an optimization of write_entry().
> Unfortunately, we cannot take advantage of this optimization on Windows
> because there is no guarantee that the time stamps are updated before the
> file is closed:
> 
>   "The only guarantee about a file timestamp is that the file time is
>    correctly reflected when the handle that makes the change is closed."
> 
> (http://msdn.microsoft.com/en-us/library/ms724290(VS.85).aspx)
> 
> The failure of this optimization on Windows can be observed most easily by
> running a 'git checkout' that has to update several large files. In this
> case, 'git checkout' will report modified files, but infact only the
> timestamps were incorrectly recorded in the index, as can be verified by a
> subsequent 'git diff', which shows no change.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  My gut feeling was right: We cannot have this optimization on Windows.
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/108351/focus=108357
> 
>  I've a repository where I can reproduce the error quite easily and this
>  fixes it.
> 
>  -- Hannes (who forgot to add Dscho and git@vger on the first send attempt)

You want this in 4msysgit's 'devel' branch, correct?

Ciao,
Dscho "who is still interim maintainer ;-)"
