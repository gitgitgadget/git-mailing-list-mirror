From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Clarified how "git submodule add" handles relative paths.
Date: Sat, 04 Jun 2011 18:19:15 +0200
Message-ID: <4DEA5B03.7020704@web.de>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de> <7vhb86a4kt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 18:20:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QStaK-0006L6-F8
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 18:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab1FDQUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2011 12:20:15 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:49801 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab1FDQUO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2011 12:20:14 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id C7403190ACA9C;
	Sat,  4 Jun 2011 18:19:18 +0200 (CEST)
Received: from [93.240.100.218] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QStZG-0003UQ-00; Sat, 04 Jun 2011 18:19:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vhb86a4kt.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18IOQFOAc/yPFTSXox5cxKvACVhxXdq+UXywFtR
	Ff08Hxj/Z9iGsVHxtGtDgFYjrwxFKz9oG2cV1QKiePzv5mjqWV
	6S9SZ8V9qiD0DDW/l9OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175062>

Am 04.06.2011 01:16, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Now I understand this issue better I'd vote for leaving the relative url
>> like it is, comment it better in the man page and give a better error
>> message when that happens. After all this issue only surprised a few
>> people, mostly due to the lack of information in the error message and
>> man page, so I'd rather prefer to not change the behavior but the wording.
> 
> The "how about this" patch you are voting against (I am neutral by the
> way) is a response to your earlier "I have three use cases and the current
> implementation is forgetting the third", which in turn was a response to
> my "your third use case does not count, so the updated wording of the
> documentation is wrong---it should say 'do not', not 'cannot'".
> 
> So what should the updated document say?

I think that for the improved error message the v2 of my 'submodule add:
improve message when resolving a relative url fails' should be sufficient.

For the documentation I'd propose to apply Marc's 'Clarified how "git
submodule add" handles relative paths.' patch with the interdiff below
squashed in. It fixes a typo and explains that absolute paths are allowed
too (and join case three with the absolute url one by using a "file://"
scheme as default, which is what Mark hinted in his email).

If you want me to resend these two as an updated series just let me know.
---------- 8< ----------
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2294fa6..99d0a83 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -76,9 +76,10 @@ to exist in the superproject. If <path> is not given, the
 "/path/to/repo.git" and "foo" for "host.xz:foo/.git").
 +
 <repository> is the URL of the new submodule's origin repository.
-This may be either an absolute URL, or (if it begins with ./
+This may be either an absolute URL (when the scheme part is not
+specified "file://" is assumed) or (if it begins with ./
 or ../) a URL relative to one of the superproject's remote
-repostories:  If the superprojet's currently checked-out branch tracks
+repostories:  If the superproject's currently checked-out branch tracks
 a remote branch then that remote's URL is used, otherwise the "origin"
 remote's URL is used.  Relative URLs allow users to easily clone the
 superproject and its submodules using a different URL than what the
