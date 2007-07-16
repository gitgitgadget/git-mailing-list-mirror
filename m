From: Scott Lamb <slamb@slamb.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 12:05:33 -0700
Message-ID: <469BC17D.60806@slamb.org>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <vpqd4yss1vo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 21:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAVtU-0000pI-Ik
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 21:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbXGPTGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 15:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbXGPTGA
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 15:06:00 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:54047 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608AbXGPTF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 15:05:59 -0400
Received: from spiff.local (ppp-71-139-183-188.dsl.snfc21.pacbell.net [71.139.183.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id A58B598105;
	Mon, 16 Jul 2007 12:05:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <vpqd4yss1vo.fsf@bauges.imag.fr>
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52707>

Matthieu Moy wrote:
> Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:
> 
> I believe you still have a race condition if ...
> 
>> -				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
>> -					continue;
> 
> ... buf exists here as a file ...
> 
>>  				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
>>  					continue; /* ok */
> 
> ... and became a directory here.
> 
>> +				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
>> +					continue;
> 
> But that's quite unlikely to happen. And I have no fix to propose.
> 

If arbitrary other tasks are running, the only way to be absolutely
certain you're not calling unlink() in a directory is to never call
unlink().

SUS describes a safe remove(), but Solaris's implementation contains the
same race:

http://src.opensolaris.org/source/xref/pef/phase_I/usr/src/lib/libc/port/gen/rename.c

so I think this patch is the best that can be done.

Best regards,
Scott

-- 
Scott Lamb <http://www.slamb.org/>
