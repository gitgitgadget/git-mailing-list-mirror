From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 06/32] lockfile: unlock file if lockfile permissions
 cannot be adjusted
Date: Fri, 12 Sep 2014 13:03:15 +0200
Message-ID: <5412D2F3.50404@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>	<1409989846-22401-7-git-send-email-mhagger@alum.mit.edu> <xmqqr3zkifl5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershaus?= =?windows-1252?Q?en?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 13:03:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSOdQ-0002dy-RO
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 13:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbaILLDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 07:03:21 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53226 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752818AbaILLDU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 07:03:20 -0400
X-AuditID: 12074413-f79ed6d000002501-50-5412d2f706ef
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 44.79.09473.7F2D2145; Fri, 12 Sep 2014 07:03:19 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1EE6.dip0.t-ipconnect.de [93.219.30.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8CB3Gvl028633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Sep 2014 07:03:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqqr3zkifl5.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqPv9klCIwYY70hZdV7qZLBp6rzBb
	PJl7l9niR0sPs0Vnx1dGB1aPh6+62D2e9e5h9Lh4Sdnj8yY5j9vPtrEEsEZx2yQllpQFZ6bn
	6dslcGfsfN/IVDCdo2L9607WBsYjbF2MnBwSAiYSd+/OZIewxSQu3FsPFOfiEBK4zCjx+ugC
	RgjnPJPEycfTwap4BTQlfkyexwRiswioSmyYPIMFxGYT0JVY1NMMFhcVCJD40PmAEaJeUOLk
	zCdgNSICahIT2w6xgAxlFtjMKPF75RawImGBBImOzzdYILatYZTo27webBKngLXE8zm9rCA2
	s4CexI7rv6BseYntb+cwT2AUmIVkySwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5da
	pGuul5tZopeaUrqJERLowjsYd52UO8QowMGoxMNb6S8YIsSaWFZcmXuIUZKDSUmU1+eoUIgQ
	X1J+SmVGYnFGfFFpTmrxIUYJDmYlEV5zkBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZq
	akFqEUxWhoNDSYJ3wUWgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQvMYXAyMW
	JMUDtLcZpJ23uCAxFygK0XqKUZdjXee3fiYhlrz8vFQpcd7ZIEUCIEUZpXlwK2Bp7RWjONDH
	wrz9IFU8wJQIN+kV0BImoCXv5oAtKUlESEk1MNrPPGeby6ibsvHtlok2W28Gvb/z8/H2mPPz
	Vu6QcOl9Nqe8RWrL3rP35E5JxUyeoVSozMX33dbzR9nzJ0q++RkmLYytrBX/Nb/2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256914>

On 09/10/2014 12:39 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> If the call to adjust_shared_perm() fails, lock_file returns -1, which
>> to the caller looks like any other failure to lock the file.  So in
>> this case, roll back the lockfile before returning so that the lock
>> file is deleted immediately and the lockfile object is left in a
>> predictable state (namely, unlocked).  Previously, the lockfile was
>> retained until process cleanup in this situation.
> 
> ... which would mean that other processes can grab a lock on the
> same file a bit earlier. Is there any negative implication caused by
> that difference?  I do not think of any but I could be missing
> something.

I think the end effect would be the same as if another process had
grabbed the lock a nanosecond before this process tried to do so. So
assuming that callers handle that situation correctly, I don't think
this change can cause any problems.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
