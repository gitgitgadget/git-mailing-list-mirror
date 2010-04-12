From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/2] index-pack: smarter memory usage when resolving deltas
Date: Mon, 12 Apr 2010 11:45:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004121141480.7232@xanadu.home>
References: <1271041047-32563-1-git-send-email-nico@fluxnic.net>
 <4BC2BE09.7060809@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 12 18:26:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1MTD-0007pl-HD
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 18:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab0DLQ0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 12:26:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46109 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab0DLQ0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 12:26:24 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0R00A4KT3OI2K0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Apr 2010 11:45:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4BC2BE09.7060809@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144750>

On Mon, 12 Apr 2010, Johannes Sixt wrote:

> Am 4/12/2010 4:57, schrieb Nicolas Pitre:
> > --- a/builtin/index-pack.c
> > +++ b/builtin/index-pack.c
> > @@ -359,34 +359,33 @@ static void *get_data_from_pack(struct object_entry *obj)
> >  {
> >  	off_t from = obj[0].idx.offset + obj[0].hdr_size;
> >  	unsigned long len = obj[1].idx.offset - from;
> > -	unsigned long rdy = 0;
> > -	unsigned char *src, *data;
> > +	unsigned char *data, inbuf[4096];
> 
> With this tiny buffer we make way more pread() calls than we used to,
> right? This hurts emulated pread(), where we do at least 4 syscalls per
> pread(). Shouldn't the buffer be much larger, like min(len,16*4096)?

Well, that is certainly a good compromize.  The buffer would need to be 
malloc()'d and free()'d again though.


Nicolas
