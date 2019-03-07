Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B240320248
	for <e@80x24.org>; Thu,  7 Mar 2019 21:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCGVo5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 16:44:57 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:39264 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCGVo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 16:44:57 -0500
Received: by mail-pg1-f179.google.com with SMTP id h8so12310385pgp.6
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 13:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grande.coffee; s=omgwhathaveyoudone;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yIr5oSYaEIg43jeg8Ows3+qju0WMTCnzpMsvgueUXhg=;
        b=v5WbWb+rOVuLp1uJdP0seqIepkdta0V87XHkxbcynCEi6/BexMXLN/+qkFAGthrffq
         YcOaUQe3n9fui30Fn0t58T0U/kBcIyADO53WXpgLzfd6WgUO2C4DizOsYm9tbvsYEk20
         hisuNUroIl5AZOpOBgWqXWFrMyD24zr1SwUexmQx8utH0p9j72lkHWKGvByK0hQ099oI
         op7hDxTyCFkptsTAGcwJS0fhWPeSAvTh+omn0y+MRq/o/fS0YqNU4e8S01G6EdYP1meu
         fK4YaKhzCtazNhkOg42tEd5JT4gfL9tBacFZN/n67xp1euYad9uZYKFXPpbOovUl/1e7
         MDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yIr5oSYaEIg43jeg8Ows3+qju0WMTCnzpMsvgueUXhg=;
        b=Ew/q/b30Fqt+1GWXRH33yBFhrna8yNt1Dmafq4Qz7T6j65lanLzwS3unZq8u2SfBEi
         sH0yPv2QebzjMIf4+iDlH40e5qOUrTZvqyenQCsZSqQtbRs7kZVALISEpW/S31n3wY5h
         j38tzKkQo6aup/LvXv5aPMdB89/UkbdUOTffWqUJ9Fm14osR5GPTfoSk4EmxNqeGnAqz
         WpIIvQny4+Ww/0Cplsp5Eydjrv3I5yiXtRwxakqngLTFoeAiKS5aqNZdQxKj4/izlgXn
         +B+1WhXC2lwAHnVRe+c3gQgbF/QHaZAWMs9goTWT9to5pucIkawnTHADCKUy0fx7sWxD
         6c+A==
X-Gm-Message-State: APjAAAVJrmshURlQIq9rMSrFUcV0mIxV4PorCOqt3GiH+iC0OqKsdcZH
        dFqkXeAZj7qnurOew1/6qZOu4JdNEWKgsQ==
X-Google-Smtp-Source: APXvYqx/IFjXXjCpiml3mRzgwKP+XNalVf1+lBfr7gjbmnrxvwG+l6YwZYi4x53soNHjr48aawoGkQ==
X-Received: by 2002:a17:902:d896:: with SMTP id b22mr1618464plz.307.1551995095501;
        Thu, 07 Mar 2019 13:44:55 -0800 (PST)
Received: from chabuduo ([198.41.129.1])
        by smtp.gmail.com with ESMTPSA id r28sm11360586pgl.72.2019.03.07.13.44.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 13:44:54 -0800 (PST)
Date:   Thu, 7 Mar 2019 21:44:47 +0000
From:   Alexander Huynh <alex@grande.coffee>
To:     git@vger.kernel.org
Subject: [BUG] fetching all remote branches results in failed multiple updates
Message-ID: <20190307214447.GA4909@chabuduo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

When running the latest release of git, I receive an error when attempting to
fetch all remote branches from a repo:

    fatal: multiple updates for ref 'refs/remotes/origin/maint' not allowed

The specific ref that it fails on changes depending on the repository, but the
end result is the repo isn't cloned.

The specific configuration that causes this bug is the `remote.origin.fetch`
option, specifically:

    [remote "origin"]
    	fetch = +refs/heads/*:refs/remotes/origin/*

These settings are listed as an example in "CONFIGURED REMOTE-TRACKING
BRANCHES" of git-fetch(1), as well as expanded upon in
https://stackoverflow.com/a/40739835.

I'm running git version 2.21.0.

Full reproduction steps are below:

    [root@chabuduo ~]# useradd -m git-test -s /bin/bash
    [root@chabuduo ~]# sudo --preserve-env=SSH_AUTH_SOCK -u git-test -i
    [git-test@chabuduo ~]$ git --version
    git version 2.21.0
    [git-test@chabuduo ~]$ cat > ~/.gitconfig
    [remote "origin"]
    	fetch = +refs/heads/*:refs/remotes/origin/*
    [git-test@chabuduo ~]$ cat ~/.gitconfig
    [remote "origin"]
    	fetch = +refs/heads/*:refs/remotes/origin/*
    [git-test@chabuduo ~]$ git clone git@github.com:git/git.git
    Cloning into 'git'...
    Warning: Permanently added the RSA host key for IP address '192.30.255.112' to the list of known hosts.
    remote: Enumerating objects: 265113, done.
    remote: Total 265113 (delta 0), reused 0 (delta 0), pack-reused 265113
    Receiving objects: 100% (265113/265113), 113.20 MiB | 5.49 MiB/s, done.
    Resolving deltas: 100% (196542/196542), done.
    fatal: multiple updates for ref 'refs/remotes/origin/maint' not allowed
