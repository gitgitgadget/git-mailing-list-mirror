From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Wed, 12 Jul 2006 08:13:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607120810320.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <44B4172B.3070503@stephan-feder.de> <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
 <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
 <slrneb96rd.dma.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 12 17:14:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0gPU-0004sE-3o
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 17:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWGLPNb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 11:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWGLPNb
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 11:13:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59866 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751395AbWGLPNa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 11:13:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6CFDNnW019083
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Jul 2006 08:13:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6CFDMJn010849;
	Wed, 12 Jul 2006 08:13:22 -0700
To: Peter Baumann <waste.manager@gmx.de>
In-Reply-To: <slrneb96rd.dma.Peter.B.Baumann@xp.machine.xx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23782>



On Wed, 12 Jul 2006, Peter Baumann wrote:
> 
> This doesn't match the logic used in unpack_object_header, which is used
> in the packs:

Yeah, good point. I reversed the meaning of the high bit by mistake. In 
pack-files, the high bit is a "there is more to come" bit, and in my new 
code it was a "this is the last byte" bit.

It doesn't matter for the ultimate reason for this (being able to re-use 
the actual _bulk_ of the data), but having it be different would be stupid 
and confusing, and means that we can't later try to use the same routines 
for packing/unpacking the objects.

Junio - do you want me to send an updated patch, or do you want to reverse 
bit#7 yourself?

		Linus
