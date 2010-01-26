From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH 1/4] Add xmallocz()
Date: Tue, 26 Jan 2010 14:56:06 -0600
Message-ID: <19295.22246.788034.159299@blake.zopyra.com>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<1264530255-4682-2-git-send-email-ilari.liusvaara@elisanet.fi>
	<19295.21148.182245.516321@blake.zopyra.com>
	<7v1vhczj95.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 21:56:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZsSN-0005Uq-IE
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 21:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab0AZU4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 15:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596Ab0AZU4L
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 15:56:11 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:42024
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752103Ab0AZU4K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 15:56:10 -0500
Received: (qmail 26640 invoked by uid 500); 26 Jan 2010 20:56:09 -0000
In-Reply-To: <7v1vhczj95.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138076>

On Tuesday, January 26, 2010 at 12:47:02 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> On Tuesday, January 26, 2010 at 20:24:12 (+0200) Ilari Liusvaara writes:
>>>Add routine for allocating NUL-terminated memory block without risking
>>>integer overflow in addition of +1 for NUL byte.
>>>...
>>> void *xmemdupz(const void *data, size_t len)
>>> {
>>>-	char *p = xmalloc(len + 1);
>>>+	char *p = xmallocz(len);
>>> 	memcpy(p, data, len);
>>> 	p[len] = '\0';
>>> 	return p;
>>
>> Do you need the statement
>>
>>  	p[len] = '\0';
>>
>> any longer in the above?  If not, could you just do this:
>>
>> void *xmemdupz(const void *data, size_t len)
>> {
>> 	return memcpy(xmallocz(len), data, len);
>> }
>
>I think the intention to name it xmallocz() was "This is to allocate
>buffer to hold 'len' bytes worth of stuff, and between the caller and this
>function the buffer is arranged to be NUL terminated".  Even though none
>of the existing callers of xmalloc() expected the function to do the NUL
>termination (hence they do NUL termination themselves), I _think_ Ilari
>made the function to do this because its name now ends with "z" that hints
>the callers such a NUL-termination might happen inside the function.
>
>I'd rather see the function lose the NUL termination; if that makes the
>behaviour inconsistent with its name, perhaps it is better to rename the
>function; perhaps xmalloc1() to denote that it overallocates by one?

Why have xmallocz/xmalloc1 lose the NUL termination?  Is it because some
call sites don't need the NUL termination?  [I spotted one, I think, in
the patch series...].


Bill
