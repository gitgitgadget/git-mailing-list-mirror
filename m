From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: dereference tags with --ignore-if-in-upstream
Date: Mon, 01 Jun 2015 10:58:24 -0700
Message-ID: <xmqq1thv71kv.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
	<1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqqr3pv8okj.fsf@gitster.dls.corp.google.com>
	<xmqq6177728a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 19:58:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTyt-00024R-H1
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbbFAR61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 13:58:27 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38634 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbbFAR60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 13:58:26 -0400
Received: by igbjd9 with SMTP id jd9so67884705igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TzLaeKUn+uneCb6zekNomB8O9cX5L22jjd5+HlqYrKU=;
        b=We5TQbvF7ma9TrxDh7fV2d69POytI3M2wuK9KiWnlWC4MJpfhznC8fzVGN8nHKOqyo
         s+a4yDgGeuaEiN/Ac3MkjXJ9sPR9JWraGYO0ibiDYtlGSaC7UsjQ+Ol6mARhGBHRP2Ap
         9KZefOdwYwjV53USojw3NLjJ0ogSOW4B2Pcwo7xnORMDm9PAlS+tIbygXZcmbX1+6LnO
         kOsuiF6BPimqhCBZGE+M7joSEltBuQ/6hSKbeqOf6/I1edncyMDTiJIOuscfy2moU0IV
         pZK5Gd35iOvIiqPt9DzoFIKvdJF0iL44lLPSOnUfsGNTq7GqPky5ns2vjxgtbJ/50JHn
         GOQQ==
X-Received: by 10.50.122.102 with SMTP id lr6mr15126958igb.37.1433181505994;
        Mon, 01 Jun 2015 10:58:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id l1sm10866444ioe.32.2015.06.01.10.58.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 10:58:25 -0700 (PDT)
In-Reply-To: <xmqq6177728a.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Jun 2015 10:44:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270449>

Junio C Hamano <gitster@pobox.com> writes:

> How about doing it this way?  We know and trust that existing
> revision traversal machinery is doing the right thing, and it is
> only that the clear_commit_marks() calls are botched.

Another alternative may be to allow any object to clear_commit_marks()
and have the callee dereference as needed.  After all, the revision
walking machinery does such a dereferencing when leaving these marks
that the function wants to clear, so it might make sense from that
point of view.

A quick "git grep clear_commit_marks()" tells me that most of the
codepaths do make sure the object is a commit when they cast their
first argument to (struct commit *) when calling this function, but
some of them do look suspicous.
