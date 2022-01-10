Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B31C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 08:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiAJIY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 03:24:27 -0500
Received: from mail1.rz.htw-berlin.de ([141.45.10.101]:60922 "EHLO
        mail1.rz.htw-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbiAJIYV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 03:24:21 -0500
X-Greylist: delayed 1530 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jan 2022 03:24:21 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=htw-berlin.de; s=my; h=Subject:To:From:Date:From:To:Date:Subject;
        bh=SYxnGvg8ZfMZf+Po7z4wVY0rReWC2yoqcROyeTY7MQg=; b=iukWis+fEjjewfLLjYMtYcr91K
        ctfbEm/oNlDxQa9Cuc03MiJ5l53AlSJWoRHFRb4+zZMsKHB8AOWdcvUvagqpfCJXwNfJzwcatlx0q
        jQnzpjLKqRnlR09C+0Q8m6Ye+AzWNYblNVtSBEh78Jp7xSBnX5iRwlU+eb5ytsMvwz+v92cV9MtyQ
        paAcgRttqqaIgq8tIraiPbDbnOoeagalmDjZoeDRJfCQsMY9Fa5H3C6fN4BjM474tMBpp5xX5AwMQ
        1/EyAAv8MqIyTNzElTiyfRSnlkdysNj8Wn6PMtQYziRQSejink6IM18zI0ecirm3kW2h4zwMaoa5L
        nezG1+JQ==;
Envelope-to: git@vger.kernel.org
Received: from webmail.htw-berlin.de ([141.45.70.36])
        by mail1.rz.htw-berlin.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <Sebastian.Richter@HTW-Berlin.de>)
        id 1n6pZR-0009fF-Q3; Mon, 10 Jan 2022 08:58:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 10 Jan 2022 08:58:45 +0100
From:   Sebastian Richter <Sebastian.Richter@HTW-Berlin.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Imi Admin <imiadmin@htw-berlin.de>, git@vger.kernel.org
Subject: Re: Problem with credential.helper=store in git 2.32.0.windows.2
Organization: HTW Berlin
In-Reply-To: <nycvar.QRO.7.76.6.2201092246520.339@tvgsbejvaqbjf.bet>
References: <8838ac786ed46b841e4172824b80564b@htw-berlin.de>
 <nycvar.QRO.7.76.6.2201092246520.339@tvgsbejvaqbjf.bet>
Message-ID: <1c331bdd51b424022bfd598c71d7d666@HTW-Berlin.de>
X-Sender: Sebastian.Richter@HTW-Berlin.de
User-Agent: Roundcube Webmail
X-HTW-AUTHENTICATED: yes
X-HTW-DELIVERED-TO: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

thanks for clarifying this. I'm using 'git config --system --unset 
credential.helper' before setting the file store in the local 
configuration now and it works.

Best Sebastian

Am 09.01.2022 22:53, schrieb Johannes Schindelin:
> Hi Sebastian,
> 
> On Thu, 6 Jan 2022, Imi Admin wrote:
> 
>> Here's my local git configuration:
>> 
>> PS C:\scripts> git config -l --show-origin
>> [...]
>> file:C:/Program Files/Git/etc/gitconfig	credential.helper=manager-core
>> file:C:/Program 
>> Files/Git/etc/gitconfig	credential.https://dev.azure.com.usehttppath=true
>> file:C:/Program Files/Git/etc/gitconfig	init.defaultbranch=master
>> file:.git/config	core.repositoryformatversion=0
>> file:.git/config	core.filemode=false
>> file:.git/config	core.bare=false
>> file:.git/config	core.logallrefupdates=true
>> file:.git/config	core.symlinks=false
>> file:.git/config	core.ignorecase=true
>> file:.git/config	remote.origin.url=https://mygitlab.de/mygroup/myrepo.git
>> file:.git/config	remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
>> file:.git/config	branch.master.remote=origin
>> file:.git/config	branch.master.merge=refs/heads/master
>> file:.git/config	user.name=myname
>> file:.git/config	user.email=my@email
>> file:.git/config	credential.helper=store --file 
>> C:/scripts/.git/.git-credentials
>> 
>> [...]
>> 
>> Anyway as far as i understood git should not exec 
>> git-credential-manager-core
>> get at all with my local git configuration?
> 
> You need one additional thing to make that happen. As per
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-credentialhelper:
> 
> 	Note that multiple helpers may be defined. See gitcredentials[7]
> 	for details and examples.
> 
> And in https://git-scm.com/docs/gitcredentials#_configuration_options, 
> we
> read:
> 
> 	If there are multiple instances of the credential.helper
> 	configuration variable, each helper will be tried in turn, and may
> 	provide a username, password, or nothing. Once Git has acquired
> 	both a username and a password, no more helpers will be tried.
> 
> 	If credential.helper is configured to the empty string, this
> 	resets the helper list to empty (so you may override a helper set
> 	by a lower-priority config file by configuring the empty-string
> 	helper, followed by whatever set of helpers you would like).
> 
> So you need to insert a line "helper =` (with an empty value) in your
> .git/config's `[credential]` section:
> 
> 	[credential]
> 		# reset 'credential.helper' list
> 		helper =
> 		helper = "store --file C:/scripts/.git/.git-credentials"
> 
> Ciao,
> Johannes

-- 
Hochschule für Technik und Wirtschaft
Wilhelminenhofstr. 75A
12459 Berlin
Gebäude C Raum 538
tel 030 5019 2945
fax 030 5019 48 2945
mail richter@htw-berlin.de

