From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 10:45:47 +0200
Message-ID: <48C7893B.6050001@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 10 10:47:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdLLr-00056F-Jq
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 10:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbYIJIpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 04:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbYIJIpw
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 04:45:52 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:48467 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbYIJIpv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 04:45:51 -0400
Received: by gxk9 with SMTP id 9so13032582gxk.13
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=1ogtlv6I+McPXYr6LusP5GujVVo9GxFBOipGtcrFm9U=;
        b=xGefDceMDF1t8jOnRw5nvrbqDvbKr6erQWZ8ZtM55Z6EVVwKeatcQxucqTKGvUUBBw
         YYBBZubcS7EWDMg33ldXB+LNChdb3GwmV7r0Jv8sY2pfzCu7vFyQL9teF2uqj3AUMAHE
         H8F9QJg7Gf6Ugz4BqniC2hoOsnfvR0MrBL4F0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=LuDynLsVm7MuXfl0DotkMxE61Mskt8ezfu7TgGjNufuK6zVeEGfLct0sCu8R/KCi15
         8HJv++HMe+ybYRM9xVKZUXfh4AK2le7SVwcF9nWE516i60ZXDVOhQJtNjQva1M6F6vxU
         n551LdUdrCw98ZRBXMGDHKjSMTmwBO4Yi6PZc=
Received: by 10.86.79.19 with SMTP id c19mr734842fgb.5.1221036349817;
        Wed, 10 Sep 2008 01:45:49 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id d4sm8165441fga.5.2008.09.10.01.45.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 01:45:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080909211355.GB10544@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95498>


> Having history browsers draw fancy lines is fine but I see nothing wrong
> with them extracting this from the free-form part of the commit message.
> For informative purposes, we don't shy away from heuristics anyway, c.f.
> our renames detection (heck, we are even brave enough to use that for
> merges).

... and it works only because false positives (which make the merge
actively wrong) are extremely rare.  If there is the occasional false
negative, well, it just makes merges more complicated and screws up
visualization a bit, so you live with it.

Move/copy detection almost always worked for me, but there are two cases
where it didn't:

1) empty files.  Each of them is marked as copied from a
seemingly-picked-at-random one.

2) renaming a Gtk+ class.  You rename it (e.g. from gtkclassnamea.c to
gtkclassnameb.c) and at the same time do

  s/GtkClassNameA/GtkClassNameB/
  s/GTK_CLASS_NAME_A(?:\>|?=_)/GTK_CLASS_NAME_B/
  s/gtk_class_name_a(?:\>|?=_)/gtk_class_name_b/

and reindent everything.  Guaranteed to have a similarity index around
30-40%, not more.

I don't care much about it, but face it, it is *not* perfect.

Paolo
