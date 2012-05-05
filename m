From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: how to restrict git to specific non-root superuser
Date: Sat, 5 May 2012 10:37:24 +0530
Message-ID: <CAMK1S_g+EmVe+xHB0TvRB0Xhk0Su1MJXyQEHfHMcqvyhjg1Gvw@mail.gmail.com>
References: <jo20t5$e8n$1@dough.gmane.org>
	<4FA49EA6.8030000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 07:07:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQXDO-0005uW-48
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 07:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207Ab2EEFHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 01:07:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54478 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2EEFHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 01:07:25 -0400
Received: by obbtb18 with SMTP id tb18so4955043obb.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 22:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RE+LY+2hrw0uk2A8Hdb5IPQPLR1AReQbI7GyaHFfqt0=;
        b=hnKghrrBfsdh27BIzw3wvnkssgUU4Mmx8LEjY19tz+5aa+ONAjMKwY3ZT6Ivgk/Nqe
         BT8ynEgYC6dT2wkguhB1IVzdxi8pINL0lYeqBvP/RUBea9f1LHvZBWawb62XwjClM2+W
         R1SZtVBmoHcPqFuPnvaFS52r7bh5S/8R2/I4isBHPGrE2KA/BC5emXVSPZUnX9hbCDzZ
         2c1dIVBu1kyprvKJPfXChRzqjkfhn6ou6un3IOLQITnuRnFhEy6Gd13IZJJNvxjeg37B
         WI2v9eHI2MUiKAS7cyvEqC9HMpLjpRdxfb+I+tAvlH3ujlDQbNgtdhQTkLG5o2C0Omyy
         bvhg==
Received: by 10.60.30.3 with SMTP id o3mr11992207oeh.9.1336194444652; Fri, 04
 May 2012 22:07:24 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Fri, 4 May 2012 22:07:24 -0700 (PDT)
In-Reply-To: <4FA49EA6.8030000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197095>

On Sat, May 5, 2012 at 8:59 AM, Neal Kreitzinger <nkreitzinger@gmail.com> wrote:
> On 5/4/2012 8:48 PM, Neal Kreitzinger wrote:
>>
>> I work on systems where 'everyone' has the root password (that problem
>> is somewhat out of my hands). Is there a technique to setup git so that
>> only a certain non-root superuser (ie, gittech) is allowed to run git
>> commands? I don't want people logged in as root to mess up the git repos.

move /usr/bin/git to some other name and replace it with this shell script:

#!/bin/bash
# scary message
echo 'running: rm -rf /'
# lots of disk activity
find / >/dev/null 2>&1

Jokes apart, even though you said it is out of your hands, you
actually have a very serious problem.  There are no shortcuts to that
one until you get burnt.

Meanwhile, you could add 'update' as well as 'pre-commit' hooks (and
possibly several others; check 'man githooks') using code that checks
the effective userid and aborts if it is root.

("aborts" in a hook generally means the eqvt of "exit 1" but again,
please check "man githooks" for details).
