From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 11:45:13 +0100
Message-ID: <vpqmwhexidi.fsf@anie.imag.fr>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com (Junio C Hamano),
	stephen_leake@stephe-leake.org (Stephen Leake),
	git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Wed Feb 26 11:45:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIbzW-0001N2-VO
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 11:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbaBZKp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 05:45:27 -0500
Received: from mx1.imag.fr ([129.88.30.5]:58908 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaBZKp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 05:45:26 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1QAjCta024846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Feb 2014 11:45:12 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1QAjDqw016593;
	Wed, 26 Feb 2014 11:45:13 +0100
In-Reply-To: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de> (Stefan Haller's
	message of "Wed, 26 Feb 2014 11:24:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 26 Feb 2014 11:45:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1QAjCta024846
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394016313.18149@kr9ETesaOJn3qClBvgG0Ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242712>

lists@haller-berlin.de (Stefan Haller) writes:

> Your intention was clearly to drop the stash, it just wasn't dropped
> because of the conflict. Dropping it automatically once the conflict
> is resolved would be nice.

Your intention when you ran "git stash pop", yes. Your intention when
you ran "git add", I call that guessing.

The condition for dropping the stash should be more "conflits
resolutions are done AND the user is happy with it". Otherwise, if you
mess up your conflict resolution, and notice it after running "git add",
then you're screwed because Git just happily discarded your important
data. The point of keeping the stash is to leave it up to the user to
decide between "I'm happy, I can drop" or "I'm not, I should re-apply",
and Git cannot tell which is which.

Hinting the user to run "stash pop" would be more acceptable, but
talking about "git stash" in "git add"'s code is somehow a dependency
order violation (stash is normally implemented on top of Git's basic
features, not the other way around). Does not seem serious from at first
from the user point of view, but this pushes the codebase one step in
the direction of an unmaintainable mess.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
