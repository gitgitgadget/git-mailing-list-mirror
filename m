From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 16:09:01 -0500
Message-ID: <20120710210901.GI8439@burratino>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
 <20120710191354.GE8439@burratino>
 <7v1ukjiehe.fsf@alter.siamese.dyndns.org>
 <20120710201105.GH8439@burratino>
 <7vsjczgx3h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 23:09:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SohgI-0007o6-90
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 23:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861Ab2GJVJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 17:09:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60422 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab2GJVJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 17:09:07 -0400
Received: by yhmm54 with SMTP id m54so520948yhm.19
        for <git@vger.kernel.org>; Tue, 10 Jul 2012 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FQHGciCgmk8XnOadiAX4SY3lplJ9CxQbbC+RnLoG2EU=;
        b=GNTtkFOR09Xd23fBLu7fjqj7kl8J9E4PXpC4OPeeQgMprc1fXRo6VvP8OUKIQ8g0Ph
         zP5A+Nu9mG1j/IdQUkX3s2ogAE+yWLulURR2nwGG+iE9LKp1A5H30qDYnMVqasdkkT3h
         piAMeQju8lkB0zilvLXKJhOFO3ZrVitl9pVhJ8MsKhgqGewiEkCgQo0sLKaQAok14oqo
         xD2RdCnz9R4YVO96Q7xiSrRfs4O80EJIUEGMhy9EtcU3GWizWn8kQdeuErDEfU8GOGkC
         Q4q559ZxfMgyKyTAVOwF5xN39aSEwNMPbVYbSdKtaWJv2XWaQuLh5hXiHVKXbtI2+IQb
         76Iw==
Received: by 10.50.135.74 with SMTP id pq10mr12449849igb.48.1341954546532;
        Tue, 10 Jul 2012 14:09:06 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ai6sm27249495igc.0.2012.07.10.14.09.05
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jul 2012 14:09:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjczgx3h.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201280>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The immediate problem that seems to trip people up is that it is very
>> tempting to run
>>
>> 	git branch --set-upstream junio/master
>
> I think we have discussed this already a few days ago.  See my
> comment in the earlier thread before this round.

You wrote[*]:

| I think it was a mistake that nobody noticed that it is likely that
| the operation most often will be done for the current branch and the
| usual "give me one branch name to operate on, or I'll operate on the
| current branch" command line convention of "git branch" commannd is
| not a good fit for it, when "set upstream" feature was added

with which I completely agree.  You then moved on to

|                                                               and
[someone should have]
| suggested an alternative syntax that avoids the mistake you quoted
| above, perhaps something like:
|
| 	git branch --set-upstream-to=origin/master [HEAD]

with which I disagree.

As far as I can tell, nobody really thought very hard about what
--set-upstream would do when passed only one argument.  It should have
been made to error out and only later change if someone had an idea
about how to make it useful.

Luckily we have a way out.  Any example transition plan looks like
the following.

DAY 1.

	$ git branch --set-upstream origin/master
	Branch origin/master set up to track local branch debian-sid.
	hint: If you intended to make the current branch track
	hint: origin/master, you can recover with the following commands:
	hint:  $ git branch -d origin/master
	hint:  $ git branch --set-upstream master origin/master
	$

DAY 2.

	$ git branch --set-upstream origin/master
	Branch origin/master set up to track local branch debian-sid.
	warning: using --set-upstream when creating a new branch is deprecated
	hint: use --track instead
	hint:
	hint: If you intended to make the current branch track
	hint: origin/master, you can recover with the following commands:
	hint:  $ git branch -d origin/master
	hint:  $ git branch --set-upstream master origin/master
	$

DAY 3.

	$ git branch --set-upstream origin/master
	fatal: no such branch "origin/master"
	$

DAY 4.

	$ git branch --set-upstream origin/master
	usage: git branch --set-upstream <branchname> <upstream>
	$

[*] http://thread.gmane.org/gmane.comp.version-control.git/201040/focus=201051
