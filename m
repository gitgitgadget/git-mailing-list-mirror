Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6119C201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 12:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbdF3Mh7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 08:37:59 -0400
Received: from mail.peralex.com ([41.164.8.44]:33802 "EHLO mail.peralex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbdF3Mhz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 08:37:55 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jun 2017 08:37:54 EDT
Received: from [192.168.1.188] (noel1.ct [192.168.1.188])
        by mail.peralex.com (Postfix) with ESMTPSA id A7242336F5C
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 14:28:01 +0200 (SAST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=peralex.com;
        s=default; t=1498825681;
        bh=/32+ileS47VLZTo8JE+Em1kzNlyGf47NkwQzFof6RNE=;
        h=To:From:Subject:Date;
        b=OYpJrO0OFJntOMmOzOoq8gTEK10gKkSkFTFkPRbST55/qUkNj8UFlLFiTvt1c4AFA
         fbz1Iro281hLh+H9I31fvzlf2HC4Qd79bMWiSSkJhD+nAneV22ViCVMQI9pzv1QmmS
         PNTdPLF+orhLSySQ4b/YXshs0wDu4kWJ3akHxR4E=
To:     git@vger.kernel.org
From:   Noel Grandin <noel@peralex.com>
Subject: speeding up git pull from a busy gerrit instance over a slow link?
Message-ID: <19ee7852-efcc-66d0-24ad-3462a4d5eaf6@peralex.com>
Date:   Fri, 30 Jun 2017 14:28:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.peralex.com [0.0.0.0]); Fri, 30 Jun 2017 14:28:01 +0200 (SAST)
X-Scanned-By: MIMEDefang 2.78 on 41.164.8.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I'm running git version 2.13.1 on Ubuntu 16.04 (x64)

I'm connecting over a very slow (international link) to a very busy gerrit server (gerrit.libreoffice.org) using ssh.
Ping types are on the order of 200ms.

Using GIT_TRACE_PACKET=true, what I am seeing is that the bulk of the time is spent retrieving packets having to do with 
things which I have no interest in, i.e. the refs/changes/* stuff (see below).

Is there any way to deliberately exclude these from the pull process?

My git config looks like:
    remote.origin.url=ssh://logerrit/core
    remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
    branch.master.remote=origin
    branch.master.merge=refs/heads/master
    branch.sdrshapeid.remote=origin
    branch.sdrshapeid.merge=refs/heads/master

Thanks, Noel Grandin

---------------------
snippet of packet trace
-------------------

14:20:45.705091 pkt-line.c:80           packet:        fetch< c5b026801c729ab37e2af6a610f31ca2e28b51fe 
refs/changes/99/29099/2
14:20:45.705093 pkt-line.c:80           packet:        fetch< 931e2c40aeb4cf4591ae9fcfea1b352b966f0a32 
refs/changes/99/29199/1
14:20:45.705096 pkt-line.c:80           packet:        fetch< 373b44a2fcbe78e8a3ff14cd410826af151a6adf 
refs/changes/99/29199/2
14:20:45.705099 pkt-line.c:80           packet:        fetch< 90e0db5edf83595121818627f590cc6b776f9f45 
refs/changes/99/29299/1
14:20:45.705102 pkt-line.c:80           packet:        fetch< 0f23647484e969fcd3c1b7e7ae72249026b20a80 
refs/changes/99/29299/2
14:20:45.705104 pkt-line.c:80           packet:        fetch< c6b6e54eeb0878a63179d2827d9c1623fe6f54e9 
refs/changes/99/29299/3
14:20:45.705107 pkt-line.c:80           packet:        fetch< 8e466c431e6d61911b2b15895a4b63df12422057 
refs/changes/99/29299/4
14:20:45.705110 pkt-line.c:80           packet:        fetch< 168bb711950f175c0fc4a889b9c8d41cf35bedec 
refs/changes/99/29399/1
14:20:45.705114 pkt-line.c:80           packet:        fetch< 6c76ade9516ada09222a18af69eb381b2e859b24 
refs/changes/99/29399/2
14:20:45.705116 pkt-line.c:80           packet:        fetch< ff88d1ba10b2bfc7af7cbb518d3a3c1122d6dffc 
refs/changes/99/29599/1
14:20:45.705119 pkt-line.c:80           packet:        fetch< 0d93900801224b797741e9a1abf305109fa35665 
refs/changes/99/29599/2
14:20:45.705122 pkt-line.c:80           packet:        fetch< 46f34d1b27f2056bb145cbdb526d4ed48b426f97 
refs/changes/99/29699/1
14:20:45.705124 pkt-line.c:80           packet:        fetch< 90d0a3d08c07d22b9a2b85ee08c72a0c047ed2d5 
refs/changes/99/29699/2
14:20:45.705127 pkt-line.c:80           packet:        fetch< 8821675d8e5a8b9c6f7fa5139a973394bfa67294 
refs/changes/99/29699/3

Disclaimer: http://www.peralex.com/disclaimer.html


