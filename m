From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 02:31:02 -0500
Message-ID: <20101018073102.GA3979@burratino>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
 <20101018051702.GD22376@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Bash <bash@genarts.com>, Matt Stump <mstump@goatyak.com>,
	git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 09:35:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7kFN-0007z5-0p
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 09:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab0JRHeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 03:34:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42815 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab0JRHen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 03:34:43 -0400
Received: by yxm8 with SMTP id 8so199611yxm.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sGR/hKlYZ9g7bkJRyA31yQb0Orncz/9MzjY2+uhAQDo=;
        b=tvVz8oEa6pu1jnnxQY/DxaDnVa3aNsaDeITwN99G8RlMF4+dw61f/oJR/7tLQHMc9K
         EtLKeTcoRi/OBxH2M8ldSU2zcsYSwJjZ3ULLg04JUGbHLXGJql58vArwd59w6LZiS/At
         +tTxefksSreH2HwKKG/xTxRcrh9aWfnohGpp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K+byUOCmW730CKhlSiSsbP7s9SS+mryIRoPtLFQ3EPmjw8mGNBVE9jTg8MH17Kh7aJ
         sWAHEv6UglIrWboiAaBfbiZmnjrTmWgMw0ksmO2ZuPeTKDbWZlaZr/52Tci7hy6eKvQs
         VpMKk2BRlIwCyM1mYWKoefJjbhKt4nJB3XMgI=
Received: by 10.151.92.9 with SMTP id u9mr6017310ybl.319.1287387283065;
        Mon, 18 Oct 2010 00:34:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m46sm8007542yha.44.2010.10.18.00.34.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 00:34:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018051702.GD22376@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159235>

Ramkumar Ramachandra wrote:

> Also, since we're aiming for a two-way mapping, it's going to be
> significantly more challenging: we will need a mapping function that
> can be inverted perfectly.

Sounds interesting!  Let's see how much I can narrow scope/dash hopes.
:)

First of dreams is the possibility of using git as a replacement for
svnsync, to get semantically identical SVN repositories like so:

[...]
> SVN repository 1 -> dumpfile -> Git repository
> Git repository -> dumpfile' -> SVN repository 2

in a way that svn tools can look at repo 2 as a basically perfect
replacement for repo 1.  This means copying svnsync properties,
rename tracking info, svn properties, etc.

I. Some people might want that, and I wouldn't want to stop them
   trying (maybe using notes, perhaps even the mythical tree-based
   form) but I'm not interested in it at all.  Is it a goal for you?

Second would be the possibility of using an SVN repository as a
conduit for communication between git repositories:

Git repository 1 -> fast-export stream -> SVN repository
SVN repository -> dumpfile -> Git repository 2

II. It would be super cool to be able to transport arbitrary git
    objects via svn (maybe using custom properties and fabricated
    temporary branches named after the first commit after a fork
    point).  Perhaps some people could host git projects on Google
    Code this way.  Is that a goal?

Git 1 -> SVN 1 -> Git 2 -> SVN 2 -> Git 3

III. Perhaps only the subset of git objects with certain properties
     should be considered safe to transport via an SVN repository
     (e.g.:

      - author matches committer
      - timestamps are New York time
      - author address is of the format username <username>
      - filenames are valid UTF-8

     ).  And maybe any existing git repository can be painlessly
     transformed to consist only of such commits.  Is that a model
     to strive for?

SVN 1 -> Git 1 -> SVN 2 -> Git 2 -> SVN 3

IV. Maybe only some svn changes would be considered safe to
    transport via git: no weird properties, no tracked renames
    not involved in branches/merges, all branches named after the
    git commit id of the first rev after the fork point, ...
    And maybe any existing svn repository can be painlessly
    transformed to consist only of such revisions.  Is that a goal?

(As you might have guessed, my answers are "no, no, no, and no, at
least at first, but it is fun to imagine how a person would go about
achieving these things anyway").

Hope that clarifies something,
Jonathan
