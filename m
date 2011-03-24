From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 1/1] gitweb: javascript ability to adjust time based on
 timezone
Date: Thu, 24 Mar 2011 15:29:23 -0700
Message-ID: <4D8BC5C3.4010309@eaglescrag.net>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>	<1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>	<AANLkTincAcVQQtH+T9+K7tyBd0P5S=8YxXpsfrQ=68gE@mail.gmail.com>	<201103242119.40214.jnareb@gmail.com> <AANLkTi=OsPwQxMRoxLSUEXE1FzSYNvrv3Y+-rXUbzTST@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio Hamano <gitster@pobox.com>
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 23:30:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2t2b-0001IU-FO
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 23:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915Ab1CXW36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 18:29:58 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:38325 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252Ab1CXW35 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 18:29:57 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p2OMTNc4015198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 24 Mar 2011 15:29:24 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <AANLkTi=OsPwQxMRoxLSUEXE1FzSYNvrv3Y+-rXUbzTST@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 24 Mar 2011 15:29:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169950>

On 03/24/2011 03:00 PM, Kevin Cernekee wrote:
> 2011/3/24 Jakub Narebski <jnareb@gmail.com>:
>>> 4) IE6 does not seem to like ISO 8601 format:
>>>
>>> x = new Date("2011-03-09T03:29:09Z");
>>>
>>> This sets all fields to NaN.  I suspect that getTime() values
>>> (milliseconds since 1970-01-01) are more portable.
>>
>> Do you mean using epoch in title attribute, or fallback to parsing
>> ISO 8601 UTC format with regexps?
> 
> getTime() format is $epoch * 1000.  When I switched to that format,
> all 3 of my browsers were able to handle it.
> 
> I really don't think relying on "new Date(iso8601_timestamp)" is a
> good idea, but I guess the string parsing approach would work:
> 
> http://webcloud.se/log/JavaScript-and-ISO-8601/

Looking at that, MS provides VM images for compatability testing with
older IEs so I'm at least able to see the problem directly.  There's
also badness in using epoch directly, screen readers will handle that
particularly badly (which is one of the reasons the microformats
generally shifted to a slightly, if more painful to read from
Javascript, method)

>> Dealing with DST (zoneinfo library) is simply too hard for JavaScript
>> IMHO.  What we could do is to store "local" in cookie, not a fixed TZ
>> offset (or perhaps store both as to not recalculate it).
> 
> I agree, and I do not have a comprehensive solution for handling
> non-local timezones.
> 
>> Hmmm... perhaps a 'config' page?
> 
> Any thoughts on what other user-configurable items might get added in
> the future, and whether they will be on the client side or server
> side?

Any configurations that would happen there will all be client side, for
a lot of reasons gitweb will not be able to have anything user level
configurable from the server side (well at least any of the larger
gitweb installs, which is what I'm primarily focused on).  That said
there's a lot we could do with Javascript from the client side, and that
was one way of handling to change I had thought of - just didn't seem
useful since we currently would only have this.

I'm fine with the idea however (I envisioned it as some larger drop down
that more or less filled the whole page and set various cookies for it's
storage of things).  But moving in this direction should be a conscious
and definitive move that these kinds of changes will be client side, and
will involve more and more Javascript.  Assuming that our fallback
non-javascript version of the page still works fine, and is usable, this
is a good plan overall but it is a shift from where we have been with
respect to Gitweb.

- John 'Warthog9' Hawley
