From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: More on git over HTTP POST
Date: Sat, 02 Aug 2008 20:47:46 -0700
Message-ID: <48952A62.6050709@zytor.com>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org> <7v63qiydzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 05:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPUat-00089I-Pq
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 05:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbYHCDrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 23:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYHCDrf
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 23:47:35 -0400
Received: from terminus.zytor.com ([198.137.202.10]:53997 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbYHCDre (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 23:47:34 -0400
Received: from [10.71.1.72] ([12.197.88.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m733lSZ1031904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Aug 2008 20:47:29 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <7v63qiydzg.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.93.3/7918/Sat Aug  2 19:45:57 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91200>

Junio C Hamano wrote:
> With the git native protocol, we luckily found space to do so after the
> ref payload (because pkt-line is "length + payload" format but the code
> that reads payload happened to ignore anything after NUL).  You would want
> to define how these are given by the server to the client over HTTP
> channel.  For example, putting them on extra HTTP headers is probably Ok.

I think that would be a mistake, just because it's one more thing for 
proxies to screw up on.  It's better to have negotiation information in 
the payload, before the "real" data.

Obviously one thing that needs to be included in each transaction is a 
transaction ID that will be reported back on the next transaction, since 
you can't rely on a persistent connection.

	-hpa
