From: Angus Hammond <angusgh@gmail.com>
Subject: Re: Cherry-picking commits with empty messages
Date: Wed, 1 Aug 2012 19:15:16 +0100
Message-ID: <CAOBOgRZ9Ouan2htT9m3qBrUvae3nT1az3A61kiRMSJNyFv1MdQ@mail.gmail.com>
References: <20120801111658.GA21272@arachsys.com> <7vd33afqjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Webb <chris@arachsys.com>, git@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 20:15:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwdSV-0004Qa-LE
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 20:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab2HASPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 14:15:39 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41653 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab2HASPi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 14:15:38 -0400
Received: by lbbgm6 with SMTP id gm6so508181lbb.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dVllBxQfBUO3VkGsARe5zRgwJZS+ScHMSoH+4PiEdSg=;
        b=AMtUTb0+mwm7sku2j03UXL7J6Pxe2wKnf42+WlhvTCs58gxJk82gc/0/t1ozsZ+Yta
         V4rdzNfpCg6f2su8mgMLne3GO2wdwIKlkDI4NU5UWVOv/MfVkwu54sbeS/bTVxVDbegk
         ITqnowDWVXlAt8RpNl7AQn0Id1Pa4+L/1lxcGymJDiQREJgtWRHiMliYPFz39WUcvE+9
         fxih2XHxqHsMJaoIMj599RzavOnHldYrsCBsA8l7ABRXOoI3l+/3TpJvyLUz0W2SM6k3
         GhZI33HCPymmcRPUhAFKO7XkbP3cz5RvOVby0+uRiALE6NM+bVg/pKPzjtZOWKsT0uNG
         t6tQ==
Received: by 10.152.132.233 with SMTP id ox9mr18800732lab.25.1343844936552;
 Wed, 01 Aug 2012 11:15:36 -0700 (PDT)
Received: by 10.114.12.1 with HTTP; Wed, 1 Aug 2012 11:15:16 -0700 (PDT)
In-Reply-To: <7vd33afqjh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202717>

>    But from the bigger UI consistency point of view, it would be
>    chaotic to change the default of some options for a single
>    command depending on the nature of the operand, so I would
>    recommend against going this route, and pick one view between
>    "give the user a chance to fix" or "the user must have done so on
>    purpose" and apply it consistently.
>
> My recommendation, backed by the above line of thought, is to add
> support for the "--allow-empty-message" option to both "rebase [-i]"
> and "cherry-pick", defaulting to false.

Though I completely agree regarding having a consistent UI that
doesn't change it's behaviour based on the operand, I'd argue that
--allow-empty-message should default to true on cherry-pick for a
couple or reasons. Firstly, in the case that git perpetuates an empty
commit message that the user does not want, it is only damaging a
repository in a way that it is already damaged, clearly this still
isn't ideal, but it's certainly not as bad as damaging a repository
that's pristine. Arguably it's the user's responsibility to ensure
they don't TELL git to perpetuate their own bad commit.

Secondly, I'd don't like the idea of a command that 99.9% of the time
will run completely independently, but then every so often will become
interactive. This is probably a rare enough scenario that script
writers would reasonably assume that cherry-pick (without the
--allow-empty-message flag) is not an interactive command and write
their scripts accordingly. A user who made use of empty commit
messages would find any such scripts crashing on them or producing
strange results. Even if this is the fringe case, it seems to be a
substantially worse fringe case than that where we make a commit that
has no message at the user's instruction.

Thanks
Angus
