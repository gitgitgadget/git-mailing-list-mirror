From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 00/12] Re: Makefile: add missing header dependency rules
Date: Tue, 26 Jan 2010 09:43:57 -0600
Message-ID: <20100126154357.GA4895@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:44:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZnaH-0000B1-Py
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab0AZPn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876Ab0AZPn7
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:43:59 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:44246 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776Ab0AZPn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:43:58 -0500
Received: by iwn3 with SMTP id 3so474436iwn.19
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=b1yQSgzeZBygHtZ/LJnNbqD1NPo+SYkI2uvAKdWlNkQ=;
        b=exsTm4Zvzsy05J+B9WlmlP7zQweNjn1pbb3DCGO3cDD09jQmN94V4gpC+J2ABU5K+B
         RCzNeoOBLuWF+dTkUapCxIvfwvDl4UWyfFyMFxte3DM56hO8/b8rXMCgFxZ+4OeCopuy
         18h4YyRiWZ1YzfqyMi0PtJteR2NlplaBTzXls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w+tr7SGT20w+3DvpdW+8U5LDmIYPgdZrjEsJh0Awg2MrKj50bujuq2GJ+rpjsnwL0+
         /oF48Q4NJSKCZTnK/cgkiNv0eRFSG8k/iMcXjZ9hBU10uX6EDaDVnwLTwUedHYWhyu4K
         MMigYyrk4dJvizi9bGMEqDPYDak9Rz5O7pSHQ=
Received: by 10.231.148.207 with SMTP id q15mr1706751ibv.45.1264520637725;
        Tue, 26 Jan 2010 07:43:57 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm6007198iwn.10.2010.01.26.07.43.55
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:43:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138041>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> These patches are independent of the jn/makefile topic.  I sent them
>> before, but I screwed up the sender so nobody received them.  Anyway,
>> perhaps they could be useful.
>
> I found all of them sensible but it seems to be based on version that is a
> bit behind...

Thanks.  Patches 1-5 below are those I sent before, rebased against
maint.  Since last time, remote-curl.o gained a few more dependencies,
which are included.

The remainder of this series is based on a merge of master and
patches 1-5:

 Patch 6 adds another missing header dependency rule.  It is not
 included with the others because it applies to master, not maint.

 Patches 7-12 revisit the topic of generating header dependency
 rules on the fly.  I updated them to produce patches 1-6, so I
 thought, why not get some feedback on their present state?

Patch 7 clumps the header dependency rules together.  I think this
makes them more readable; more importantly, later this will allow
ifdef'ing them out later in one fell swoop.

Patches 8-9 and 11 list all targets that can depend on headers in a
new OBJECTS variable, for use in patches 10 and 12.

Patch 10 generates header dependency rules on the fly.  The resulting
dependency rules contain no useless dependencies (unlike the
hard-coded ones where almost everything depends on $(LIB_H)), so this
might be interesting to people wishing to speed up the
edit-compile-run cycle.

This only works with gcc.  It should be possible to teach the relevant
options to clink.pl if there is demand, but not SCO cc.

Patch 12 is what I am most interested in: it uses the computed
dependencies to check that the hard-coded dependency rules are
correct.  In the long term, maybe we will be able to get rid of the
hard-coded header dep rules altogether; in the short term, I am hoping
this checker can be useful for avoiding problems with the hard-coded
rules without spending too much human time on it.

Enjoy,
Jonathan Nieder (12):
  Makefile: add missing header file dependencies
  Makefile: make sure test helpers are rebuilt when headers change
  Makefile: remove wt-status.h from LIB_H
  Makefile: clean up http-walker.o dependency rules
  Makefile: drop dependency on $(wildcard */*.h)
  Makefile: transport.o depends on branch.h now
  Makefile: rearrange dependency rules
  Makefile: disable default implicit rules
  Makefile: list generated object files in OBJECTS macro
  Makefile: lazily compute header dependencies
  Makefile: list standalone program object files in PROGRAM_OBJS
  Teach Makefile to check header dependencies
