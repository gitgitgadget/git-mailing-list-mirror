From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] git-svn: allow git-svn fetching to work using serf
Date: Sat, 6 Jul 2013 19:23:32 -0700
Message-ID: <20130707022332.GD4193@google.com>
References: <ABDE5FFA-C19F-44BF-A360-3FD5D74F2B28@gmail.com>
 <20130707002430.GE30132@google.com>
 <8CACBE8F-8672-43AB-882E-4ADA05B4D822@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Rothenberger <daveroth@acm.org>,
	Petr Baudis <pasky@ucw.cz>,
	Daniel Shahaf <danielsh@apache.org>,
	Eric Wong <normalperson@yhbt.net>
To: Kyle McKay <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 04:23:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvedl-0004ss-GK
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 04:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab3GGCXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 22:23:36 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:65183 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3GGCXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 22:23:36 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so2987375pdj.36
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 19:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0ClBHdR/qY5hu+BTP55T50Ak6cn8UVVU7h1QWzJBqNI=;
        b=0p1gz1B+5XXWGBPTHO4b5ZqCOIAhQx05NlvWEaNpIAojhOmcEXgk2R1o1XA0ycVKr6
         D+7g5rzbdKRkzLP5cPGES/QnqgfOzwR1GKoIaeUaWAu1FrwU/oXxT1qIdEe3t3MohVEq
         8QF04IrELyKUMMgatM4nRZIR07zLaOLI5QFRU4mdpD2qwTvbNu1N9A1nZwLKsiAYI4qN
         KmaJNpY15t8VzjyH7DyREUZVPu/uteBvUCS+b8uuA73oa4ur2xxsfw7bhV5QCjEQ0Iwe
         n0bFTQklo88yyBDMyDqCe626iIjux0BnA1od+zjb5YDLztBQS0Ajzq6K5csznrmboaFp
         k3Ug==
X-Received: by 10.66.162.102 with SMTP id xz6mr17571953pab.0.1373163815525;
        Sat, 06 Jul 2013 19:23:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vb8sm14759116pbc.11.2013.07.06.19.23.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 19:23:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8CACBE8F-8672-43AB-882E-4ADA05B4D822@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229717>

Kyle McKay wrote:

> Unless bulk updates are disabled when using the serf access method
> (the only one available with svn 1.8) for https?: urls,
> apply_textdelta does indeed get called multiple times in a row
> without an intervening temp_release.

You mean "Unless bulk updates are enabled" and "without an intervening
close_file", right?

Unlike the non-depth-first thing, that sounds basically broken ---
what would be stopping subversion from calling the editor's close
method when done with each file?  I can't see much reason unless it is
calling apply_textdelta multiple times in parallel --- is it doing
that, and if so is git-svn able to cope with that?

This sounds like something that should be fixed in ra_serf.

But if the number of overlapping open text nodes is bounded by a low
number, the workaround of using multiple temp files sounds ok as a way
of dealing with unfixed versions of Subversion.

Jonathan
