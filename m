From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: read() MAX_IO_SIZE bytes, more than SSIZE_MAX?
Date: Sat, 7 Feb 2015 21:32:33 -0500
Message-ID: <020e01d04347$7efbe200$7cf3a600$@nexbridge.com>
References: <loom.20150207T174514-727@post.gmane.org> <54D64939.4080102@web.de> <loom.20150207T182443-33@post.gmane.org> <54D67662.7040504@web.de> <CAPc5daUnKcktv0xcz-fGEApckbkQksKuZO53ZL20E1MhtZmn4w@mail.gmail.com> <loom.20150207T232422-706@post.gmane.org> <CAPc5daXD_7XZD5Vag51BjrSZ0q1r9eMswhLmnpUFqqjrc9oSTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Git Mailing List'" <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Joachim Schmitz'" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 03:32:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKHfx-0007yA-NX
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 03:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbbBHCck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 21:32:40 -0500
Received: from elephants.elehost.com ([216.66.27.132]:36544 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbBHCck convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2015 21:32:40 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t182WYnO028301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Feb 2015 21:32:35 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <CAPc5daXD_7XZD5Vag51BjrSZ0q1r9eMswhLmnpUFqqjrc9oSTw@mail.gmail.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJmR/w5xrE0KMfMA1Zo9YnW3Qq2xQKZ8nS9AjJiLWQBzNUsVQECa4ALAnWhK8kCBWVv0JtZSRCw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263461>

On Feb 7 2015 at 9:14 PM Junio C Hamano wrote:
>On Sat, Feb 7, 2015 at 2:31 PM, Joachim Schmitz <jojo@schmitz-digital.de> wrote:
>> Junio C Hamano <gitster <at> pobox.com> writes:
>>>
>>> Yup, I agree that is a sensible way to go.
>>>
>>>  (1) if Makefile overrides the size, use it; otherwise
>>>  (2) if SSIZE_MAX is defined, and it is smaller than our internal 
>>> default, use it; otherwise
>>>  (3) use our internal default.
>>>
>>> And leave our internal default to 8MB.
>>>
>>> That way, nobody needs to do anything differently from his current 
>>> build
>> set-up,
>>> and I suspect that it would make step (1) optional.
>>
>> something like this:
>>
>> /* allow overwriting from e.g. Makefile */ #if !defined(MAX_IO_SIZE) # 
>> define MAX_IO_SIZE (8*1024*1024) #endif
>> /* for plattforms that have SSIZE and have it smaller */ #if 
>> defined(SSIZE_MAX && (SSIZE_MAX < MAX_IO_SIZE) # undef MAX_IO_SIZE /* 
>> avoid warning */ # define MAX_IO_SIZE SSIZE_MAX #endif
>No, not like that. If you do (1), that is only so that the Makefile can override a broken definition a platform may give to SSIZE_MAX.  So
> (1) if Makefile gives one, use it without second-guessing with SSIZE_MAX.
> (2) if SSIZE_MAX is defined, and if it is smaller than our internal default, use it.
> (3) all other cases, us our internal default.

That is reasonable. I am more concerned about our git-upload-pak (separate thread) anyway :)

Cheers, Randall
