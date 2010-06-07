From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Create Gitweb::Git module
Date: Mon, 7 Jun 2010 17:25:46 +0200
Message-ID: <201006071725.51263.jnareb@gmail.com>
References: <1275859451-21787-1-git-send-email-pavan.sss1991@gmail.com> <20100607144852.GN20775@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jun 07 17:26:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLeDI-0008TC-KB
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 17:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab0FGPZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 11:25:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40685 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab0FGPZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 11:25:55 -0400
Received: by fxm8 with SMTP id 8so2181448fxm.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RCtDPhvrNB5aeAoCeyJ1D0vdlfUIyRDxgaqeNdQjyvk=;
        b=FcCKDrG/odBiJqEBioZERMEHYB0ta4Ot4YhRvW9r5c++j8rI+jAV/YALudf9ef4SQV
         9B4i9T7OrsCZvkD1AXqJaAKjwI+3LKVtfE/Wx/Rr6At0CA4H9yF2OWTvrDuhkFmXKpjo
         LNxGe3p7l5cT8aEr/xY3b7Xm96b/YfijUuv9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OcGi6AKdhfOf8mC8REgtnzFchcL5QcLFNRM33XlA4BUoV7wqdrAheoZNZ+b+5ScIQ0
         ZP66ljWiQJcfVpjcp/p6s4dBfYmoKSgitySZM9KGgCgtNhv5UDv2QW3gO+Yq/Rfk2LVX
         LTpI8qiY0gHdChPTNUYcIuanIhQukrgXQTnqQ=
Received: by 10.223.26.130 with SMTP id e2mr15268642fac.101.1275924353934;
        Mon, 07 Jun 2010 08:25:53 -0700 (PDT)
Received: from [192.168.1.15] (abwb99.neoplus.adsl.tpnet.pl [83.8.225.99])
        by mx.google.com with ESMTPS id j23sm20765652faa.2.2010.06.07.08.25.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 08:25:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100607144852.GN20775@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148607>

On Mon, Jun 07, 2010, Petr Baudis wrote:
> On Mon, Jun 07, 2010 at 02:54:11AM +0530, Pavan Kumar Sunkara wrote:

> > @@ -1548,21 +1536,6 @@ sub get_feed_info {
> >  ## ----------------------------------------------------------------------
> >  ## git utility subroutines, invoking git commands
> 
> Is there any reason why didn't you move the rest of the commands from
> this section to Gitweb::Git as well?

Probably because they are less clear about being about running (git)
commands, I guess?

Let's examine those subroutines in more detail:

* git_cmd - requires $GIT and $git_dir, also $number_of_git_cmds

* quote_command - helper command, not exactly about running comands,
  but about shell escaping / shell quoting.  Should it be in Gitweb::Git
  or in Gitweb::Escape?

* evaluate_git_version - requires $GIT, sets $number_of_git_cmds
  and $git_version.  Does it belong to Gitweb::Git, or Gitweb::Config,
  or perhaps Gitweb::Request?

* git_get_hash (and wrappers: git_get_head_hash, git_get_full_hash,
  git_get_short_hash) - requires $projectroot, something which other
  commands do not require, and $git_dir.  Uses git_cmd().

* git_get_type - uses git_cmd().

* git_get_hash_by_path - uses git_cmd()
* git_get_path_by_hash - uses git_cmd()

Subroutines related to parsing per-repository configuration should be
either in Gitweb::Config, or in a separate module, e.g. Gitweb::Git::Config
(or something like that, like Gitweb::RepoConfig, etc.).

Next there are 'git utility functions, directly accessing git repository'

-- 
Jakub Narebski
Poland
