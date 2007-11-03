From: Jakub Narebski <jnareb@gmail.com>
Subject: StGIT fails to clean patch series, and to go to a patch
Date: Sat, 3 Nov 2007 10:45:20 +0100
Message-ID: <200711031045.21506.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 10:45:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoFZa-0001HV-TR
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 10:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbXKCJpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 05:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbXKCJpc
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 05:45:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:27070 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbXKCJpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 05:45:30 -0400
Received: by nf-out-0910.google.com with SMTP id g13so997048nfb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=rPq2VJSPhV/ukOJTmvlt1CyTl6zxKD0XGZc6XrQ7wwY=;
        b=kZXy5LJSMbV7HtBXDe+HuL7AAXLdbiQNBWx6fou3inLXzC2AnvctNs8WS4HX5+WnYgK/EV3NW9BN0eZPCHAC0UgJZHiOGoM4r+TzFt2WPcBI+QliHr56Pp5K5zVi8YewPrBh+qYTt+vX/eOqzUXMpZOpHzGsNrUpRI9f7xH4U64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CHVHqLar5QH6ArxUJGBh927j2JXunboqCeJ77HxO2tQEw6tQWjNMK1BrtTCvKzHlpENlP8su5Oi1pEV0j6cSsbyimUXGRFECHrFlYdnP0dPUuEvmfi0dgdrct03GXJROcwY94s1nLWO3Cad1m3LB22W/6a6adJhYHjrA5HGj710=
Received: by 10.78.188.10 with SMTP id l10mr1893417huf.1194083129147;
        Sat, 03 Nov 2007 02:45:29 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.198.10])
        by mx.google.com with ESMTPS id g17sm3992906nfd.2007.11.03.02.45.27
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Nov 2007 02:45:28 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63223>

I have patch series with empty patch in the middle of the stack.
After trying to stg-clean (and failing) stack looks like below:

1167:[gitweb/web!git]$ stg series -e -s
+ gitweb-Always-set-from_file-to_file
+ gitweb-Add-status_str-diffinfo
+ gitweb-Easier-adding-parameters-to-current-URL
+ gitweb-Use-replay-to-generate-pagination
> gitweb-Use-replay-to-generate-alt-views
0 gitweb-Update-INSTALL-file
- gitweb-No-CGI_Carp-in-test
- gitweb-Test-config-override
- gitweb-Config-reader
- gitweb-Use-config-more

Now stg-rebase works, but stg-goto doesn't work. It returns
the following error.

1164:[gitweb/web!git]$ stg goto gitweb-Use-config-more 
Checking for changes in the working directory ... done
Traceback (most recent call last):
  File "/usr/bin/stg", line 43, in ?
    main()
  File "/usr/lib/python2.4/site-packages/stgit/main.py", line 284, in main
    command.func(parser, options, args)
  File "/usr/lib/python2.4/site-packages/stgit/commands/goto.py", line 63, in func
    push_patches(patches)
  File "/usr/lib/python2.4/site-packages/stgit/commands/common.py", line 165, in push_patches
    forwarded = crt_series.forward_patches(patches)
  File "/usr/lib/python2.4/site-packages/stgit/stack.py", line 954, in forward_patches
    bottom_tree = git.get_commit(bottom).get_tree()
  File "/usr/lib/python2.4/site-packages/stgit/git.py", line 136, in get_commit
    commit = Commit(id_hash)
  File "/usr/lib/python2.4/site-packages/stgit/git.py", line 77, in __init__
    lines = _output_lines(['git-cat-file', 'commit', id_hash])
  File "/usr/lib/python2.4/site-packages/stgit/git.py", line 196, in _output_lines
    raise GitException, '%s failed (%s)' % (' '.join(cmd),
TypeError: sequence item 2: expected string, NoneType found
1165:[gitweb/web!git]$ stg version
Stacked GIT 0.13
git version 1.5.3.5
Python version 2.4.3 (#1, Jun 13 2006, 16:41:18) 
[GCC 4.0.2 20051125 (Red Hat 4.0.2-8)]
-- 
Jakub Narebski
Poland
