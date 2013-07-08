From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/4] describe/name-rev: tell name-rev to peel the incoming
 object to commit first
Date: Mon, 8 Jul 2013 18:38:32 +0530
Message-ID: <CALkWK0nMmQO=cML-s9rgku+_4fZnYwtGC+daYPOBPn6-RFZj=g@mail.gmail.com>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com> <1373236424-25617-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 15:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwBBu-00061c-VO
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab3GHNJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 09:09:14 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39054 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab3GHNJN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 09:09:13 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so2894836iee.20
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=I4Pt4qWUQBdc9tkSMNDEsZSYpTiW0pNZbgDPGfjzE84=;
        b=XQI2GQkbKKsPoA/QUBb4i08NnEP6r32iWKw0NHiZ2IQm3Jvpwe0BECr83w6UwIVzPt
         h4AC26IyCsch0Pj0yKndIwRLBwzueB/rw4novxgmLC5SDfJDHgZGCTIg3QGPefAHyYAM
         dsFOxqvquVes+s3uaKCIBTbHFxFgJtGHHWpWm2r5o7pCzgv9raGcMkLLuzFYulqKRWAn
         GwFnlC65lZF/BLsFDzeULpXAAEo+qmEjb6nsdNmzp4zPZmVsU/PN88AbjJGtZh2EFjAR
         FtPZQNWByDRpp3qEiQ2vGCnYHjwuZVYffLe6O5rGN4gNpkfPV+MgAxkE/IDXiUZGty2U
         nzLQ==
X-Received: by 10.50.47.12 with SMTP id z12mr8418725igm.50.1373288952936; Mon,
 08 Jul 2013 06:09:12 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 8 Jul 2013 06:08:32 -0700 (PDT)
In-Reply-To: <1373236424-25617-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229848>

Junio C Hamano wrote:
> With this on top of the other patches in this series, you would get:
>
>     $ git describe --contains $(git rev-parse v1.8.3 v1.8.3^0)
>     v1.8.3
>     v1.8.3
>
> while you can still differentiate tags and the commits they point at
> with:
>
>     $ git name-rev --refs=tags/\* --name-only $(git rev-parse v1.8.3 v1.8.3^0)
>     v1.8.3
>     v1.8.3^0
>
> The difference in these two behaviours is achieved by adding --peel-to-commit
> option to "name-rev" and using it when "describe" internally calls it.

Essentially a revert of [2/4] for describe-purposes, achieved by
adding an ugly command-line option to name-rev.  Before we argue any
further, let me ask: who uses name-rev (and depends strongly on its
output)?!  Our very own testsuite does not exercise it.  There are
exactly two users of describe/name-rev:

1. prompt, obviously.
2. DAG-tests, for simplification.

I really can't imagine it being useful elsewhere.
