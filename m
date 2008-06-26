From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git rebase interactive: usability issue
Date: Thu, 26 Jun 2008 15:35:50 +0400
Message-ID: <20080626113549.GF5737@dpotapov.dyndns.org>
References: <20080625233208.GE5737@dpotapov.dyndns.org> <alpine.DEB.1.00.0806260416410.4503@eeepc-johanness> <7vbq1ovpl7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 13:36:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBpmV-0004oT-Q3
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078AbYFZLf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 07:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755017AbYFZLf4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:35:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:44495 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbYFZLfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:35:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1547599fgg.17
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XFxWOaUxqnkEyEI0VpFlNzSVpgvVF/9s9R8S4z4eZGQ=;
        b=LwHzYoGnGsC1la1P5lubO7LWd8yMp8I4z4Xy0YrEI8vwuEOgPl9fcpCUzgdgQA4WZR
         TnGW42RybG1udO+z1HoHTKhda98kzMsjnBH6xwmaaYM3RX63GPyACtSFAfqM0PDbg9Aw
         hO0RShTO2rzj0M74HByO3i9ee791gApKS/zAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fyPYEyHv1a6wIOPCN7TWDehrvvMscgaMtzeg6fkNczn+CLPo3bqnbSGGPgjVD2ka48
         61/6blPgw0AiM4wIxv5Rz5PZ7iW2NY+r+WSnHNXzWn49dxnbUQS4IuJiV0XLX4rzLKZJ
         c0yagpDjsyFR3s7T1Nk8UESzIstsvfQtnVXa4=
Received: by 10.86.33.19 with SMTP id g19mr12148051fgg.4.1214480153822;
        Thu, 26 Jun 2008 04:35:53 -0700 (PDT)
Received: from localhost ( [85.141.151.43])
        by mx.google.com with ESMTPS id 4sm15545169fge.5.2008.06.26.04.35.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Jun 2008 04:35:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbq1ovpl7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86435>

Hi Junio,

Please, do not apply my previous patch. I just realized that it will
break the following sequence of commands when you are stopped on a
conflicting commit during rebase:

$ edit file
$ git add file
$ git commit
$ git commit --amend

I don't see a good solution right now. Perhaps, the better approach
will be to remove the suggestion of using "git commit --amend" and
instead to recommend to use "git add" to add your changes and then
run "git rebase --continue". This works regardless whether you stop
on the "edit" mark or conflict. The only problem with that is what
if the user actually wanted to edit the commit message. Currently,
saying just "git rebase --continue" without adding anything will
not allow you to edit the commit message.

After studying git-rebase script, I noticed that it always commit
with the --no-verify option. It makes sense for those commits that
were just "pick" but IMHO those commits that were edited by users
probably should be commited in the normal way, so the pre-commit
hook can ensure that your changes are okay.


Dmitry
