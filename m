From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/2] Slightly prettier reflog message from checkout
Date: Sun, 16 Jun 2013 14:51:52 +0530
Message-ID: <CALkWK0ki9C9OL36b3j14C-mVMPy07Uj5FXcrfMZJs_g3zBRC9A@mail.gmail.com>
References: <1371317906-3991-1-git-send-email-artagnon@gmail.com> <7vmwqqkftv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 11:22:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo9AW-0008Iz-KF
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 11:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147Ab3FPJWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 05:22:34 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64922 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab3FPJWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 05:22:33 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so4416747ieb.24
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ha12pLBNEyKFRbwo0C0vKq08nlTQCkxXbNEJ4vfh41U=;
        b=KA/peZ2hO8tuw4JudEkAvZyVJcRQEGpU0Y0Se6Bkr+aZ9g4FVApiu0PWjlOdqbK6YI
         uD88UO+FXVtibNqQQ8sc8xZpA5Y+kf/Zg5OPBd/qkb7Z9hm37K8nKjj9IeIyw2zC2scK
         JMlOFxRNE1uQWQYru0nKhZ7Av3h/ZzJU+ZHYjoxzLkxn856KGR4r/erhezNeH22Vpl0h
         Qr9gFkbkggCcpjy8kJBp5zQHWW6q7yJh7FGTdayo5mCFAriX/wz9B20I+LNQTEf7rHQT
         wxqhBEDGZ5rn5ezNKXf49LGx0QdDtRTvG1jIwIBbFQx8T7pfVT+iHnGsWW7xLtb6SyVs
         VKzw==
X-Received: by 10.50.23.8 with SMTP id i8mr2527478igf.42.1371374552648; Sun,
 16 Jun 2013 02:22:32 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 16 Jun 2013 02:21:52 -0700 (PDT)
In-Reply-To: <7vmwqqkftv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228003>

Junio C Hamano wrote:
> I view the two codepaths touched by these patches the other way
> around.

I see.  Thanks for the early feedback.  I have some doubts.

> An abbreviated unique SHA-1 you have today may not be unique
> tomorrow.  There is no reason to deliberately lose information
> (e.g. by using "Then, instead of the absolute minimum, let's record
> a bit more bytes" heuristics) when we record. The reflog recording
> code in checkout writes full 40-characters on purpose and there is
> no reason not to do so (i.e. the codepath that is the topic of 2/2).

When did we guarantee that the messages written by the reflog are invariant?

  $ git checkout @^
  $ git reflog | head -n 1
  b1d94f2 HEAD@{2 seconds ago}: checkout: moving from checkout-dash to HEAD^

What does HEAD^ even mean?  What guarantees that checkout-dash will
not be something else tomorrow?  If you want invariance, isn't that
what the first field is for (b1d94f2)?  As I understand it, the
messages are purely to convey end-user information about the
breadcrumb trail: they were later made semi-semantic (like the @{-N}
parser using them).

> Once we accept that design principle of not losing information when
> we do not have to, it naturally follows that the writing side should
> write full 40-hex, and also the reading side (i.e. the codepath that
> is the topic of 1/2) should make sure that it reads 40-hex and
> nothing else.  This also reduces the risk of a funny branch name
> that consists only of [0-9a-f] getting mistaken as an object name,
> but that is not the primary point.

As I already explained, I don't know what information loss you're
talking about.  And yes, I noticed advice.object_name_warning.

> So I am fairly strongly negative on both changes.

Okay, but please explain it for me.
