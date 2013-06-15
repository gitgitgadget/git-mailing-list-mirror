From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Sat, 15 Jun 2013 18:05:44 +0530
Message-ID: <CALkWK0nRtrvd=oX04XfqovYg1dnx3h+aNSNWH6MXnssOBqz=xw@mail.gmail.com>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
 <1371196058-23948-2-git-send-email-artagnon@gmail.com> <7vli6crau5.fsf@alter.siamese.dyndns.org>
 <7v61xgraba.fsf@alter.siamese.dyndns.org> <CALkWK0m6iiDAmbxG9wrpgxJ3=nM816U7RM519Mu62qSgDwJbaQ@mail.gmail.com>
 <7vip1gpqjp.fsf@alter.siamese.dyndns.org> <7vbo78o6ut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 14:36:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unpik-0003TG-Rt
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 14:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab3FOMg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 08:36:26 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45490 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab3FOMgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 08:36:25 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so3593182ied.0
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 05:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jFJekA3m39MPoLs+vEaSUUc0ywcxTsqedVMyiY5DkOQ=;
        b=imKDobt+zOOo4LZ+gpFzk3aRsGnCQtWY4cL/S9Eo5Or8i8OhDH1Os5LNEusxUIzBEf
         4/TW/1w1R3rHgY+lK5R6M++YeUrXux53IYUtNnlM5U2F+4OEtQKznaj6gUHOgW7qSAVx
         Gec3rAPeAvM21fyJdGaEiHy0I/oO38poL7Sp3SiFevp5oe4lG7d3babwR8hrO88hN3IW
         dKgY31H/FaWK89yBrx/Ez3MFfAxjJCegHfujVe4O9Ceeshi2w/S1TVSwipQNaFUKbjmo
         9lEg1I0YbgPXVxk4/pxGp5/rtnxrndAqVm5KvoGUtwUhzJEDrRKQX5LAUswe7jmmWGIj
         Irvw==
X-Received: by 10.50.118.72 with SMTP id kk8mr1004281igb.13.1371299785149;
 Sat, 15 Jun 2013 05:36:25 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 15 Jun 2013 05:35:44 -0700 (PDT)
In-Reply-To: <7vbo78o6ut.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227945>

Junio C Hamano wrote:
> I _think_ the new check you added may be too loose.

Yep, I totally forgot about the case when git-am.sh is called from an
existing script.  In that case, it is upto the caller to handle
whatever stray directories; we have no business meddling with that.

> A fix-up may look like this.

No, don't leak autostash detail.

Just change that condition to

  if test -d "$dotest" && test -z "$rebasing"

and we're done.  I'll send in a re-roll.
