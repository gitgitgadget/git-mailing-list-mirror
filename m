From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 13:11:33 +0100
Message-ID: <510124F5.9090505@atlas-elektronik.com>
References: <20130123143816.GA579@krypton.darkbyte.org> <20130123200222.GB19832@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Armin <netzverweigerer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 13:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyLnI-0005kz-CM
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 13:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab3AXMUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 07:20:08 -0500
Received: from mail96.atlas.de ([194.156.172.86]:29625 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753775Ab3AXMUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 07:20:04 -0500
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2013 07:20:04 EST
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id E73B710121;
	Thu, 24 Jan 2013 13:11:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id 38nH5smljK3v; Thu, 24 Jan 2013 13:11:28 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 24 Jan 2013 13:11:27 +0100 (CET)
Received: from [10.200.54.97] (as112671.atlas.de [10.200.54.97])
	by mgsrv01.atlas.de (Postfix) with ESMTP id D9DFE27169;
	Thu, 24 Jan 2013 13:11:27 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130123200222.GB19832@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214428>

Am 23.01.2013 21:02, schrieb Jeff King:
> On Wed, Jan 23, 2013 at 03:38:16PM +0100, Armin wrote:
> 
>> Hello dear git people.
>>
>> I experience a reproducible segmentation fault on one of my
>> repositories when doing a "git log --submodule -p", tested with newest
>> version on Arch Linux (git version 1.8.1.1) and built fresh (git
>> version 1.8.1.1.347.g9591fcc), tried on 2 seperate systems:
>>
>>
>> Program terminated with signal 11, Segmentation fault.
>> #0  0x00000000004b51e5 in parse_commit_header (context=0x7ffff69b6980) at pretty.c:752
>> 752     for (i = 0; msg[i]; i++) {
>> [...]
>> (gdb) l
>> 747 static void parse_commit_header(struct format_commit_context *context)
>> 748 {
>> 749     const char *msg = context->message;
>> 750     int i;
>> 751 
>> 752     for (i = 0; msg[i]; i++) {
>> 753         int eol;
>> 754         for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
>> 755             ; /* do nothing */
>> 756 
>> (gdb) p msg
>> $7 = <optimized out>
>> (gdb) p context->message
>> $8 = 0x0
> 
> Yeah, that should definitely not be NULL. I can't reproduce here with a
> few simple examples, though.
> 
> Does it fail with older versions of git? If so, can you bisect?

I did. My bisection told me this is the suspect:

ccdc603 (parse_object: try internal cache before reading object db)

My git-fu is not good enough to analyze that...

> Is it possible for you to make your repo available?

Unfortunately not. It crashes with one particular repos (using submodules)
that I can't make available but not with another which is available
at https://github.com/snaewe/super.git

HTH

Stefan
-- 
----------------------------------------------------------------
/dev/random says: There must be more to life than compile-and-go.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
