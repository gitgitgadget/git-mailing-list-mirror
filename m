From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and
 arguments
Date: Mon, 10 Feb 2014 20:59:36 +0100 (CET)
Message-ID: <20140210.205936.813126606054805390.chriscool@tuxfamily.org>
References: <xmqqr47fx001.fsf@gitster.dls.corp.google.com>
	<20140209.145205.1882309246743951569.chriscool@tuxfamily.org>
	<xmqq61omu96d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 10 21:01:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCx2M-0003eQ-Io
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 21:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbaBJUAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 15:00:05 -0500
Received: from [194.158.98.15] ([194.158.98.15]:40118 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754968AbaBJUAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 15:00:00 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 5809561;
	Mon, 10 Feb 2014 20:59:37 +0100 (CET)
In-Reply-To: <xmqq61omu96d.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241928>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Mon, 10 Feb 2014 10:14:34 -0800

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> This is what "if_exists" and "if_missing" are all about.
>>
>> Either:
>>
>> 	the same key already exists regardless of the value
>>
>> and, in this case, what happens depends on what has been specified using
>> the "if_exists" configuration variable.
>>
>> Or:
>>
>> 	the same key DOES NOT already exists regardless of the value
>>
>> and in this case, what happens depends on what has been specified
>> using the "if_missing" configuration variable.
> 
> Hmm, how should things like signed-off-by be handled?  You may want
> to allow many entries with the same key with distinct values, but
> duplicated values may want to be handled differently (currently we
> only avoid to place a duplicate <key, value> consecutively, but keys
> with different semantics (e.g. "fixes-bug: #bugid") may want to say
> "unless the same key with the same value exists, append it at the
> end".

Many entries with the same key but distinct values can be configured
using:

if_exists = add_if_different
if_missing = add

Many entries with the same key but values that can be the same can be
configured using:

if_exists = add
if_missing = add

The place where the trailers are added, if they should be added, can
be selected using either "where = after", the default, or "where =
before".

"where = after" means just after trailers with the same key, or, if
there are no trailers with the same key, after all the existing
trailers.

"where = before" means just before trailers with the same key, or, if
there are no trailers with the same key, before all the existing
trailers.

I think that this is enough to handle most of the usual cases, but we
can add other more complex options later, as I said in the last
message of this thread:

http://thread.gmane.org/gmane.comp.version-control.git/237278/

Thanks,
Christian.
