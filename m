From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Bug-ish: CRLF endings and conflict markers
Date: Thu, 11 Jan 2007 11:36:22 +0000
Message-ID: <200701111136.23864.andyparkins@gmail.com>
References: <200701110941.22024.andyparkins@gmail.com> <Pine.LNX.4.63.0701111043440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 11 12:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4yEX-0004Lb-6y
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 12:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbXAKLg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 06:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbXAKLg3
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 06:36:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:27991 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030267AbXAKLg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 06:36:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so434823uga
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 03:36:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pakWVeCwOlcq79ZCqFiSxc5hqXkKxIil6acwUfCvkyQk7m+39E9noblcIIk9V45YA6h8XmmGlTx1Bq9iZWl/115dO8hMYF6pxxFj1XmSoYrijUcIr3ZZ6NFg9YrAkHmefu2BxHMyo20h+z6T2ehI4k0DqS55TRQAgwXM2nU5Drs=
Received: by 10.67.121.15 with SMTP id y15mr1577434ugm.1168515387611;
        Thu, 11 Jan 2007 03:36:27 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id 32sm664076ugf.2007.01.11.03.36.26;
        Thu, 11 Jan 2007 03:36:27 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0701111043440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36582>

On Thursday 2007 January 11 09:46, Johannes Schindelin wrote:

> > The best solution is probably to use the line ending of the conflicted
> > lines.
>
> Question is: how to find out. Especially if your file already has mixed
> line endings...

That's why I said use the line endings of the conflicted lines.  Even if the 
file is mixed, at least lines added are the same as the ones near them.  
Let's say for example a conflict like this:

<<<<
Whole file has DOS endings^M
====
The whole file has DOS endings^M
>>>>

As both of the conflicted parts end in CRLF, the conflict markers would 
default to having CRLF.  This would cope with mixed-ending files as well, as 
the ending is always determined locally.

If we were being really clever, we could make each marker use the ending of 
the line following it; making it impossible to accuse git of doing anything 
worse than already existed.

> No. It would be in xdiff/xmerge.c:{139,147,160}. But I think that xdiff

Thanks; I see why I couldn't find it: it's generated as a loop "marker_size" 
long, rather than the literal that is in rerere.  I've had a quick glance at 
xdl_fill_merge_buffer() and can see it's not an easy thing to do (at least 
for me).  Maybe if it itches me a bit more I'll put some effort into my 
scratching :-)

> really is LF-only throughout, so you'd have to do much more work anyway.

That doesn't seem to be a problem.  git is performing very nicely on the CR-LF 
file I'm tracking.  As I mentioned, it's treating the CR as just another 
character on the line - perfect: merges, diffs, diffstats all work just fine.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
