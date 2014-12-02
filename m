From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: http-protocol question
Date: Mon, 1 Dec 2014 21:17:55 -0800
Message-ID: <20141202051755.GA6527@google.com>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
 <20141202033416.GY6527@google.com>
 <CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
 <20141202044522.GZ6527@google.com>
 <CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 06:18:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvfqv-00013q-BL
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 06:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbaLBFR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 00:17:58 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:48702 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbaLBFR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 00:17:58 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so14387744igb.7
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 21:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qXp00U0HPBqGniZ3gqx+Jrupzpseo7VxuCA80S9ecCg=;
        b=dZqm/KVYR0V7ITVPFOW7SMUlrfiZRunAfWdmD/SU27U19vStgk6v6oWjSpSs9aSOO2
         1qo1r+gtAZO5sd4H0falI51JwU52Lj+T59QEuj4LIj9yQ2YJ6CeoWUkwezPWgNyDxl3m
         HBsxvGlphnZPoEH8iRSGkBUZhilreURGNigu/mmo3ZAharqPEtit8x9Qqk2fqWYCDnsf
         fIwpsXX3w/e5UI0eZbZK8Ug9nbKap7u5lvSjn/GfXU3F9lkllEZM+BXq+vslAi714eky
         nO3BvjLGBpAECvRqOViT8StWU5pEYXWlkk0Ko+ApqruOugmQjPQsEjFvSPsgHx2vdGkO
         JAuw==
X-Received: by 10.50.50.165 with SMTP id d5mr50354165igo.16.1417497477603;
        Mon, 01 Dec 2014 21:17:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:adae:4a7e:fb33:5785])
        by mx.google.com with ESMTPSA id w6sm16443358igp.15.2014.12.01.21.17.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 21:17:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260534>

Bryan Turner wrote:

> I ask because it's actually happening. Heavy CI load sometimes has
> builds fail because git clone dies with "not our ref". That's the
> specific context I'm working to try and address right now.

Thanks --- that makes sense.

>                                                            Some teams
> use rebase-heavy workflows, which also evades the check_non_tip easing
> and fails with "not our ref", so I can't be 100% certain it's ref
> deletion in specific causing it (but I guess which of those it is is
> probably largely academic; as long as hosting spans multiple requests
> it seems like this type of race condition is unavoidable).

Yeah, everything mentioned before about ref deletion also applies to
non-fast-forward updates.

> I'm trying to decide if there is something I can enable or tune to
> prevent it, and the type of twilighting hinted at by the http-protocol
> documentation seemed like it could be just the thing.

If you control the side that clones, then just cloning the single branch
you are building (with --single-branch and -b) can help.

Using a bidirectional protocol like git:// or ssh:// (where the ref
advertisement and check of wants happen in the same connection) would
avoid the problem we're talking about.

On the server side, I agree that either mining reflogs or storing
advertisements to disk would be a nice way to take care of this.
No one has implemented either of those, but it would be a nice setting
to have. :)

Thanks,
Jonathan
