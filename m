From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUG] 'git show-ref <pattern>' doesn't work (shows nothing)
Date: Mon, 18 Oct 2010 12:03:37 +0200
Message-ID: <201010181203.38554.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 18 12:03:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7mZL-0007ry-HX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 12:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab0JRKDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 06:03:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63724 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab0JRKDp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 06:03:45 -0400
Received: by bwz15 with SMTP id 15so482160bwz.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=By2HrmMWlgtwDFNTdBi7ckUlsedQqhMNy2J2J5Bog5s=;
        b=xvVBv5laI+mLVBUVSXBnhyRY9rcZPCBTacYR+++D+40tZb/i4o4htN++6XL3UrIEFh
         c/mRVn310EvYW6aB4Eho/Ejge+PD5U8n5qK/nXNxsVH9l/BZcmBpu4Ox3bnJWUdoUpMq
         FVotbcH0F6Zve8QaeXbOhzohA1kv95wQgAeRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=xwH27RRXIJTyg2UjCbd/dWGnmsQSJ1KpoWUZH+w35/meQsou1hlSqhOV/iHtDdZs8C
         xPJdHl2Ahz8Oy18/W0yKH9JdUyEyAdssZCXCOBxzarqSFixVimx9Lo+RGTtDv0MFBFHN
         FwrJ+kUdHn8CDkoze6ukVkFmfner5tFhoGcZ8=
Received: by 10.204.142.92 with SMTP id p28mr4305321bku.2.1287396223149;
        Mon, 18 Oct 2010 03:03:43 -0700 (PDT)
Received: from [192.168.1.13] (abwp24.neoplus.adsl.tpnet.pl [83.8.239.24])
        by mx.google.com with ESMTPS id p34sm14566638bkf.15.2010.10.18.03.03.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 03:03:41 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159247>

In the git-show-ref documentation we read:

  git-show-ref - List references in a local repository

  SYNOPSIS
  --------
  [verse]
  'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
               [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
               [--heads] [--] [<pattern>...]
  'git show-ref' --exclude-existing[=<pattern>] < ref-list

  DESCRIPTION
  -----------

  Displays references available in a local repository along with the
  associated commit IDs. Results can be filtered using a pattern and
  tags can be dereferenced into object IDs. Additionally, it can be
  used to test whether a particular ref exists.

Let's overlook the fact that the using '--verify' is a separate way of 
operation, and should be given seperate line in synopsis.

What is more important is that filtering using pattern doesn't work.  
All of commands listed below produce empty output:

  $ git show-ref refs/heads
  $ git show-ref refs/heads/
  $ git show-ref 'refs/heads/*'
  $ git show-ref -- refs/heads
  $ git show-ref -- 'refs/heads/*'

Note that using '--heads' gives output:

  $ git show-ref --heads
  01cc740941a6b81fd7be03484c83f688dc79a5f2 refs/heads/Git.pm
  23b2a0387f0acd7e3cd906a0dc3c2c23dd32c03d refs/heads/autoconf
  [...]

but I am more interested in patterns like 'refs/heads/gitweb/', or 
'refs/remotes/origin/', or 'refs/tags/v*'.

For the time of being I'd have to use git-for-each-ref instead:

  $ git for-each-ref refs/heads/
  01cc740941a6b81fd7be03484c83f688dc79a5f2 commit refs/heads/Git.pm
  23b2a0387f0acd7e3cd906a0dc3c2c23dd32c03d commit refs/heads/autoconf

(though to get same output I'd have to use appropriate <format>).
-- 
Jakub Narebski
Poland
