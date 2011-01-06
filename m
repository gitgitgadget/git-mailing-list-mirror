From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] t9010: svnadmin can fail even if available
Date: Thu, 06 Jan 2011 13:32:25 -0500
Message-ID: <4D260AB9.2060406@gmail.com>
References: <4D25E818.5050909@gmail.com> <20110106165958.GA11190@burratino> <4D25F9C5.6030503@gmail.com> <20110106180051.GC11346@burratino>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 19:33:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paudt-0001ib-Pt
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 19:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab1AFScx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 13:32:53 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:35871 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab1AFScw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 13:32:52 -0500
Received: by qyk12 with SMTP id 12so18853294qyk.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 10:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BDSCTNankF0gqYIVVpRhe/P5qad9b/6GjrI708ISoYM=;
        b=X8ERFHdtIBOUv1g++LGVI6a44T+VomsqeFMF3pzFfspVRIT8MWQn9Nz3eEhN97MVrH
         FXw8bFhLx/kUZ+y/ozRfRfsXPOU/hSPUraMdKhr+vBgbjhcS7akax6Lql/6ASKvbBhDE
         GrnA3SzuH5I8KrLo0647f0/7gxWXLE9/lwU6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=yB+KG6wAUOi5iEnbkxEzqOoOfGra52ge1QNmrH07bS98NvmtV04q5HiQuuDB9wbT9t
         YzrHI9Y/Gh4mm4ylgw8oMaHmwp8Ketkv7FLV06SFUNFg7aNU9qerkEI3B1h5DE/TE1cJ
         o6tPy6qJ/nZcbFVoAcwE/WrYtPjKtoL9Q0GgU=
Received: by 10.224.38.26 with SMTP id z26mr22852596qad.375.1294338771560;
        Thu, 06 Jan 2011 10:32:51 -0800 (PST)
Received: from [10.0.1.130] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id p13sm14534285qcu.17.2011.01.06.10.32.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 10:32:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
In-Reply-To: <20110106180051.GC11346@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164653>

On 01/06/2011 01:00 PM, Jonathan Nieder wrote:
> If svn is built against one version of SQLite and run against
> another, svnadmin (needlessly) errors out during t9010:
>
>   <<<  Started new transaction, based on original revision 1
>        * adding path : branches ... done.
>        * adding path : trunk ... done.
>   svnadmin: Couldn't perform atomic initialization
>   svnadmin: Couldn't perform atomic initialization
>   svnadmin: SQLite compiled for 3.7.4, but running with 3.7.3
>
> Work around this by putting the svn invocations into a single test
> that builds a repo to compare the test-svn-fe result against.  This
> test would always pass but only set the new SVNREPO test prereq if svn
> succeeds; and the test using that repo gets an SVNREPO prerequisite so
> it only runs with working svn installations.
>
> This seems like the right thing to, anyway: the test script is meant
> to test the version of git just built, not the installed svn.
>
> As a side effect, earlier tests will run now even if svn is not
> installed.  Remove the svn_cmd () helper to decrease the temptation to
> run svn from those tests.
>
> Works-around: http://bugs.debian.org/608925
> Reported-by: A Large Angry SCM<gitzilla@gmail.com>
> Signed-off-by: Jonathan Nieder<jrnieder@gmail.com>
> ---
> Thanks.  Does this patch work for you?

$ sh t9010-svn-fe.sh
ok 1 - empty dump
ok 2 - v3 dumps not supported
ok 3 - set up svn repo
ok 4 # skip t9135/svn.dump (missing SVNREPO)
# passed all 4 test(s)
1..4

Rerunning the full test suite now ...
