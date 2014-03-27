From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RFC/PATCH] Better control of the tests run by a test suite
Date: Thu, 27 Mar 2014 03:15:39 -0700
Message-ID: <5333FA4B.5040308@gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>	<20140324230304.GC17080@sigill.intra.peff.net> <7v4n2mq3h1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 11:15:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT7Lp-0005yC-SN
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 11:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbaC0KPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 06:15:53 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:37131 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbaC0KPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 06:15:52 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so3258468pab.40
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VU4hxWZIF93CnpbME115WMG3jcnpJQnI+rXV5SsJ2IA=;
        b=vRqk91rIb0T49/P0Hstxvs8emOT4qk1970MejTgIrEO/ug6vdMeJN1mp9+Bvcu31Nw
         /F1sM5aDPr8s5aWEL2yDJwsHegJkstcHVr0rfeKeUpRdoMqzhpdHOg5UPWDpYcBS0UFq
         2S/3giRB5qR/1QKX9msbF/bTPpammWFTMefQ4pxsQrlzqXgdYvhe/Tq+pAkJlZyLuKnd
         9G4+swo+lGo5+CxosM+dbdvy7H/4ep2pX9lYt7Wq9/CajPudR2vR34xdniVaDJcH6Rh9
         chS/+zISLdJbIsEibQ51RULTfZCOjzTU//dXecZapVLNAJdhmj9a+UBYxwwuwCck9Amy
         p/XQ==
X-Received: by 10.68.171.229 with SMTP id ax5mr842828pbc.125.1395915351518;
        Thu, 27 Mar 2014 03:15:51 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id e6sm6938294pbg.4.2014.03.27.03.15.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Mar 2014 03:15:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <7v4n2mq3h1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245270>

On 3/24/2014 9:58 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Mar 24, 2014 at 01:49:44AM -0700, Ilya Bobyr wrote:
>>
>>> Here are some examples of how functionality added by the patch
>>> could be used.  In order to run setup tests and then only a
>>> specific test (use case 1) one can do:
>>>
>>>     $ ./t0000-init.sh --run='1 2 25'
>>>
>>> or:
>>>
>>>     $ ./t0000-init.sh --run='<3 25'
>>>
>>> ('<=' is also supported, as well as '>' and '>=').
>> I don't have anything against this in principle, but I suspect it will
>> end up being a big pain to figure out which of the early tests are
>> required to set up the state, and which are not. Having "<" makes
>> specifying it easier, but you still have to read the test script to
>> figure out which tests need to be run.
> Likewise.

The idea is that you will use that option when you know what
setup the test need.  And the case that I was targeting is when
you are the author of the test, because you are also writing the
relevant functionality or you are really familiar with the test
because you are, again, working on something in that area.

It does not mean you actually have to do it.  It is just a
possibility.

And as you mentioned, "<" helps in another case - when you do not
know enough about the test, but want to run it.  For example when
you are just starting with a failed test.

My experience, thought quite limited, is that it is very simple
to understand what the test needs and where it is prepared, if
you are actually adding new test to a test suite.  Or if you
spent some time figuring how specific test works.  I think this
is mostly because all the tests are rather simple.  Which is
definitely a good thing.

This is not for cases when you treat test suites as black boxes.
For example, when you are just checking someone else code.

>> I wonder if it would make sense to "auto-select" tests that match a
>> regex like "set.?up|create"? A while ago, Jonathan made a claim that
>> this would cover most tests that are dependencies of other tests. I did
>> not believe him, but looking into it, I recall that we did seem to have
>> quite a few matching that pattern. If there were a good feature like
>> this that gave us a reason to follow that pattern, I think people might
>> fix the remainder
> This may be worth experimenting with, I would think.

I was also thinking about it a bit.  I do not have that much
knowledge on how all the tests are organized.  But I did see some
cases where this rule would fail.

One example would be "t\t0000-basic.sh".  It could probably be
considered a very special test suite, but if you skip one of
these tests:

 - "test runs if prerequisite is satisfied"
 - "unmet prerequisite causes test to be skipped"

the test suite would just exit in the middle.  There is a number
of other tests that you do not want to skip for the same reason.
Also, in the same test suite "showing tree with git ls-tree -r"
is a setup test for the next one "git ls-tree -r output for a
known tree".  And the same pattern is repeated for some other
tests.

I've also looked at "t5601-clone.sh".  There is indeed a test
called "setup" at the very beginning.  But somewhere in the
middle there is a test called "clone from .git file" that creates
a folder used in two subsequent tests.

In "t0001-init.sh", "re-init on .git file" creates a folder that
is used in the next test called "re-init to update git link".

Maybe these are just some outliers, I do not know for sure.
These were the only test suites I've looked at so far.

I think that if there is a desire to support automatic setup for
tests maybe a rule could be introduced that a test must succeed,
if there is no breakage, if all the tests that match regex
'^(setup|cleanup)\>' before it have been run.  It should not be
too complicated to create a target that would automate checking
of this rule.

I am not 100% sure that this kind of change is worth the trouble.
People who run individual tests should probably know why they are
doing it.  And as such that might know the prerequisites.

Otherwise I can not come up with a reason to run an individual
test.

On the other hand, the rule may add a bit more structure to the
tests and automated checking could enforce that.
