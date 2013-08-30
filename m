From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/5] replace: forbid replacing an object with one of
 a different type
Date: Fri, 30 Aug 2013 07:41:24 +0200 (CEST)
Message-ID: <20130830.074124.1031903859178992049.chriscool@tuxfamily.org>
References: <xmqqa9k1a9wq.fsf@gitster.dls.corp.google.com>
	<20130829.082936.1893875995125817253.chriscool@tuxfamily.org>
	<xmqqli3k7abw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: trast@inf.ethz.ch, git@vger.kernel.org, philipoakley@iee.org,
	j6t@kdbg.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 30 07:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHSe-000413-Jv
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 07:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab3H3Fl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 01:41:28 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:52126 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638Ab3H3Fl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 01:41:28 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 82B723C;
	Fri, 30 Aug 2013 07:41:25 +0200 (CEST)
In-Reply-To: <xmqqli3k7abw.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233395>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> But if all the objects that point to an object, called O, are to be
>> replaced, then in most cases object O probably doesn't need to be
>> replaced. It's probably sufficient to create the new object, called
>> O2, that would replace object O and to replace all the objects
>> pointing to object O with objects pointing to O2.
> 
> Hmmmm.
> 
> What the above says, with "probably" and "most cases", can easily
> inferred by anybody remotely intelligent, and the only reason to
> have something like the above paragraph would be if it assures that
> the statement holds without these qualifications to weaken it, which
> it doesn't.  I am not sure this paragraph adds much value.
> 
>> The only case where someone might really want to replace object 0,
>> with an object O2 of a different type, and all the objects pointing to
>> it, is if it's really important, perhaps for external reasons, to have
>> object O's SHA1 point to O2.
> 
> The same comment applies here.
> 
>> And anyway, if one really wants to do that, it can still be done using
>> "git update-ref".
> 
> And I really do not think this sentence is right---you can justify
> with the same sentence to remove "git replace" wrapper.

Ok, so the commit message (excluding the Acked-by and Signed-off-by)
will be only:

------------------------------------------

Users replacing an object with one of a different type were not
prevented to do so, even if it was obvious, and stated in the doc,
that bad things would result from doing that.

To avoid mistakes, it is better to just forbid that though.

If one object is replaced with one of a different type, the only way
to keep the history valid is to also replace all the other objects
that point to the replaced object. That's because:

* Annotated tags contain the type of the tagged object.

* The tree/parent lines in commits must be a tree and commits, resp.

* The object types referred to by trees are specified in the 'mode'
  field:
    100644 and 100755    blob
    160000               commit
    040000               tree
  (these are the only valid modes)

* Blobs don't point at anything.

The doc will be updated in a later patch.

------------------------------------------

> The earlier suggestion to bypass the new hand-holding with "--force"
> is more sensible, I think.

There is already a --force option, but I can add a --force-type in a
another patch.

Thanks,
Christian.
