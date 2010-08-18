From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 1/2] commit: add parse_commit_repl() to replace
 commits at parsing time
Date: Wed, 18 Aug 2010 13:17:52 +1000
Message-ID: <AANLkTimu0r_3L7_YJgfMVb6saFOyOK-mHLiKyTG_6Q5O@mail.gmail.com>
References: <20100817015901.5592.25471.chriscool@tuxfamily.org>
	<7vbp91aqfk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 05:18:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlZA9-0005TR-VZ
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 05:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882Ab0HRDRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 23:17:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53651 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab0HRDRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 23:17:54 -0400
Received: by wwi17 with SMTP id 17so149819wwi.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=SKFZmLezka7515Rhvl/YzGxPwz8nnalmXIyUM2fVmi8=;
        b=KRdlnj8OYxBhnfkV9Ci9kaDXkG/HJfAkPeYN/bLIdmVDl/hK1q+YMTF6c7+3whxnU6
         cb4DMHbC64P0hwx9pLqlqEjvZtO56U/i+kblu3OA5VlxO5WlUrgrW4UGY+fkC+XJIrJQ
         lnAl4eYHyBhJvJYCs7pmHwcxr5RrlSJJRneio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=h4gOMrpMtd72d6GMU6uffNvh8/sWfVBkcCc4lcM+aIf/fnY6MNbfuVmtMrotBrTjXt
         uH0VvaH9e5oOZg78uXJsNjpCC/3eZirLyMZOTSByjOqSqh3hLYnUJ8nBdoLI94XRmhpq
         KvUek3vWScSwdBJCkfmtaWKaxmmQLBOiJ/AN8=
Received: by 10.227.127.82 with SMTP id f18mr6463493wbs.185.1282101472576;
 Tue, 17 Aug 2010 20:17:52 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Tue, 17 Aug 2010 20:17:52 -0700 (PDT)
In-Reply-To: <7vbp91aqfk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153807>

On Wed, Aug 18, 2010 at 7:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> The function parse_commit() is not safe regarding replaced commits
>> because it uses the buffer of the replacement commit but the object
>> part of the commit struct stay the same. Especially the sha1 is not
>> changed so it doesn't match the content of the commit.
>
> This all sounds backwards to me, if I am reading the discussion correctly.
>
> If a replace record says commit 0123 is replaced by commit 4567 (iow, 0123
> was a mistake, and pretend that its content is what is recorded in 4567),
> and when we are honoring the replace records (iow, we are not fsck),
> shouldn't read_sha1("0123") give us a piece of memory that stores what is
> recorded in 4567, parse_object("0123") return a struct commit whose buffer
> points at a block of memory that has what is recorded in 4567 _while_ its
> object.sha1[] say "0123"?

1. parse_object() as it is now would return object.sha1[] = "4567".
2. lookup_commit(), then parse_commit() would return object.sha1[] = "0123".

> What problem are you trying to solve?

Inconsistency in replacing objects. I have no comments whether #1 or
#2 is expected behavior. But at least it should stick to one behavior
only.
-- 
Duy
