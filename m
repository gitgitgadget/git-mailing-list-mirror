From: Jonathan Nieder <jrnieder@gmail.com>
Subject: mg/rev-parse-option-sifter-deprecation
Date: Thu, 3 Jun 2010 13:25:13 -0500
Message-ID: <20100603182513.GA25093@progeny.tock>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <4C076A6C.601@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 03 20:25:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKF6D-0005Ly-H9
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 20:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab0FCSY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 14:24:56 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:52193 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303Ab0FCSYz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 14:24:55 -0400
Received: by ywh6 with SMTP id 6so438169ywh.16
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vv6C8HmNI74aK0zu6JkwMAV5r/s7wSs+ibP/9+1xWOo=;
        b=koJNbCH9wNXyLzKjEOvFoyWZ+itGQqHczrbsw+X9sPRdf9DQxLk2XSzBGLqV4ZS/U9
         rOUBTNbKRDzW/r3JObQbsC4yEQaYm6ctNyXvSWQfZksRBVkKl/CTb0ojL0eONT+plg4d
         ljqsau0Jj4OiOB0MHj2vMcVWncSc/SOThYVnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J4TslhcXmZVpvDMuDSmu3RBfG/8ttRW7KivXFInJHTpML1/IMtE4XcCHUfyaILqQuZ
         0+CJe6nW62C+Gm/UIJYG8f2YEULxqk9xtYO3SccWzL5mJzVcNm2Dl5MWrG/dxvLWl7LK
         cHiDp1M3/IuhGPBoOATluaHZIzRegLzYpqVnE=
Received: by 10.42.8.72 with SMTP id h8mr1114184ich.17.1275589494674;
        Thu, 03 Jun 2010 11:24:54 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm1239662ibi.8.2010.06.03.11.24.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 11:24:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C076A6C.601@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148351>

Hi,

Michael J Gruber wrote:
> Junio C Hamano venit, vidit, dixit 03.06.2010 01:36:

>> Some people might interpret "Deprecate" too strongly; the intent is that
>> we shouldn't keep piling parsing of new rev-list options to it and
>> discourage the use of "option sifter" in new programs.
>
> So, s/deprecated/discouraged/? Is there an alternative we should suggest
> there for scripts needing to sift their options?

Ah, I was wondering about this, too.

Most git tools use parseopt now, whether they are written in sh or C.
When I first read this deprecation, I thought, "Wait --- so rev-parse
--parseopt is going away?"  So it might make sense to mention
rev-parse --parseopt separately in the description section.

As for --revs-only and --no-revs, the problem aiui is that we have no
in-tree users for them except git filter-branch.  Worse still, they
share no code with setup_revisions().  Would it be sensible to change
this?

 - teach setup_revisions() to use an option sifter instead of parsing
   options in one pass (probably a bad idea), or

 - give setup_revisions a second identity as an option sifter, or

 - teach filter-branch to do its own sifting of filespec arguments
   from revision arguments, and let rev-parse --revs-only rot

Unfortunately, any one of these changes would take time; so to be
realistic, regardless of what else happens, the deprecation notice
seems like the right thing to do.

| You can use linkgit:git-rev-list[1] directly or
| +linkgit:git-for-each-ref[1] for scripting.

I do not understand the reference to for-each-ref here.

Thanks,
Jonathan
