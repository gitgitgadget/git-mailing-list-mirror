From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [BUG] in rev-parse
Date: Thu, 15 Dec 2011 23:53:50 +0100
Message-ID: <4EEA7A7E.4070109@alum.mit.edu>
References: <20111214184926.GB18335@llunet.cs.wisc.edu> <20111214210157.GA8990@sigill.intra.peff.net> <7vk45yplkm.fsf@alter.siamese.dyndns.org> <20111215070521.GB1327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, nathan.panike@gmail.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 23:54:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbKBe-0008TT-5q
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 23:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759632Ab1LOWx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 17:53:58 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51360 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab1LOWx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 17:53:57 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.2.128] (p54BEA4CB.dip.t-dialin.net [84.190.164.203])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBFMrolP019102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Dec 2011 23:53:50 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <20111215070521.GB1327@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187252>

On 12/15/2011 08:05 AM, Jeff King wrote:
> On Wed, Dec 14, 2011 at 07:20:41PM -0800, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> On the other hand, it has been like this since it was introduced in
>>> 2006, and I wonder if scripts rely on the --verify side effect.
>>
>> It would have been nicer if it did not to imply --verify at all; a long
>> hexdigit that do not name an existing object at all will be shortened to
>> its prefix that still do not collide with an abbreviated object name of an
>> existing object, and even in such a case, the command should not error out
>> only because it was fed a non-existing object (of course, if "--verify" is
>> given at the same time, its "one input that names existing object only"
>> rule should also kick in).
> 
> Dropping the implied verify is easy (see below). But handling
> non-existant sha1s is a much more complicated change, as the regular
> abbreviation machinery assumes that they exist. E.g., with the patch
> below:
> 
>   $ good=73c6b3575bc638b7096ec913bd91193707e2265d
>   $ bad=${good#d}e
>   $ git rev-parse --short $good
>   73c6b35
>   $ git rev-parse --short $bad
>   [no output]
> 
> Anyway, I'm not sure it's worth changing at this point. It's part of the
> plumbing API that has been that way forever, it's kind of a rare thing
> to ask for, and I've already shown a workaround using rev-list.

I believe that the OP was more inconvenienced that "git rev-parse
--short" chokes on multiple objects than by the fact that it insists
that the objects exist.  (And shortening the SHA1s of non-existent
objects doesn't sound very useful anyway.)  So I think that a useful
compromise would be for "git rev-parse --short" to accept multiple args
but continue to insist that each of the args is a valid object.

If that is considered too big a break with backwards compatibility, one
could add a --no-verify option that turns off the verification behavior
of --short.  But IMHO this problem is not important enough to justify
adding an extra option.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
