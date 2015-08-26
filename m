From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/2] trailer: support multiline title
Date: Wed, 26 Aug 2015 08:07:13 +0200
Message-ID: <vpqa8tetwfi.fsf@anie.imag.fr>
References: <1440557461-1078-1-git-send-email-chriscool@tuxfamily.org>
	<1440557461-1078-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 08:07:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUTrn-00058n-P0
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 08:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbbHZGHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 02:07:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34468 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755872AbbHZGHR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 02:07:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7Q67D18010451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 26 Aug 2015 08:07:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7Q67Drj025715;
	Wed, 26 Aug 2015 08:07:13 +0200
In-Reply-To: <1440557461-1078-2-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Wed, 26 Aug 2015 04:51:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 26 Aug 2015 08:07:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7Q67D18010451
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441174033.79316@p8Pinn7fnEAkfA7cKAZnbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276596>

Christian Couder <christian.couder@gmail.com> writes:

> Unfortunately this does not work well when a commit is created with a
> line break in the title, using for example the following command:
>
> git commit -m 'place of
> code: change we made'

I confirm that this patch fixes the behavior for me.

Now, I found another issue: I still have this "interpret-trailers" in my
hooks/commit-msg, and it behaves badly when I use "git commit -v". With
-v, I get a diff in COMMIT_EDITMSG, and interpret-trailers tries to
insert my Sign-off within the diff, like this:

  # Do not touch the line above.
  # Everything below will be removed.
  diff --git a/git-multimail/README b/git-multimail/README
  index f41906b..93d4751 100644
  
  Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
  --- a/git-multimail/README
  +++ b/git-multimail/README

Either commit-msg should be called after stripping the diff from
COMMIT_MSG, or interpret-trailers should learn to stop reading when the
patch starts. I think the first option is better, since it means that
any commit-msg hook does not have to deal with the patch stuff (my guess
is that there are many broken commit-msg hooks out there, but people
didn't notice because they don't use "commit -v").

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
