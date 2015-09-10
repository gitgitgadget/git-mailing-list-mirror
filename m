From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 23:05:48 +0530
Message-ID: <CAOLa=ZQXP-U+dGYYFcvxVmuG2NOSiHYLHEwm2OtvhGQrBW9hdQ@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <1441900110-4015-6-git-send-email-Karthik.188@gmail.com> <xmqq37ym5i2u.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQM77+EzbHbY24nvu=hgNCa9MJ3wyz1XhFjk+3HdDd_Hg@mail.gmail.com> <xmqqlhce420b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:37:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5mI-0001s9-Vv
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbbIJRgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 13:36:37 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35933 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbbIJRgT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 13:36:19 -0400
Received: by obqa2 with SMTP id a2so40702754obq.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BLzOxwjgJvuAbRFMWsAcuZGf/EERSbD53S60B04zjXk=;
        b=NED062/sJOVbMOWgVg0TskbEDhfkgNyMP1iN8RLGAPg/IsqlG+8nWPjVRV7c4HNJq2
         TvDuAiwwMmIbWnEPBsq3+3iVNQIW11BTj73g24auhh+xtlB/bQJzkzXwn4TfsWDZVSiV
         d7zofRNZtlykOkCabdLJPcAW/KH8trXprd1Kq1d9HS1zjy57WV88QDL5US+FoSo3hg7w
         JfWJlX4NG8pdBf4AA18g/ZTTfmrfwIOncrmHVjj4nJjb0FiQv9aSVCxXPiz86cmxAezt
         HNsj/ikfs2y6AxZnDS5SrlLjuDmPQfb8Glpsx4M38uZdEdzvZAwLWh6L5F6lq3uzU3fj
         4JyA==
X-Received: by 10.60.81.69 with SMTP id y5mr33596023oex.30.1441906578085; Thu,
 10 Sep 2015 10:36:18 -0700 (PDT)
Received: by 10.182.59.15 with HTTP; Thu, 10 Sep 2015 10:35:48 -0700 (PDT)
In-Reply-To: <xmqqlhce420b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277612>

On Thu, Sep 10, 2015 at 10:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The check was for checking if there is anything after the colon,
>
> Why do you even care?  If %(color) expects more specific
> customization by adding colon followed by specific data after it,
> i.e. %(color:something), %(color:) should clearly be that "%(color)"
> thing with no customization---if it is "not enough customization" or
> "leaving everything default" depends on each atom, match_atom_name()
> is not a good place to make that policy decision (i.e. Mattheiu's
> rewrite to clear *valp to NULL when %(color:) is seen).  Instead,
> point *val to body + 1 just as usual, and let the caller tell
> between *val being NULL (not even any colon) and *val pointing at a
> NUL byte (nothing after colon) if it cares.

It is one thing that the user can actually do the check themselves,
but doesn't it make more sense that when we're using colon we expect a
value after it, and something like %(color:) makes no sense when color
specifically needs a value after the colon.

Hence rather than assuming that the no value is given and fallback to
the default
%(color), wouldn't it be better to warn the user that there is no value?

But then again we can leave this decision to the user like you said.

-- 
Regards,
Karthik Nayak
