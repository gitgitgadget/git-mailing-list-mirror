From: yac <yac@blesmrt.net>
Subject: Suspected bug on `git -C <rp> rev-list --all` where <rp> has 0
 commits
Date: Wed, 11 Nov 2015 19:26:34 +0100
Message-ID: <20151111192634.629102e6@linux-apw9.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 19:26:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwa64-0002iq-O5
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 19:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbbKKS0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 13:26:12 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37510 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbbKKS0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 13:26:12 -0500
Received: by wmww144 with SMTP id w144so56166248wmw.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 10:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blesmrt_net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=hR5hauiIJiykbfQlN5/9C3NRRZK+qt+dOfJl5IX2kT4=;
        b=KQKUxjSWFDeyNpdY8FpcbMXVOh+lXUrTlQUhF9B14Tpbxn0tlzULU1ACoW+Uh/prRx
         +qzZD7T6EZNLyIYOlINGpnFEdCYccgKnhhvsU/vGFXvTe7Fv6CQhLhZSxneAWgbBQT8m
         6YKyI1c672gn2kEUM0BDSUH1mlvc3YPHpiFYEFB9HNlt9YCtinbGk1ukj1JVDEUpoaHw
         1UkSvSd7dj5e3Dvo9plLyj0pLva4TqOWCIfOHkNSPGxkYk0ByjovQNJZnh4HIw4Oyol4
         zf5xinIV3oyRbjIPE0nPgcBoDHtnA06n3+73nbTJ9kGbjYvYUywMs7q7mOZEkSemX3xT
         tEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=hR5hauiIJiykbfQlN5/9C3NRRZK+qt+dOfJl5IX2kT4=;
        b=c8M0wFJP6MvfjmkUZxFe6ABUcJKQz77B3Tk+k26JJc5EBiv+roYuHvvLP+nkO0lMct
         W36qY/1ZauMe66yJmzGjIyeUUFxLz2lL7To+4Ui08eWFVxAerZrAxEvCXXSIUYPyvOav
         PdJqVrZRlvBY5DSCEGnjUwvRoRmWtjFeVwZAjjf4XkmcpQDdZEcMyZVvU8SSW0hdAzHS
         DTRbb3OdbPwyHa4MrSAH7f6gu0d7si51yrqKMl5DJR3yByxwKpANbybUpY44Nmw/hStk
         2RnkcZlHMZJlsvfIx/jPTSOLbZ20h39/SOBfeXQlyDcDZzdEQT2tEAXXnfHXMWI2yF21
         xphA==
X-Gm-Message-State: ALoCoQn4f9P/aKD5DGhkKVfVj/hafryUAJro19gAxCgcrbba6KAfwgkAtd+i1H2Jq+LwUaVdwnee
X-Received: by 10.28.61.213 with SMTP id k204mr24223209wma.5.1447266369788;
        Wed, 11 Nov 2015 10:26:09 -0800 (PST)
Received: from linux-apw9.site (nat1.scz.suse.com. [213.151.88.250])
        by smtp.gmail.com with ESMTPSA id vr10sm10254975wjc.38.2015.11.11.10.26.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2015 10:26:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281175>

Hello

basics:

% rpm -q git git-core
git-2.6.2-2.1.x86_64
git-core-2.6.2-2.1.x86_64

~ % grep PRETTY_NAME /etc/os-release
PRETTY_NAME="openSUSE Tumbleweed (20151030) (x86_64)"

current behavior:

~ % git init no-commits
Initialized empty Git repository in /home/tester/no-commits/.git/
~ % git -C no-commits rev-list --all
usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]
  limiting output:
    --max-count=<n>
    --max-age=<epoch>
    --min-age=<epoch>
    --sparse
    --no-merges
    --min-parents=<n>
    --no-min-parents
    --max-parents=<n>
    --no-max-parents
    --remove-empty
    --all
    --branches
    --tags
    --remotes
    --stdin
    --quiet
  ordering output:
    --topo-order
    --date-order
    --reverse
  formatting output:
    --parents
    --children
    --objects | --objects-edge
    --unpacked
    --header | --pretty
    --abbrev=<n> | --no-abbrev
    --abbrev-commit
    --left-right
    --count
  special purpose:
    --bisect
    --bisect-vars
    --bisect-all
~ % echo $?
129

expected behavior:

~ % git -C no-commits rev-list --all
~ % echo $?
0
