From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Thu, 20 Jun 2013 16:25:31 +0530
Message-ID: <CALkWK0nqOSmFaYhbW3anmBvgy2=DZs7qU0kz7=eEO5R99uLAqQ@mail.gmail.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
 <1371607780-2966-3-git-send-email-rhansen@bbn.com> <7vhagu10ql.fsf@alter.siamese.dyndns.org>
 <51C203A1.4000404@bbn.com> <7vtxktyfo1.fsf@alter.siamese.dyndns.org>
 <51C22F77.8050004@bbn.com> <7vwqppwwwj.fsf@alter.siamese.dyndns.org> <51C2409F.1070801@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 12:56:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpcXL-0005XK-2M
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 12:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757589Ab3FTK4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 06:56:14 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62494 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757582Ab3FTK4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 06:56:12 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so16161426iec.36
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8gO81rHwhLQsT0HTAgslWF/p2c5O0yyboeHQIox3EUY=;
        b=yZZ81BkcCTCk66rtMx+L8dfvGRJ5qc/6mGyuwVJWzKjEx6FdHLxzw5ZgpFMtfbeSR/
         y/EG4awfD0Mj7or9LppRjn9h1YDSKr/UJ6+UkXC8BnvFKuBe3q+2t+gTiNJ60o/zy2Q9
         u8A27XzkA8bH9m2skVC2xmh6kJ3ILO++WNiDBxw3F/Kx8gqgDvlI/UNX2g6y7/wVoJWk
         kVzc8cMtOqQdLZ96diSEgtJf16j+J65AcL3UYvtImuHIH/oxekzUyJa0mLCrFIBXs2k5
         crFLji80dy4f7JQ0pOI23wRNd4wB82JPwSh8q3PIXdrO2A5Yv3Ous9OILP89sUkRuzSc
         OxaA==
X-Received: by 10.50.25.194 with SMTP id e2mr3417472igg.111.1371725771675;
 Thu, 20 Jun 2013 03:56:11 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 03:55:31 -0700 (PDT)
In-Reply-To: <51C2409F.1070801@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228478>

Richard Hansen wrote:
>   * Aren't HEAD, FETCH_HEAD, ORIG_HEAD also refs?

HEAD is a symbolic ref [*1*], FETCH_HEAD is not a ref [*2*], and
ORIG_HEAD is a ref.

>     ref
>         A binding of a name to an object or other ref (in which case it
>         is a symref).  Refs are stored in the repository.

What is "binding of a name"?  It's a file that contains exactly one
line: a 40-character SHA-1 hex.  End of story.  Like I explained in
[*1*], I see no advantage in grouping symbolic refs with refs.

>         The ref namespace is hierarchical.  Different subhierarchies
>         are used for different purposes (e.g. the refs/heads/ hierarchy
>         is used to represent local branches).

Good.

[Footnotes]

*1*: HEAD is the one and only symbolic ref, unless you create more by
hand using `git symbolic-ref`.  Unfortunately, no other symbolic ref
can ever be on the same footing as HEAD: the sources hard-code "HEAD"
in a large number of places, and reworking it to truly support
symbolic refs is probably not worth the pain at all.  If you want to
convince yourself that this is true, run `git symbolic-ref H HEAD` and
then try to resolve H@{u}: HEAD@{u} resolves fine, doesn't it?

*2*: It's not an "ordinary file" like COMMIT_EDITMSG either, in that
rev-parse can operate on it.  It is not a ref because it contains
references to several objects; cat it and see for yourself.
