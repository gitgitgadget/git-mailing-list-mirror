From: Gordon McGregor <gordon.mcgregor@nitero.com>
Subject: inconsistent include behaviour for core.sharedRepository
Date: Thu, 30 Jan 2014 12:52:38 -0600
Message-ID: <CABJvL7duzsqH=3DLR6uhD05x2RmVJ=K53Up30K3sHOYzSfaLfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 30 19:53:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8wjY-000548-02
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 19:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbaA3Sw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 13:52:59 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:53277 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaA3Sw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 13:52:59 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so5472875qcy.26
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 10:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=jAbFgxTshFZZ5Hb5BG2RPBzvzGQBiegb7uHVikG4DLk=;
        b=BUddSydIdcm9tpPw2HiN3Z/Xgh8bpAyl2C+QWgD3zjYC2RK5uoNkVw7cM3E1v/QaEe
         aMlGDeMVNFQQMlcWcz2l3pBWddzgzf9FQOVYsMb1mRtSOWXAUPtrczrhkC1oOJFAkHub
         y8ebfeZHwP0Y+9l/rqQ4rZa33TA6v6gDr6Rp/1gxHDTv+0qiIKvRkS0wD/KknLpvcipS
         cHPfGe9Px7AN849unf0/msbjthieKMpEM3WRTaamAMHugpqGtGxaZ73TbzENQ2zODJ5E
         HZcc4lqHvqz3vZoPj10KuIpVX/o2HnjNiajte7PQjCZLlTyOA6Fydg/I55LE694ADsUF
         uUKg==
X-Gm-Message-State: ALoCoQlv4EuWgA/+SRyhw7KGHauTT/HBjM+zuKtaRD0+c4UPTbnWGa++MKT/H0kGkR/tXY0a25q0
X-Received: by 10.140.105.35 with SMTP id b32mr23615601qgf.36.1391107978507;
 Thu, 30 Jan 2014 10:52:58 -0800 (PST)
Received: by 10.96.87.34 with HTTP; Thu, 30 Jan 2014 10:52:38 -0800 (PST)
X-Originating-IP: [24.173.27.250]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241277>

After several days of problems with directory permissions in the
objects/ directory for shared users, I finally found the cause of an
issue that we have been seeing.

We are working with several shared repositories. We were trying to use
a shared [include] configuration that contained

[core]
sharedRepository = group

This was not being honoured, from an included config file.

Using git config, would show that core.sharedRepository was set to
'group', as expected.

However, digging through setup.c I see that shared_repository is
actually configured using git_config_early(), which does not use the
include mechanism that git_config()/ git_config_with_options() uses.

This is particularly difficult to debug given the git-config reports
values that are not actually used internally.

I think that git config should report the correct values, for features
that are accessed via git_config_early. Otherwise it is quite
difficult to understand the behaviour, without the source code.



git version 1.8.2.1 on CentOS release 5.6 (Final)


-- 
Gordon McGregor
+1 512 577 9712
