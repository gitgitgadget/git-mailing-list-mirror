From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Wed, 23 Sep 2015 08:13:56 -0700
Message-ID: <xmqqwpvhxj63.fsf@gitster.mtv.corp.google.com>
References: <1440157010.1759.83.camel@transmode.se>
	<CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
	<1442245035.10125.18.camel@transmode.se>
	<CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
	<1442508864.21964.26.camel@transmode.se>
	<CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
	<xmqqpp1bbtvz.fsf@gitster.mtv.corp.google.com>
	<1442855328.29498.30.camel@transmode.se>
	<37ca95b3fef79e348fb5ba68cd21c590@dscho.org>
	<1442955525.29498.94.camel@transmode.se>
	<5f56381a3cf5a5ccf6a1e4e3ea48f516@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	git@vger.kernel.org, pclouds@gmail.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 23 17:14:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZelkC-0007lX-1f
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 17:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbbIWPN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 11:13:59 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35314 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411AbbIWPN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 11:13:58 -0400
Received: by pacfv12 with SMTP id fv12so43728648pac.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=L1zX827rCkB2++quRfJvZQLW6sDp8hbLtGFwVfFsBX0=;
        b=ywqXEc6oAxy2LWxTBbbUhLxjftp8LaxjwQ2P3B0zB+sxBgJHi0ykcnCe25BkFyiyL6
         Cmmt5EFVV1YkNYuCiWeYzn/SnR19AwklznAs0ZwWzEgA+kr78NDpnbsP1nYqIfwyCm/M
         LO9hFYlKIkJkHAHPFo4SDFWA1FpvskXpg2MAGKlnNVSMZ7StY3cFfidfTnnA5+4dhrLD
         L6NIGfpoiOrSDYbu7Bjpo/4OlXiRsGOGjnPAtEBKrvd02xxDU088jDPV0u0vElRbEDJm
         qqZKhQJOU2BkrbdGpTFA9aGtyv+w4W6kYYmcoPAj4Ad0pc1Ey6V7k/ZRU+NStya/I3Oy
         h6+A==
X-Received: by 10.66.175.7 with SMTP id bw7mr38979395pac.155.1443021238069;
        Wed, 23 Sep 2015 08:13:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id rw8sm4160875pac.11.2015.09.23.08.13.56
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 08:13:57 -0700 (PDT)
In-Reply-To: <5f56381a3cf5a5ccf6a1e4e3ea48f516@dscho.org> (Johannes
	Schindelin's message of "Wed, 23 Sep 2015 13:10:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278488>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> A .git/tmp/ would make housekeeping easier, you would know that every
>> file under .git
>> should be there and if you find something you don't recognize you would react.
>
> No, it would actually make it harder. I seem to recall that there was
> some problem with renaming a file unless it was already in the same
> directory as the destination. If all files were to be written to
> .git/tmp/ first...

I agree with you here.  This "some filesystems do not like
cross-directory renames" was also why I thought the idea to create
everything in $GIT_DIR/tmp and moving to the final destination would
not fly well.

For the specific issue with the shallow-cutoff list temporarily
created, however, it is created, written to, read from and removed
without ever leaving the original place, so we could designate one
writable "temporary" place somewhere under $GIT_DIR, and $GIT_DIR/tmp
could certainly that designated temporary place.

By the way, the temporary shallow-cutoff-list is created by callingy
xmks_tempfile().  I wonder if it can safely changed to use
mks_tempfile() instead.  That way, people can set up a wrapper for
receive-pack that sets up a suitable TMPDIR exported to the real
thing to relocate it.
