From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Combine WindowedFile into PackFile to simplify the internals
Date: Thu, 23 Apr 2009 00:56:04 +0200
Message-ID: <200904230056.05424.robin.rosenberg.lists@dewire.com>
References: <1240421616-14662-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 00:58:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwlOD-0004VB-IX
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 00:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbZDVW4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 18:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbZDVW4O
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 18:56:14 -0400
Received: from mail.dewire.com ([83.140.172.130]:5593 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbZDVW4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 18:56:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4CA4614927D2;
	Thu, 23 Apr 2009 00:56:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qn9vlV6-s87t; Thu, 23 Apr 2009 00:56:07 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.14])
	by dewire.com (Postfix) with ESMTP id 2865E14927C0;
	Thu, 23 Apr 2009 00:56:07 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1240421616-14662-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117278>

onsdag 22 april 2009 19:33:36 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> The only user of WindowedFile is PackFile, and it did so by making
> an anonymous inner subclass within its constructor.  This is simply
> too confusing to work with.  The two classes are tightly integrated
> and work together to implement pack access.  Half of WindowedFile
> is just exposing accessors for PackFile to call through.
Thanks for clearing that out.

Nested classes are E-V-I-L. For UI-code you cannot sanely get away,
without them, where they are typically used more like an approximation
of closures and anonymous functions so the yield is high. In most
places they just confuse.

> Long ago both PackFile and PackIndex used WindowedFile to read
> data on demand, so having the WindowedFile class made some degree
> of sense.  But in 667a84b6997e9048e0771168c98d2ffbca791937 (almost 2
> years ago) Robin changed the pack index data to be read in one shot,
> as that performed better than paging in the index on demand.

The really real reason was that on Windows the index was locked when
mapped until the Great Collector kicks in, with no way of forcing unlock. 
Faster or not, using memory mapping was simply not possible for the
index or any file that must be rewritten from time to time. That it was
faster is perhaps not so strange since a few big I/O's presumably takes
less time than many small.

-- robin
