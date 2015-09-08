From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Questions about git-push for huge repositories
Date: Tue, 08 Sep 2015 11:24:06 -0700
Message-ID: <xmqq4mj493cp.fsf@gitster.mtv.corp.google.com>
References: <CAN6cQGPcGpaXUGu_7aaeJtMbruMocte-5po97vG5r39f=YdTZQ@mail.gmail.com>
	<xmqq4mj7bfsf.fsf@gitster.mtv.corp.google.com>
	<CAN6cQGMf089ERn2kZbFpHJ6vyJ4BnjCm-m-E+hQsduH55XFvKw@mail.gmail.com>
	<CAN6cQGNGP+n3L=tuRCymOTWFCnFNsq-tFHkaNm+W=o726mjmmw@mail.gmail.com>
	<CAN6cQGOO540FV9bTQPks+1nHS1xO10Rv8iNzAj8-cBihQ4_kEw@mail.gmail.com>
	<20150908054432.GC26331@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Levin Du <zslevin@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:24:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZNYz-00040r-Gc
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311AbbIHSYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 14:24:10 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33858 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbbIHSYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:24:08 -0400
Received: by padhy16 with SMTP id hy16so128566151pad.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sBncd5TZMa4nCyT21ues29T7AkBlayfAYNehEh1/kcE=;
        b=PeLH31njlQZOvccl/NtqD+eiPdZfbkpnRsxl9tDlYX83e2aciW+uL1jUYTjd6f+76a
         dRw5M62ml7AdDk6tP3r9tB/fswGf5vlqZiaTZQp0FmVbYwxr6JgcQjBmhlY9dVGAeAVn
         nM8EhFjuLE6q1BHyciaxTGh6x4n2ZqTrNPdD4NZ8VzFpRD/MEXx640ehlvAXr+uQTtz3
         3xnzMA+KKudxdQosVGSZU/djuZk5CWzOZs52AV5iesn5A9ZMhWTlXB0r3Z/6t7VWH3z/
         szjcGEpYNRjSxB7vbGCnPP45ACgVZ6B9nduIeXNYyqbkowh6E4ZTmUjrfGAg4qR9xRHk
         3Ktg==
X-Received: by 10.68.69.98 with SMTP id d2mr59856613pbu.137.1441736648336;
        Tue, 08 Sep 2015 11:24:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id ni2sm4204431pdb.68.2015.09.08.11.24.07
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 11:24:07 -0700 (PDT)
In-Reply-To: <20150908054432.GC26331@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 8 Sep 2015 01:44:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277515>

Jeff King <peff@peff.net> writes:

> If you turn on reachability bitmaps, git _will_ do the thorough set
> difference, because it becomes much cheaper to do so. E.g., try:
>
>     git repack -adb
>
> in repo A to build a single pack with bitmaps enabled. Then a subsequent
> push should send only a single object (the new commit).

Hmph, A has the tip of B, and has a new commit B hasn't seen but A
knows that new commit's tree matches the tree of the tip of B.

Wouldn't --thin transfer from A to B know to send only that new
commit object without sending anything below the tree in such a
case, even without the bitmap?
