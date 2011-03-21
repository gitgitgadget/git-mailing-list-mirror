From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Mon, 21 Mar 2011 10:45:53 +0100
Message-ID: <4D871E51.8090106@drmicha.warpmail.net>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com> <7vmxl37bdp.fsf@alter.siamese.dyndns.org> <7vvczr5pw6.fsf@alter.siamese.dyndns.org> <AANLkTimsv9bO+Go6Mqrrp_1-AZ=sC3ndyAuskPYLVbkv@mail.gmail.com> <AANLkTimWPoMEYdLCwTTit6AeuJegOc96gE1JsO8B4fh=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 10:46:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1bgW-0003sf-7Q
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 10:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab1CUJp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 05:45:56 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42377 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752468Ab1CUJpy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 05:45:54 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CAFA22055E;
	Mon, 21 Mar 2011 05:45:53 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 21 Mar 2011 05:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=9c6AqQsU2BDuRNDnv4+rSrXMEuU=; b=Q8YUUVu7k9LNS+dXq7juGPQ3gMu0q/9w99kYOHl44UyEFvS1VK0tAFzCebT9HRsShR8dooXCs1sl2Md/jKMacSMhc/3MyJokou/Tl69srSh6O4br9Oq1qmxS14OQCL18P0U3mF+as7pIptjY1ie+mxigcXaSolwF027h8x3MyRM=
X-Sasl-enc: ayL30WpCrUK4E13X2qNO9Jm/c+qct/GvZrQTnKVTTFs9 1300700753
Received: from localhost.localdomain (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07AD6447096;
	Mon, 21 Mar 2011 05:45:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTimWPoMEYdLCwTTit6AeuJegOc96gE1JsO8B4fh=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169569>

Nguyen Thai Ngoc Duy venit, vidit, dixit 21.03.2011 05:02:
> On Thu, Mar 10, 2011 at 5:05 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> 2011/3/10 Junio C Hamano <gitster@pobox.com>:
>>> Let's step back a bit.
>>>
>>> We chose to use ":/<regexp>" as one new form of extended SHA-1 expression
>>> to name an object for two reasons: (1) no normal <ref> can have a colon in
>>> it, because of check-ref-format restriction; (2) ":" is an unlikely letter
>>> to appear at the beginning of a pathname, and people with such a path can
>>> work around by saying "./:frotz" or "\:xyzzy".
>>>
>>> There is a disambiguation logic to check a list of arguments that lacks an
>>> explicit "--" separator to make sure that each element early on the list
>>> can only be interpreted as an object name but not as a pathname that
>>> exists on the filesystem, and all the remaining elements are pathnames
>>> that exist on the filesystem.
>>>
>>> If we introduce an extended syntax for pathspec and make the prefix magic
>>> character ":", and if we choose to use ":/" as one kind of magic, I was a
>>> bit worried that this may affect the disambiguation.  The users must use
>>> an explicit "--" when feeding a pathspec with the magic so that the parser
>>> knows which kind of magic (either object name magic or pathspec magic)
>>> they are talking about.
>>
>> Or.. we can consider this ':' a special form of wildcard and interpret
>> the same way:
>>
>>  - first try exact match. If it matches, the leading ':' is
>> interpreted literally as part of file name.
>>  - magic.
> 
> One thing that makes it different from Michael's approach is, :/foo
> will match ':/foo' literally in every directories and foo at top-tree.
> I feel mildly uncomfortable with it, but it makes it consistent with
> other wildcards. If no one objects, I'll try to make a patch with this
> approach.

Maybe I misunderstand which topic you are referring to. I have a patch
for ":" (to denote repo-root in pathspecs), there's no need to make
another one for ":/". (I would really prefer to do it myself since I
brought it up.) I was just waiting for agreement to settle in about
which prefix to use. Also, I have checked with J&J of mingw/msysgit fame
meanwhile to make sure that the notation does not create problems on the
windows side of git.

Michael
