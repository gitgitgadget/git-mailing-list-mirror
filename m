From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Freeing struct lock_file?
Date: Sat, 04 Apr 2015 09:16:19 +0200
Message-ID: <551F8FC3.8010104@web.de>
References: <1428097515.31333.2.camel@ubuntu>	 <xmqqfv8gg9bp.fsf@gitster.dls.corp.google.com> <1428107083.31333.11.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 09:18:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeILB-0000EV-Jo
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 09:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbbDDHQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 03:16:39 -0400
Received: from mout.web.de ([212.227.15.3]:51026 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbbDDHQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 03:16:38 -0400
Received: from macce.local ([93.222.5.85]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MVu2q-1YyCl50faS-00X61f; Sat, 04 Apr 2015 09:16:32
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1428107083.31333.11.camel@ubuntu>
X-Provags-ID: V03:K0:7wZu9DLmC4F2byh5O9q9yrp2trkLGlB9vbzMKMd/XyE2iCAi6kh
 mnExmRuoP14e9+E8stmOY1P69shFi1j+aymRLFWb5Fn4Po+y+aUI02u8it6ugHZg+PgnqtJ
 J85+aC9nqi5oBMWPJPy6AGupKrWDH9qHC4kAnluXpcHH/4zoecOvDLl6sdmJWPjtHL/da6U
 +BDAaLSJJ4R2OxMXbMrZA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266766>

On 2015-04-04 02.24, David Turner wrote:
> On Fri, 2015-04-03 at 15:01 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>>
>>> Why is it impossible to free struct lock_files?  I understand that they
>>> become part of a linked list, and that there's an atexit handler that
>>> goes over that list.  But couldn't we just remove them from the linked
>>> list and then free them? 
>>
>> I suspect that the code is worried about getting a signal, while it
>> is manipulating the linked list, and then cause the atexit handler
>> to walk a list that is in a broken state.
> 
> This is technically possible, but practically unlikely: aligned
> pointer-sized writes are atomic on very nearly every processor, and that
> is all that is required to remove an item from a linked list safely in
> this case (though not, of course, in the general multi-threaded case).
> 
> But I can see why git wouldn't want to depend on that behavior. C11 has
> a way to do this safely, but AIUI, git doesn't want to move to C99 let
> alone C11.  So I guess this will just have to remain the way it is.
> 
If you insist on using C11, may be.

But if there is an implementation that is #ifdef'ed and only enabled for
"known to work processors" and a no-op for the others, why not ?

Do you have anything in special in mind ?
A "git diff" may be a start for a patch series..
