From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git error in tag ...: unterminated header
Date: Thu, 25 Jun 2015 23:07:41 +0200
Organization: gmx
Message-ID: <2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
References: <20150625155128.C3E9738005C@gemini.denx.de>
 <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
 <20150625201309.5026A384E81@gemini.denx.de>
 <xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:07:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8END-0000XC-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 23:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbbFYVHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 17:07:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:57477 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbbFYVHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 17:07:46 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MPUlV-1ZCvCJ0lxB-004hFi; Thu, 25 Jun 2015 23:07:42
 +0200
In-Reply-To: <xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:OY0+pI5dVkxwdYoDbxCIZonfdyzsT4M0iFblmBGEHOzcxiH4/+M
 17Gpuc/MkeHCVwAWqJX5zDAom2uN2Jm2OzUNZShKUXAGaY5BGyVTYTtkxVNVULNYDjLyy5T
 1Jwn0gjqz8K8bQxBI8bK1qWs+5pM5FapwcVfj7mrTJFOhaws4Tj0egUEliLPZf1OVmipn6X
 2wJJBtaprylJQyAuKVVfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xO+7MG9UHi0=:Em+r9hKuM2pe7LWb+eX2gY
 n81VBLPtoZ2T0w9Ho5pI17abOMyGnLn7aQGP9/fdbmox6Cn0Oqx1JsI7oeNjCsmaEuq6nN25B
 ljkR15Rask69go3zfL1sHmbmHYk7q71NktQHRdZWlhGuULEH9RkfMS3OH956GTdI3+5ri/58w
 /KRNsw3rw5uBrWLGcXap5yx/6z5CqRsbas3IGMWDsNyAyT0IYE7xp4Wei+0VvY/ci87AaCIRB
 UUaayiY72TBrCrOWH66UED8rZROA3PhGJrGOv3s3SDu9OcjwMb9k+qI6COZHjC6qZolxJDZnl
 Oxy0BHDJjP5EJDObxsVwTyDOs0GfDj5osQMEgGneSrEbXzqFv4e+w36zfKyCK1Efz219PP8zv
 SpBE+mVt6v31TtB3QxAcGuy8Fo4XO37upe3y//t5zLCcEbG8ttbUpztGzedkCHD/5pEscYuXG
 L8Xk9lFGcI4qGQtSOWn3b5pGBJHDCdMJKgZMJYaGFNu69MotWFCeWisJ3fiiZwaV/dXO+7Z88
 xTNlWO6WW5u6ksOeQpjOhEBEVDsRZoUGxNZ9DjqoKW01tBBHUdxtPHqUqMO+nsVyUeOxM2kkp
 MHqpHi9aRrivVXDW6lzInUA6k9TtSwxQgARnIHM7IOrrmSY9z0MGi9mpzkQ0JtrBKYOcoNsbt
 aYupkEe86bdwtGRC2SQVD/mGHheBeL4UVmq+A8aypoppjSeTTcnJPvzLIlo/jKHEDjLk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272735>

Hi Junio & Wolfgang,

On 2015-06-25 22:24, Junio C Hamano wrote:
> Wolfgang Denk <wd@denx.de> writes:
> 
>> In message <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com> you wrote:
>>>
>>> > Question is: how can we fix that?
>>>
>>> It could be that 4d0d8975 is buggy and barking at a non breakage.

Well, I would like to believe that this commit made our code *safer* by making sure that we would never overrun the buffer. Remember: under certain circumstances, the buffer passed to the fsck machinery is *not* terminated by a NUL. The code I introduced simply verifies that there is an empty line because the fsck code stops there and does not look further.

If the buffer does *not* contain an empty line, the fsck code runs the danger of looking beyond the allocated memory because it uses functions that assume NUL-terminated strings, while the buffer passed to the fsck code is a counted string.

The quick & dirty work-around would be to detect when the buffer does not contain an empty line and to make a NUL-terminated copy in that case.

A better solution was outlined by Peff back when I submitted those patches: change all the code paths that read objects and make sure that all of them are terminated by a NUL. AFAIR some code paths did that already, but not all of them.

Ciao,
Dscho
