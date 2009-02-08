From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gc considered dangerous
Date: Sun, 8 Feb 2009 15:56:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 15:58:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWB7Q-0004DO-KF
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 15:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbZBHO4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 09:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbZBHOz7
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 09:55:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:48275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751743AbZBHOz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 09:55:58 -0500
Received: (qmail invoked by alias); 08 Feb 2009 14:55:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 08 Feb 2009 15:55:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0UX96i6m0Cf1AvHavnt6A4cI/VETojD+GGJJmGK
	qrGsRU/JsN00EC
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200902080347.25970.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108987>

Hi,

On Sun, 8 Feb 2009, Robin Rosenberg wrote:

> I've seen this. Running git gc on Windows, while having Elipse open can 
> kill your object database.

You had me really scared with the mail subject!

> if gc doesn't find a new optimal pack it tries to rewrite a new pack 
> with the same id. So it rm's the idx file (fine) and the the pack file 
> (not ok) and gives up,

I disagree with your notion that it is fine to kill the existing idx file 
until the new one has been written successfully.

My preliminary guess is that this code in pack-write.c needs to use the 
lock file paradigm:

        if (!index_name) {
		[...]
        } else {
                unlink(index_name);
                fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
        }

Ciao,
Dscho
