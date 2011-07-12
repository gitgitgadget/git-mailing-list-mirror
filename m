From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/14] revert: Introduce struct to keep command-line
 options
Date: Tue, 12 Jul 2011 01:33:35 -0500
Message-ID: <20110712063335.GA10742@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-8-git-send-email-artagnon@gmail.com>
 <7vzkkrjec2.fsf@alter.siamese.dyndns.org>
 <CALkWK0mxXwvurJzDOYOdXS33cb563WnKmG1_cue6F4pgqOU_WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:33:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWXY-0003Ko-0C
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab1GLGds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 02:33:48 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41982 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab1GLGdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 02:33:47 -0400
Received: by ywe9 with SMTP id 9so1811148ywe.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 23:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GL44UIO7yln4mhL5mF7Z6AHe/2SUhvU10MYmaJc2b54=;
        b=VfDG8JFsYvWJ98ig/XuLi3Budn/cM0HXJgCIl3o5OxPVNkLhVxw1keAvaqluBHwR8f
         YRpAkOct8kb0iBKee/TOHHH/pB/f5pw2lnZCsVIfgBQTSiveJj7KYcIMFFEX0QJgy2pG
         NO0YDHcGQAZM7Fuqa3jxDKU8rjR/wy0dMhxDQ=
Received: by 10.236.193.73 with SMTP id j49mr5798378yhn.332.1310452426589;
        Mon, 11 Jul 2011 23:33:46 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id f4sm6831066yhn.27.2011.07.11.23.33.44
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 23:33:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mxXwvurJzDOYOdXS33cb563WnKmG1_cue6F4pgqOU_WQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176930>

Ramkumar Ramachandra wrote:

> Since I'm not sure the function you propose will make it to
> sequencer.c, I don't want to introduce it now.

Wouldn't it be easy to remove such a function later?

Practically speaking, it is not obvious to me that making any of these
variables non-static is needed for "cherry-pick --continue" to work,
but given that most of the state is being made non-static anyway,
readers will be likely to wonder why "me" is left behind.  So the
obvious choices would be to

 a. make "me" a member of the replay_opts struct; or
 b. compute "me" in each function that needs it by calling a helper
    function; or
 c. add some explanation to the commit message to clarify the status
    of "me" as static-but-won't-be-in-the-long-term and a reason for
    that

based on the needs of the current code.  (b) sounds simplest to me,
though I haven't tried it.
