Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243212027C
	for <e@80x24.org>; Wed, 31 May 2017 00:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbdEaAsq (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 20:48:46 -0400
Received: from avasout07.plus.net ([84.93.230.235]:49675 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdEaAsq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 20:48:46 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id Sooj1v0051keHif01ook5y; Wed, 31 May 2017 01:48:44 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=XeUe3zydpSsAXE84HtUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [GSoC][PATCH v5 1/3] submodule: fix buggy $path and $sm_path
 variable's value
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
 <01e8c552-fd3a-ee05-1ff1-3b3ea0f7feeb@ramsayjones.plus.com>
 <CAGZ79kYbi5QxWAsxdfPkuWEyMt9Qg753sm0vExsKaWyksDVw+Q@mail.gmail.com>
 <24ebb17b-4324-c6ef-7e3a-5576cda3b595@ramsayjones.plus.com>
 <CAGZ79kYc9wx23N9quxhuYAf2H1Rm3tGNg_0Ydz0KO4qPH-Kz5w@mail.gmail.com>
 <56bcf006-06f1-1851-87de-5697f988cb08@ramsayjones.plus.com>
 <CAGZ79kYMA6Me_ZnBZQitW7ZSJ0kfvb-LPnH=1gTwhRN-KOe5pA@mail.gmail.com>
 <6e1db1f4-abbe-199e-a206-a56d83fac4ff@ramsayjones.plus.com>
Message-ID: <48149a4a-c7e3-d70e-7894-369681587372@ramsayjones.plus.com>
Date:   Wed, 31 May 2017 01:48:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <6e1db1f4-abbe-199e-a206-a56d83fac4ff@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 31/05/17 01:13, Ramsay Jones wrote:

> On 31/05/17 00:29, Stefan Beller wrote:
>  
>> In that test sm_path contains the relative path from $PWD to the
>> submodule. (It does NOT: "$[sm_]path is the name of the submodule
>> directory relative to the superproject" as documented but rather
>> ... relative to the $PWD)
> 
> In that case, the current user documentation does not agree with
> the current implementation, yes?
> 
> So, was the user documentation always wrong? (did git-ls-files work
> from a sub-directory, limiting its output to the cwd, or did it
> chdir() to the top of the worktree first?).

To answer my own question, I rebuilt git and tried directly:

  $ pwd
  /home/ramsay/git
  $ 
  $ ./git version
  git version 1.7.10.1.g64394
  $ 
  $ cd git_remote_helpers/
  $ ../git-ls-files --error-unmatch --stage --
  100644 2247d5f95a7193c7221b9464debe167763b4fae3 0	.gitignore
  100644 74b05dc91e42414147d5f3dc7b4fc66fb86c0eca 0	Makefile
  100644 00f69cbeda277b24e8ab35cb7db2c25cc0cc122e 0	__init__.py
  100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	git/__init__.py
  100644 9ee5f96d4ce313f4f94505ff65b560943bfd21cb 0	git/exporter.py
  100644 007a1bfdf37d231470f69d9d0cffa46e80127f34 0	git/git.py
  100644 5c6b595e16665bc508625ab0e96c95776bacba1a 0	git/importer.py
  100644 e70025095dcfb31d3944e72ac1f83dd7d4109103 0	git/non_local.py
  100644 acbf8d7785e2253777456f8910e2352992dda474 0	git/repo.py
  100644 4bff8878d14ccaf02c552073ef55d519df0b4cad 0	setup.cfg
  100644 4d434b65cbf5c42a455d5cd3bced030bfb51a245 0	setup.py
  100644 fbbb01b14619c1d2ed6bcc8f304f019fbe98697f 0	util.py
  $ 
  
Hmm, so it looks like $path was always relative to cwd!

(got to get some sleep now ...)

ATB,
Ramsay Jones


