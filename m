From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: found a resource leak in file builtin-fast-export.c
Date: Thu, 09 Jul 2009 15:36:13 +0200
Message-ID: <op.uwsyqnwt1e62zd@balu.cs.uni-paderborn.de>
References: <20090709075728.137880@gmx.net>
 <200907091031.43494.trast@student.ethz.ch>
 <alpine.DEB.1.00.0907091302520.4339@intel-tinevez-2-302>
 <200907091324.17643.trast@student.ethz.ch>
 <alpine.DEB.1.00.0907091500420.4339@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Martin Ettl" <ettl.martin@gmx.de>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 09 15:36:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOtnU-0006cf-JF
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 15:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760551AbZGINgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 09:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759143AbZGINgR
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 09:36:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:35107 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757499AbZGINgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 09:36:16 -0400
Received: (qmail invoked by alias); 09 Jul 2009 13:36:14 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp018) with SMTP; 09 Jul 2009 15:36:14 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/P7whMBcHPo5P92Qts2TGuF8WBQ/diZLe/gPR6Oe
	EKmvu4eqntcpLW
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KMIOGE-0004LC-0U; Thu, 09 Jul 2009 15:36:14 +0200
In-Reply-To: <alpine.DEB.1.00.0907091500420.4339@intel-tinevez-2-302>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122973>

Am 09.07.2009, 15:01 Uhr, schrieb Johannes Schindelin  
<Johannes.Schindelin@gmx.de>:

> Hi,
>
> On Thu, 9 Jul 2009, Thomas Rast wrote:
>
>> Johannes Schindelin wrote:
>> > On Thu, 9 Jul 2009, Thomas Rast wrote:
>> >
>> > > Martin Ettl wrote:
>> > > > -	if (ferror(f) || fclose(f))
>> > > > +	if (ferror(f))
>> > > >  		error("Unable to write marks file %s.", file);
>> > > > +  	fclose(f);
>> > >
>> > > You no longer check the error returned by fclose().  This is
>> > > important, because the FILE* API may buffer writes, and a write  
>> error
>> > > may only become apparent when fclose() flushes the file.
>> >
>> > Indeed.  A better fix would be to replace the || by a |, but this  
>> must be
>> > accompanied by a comment so it does not get removed due to overzealous
>> > compiler warnings.
>>
>> Are you allowed to do that?  IIRC using | no longer guarantees that
>> ferror() is called before fclose(), and my local 'man 3p fclose' says
>> that
>>
>>        After the call to fclose(), any use of stream results in
>>        undefined behavior.
>
> Good point.  So we really need something like
>
> 	err = ferror(f);
> 	err |= fclose(f); /* call fclose() even if there was an error */
> 	if (err)
> 		error...

I've made such a patch, to appear soon on the list (sorry for not Cc:'ing  
it).

-- 
Matthias Andree
