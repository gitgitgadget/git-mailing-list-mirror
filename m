From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Mon, 13 Feb 2012 06:29:21 +0100
Message-ID: <4F389FB1.2070706@alum.mit.edu>
References: <20120210185516.GA4903@tgrennan-laptop> <1328926618-17167-1-git-send-email-tmgrennan@gmail.com> <7vaa4qnk4u.fsf@alter.siamese.dyndns.org> <4F361DD4.9020108@alum.mit.edu> <7vlio9n5ym.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tom Grennan <tmgrennan@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 06:29:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwoTk-0000Ww-NI
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 06:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043Ab2BMF32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 00:29:28 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:39530 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab2BMF31 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 00:29:27 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEB697.dip.t-dialin.net [84.190.182.151])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1D5TLoe027579
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Feb 2012 06:29:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <7vlio9n5ym.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190607>

On 02/11/2012 09:13 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The proposal, amended to use "^" instead of "!", is that
>>
>>     git for-each-ref A B ^C
>>
>> should mean "the reference names A and B but not C".  Therefore, the command
>>
>>     git rev-list $(git for-each-ref A B ^C)
>>
>> , which consistency suggests should do the same thing as the first
>> command,...
> 
> That is an utter rubbish that does not even deserve a response.
> 
> Your argument is like saying
> 
>      git for-each-ref A
> 
> and
> 
>      git for-each-ref $(git rev-parse A)
> 
> should somehow magically produce the same (or related) result. The
> for-each-ref command operates on refname patterns, while rev-list and
> rev-parse takes object names.

Of *course* they operate on different namespaces.  But part of the way
that revisions are selected using rev-list is by *selecting or excluding
refnames* from which it should crawl.  How long do you think it will be
before somebody asks for rev-list to be able to crawl from a set of
branches *except for those that match some pattern*?  (Hint: I more or
less asked for this feature in the "rubbish" email that you quoted.)  At
that point we will have to say one of the following:

"Your suggestion is utter rubbish; just type 'git rev-list $(git
for-each-ref A B ^C)'."

This is an acceptable (though somewhat verbose) answer for the Unix
command line; for msgit users it is useless, and it probably cannot be
used in non-command-line scenarios like the gitk "edit view" dialog.

"Sure, but we have to invent yet another syntax because the one used by
for-each-ref conflicts with the existing syntax of rev-list."  This
would be the standard git project practice of letting the UI accrete
into an ever more incomprehensible mess.

That is why I suggest that we choose a new syntax *now* for for-each-ref
(and "branch --list", "tag --list", etc) so that the same syntax can be
used later in rev-list, rev-parse, etc.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
