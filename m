From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
 that are corrupted in a pack file
Date: Wed, 7 Jan 2009 19:06:42 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain>
References: <1231282320.8870.52.camel@starfruit> <alpine.LFD.2.00.0901062005290.26118@xanadu.home> <1231292360.8870.61.camel@starfruit> <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain> <1231314099.8870.415.camel@starfruit>
 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain>
 <20090108030115.GF10790@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 04:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKlGI-0008E0-1R
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 04:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbZAHDHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 22:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZAHDHW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 22:07:22 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39003 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751372AbZAHDHV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 22:07:21 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0836gDv026667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 19:06:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0836g3g028429;
	Wed, 7 Jan 2009 19:06:42 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090108030115.GF10790@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104882>



On Wed, 7 Jan 2009, Shawn O. Pearce wrote:
> 
> Ok, well, in this case I've been able to reproduce a zlib inflate
> failure on the base object in a 2 deep delta chain.  We got back:
> 
>   #define Z_STREAM_ERROR (-2)
> 
> this causes the buffer to be freed and NULL to come back out of
> unpack_compressed_entry(), and then everything is corrupt...

I bet you actually got an earlier error already from the inflateInit. 

The Z_STREAM_ERROR probably comes from inflate() itself - and could very 
easily be due to a allocation error in inflateInit leaving the stream data 
incomplete.

Let me try wrapping that dang thing and send a patch. 

		Linus
