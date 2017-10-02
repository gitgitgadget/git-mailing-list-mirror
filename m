Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA6720281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdJBXpV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:45:21 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:46382 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdJBXpU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:45:20 -0400
Received: by mail-pg0-f48.google.com with SMTP id v3so3792140pgv.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 16:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ByamBhHcj2eJ4tw27d/MkdMWFcglLDY6FfnPBe2nyBI=;
        b=cLlGI4nbfKMMg1WNy5TQ2Hr0EfDWp82bejAdTUvPMlhu3y7ZQrTGoCK50ohpTbh6kj
         IwnI88WfK3KfATPyuhhaNyXn38mErKPyzNLXYWq+9wfVWUjtDt36iFDmI0msT1h9UwTw
         oamGg6t7bOsMWFe9UcF1zvUEOEagZoR4WYC6VgDLeLvOQXXh+LkcW5k+ImTcMDf6ftMM
         3BQEK67UU6M1v+JxwwiZPj5dlsUqCAFdN0yOWmxXH6cUUTr9QW8Pm/tCmecC9w88stH6
         sNorZ+9kHs/ji9a133lPcLdz5izTWNV6PSYWHTgxcX3p6d84H0vaCvSh6NalUFHKDKGD
         r3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ByamBhHcj2eJ4tw27d/MkdMWFcglLDY6FfnPBe2nyBI=;
        b=G7CfVhf+XPX+GY4E9RX8ncHUpWSvf+6Afl26PRsPAzuyKWLKEx/jK8reABH/qHxQ9v
         xbs2r1Qto7H2hb/Tj6o5yP/n59fICKD0/YCnACIjg5Jq+ynIuH/pC9NdItIZ/XP/fiwA
         35kCAf0DTREaYKJJlTwQE04RMrplf7RtL+ldkICGfjOo43FHkv48cYDnSXkzukz3Vajp
         if1c8i+PvA7fpN8v0PBFt+li3IwRGnbc/4AmFYhsL//6pDMFE+rpAOaZHgkmjG2gMn9D
         ncaX7T7izccB3A6KohDe8FFiLDqz1txgTyPTr7kcGhhF8azdVLj7Uyqlkqt6XNbmCZ3e
         jBPQ==
X-Gm-Message-State: AHPjjUihFLagenulgFxTLQ6kQ32NCt6t7yQzyV9r9GjQXLVBQHSzTzzt
        yKB2PFDQZAR8oD02xZkRPTg7XV8M
X-Google-Smtp-Source: AOwi7QAHBpmBNPjsbV3Wi1GsG3qojW/B/yoWIvnu4ulNGFLeIGRmktFvtEQDbQ205ZdMuJq+5WeXug==
X-Received: by 10.101.81.10 with SMTP id f10mr13528750pgq.82.1506987919980;
        Mon, 02 Oct 2017 16:45:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c1fd:a9ac:f156:8142])
        by smtp.gmail.com with ESMTPSA id e133sm18840467pfh.177.2017.10.02.16.45.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 16:45:19 -0700 (PDT)
Date:   Mon, 2 Oct 2017 16:45:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Loic Guelorget <loic@google.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Sitaram Chamarty <sitaramc@gmail.com>
Subject: Security of .git/config and .git/hooks
Message-ID: <20171002234517.GV19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This topic has been mentioned on this mailing list before but I had
trouble finding a relevant reference.  Links welcome.

Suppose that I add the following to .git/config in a repository on a
shared computer:

	[pager]
		log = rm -fr /
		fsck = rm -fr /

("rm -fr /" is of course a placeholder here.)

I then tell a sysadmin that git commands are producing strange output
and I am having trouble understanding what is going on.  They may run
"git fsck" or "git log"; in either case, the output is passed to the
pager I configured, allowing me to run an arbitrary command using the
sysadmin's credentials.

You might say that this is the sysadmin's fault, that they should have
read through .git/config before running any Git commands.  But I don't
find it so easy to blame them.

A few related cases that might not seem so dated:

 1. I put my repository in a zip file and ask a Git expert to help me
    recover data from it, or

 2. My repository is in a shared directory on NFS.  Unless the
    administrator setting that up is very careful, it is likely that
    the least privileged user with write access to .git/config or
    .git/hooks/ may be someone that I don't want to be able to run
    arbitrary commands on behalf of the most privileged user working
    in that repository.

A similar case to compare to is Linux's "perf" tool, which used to
respect a .perfconfig file from the current working directory.
Fortunately, nowadays "perf" only respects ~/.perfconfig and
/etc/perfconfig.

Proposed fix: because of case (1), I would like a way to tell Git to
stop trusting any files in .git.  That is:

 1. Introduce a (configurable) list of "safe" configuration items that
    can be set in .git/config and don't respect any others.

 2. But what if I want to set a different pager per-repository?
    I think we could do this using configuration "profiles".
    My ~/.config/git/profiles/ directory would contain git-style
    config files for repositories to include.  Repositories could
    then contain

	[include]
		path = ~/.config/git/profiles/fancy-log-pager

    to make use of those settings.  The facility (1) would
    special-case this directory to allow it to set "unsafe" settings
    since files there are assumed not to be under the control of an
    attacker.

 3. Likewise for hooks: my ~/.config/git/hooks/ directory would
    contain hooks for repositories to make use of.  Repositories could
    symlink to hook files from there to make use of them.

    That would allow the configured hooks in ~/.config/git/hooks/ to
    be easy to find and to upgrade in one place.

    To help users migrate, when a hook is present and executable in
    .git/hooks/, Git would print instructions for moving it to
    ~/.config/git/hooks/ and replacing it with a symlink after
    inspecting it.

For backward compatibility, this facility would be controlled by a
global configuration setting.  If that setting is not enabled, then
the current, less safe behavior would remain.

One downside of (3) is its reliance on symlinks.  Some alternatives:

 3b. Use core.hooksPath configuration instead.  Rely on (2).
 3c. Introduce new hook.* configuration to be used instead of hook
     scripts.  Rely on (2).

Thoughts?
Jonathan
