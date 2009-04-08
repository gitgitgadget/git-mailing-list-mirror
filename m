From: Elijah Newren <newren@gmail.com>
Subject: Re: need help with git show :1:...
Date: Wed, 8 Apr 2009 12:25:35 -0600
Message-ID: <51419b2c0904081125u3bdf37deyd5dd85f6c2a6d7cc@mail.gmail.com>
References: <6838.1239212486@relay.known.net>
	 <51419b2c0904081058p7d5a56c3j6aa5cebb0188ad43@mail.gmail.com>
	 <7199.1239213762@relay.known.net>
	 <51419b2c0904081107s7ba08367w671d5b494095402@mail.gmail.com>
	 <7357.1239214209@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:28:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrcUN-0004Yd-54
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762331AbZDHSZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 14:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762987AbZDHSZi
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 14:25:38 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:65090 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583AbZDHSZh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 14:25:37 -0400
Received: by qw-out-2122.google.com with SMTP id 8so267689qwh.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h3mSgbCtUtcFQpbwP3Zi0CAeBdsIAYMYDPsQ7jtlOOE=;
        b=NuyT15HQn4Oebq51u6I9CUPhgVmheD54ZLwemymyL5leIk6Ypi8jXBMFSYJnassKYf
         DavMq1CCtUWXtntEZvYB1NDr//YPHvzAmTTIYsQgNnDqmsiF4MvSabytrOz7vgaYiWeo
         Pgdz/f0hBgwsBtWHyaqpRCQJ0zhiLgJdNUAPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V9e4BoBP53mtu5w7cCYH/xxaDhqf4OKE64adEmUJFeFNG5+mo89RNUUwgR7er8qEed
         j+J0JrbjhjswCwXZuz4Z3IF2i6Fho6Le7dLg/VqOHFduKbl8pDzbFmU6YEiq0QnFnSOu
         0H7AJuABsip+5fQiv/RkqlkhaoBolkQc/m2KU=
Received: by 10.231.18.130 with SMTP id w2mr435760iba.11.1239215135539; Wed, 
	08 Apr 2009 11:25:35 -0700 (PDT)
In-Reply-To: <7357.1239214209@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116105>

Hi,

On Wed, Apr 8, 2009 at 12:10 PM, layer <layer@known.net> wrote:
> Elijah Newren <newren@gmail.com> wrote:
>>> On Wed, Apr 8, 2009 at 12:02 PM, layer <layer@known.net> wrote:
>>> > quadra% git ls-files -s src/c/sock.c
>>> > 100644 ef6c9b94c678dc79760edfd15a0796b3726b76f6 0       src/c/sock.c
>>>
>>> That suggests that the file is not unmerged, i.e. that there aren't
>>> any remaining conflicts.  This explains why your commands wouldn't
>>> work unless you used stage 0 instead of 1 or 2.  Now, why there
>>> weren't conflicts when you thought there were?  I have no idea, unless
>>> perhaps you did a stray git add src/c/sock.c.
>
> It was several of weeks ago that I started this merge, and I remember
> playing with git show then and it worki.  I might have overwriten
> the file with one of the show's and done manual editing that way.  I
> don't know if this makes a difference.
>
> How can I redo the merge for just this file?  Is that possible?  I
> think I'd definitely like to start over on *just this one file*.

Well, someone else probably knows a clever way to do this.  I don't,
but the following may help:

MERGE_REF=$(cat .git/MERGE_HEAD)
git show HEAD:src/c/sock.c > current-sock
git show $MERGE_REF:src/c/sock.c > other-sock
git show $(git merge-base $MERGE_REF HEAD):src/c/sock.c > base-sock
git merge-file current-sock other-sock base-sock

That'll redo the three way merge on src/c/sock.c (assuming no renames
or other special cases happened) and store the result in current-sock.
 You can then edit that file and when ready, move the result over
src/c/sock.c.

Elijah
