From: Ray Chen <rchen@cs.umd.edu>
Subject: Re: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Thu, 2 May 2013 14:59:58 -0400
Message-ID: <CANtO-4OYjKpGSAxjKubvubGoXgdkkiZ9yK1unW1wrcONa3ErsQ@mail.gmail.com>
References: <1438528085.20130501090926@gmail.com> <1409591910.20130501123153@gmail.com>
 <7vhaim8w48.fsf@alter.siamese.dyndns.org> <455264907.20130501235104@gmail.com>
 <20130501213031.GA13056@dcvr.yhbt.net> <7v1u9q5pu5.fsf@alter.siamese.dyndns.org>
 <20130502024926.GA12172@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilya Basin <basinilya@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu May 02 21:00:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXyk8-0002VK-6r
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 21:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761277Ab3EBTAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 15:00:30 -0400
Received: from mail-da0-f47.google.com ([209.85.210.47]:58005 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759291Ab3EBTA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 15:00:29 -0400
Received: by mail-da0-f47.google.com with SMTP id k13so446873dae.20
        for <git@vger.kernel.org>; Thu, 02 May 2013 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=yAHkDCc4qCisayPo4K3QuazJUMl1t6mahojpXdRAYQg=;
        b=wEYWScKA8r34KQF9/Z2+FTUEXeuhUA9WP8fwkWh6Y8S/2O6wem52r3rGxCgOyvRU3e
         MfCQdrSXQ3vvs/OaqD/aOJhM+5+ZCn51vFOBhXl905QdBaxatW8JmY6M2T5gou4Obnlt
         MRmlsLEa2rgioxbB/cWTYHC+wU2yc1HYAsBOWY3VkY1k/0qrOHEfzmkgidJSImJDwrAw
         uMf6VKQN3xfD+yV+RNmX2ZHBAOLsWBZ46iZFVEXp7WKnP4hw503jep6zS5LjeN36TS8I
         6vSfJ6uQYJjS8IQU2kjw9cyxAl4K2bOpZliuk+eKEXkT+jZp3Nzg/4wEJn6b4M1AanXW
         C3nw==
X-Received: by 10.66.217.226 with SMTP id pb2mr11141932pac.109.1367521228885;
 Thu, 02 May 2013 12:00:28 -0700 (PDT)
Received: by 10.70.13.197 with HTTP; Thu, 2 May 2013 11:59:58 -0700 (PDT)
In-Reply-To: <20130502024926.GA12172@dcvr.yhbt.net>
X-Google-Sender-Auth: mUw6SeQS-_RbrCCI1qdRb66ghUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223248>

On Wed, May 1, 2013 at 10:49 PM, Eric Wong <normalperson@yhbt.net> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Eric Wong <normalperson@yhbt.net> writes:
>
>> That however is not a property of the directory containing it (or
>> the path to that .gitignore file) that is valid throughout the
>> history of the project.  It is a property of a specific tree object
>> (or you could say it is a property of the revision).  When at some
>> point in the history the upstream project adds .gitignore there
>> because many people use git-svn to contribute to their project, it
>> stops to be "should not be pushed back".
>>
>> So it seems to me that the information this "placeholder added"
>> thing wants to express belongs to the tree object (and .gitignore
>> file itself is a natural place to have that information).
>
> Perhaps that was the better way to go...
>
> How would (the presumably few) existing users of this feature be
> affected?
>
> Currently with the config file, there are problems with interop between
> git-svn users that do git <-> git repo sharing, an updated version with
> the "placeholder added" .gitignore would allow git <-> git repo sharing,
> but only between users of newer git versions.  Perhaps that's fine and
> better than the current situation.

The original patch was geared towards increasing the fidelity of a
one-time svn->git migration (ie. where svn won't be used anymore).  I
recall investigating a method to enforce this by disallowing future
git-svn fetches, but I can't remember if I was successful.  Given this
perspective, I'm not sure that existing users need to be supported.

Then, as Junio mentions, future versions of git that store placeholder
info in the tree/file object could open the possibility of proper
git<->git sharing and resync with the original svn repo.

- Ray
