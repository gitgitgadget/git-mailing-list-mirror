From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] send-email: lazily assign editor variable
Date: Thu, 25 Mar 2010 00:17:43 -0500
Message-ID: <20100325051743.GB5784@progeny.tock>
References: <20100322145947.GA1709@pengutronix.de>
 <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net>
 <7vaatxobef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 06:19:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NufTE-00061C-0o
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 06:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab0CYFRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 01:17:50 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:64264 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab0CYFRq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 01:17:46 -0400
Received: by ywh2 with SMTP id 2so3219077ywh.33
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 22:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HdMICKkfu4F2AZODYd1oIUpD1l6thBNqVullblb4l8Y=;
        b=uG6Pd/20X7q/UqpPKH3k37s2DrxgW1oci75MJG/MwyPgc/KzNfiObMlulXCG3Rn8V0
         wd/gDbBv54AuwzNkdjtJIY2sRRbl4Hr1v6xNILV+lTXsE9P5YrevF07Ff14yGhi/A9ef
         EfsNDFiY/dR9acSSSln1msqPtYqTHa7rycaL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nWPL6+6xcrJ7PURaxtXhTwV56EkDwShaRbYvuHmUXd2yuExRZOBnbyl4ZVTfGDMklh
         johholbgA1MexWX49Xm1zIiHoG9Sd1kPmUZxc+9Q90177Gc+bA06TeIWldNs5o1CWosJ
         9rBKMhTSOHU5DFQ8Km0z+cYq8v2DWvl05qYoM=
Received: by 10.90.13.27 with SMTP id 27mr5066627agm.28.1269494266073;
        Wed, 24 Mar 2010 22:17:46 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm661692iwn.12.2010.03.24.22.17.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 22:17:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaatxobef.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143160>

Junio C Hamano wrote:

> We would want to describe what kind of problems they are better than "may
> lead to problems", though.  Something like this?
> 
>     b4479f0 (add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR",
>     2009-10-30) introduced the use of "git var GIT_EDITOR" to obtain the
>     preferred editor program, instead of reading environment variables
>     themselves.
> 
>     However, "git var GIT_EDITOR" run without a tty (think "cron job") would
>     give a fatal error "Terminal is dumb, but EDITOR unset".  This is not a
>     problem for add-i, svn, p4 and callers of git_editor() defined in
>     git-sh-setup, as all of these call it just before launching the editor.
>     At that point, we know the caller wants to edit, and they cannot without a
>     tty.
> 
>     But send-email ran this near the beginning of the program, even if it is
>     not going to use any editor (e.g. run without --compose).  Fix this by
>     calling the command only when we edit a file.

Yes, please.  It would be more precise to

  s/without a tty/with TERM=dumb/

in the second paragraph but regardless this is a good description of the
problem.
