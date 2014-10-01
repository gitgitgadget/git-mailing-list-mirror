From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v7 09/38] lock_file(): always initialize and register
 lock_file object
Date: Wed, 01 Oct 2014 13:27:49 +0200
Message-ID: <542BE535.3040500@web.de>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu> <1412159322-2622-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?ISO-8859-15?Q?Torsten_B=F6gershause?= =?ISO-8859-15?Q?n?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 13:29:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZI5m-0002tB-JP
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 13:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbaJAL3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 07:29:06 -0400
Received: from mout.web.de ([212.227.15.14]:56684 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbaJAL3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 07:29:04 -0400
Received: from [192.168.178.27] ([79.250.168.13]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M57T4-1YSef62kXu-00zGkR; Wed, 01 Oct 2014 13:28:42
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <1412159322-2622-10-git-send-email-mhagger@alum.mit.edu>
X-Provags-ID: V03:K0:GDLJqPZVnjg55DRb0FspZGP8ydWNrEyQR+EzLpY4onH4NVp+dFu
 ywVDzX9tTTW3W8D0fUCteZY2NgAoMCOBgjqatUVd1G0hSkCY0FRkiksSJxOzMFTC40qh8/V
 ffbb2sczzZa1HO+YqZPHOVWyx/M3PXbAPCL5f59fTqHXm3RKij39LNESe5aASwPuQjaCsfD
 Baajo1ZiEeqg3NshjpWdA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257744>

Am 01.10.2014 um 12:28 schrieb Michael Haggerty:
> The purpose of this patch is to make the state diagram for lock_file
> objects simpler and deterministic.
>
> If locking fails, lock_file() sometimes leaves the lock_file object
> partly initialized, but sometimes not. It sometimes registers the
> object in lock_file_list, but sometimes not. This makes the state
> diagram for lock_file objects effectively indeterministic and hard to
> reason about. A future patch will also change the filename field into
> a strbuf, which needs more involved initialization, so it will become
> even more important that the state of a lock_file object is
> well-defined after a failed attempt to lock.
>
> The ambiguity doesn't currently have any ill effects, because
> lock_file objects cannot be removed from the lock_file_list anyway.
> But to make it easier to document and reason about the code, make this
> behavior inconsistent: *always* initialize the lock_file object and

s/incon/con/, certainly?

> *always* register it in lock_file_list the first time it is used,
> regardless of whether an error occurs.
>
> While we're at it, make sure that all of the lock_file fields are
> initialized to values appropriate for an unlocked object; the caller
> is only responsible for making sure that on_list is set to zero before
> the first time it is used.
