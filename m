From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] commit-queue: LIFO or priority queue of commits
Date: Fri, 7 Jun 2013 01:29:34 -0400
Message-ID: <CAPig+cQetpnYWv6OZnYfK9-gz2L86KdCFvBS7GfEE3dxN9-Qvw@mail.gmail.com>
References: <7vfvwuww39.fsf@alter.siamese.dyndns.org>
	<1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370581872-31580-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Elliott Cable <me@ell.io>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 07:29:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkpFL-0005FJ-5i
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 07:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab3FGF3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 01:29:39 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:52509 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3FGF3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 01:29:38 -0400
Received: by mail-lb0-f172.google.com with SMTP id p10so3861130lbi.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 22:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=C5Mo8uRZDs7xQjWYchBlOXnO9Veu+uK0GpC5zzttDVs=;
        b=t7PvbIRWfJWbiX2FZCXQ4KYHsNYEKFm1W6k6QMUQIBwvjjWpKX42X+SgNt5u8vHtJE
         kkhOi44DFPa3N+bWwfOlJ9Ws/UKICVdXbKiWDHtb0I6IuuuKb9TMvNfnbL82Hv4ZYnoW
         FYk6qKB5fQcyrpYOGcSVVWkF82tuIsF1kHYfTUyWzTEfxBTo66uMsUHmAqO8GAadEUQt
         EEvjW8mQSGbULOwBWlN3+8jCnDLejWmCYYvKfbfNGZcOqTa2Y6XGDnwHp+t4mEJ9YiOy
         IQFcrybn3paxWgmxfgByObhgo7OwKKboegZT2ZfxTMXchwk8NyLvDJ+gsEwNVb6xzvnw
         P2Qw==
X-Received: by 10.112.89.226 with SMTP id br2mr474664lbb.12.1370582974113;
 Thu, 06 Jun 2013 22:29:34 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 22:29:34 -0700 (PDT)
In-Reply-To: <1370581872-31580-3-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: -9yJ079dBwnlSVw6EhK0IaOBUdE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226598>

On Fri, Jun 7, 2013 at 1:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Traditionally we used a singly linked list of commits to hold a set
> of in-flight commits while traversing history.  The most typical use
> of the list is to insert commit that is newly discovered in it, keep

s/commit/a commit/

Also, "in it" is perhaps implied by "insert", so s/in it// may be appropriate.

> it sorted by commit timestamp, pick up the newest one from the list,
> and keep digging.  The cost of keeping the singly linked list sorted
> is nontrivial, and this typical use pattern better matches a priority
> queue.
>
> Introduce a commit-queue structure, that can be used either as a
> LIFO stack, or a priority queue.  This will be used in the next
> patch to hold in-flight commits during sort-in-topological-order.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
