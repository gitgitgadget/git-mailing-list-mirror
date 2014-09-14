From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 11/32] delete_ref_loose(): don't muck around in the
 lock_file's filename
Date: Sun, 14 Sep 2014 16:49:11 +0200
Message-ID: <5415AAE7.3060806@kdbg.org>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu> <1409989846-22401-12-git-send-email-mhagger@alum.mit.edu> <5413F51E.3060600@kdbg.org> <5415353E.8060907@alum.mit.edu> <541537C9.1080304@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Torsten_B=F6ger?= =?ISO-8859-15?Q?shausen?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 14 16:49:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTB7C-0004N8-4N
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 16:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbaINOtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 10:49:17 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:22721 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbaINOtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 10:49:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D1A1A130050;
	Sun, 14 Sep 2014 16:49:12 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CA12B19F494;
	Sun, 14 Sep 2014 16:49:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <541537C9.1080304@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257016>

Am 14.09.2014 um 08:38 schrieb Michael Haggerty:
> On 09/14/2014 08:27 AM, Michael Haggerty wrote:
>> On 09/13/2014 09:41 AM, Johannes Sixt wrote:
>>> Am 06.09.2014 um 09:50 schrieb Michael Haggerty:
>>>> It's bad manners.  Especially since, if unlink_or_warn() failed, the
>>>> memory wasn't restored to its original contents.
>>>
>>> I do not see how the old code did not restore the file name. Except for
>>> this nit, the patch looks good.
>>
>> Hmmmm, you're quite right. I thought I had found some circumstance in
>> which unlink_or_warn() could fail to allocate memory and die() or
>> something. But I can't find anything like that now.
>>
>> I will remove that sentence from the commit message.
> 
> I half withdraw my withdrawal. It's true that the failure of
> unlink_or_warn() wouldn't cause a problem. But a signal could arrive
> while unlink_or_warn() is executing, in which case the signal handler
> would see the wrong filename and try to delete the loose reference file,
> leaving the lockfile behind.

Good catch! This makes the patch much more important than just to
establish good manners.

-- Hannes
