From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Saving space/network on common repos
Date: Wed, 17 Dec 2014 14:32:15 -0800
Message-ID: <20141217223215.GO29365@google.com>
References: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Craig Silverstein <csilvers@khanacademy.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 23:32:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1N8p-0006gq-A4
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 23:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbaLQWcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 17:32:19 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:46138 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbaLQWcS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 17:32:18 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so268151iga.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 14:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=l5SYkTVrqVL1OrPi6BBZ1eKDw7qvkX1ArMJEo++uMQM=;
        b=hVZIlHlq+7ojsjwQMyvJXz7i+uk1Nftn6PfbgU9UDJ0+ZTzPMWEWwSIJYZsR0ZxIJ+
         ahc4xuc7qJDNmFIc63e56woEWU/XaNqPLkOhgUJlzW5qqBJDRPLiWkedMCWliM2q9ja3
         dh6sdjH+sCqjSjZeU9YLxPBfwk/dn35eqVgyPxjQm+OnBTdyZU6pid7SMWz1HujgYCAr
         FCq3hAbVWZFQtr7cZnbxK2ekDgC8zwu5QYCsCRGrKGXGvhAdms5gFOuw2XpdLpm7Xdru
         1gkyVgg7g0zphRFgwcBeD4F4tg4aq6jEhH9hzji1rSjrlYmgTB6QGPydrsuW72W2Rnoh
         Qctw==
X-Received: by 10.50.114.69 with SMTP id je5mr10554714igb.24.1418855538087;
        Wed, 17 Dec 2014 14:32:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c577:d193:b305:4b9f])
        by mx.google.com with ESMTPSA id o72sm2385395ioo.14.2014.12.17.14.32.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 14:32:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261501>

(+cc: Duy who wrote the recent 'checkout --to' patch series)
Hi Craig,

Craig Silverstein wrote:

>          By design, our Jenkins machine has several different
> directories that each hold a copy of the same git repository.  (For
> instance, Jenkins may be running tests on our repo at several
> different commits at the same time.)  When Jenkins decides to run a
> test -- I'm simplifying a bit -- it will pick one of the copies of the
> repo, do a 'git fetch origin && git checkout <some commit>' and the
> run the tests.

You might find 'git new-workdir' from contrib/workdir to be helpful.
It lets you attach multiple working copies to a single set of objects
and refs.

There's a patch series to move that functionality into core git
through an option "git checkout --to=<directory>" that creates a
new workdir for an existing repository that is currently in the
pu ("proposed updates") branch.

[...]
> An added complication is submodules.  We have a submodule that is as
> big and slow to fetch as our main repository.
>
> Question 4) Is there a practical way to set up submodules so they can
> use the same object-sharing framework that the main repo does?

It's possible to do, but we haven't written a nice UI for it yet.
(In other words, you can do this by cloning with --no-recurse-submodules
and manually creating the submodule workdir in the appropriate place.
Later calls to "git submodule update" will do the right thing.)

Thanks for a useful example,
Jonathan
