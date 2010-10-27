From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG?] t9500 --debug prints "sh: ++GIT_BINDIR++/git: not found"
Date: Wed, 27 Oct 2010 14:21:53 -0700 (PDT)
Message-ID: <m3ocafib6z.fsf@localhost.localdomain>
References: <20101027204954.GA31386@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 23:22:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBDRb-0007RW-DH
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 23:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400Ab0J0VV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 17:21:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40937 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158Ab0J0VV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 17:21:56 -0400
Received: by fxm16 with SMTP id 16so1147537fxm.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=7h+VNtzEy6lTFUdlOnYMwnkNprE6QbDBWS9b09roDjs=;
        b=RNOU1r/7gGxN+upPBuaaSK7+d/f80CEhw4nOkZI/u/8cJ1tvqdfBQueSPGHCHGtxuR
         xCo7InqzTk4NJAnwQ8osRbEB9p3Xv7btCT9uNpkB+N25vHyFuRftmhuatYaPcxVGe2Wh
         2cBCEGWQcuNGKG1NHjHIItCIENRUMdYMT9So8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KOkKx1Jzg1BQtR8UhnMAlzH7OBLn9ZdXpHRdJeTjN2vrnjTjXYFJYmHd33C890ValZ
         ADLExmZZdryO1N2ReDH1MCKHV6ruGWCgTjjFvnbCLIYU9btgqLvIsHSZwOVagh/JE7cP
         tzngfF9iYpeF5CeLxIILPvvArSemTUAC4ppgo=
Received: by 10.223.79.68 with SMTP id o4mr2950814fak.0.1288214515505;
        Wed, 27 Oct 2010 14:21:55 -0700 (PDT)
Received: from localhost.localdomain (abvr250.neoplus.adsl.tpnet.pl [83.8.215.250])
        by mx.google.com with ESMTPS id n8sm150272faa.7.2010.10.27.14.21.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 14:21:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9RLLYjG031139;
	Wed, 27 Oct 2010 23:21:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9RLLOLw031130;
	Wed, 27 Oct 2010 23:21:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101027204954.GA31386@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160125>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Trying to run t9500-gitweb-standalone-no-errors.sh, I find:
> 
>  $ sh t9500-gitweb-standalone-no-errors.sh --debug
>  ok 1 - no commits: projects_list (implicit)
>  sh: ++GIT_BINDIR++/git: not found
>  ok 2 - no commits: projects_index
>  sh: ++GIT_BINDIR++/git: not found
>  ok 3 - no commits: .git summary (implicit)
>  [...]

> Ideas?  Is this expected behavior?

Fixed in 8ff76f4 (gitweb: Move call to evaluate_git_version after
evaluate_gitweb_config, 2010-09-26):

    gitweb: Move call to evaluate_git_version after evaluate_gitweb_config
    
    This means that call to evaluate_git_version() is now inside
    run_request(), which means that is called for each request instead of
    once per starting gitweb; this matter currently only when using
    FastCGI interface (gitweb.fcgi).
    
    This change was done becayse evaluate_git_version() uses $GIT
    variable, which can be set / modified by gitweb config file... and it
    is modified this way by gitweb config file used in gitweb tests.
    Without this change there is spurious extra output from t9500 test
    when tests are run with '--debug' option.

which is part of

* jn/gitweb-test (2010-09-26) 4 commits
 - gitweb/Makefile: Include gitweb/config.mak
 - gitweb/Makefile: Add 'test' and 'test-installed' targets
 - t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
 - gitweb: Move call to evaluate_git_version after evaluate_gitweb_config

-- 
Jakub Narebski
Poland
ShadeHawk on #git
