From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 12:49:23 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802251235510.3167@xanadu.home>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
 <20080225030404.GL8410@spearce.org> <20080225072658.GB15761@auto.tuwien.ac.at>
 <7vwsotmqq2.fsf@gitster.siamese.dyndns.org>
 <20080225075242.GD15761@auto.tuwien.ac.at> <20080225080445.GM8410@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 18:50:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JThSy-00024I-L6
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 18:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbYBYRtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 12:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbYBYRtg
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 12:49:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34136 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbYBYRtf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 12:49:35 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWT0028L2UCROU0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 25 Feb 2008 12:49:24 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080225080445.GM8410@spearce.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75038>

On Mon, 25 Feb 2008, Shawn O. Pearce wrote:

> > No, it wouldn't, as object->type is never initialized to OBJ_BAD:
> > $ grep "OBJ_BAD" *.c *.h
> > cache.h:        OBJ_BAD = -1,
> 
> Today that may be true.  OBJ_BAD was created for cases where the
> internal object header parsing code in say sha1_file.c finds a type
> code it doesn't recognize and wants to return it back to the caller.
> This grew out of some of the early pack v4 work.
> 
> It actually happens today when a function that returns an object
> type enum returns failure.  sha1_object_info() is one such function.
> It returns "int" but that int is also really an enum object_type.
> When that function fails it returns -1, which has it happens
> is OBJ_BAD.
> 
> Subtle, yes.  But OBJ_BAD has meaning and is in use today.  Please do
> not use it for "we don't care what it is".

Actually, the reason for OBJ_BAD is possibly even more subtle than that.  
It is "documented" in commit fef742c4ed though.

The idea is for some function returning an object type to also be able 
to return an error condition without the overhead and/or hassle of a 
separate argument.  So the object space is returned as a positive value, 
and error space is negative.  The only purpose of OBJ_BAD was to make 
sure object_type is a signed type in order to avoid issues with 
compilers which might interpret the C standard in a way that would 
reduce the enum to its minimal expression such as some "signedlessness".


Nicolas
