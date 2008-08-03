From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: More on git over HTTP POST
Date: Sat, 02 Aug 2008 21:01:11 -0700
Message-ID: <48952D87.2070707@zytor.com>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 06:01:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPUn6-0001RR-Ns
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 06:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbYHCEAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 00:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbYHCEAz
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 00:00:55 -0400
Received: from terminus.zytor.com ([198.137.202.10]:51355 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbYHCEAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 00:00:54 -0400
Received: from [10.71.1.72] ([12.197.88.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7340rZl032545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Aug 2008 21:00:53 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080803025602.GB27465@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/7918/Sat Aug  2 19:45:57 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91202>

Shawn O. Pearce wrote:
> Chunked Transfer Encoding
> -------------------------
> 
> For performance reasons the HTTP/1.1 chunked transfer encoding is
> used frequently to transfer variable length objects.  This avoids
> needing to produce large results in memory to compute the proper
> content-length.

One more thing about chunked transfer encodings: you cannot assume that 
a proxy will maintain chunk boundaries, any more than you can assume 
that a firewall will maintain TCP packet boundaries.

> Detecting Smart Servers
> -----------------------
> 
> HTTP clients can detect a smart Git-aware server by sending the
> show-ref request (below) to the server.  If the response has a
> status of 200 and the magic x-application/git-refs content type
> then the server can be assumed to be a smart Git-aware server.
> 
> If any other response is received the client must assume dumb
> protocol support, as the server did not correctly response to
> the request.

I think it should be application/x-git-refs, but that's splitting hairs.

> Obtains the available refs from the remote repository.  The response
> is a sequence of git "packet lines", one per ref, and a final flush
> packet line to indicate the end of stream.
> 
> 	C: GET /path/to/repository.git?show-ref HTTP/1.0
> 

I really think it would make more sense to use POST requests for 
everything, and have the command part of the POSTed payload.  Putting 
stuff in the URL just complicates the namespace to the detriment of the 
admin.

> 	S: HTTP/1.1 200 OK
> 	S: Content-Type: x-application/git-refs
> 	S: Transfer-Encoding: chunked

Transfer-encoding: chunked is illegal with a HTTP/1.0 client.

	-hpa
