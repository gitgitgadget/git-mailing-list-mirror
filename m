From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: avoid ls-remote in certain scenarios
Date: Sun, 2 Jun 2013 17:57:04 -0500
Message-ID: <CAMP44s0or-wtNc85HPO8hMA47xbcXVOcF0QcWvpLAyay0bB2Ag@mail.gmail.com>
References: <1369797648-2921-1-git-send-email-felipe.contreras@gmail.com>
	<7vip1wmahf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 00:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjHD7-0002Rx-4k
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 00:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab3FBW5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 18:57:08 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:54653 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab3FBW5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 18:57:07 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so3220584lbi.9
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1XXF58G8u2s3IB1KAlW4X6dLEnzy5kAJoDkEKUetwiU=;
        b=v+IAZtt9NUcF46pNtLvojdVd8VBhIol46hyAw/PCw+WvWGoOavwQDdzREkiofEi7Je
         z7V31/6pkOEVH3Xp09IKE656ZqT1/R8IaSy55lFTKRfwJeKPf3Axwqm7vMWO+F+5UsIN
         jf336FyI9o407SxMdH+SGwotzQ5I2EwXQAw2ONw2FM7C8bElWHOy9c0jRqVQ9k2W9ULj
         YqOp1Uvya0vMJfE4CW0TghknUWw1ErNpnjVlZ1V7bK4gX1nqMQ2TKTCn8ZMviixOIiF5
         B7CmbTxrITBeYoixeF6BxMiIDWuNLGcF16SHscgzjGfCXyhsI4lQt9X1NTfDbTUZpTbx
         KD5A==
X-Received: by 10.112.33.17 with SMTP id n17mr9651944lbi.72.1370213824608;
 Sun, 02 Jun 2013 15:57:04 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sun, 2 Jun 2013 15:57:04 -0700 (PDT)
In-Reply-To: <7vip1wmahf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226191>

On Sun, Jun 2, 2013 at 5:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It's _very_ slow in many cases, and there's really no point in fetching
>> *everything* from the remote just for completion. In many cases it might
>> be faster for the user to type the whole thing.
>
> Besides, if I understand the use of __git_refs correctly, it is
> primarily about completing things like
>
>         git checkout -b topic origin/<TAB>
>
> where you actively want _local_ copies of what you currently have in
> refs/remotes/origin/, not what you would get if you were to fetch
> and then type the command again, so in that sense, using ls-remote
> is a wrong thing to do in the first place.

Yeah, but we wouldn't use ls-remote in those cases, only when __gitdir
is not available. Try 'git checkout <TAB>' outside a git repository.

> This however may need to be made optional if this is also being used
> to complete
>
>         git fetch git://g.k.org/pub/scm/git/git.git/ <TAB>
>
> to list what can be fetched, but I do not think that is a very
> common thing to do (you either know what you want to fetch, in which
> case you do not complete but copy & paste, or more likely you have a
> named remote and fetch the whole thing).

Indeed. And it doesn't make sense to punish the typical use-cases
because of the atypical ones.

Besides:

git fetch git://g.k.org/pub/scm/git/git.git/ refs/<TAB>

Would still complete everything.

-- 
Felipe Contreras
