From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Sun, 21 Jun 2015 13:46:44 -0700
Message-ID: <xmqqwpywiybv.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
	<xmqq1th77829.fsf@gitster.dls.corp.google.com>
	<95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
	<xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
	<558643CA.6000303@alum.mit.edu>
	<xmqqioahj849.fsf@gitster.dls.corp.google.com>
	<3faa92b10274ce8cfebe340761f73505@www.dscho.org>
	<xmqq1th4kdeq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 21 22:46:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6m8h-0004EO-9h
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbbFUUqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:46:47 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37322 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbbFUUqq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:46:46 -0400
Received: by igblr2 with SMTP id lr2so41816332igb.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0C9+rGm6MJ7uHpLLvN2ozXKOzaiuwG/7gMA8T08sJdA=;
        b=jZMg94Jm6+deLlgKGCpGyaC3rnHX2NRCqGpnzJlxrrGU5rJ6m++xoNnWU7PgH2GuNa
         gqdYH0yLfE9uAY+zza3i1Si5dw7xqay5L6Dn6YzPupZIP0zhDZBM/dgXNLHbzHboRcoz
         L77dOYZ5zw9F/G/D+OqqyJVh3WkNt+81RDpMpS1fQ/ubMbNEgZPnnoVHjQzo/Igu6aNG
         +kyDpuF4StLdKaPtdgpnsB1ugYgdRxJnkOLNhE9wPBSU6aKMY0v6CxKTHYKj9tKHtWrh
         1dRzSPMWTR0ZBKkjVvZx3aeHg1ayrAN6MO714Fvs9T9JNWzRFaqkdPL8WLhzKtwolxWy
         A6GA==
X-Received: by 10.107.170.216 with SMTP id g85mr27068815ioj.31.1434919605713;
        Sun, 21 Jun 2015 13:46:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:990b:778:aa29:b388])
        by mx.google.com with ESMTPSA id o200sm11585455ioo.43.2015.06.21.13.46.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jun 2015 13:46:45 -0700 (PDT)
In-Reply-To: <xmqq1th4kdeq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 21 Jun 2015 13:35:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272286>

Junio C Hamano <gitster@pobox.com> writes:

> Of course, that assumes that you can tell an object is a blob
> without unpacking.  If a tree entry mentions an object to be a blob
> by having 100644 as its mode, unless you unpack the object pointed
> at by that tree entry to make sure it is a blob, you wouldn't be
> able to detect a case where a non-blob object is stored with 100644
> mode, which would be an error in the containing tree object that we
> may want to detect.

Heh, I was being stupid here.  Of course, you can tell an object is
a blob without fully inflating it (we should already be doing that
in sha1_object_info(), inflating only the object header in loose
objects or inflating only the early parts of delta in packs to
follow the delta chain to learn the type of the object), and that
would certainly save us substantial zlib cost.

Sorry about the noise.
