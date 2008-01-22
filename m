From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to
 UTF8
Date: Mon, 21 Jan 2008 20:08:46 -0800
Message-ID: <47956C4E.1080903@zytor.com>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org>	<fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org> <7vve5nzdqx.fsf@gitster.siamese.dyndns.org> <fn1sk4$uh4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Junker <mjscod@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 05:09:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHARr-0005u8-4v
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 05:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYAVEIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 23:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbYAVEIt
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 23:08:49 -0500
Received: from terminus.zytor.com ([198.137.202.10]:35126 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbYAVEIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 23:08:48 -0500
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.1/8.14.1) with ESMTP id m0M48lrk006923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 20:08:47 -0800
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m0M48lFd028146;
	Mon, 21 Jan 2008 20:08:47 -0800
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m0M48kHN014800;
	Mon, 21 Jan 2008 20:08:46 -0800
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <fn1sk4$uh4$1@ger.gmane.org>
X-Virus-Scanned: ClamAV 0.91.2/5516/Mon Jan 21 16:29:15 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71413>

Mark Junker wrote:
> Junio C Hamano schrieb:
> 
>> I do not know how Macintosh libc implements "struc dirent", but
>> this approach does not work in general.
> 
> IMHO there is no need that this approach works in general because this 
> is a fix for MacOSX systems only. I also use d_namlen which might not be 
> available on other systems. But on MacOSX this works as expected.
> 
>> yet you can obtain a path component longer than 256 bytes.
>> Apparently the library allocates longer d_name[] field than what
>> is shown to the user.
> 
> This is not a problem either because on MacOSX we get decomposed UTF8 
> and we always convert to composed UTF8. This means that the string 
> returned from reencode_string will always be smaller than the original 
> filename that had to be reencoded.
> 

That's not true!  There are strings which gets longer when a composing 
normalization is applied.  Please see section 3.3 of Unicode Techical 
Report 36:

	http://www.unicode.org/reports/tr36/

 > People assume that NFC always composes, and thus is the same or
 > shorter length than the original source. However, some characters
 > decompose in NFC.

(NFC = Normalization Form Composing.)

U+1D160 MUSICAL SYMBOL EIGHT NOTE is given as an example with a 3x 
expansion factor when encoded in UTF-8 (I don't know what it expands to; 
seems odd to me.)

	-hpa
