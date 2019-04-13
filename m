Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8FB20248
	for <e@80x24.org>; Sat, 13 Apr 2019 20:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDMU5q convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 13 Apr 2019 16:57:46 -0400
Received: from elephants.elehost.com ([216.66.27.132]:23206 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfDMU5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 16:57:46 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x3DKvht5044967
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 16:57:43 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>
References: <000d01d4f237$5cf2dc10$16d89430$@nexbridge.com> <874l71fxmg.fsf@evledraar.gmail.com>
In-Reply-To: <874l71fxmg.fsf@evledraar.gmail.com>
Subject: RE: [BUG] GIT_SSH_COMMAND is not being decomposed
Date:   Sat, 13 Apr 2019 16:57:37 -0400
Message-ID: <000e01d4f23b$89d75590$9d8600b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGpuMnQep3MvtsjO/08o+Xas343GAFQ9z8cpoZ9VZA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 13, 2019 16:40, Ævar Arnfjörð Bjarmason wrote:
> On Sat, Apr 13 2019, Randall S. Becker wrote:
> 
> > I am encountering a problem on one of our NonStop platform variants
> > where the GIT_SSH_COMMAND string is not being broken into constituent
> > parts. This is causing SSH to not run properly. As background, SSH is
> > not in a standard location and has non-standard required arguments.
> > This also occurs with core.sshCommand. The situation is:
> >
> > git config --global core.sshCommand '/G/system/zssh/sshossz5 -Q'
> >
> > which correctly sets .gitconfig as:
> >
> > [core]
> >         sshCommand = /G/system/zssh/sshossz5 -Q
> >
> > When git is run with GIT_TRACE=true GIT_PACKET_TRACE=true git fetch
> >
> > We get the partial trace:
> > 14:19:56.027088 trace: built-in: git fetch
> > 14:19:56.029895 trace: run_command: '/G/system/zssh/sshossz5 -Q' -G
> > user@host
> >
> > The same trace on our systems that actually do work results in:
> > 14:19:56.029895 trace: run_command: '/G/system/zssh/sshossz5' '-Q' -G
> > user@host
> >
> > I need help resolving why this is happening (as in where to look and
> > debug the situation).
> 
> This doesn't seem to be documented *explicitly* (except between the lines &
> inferred), but it's only supported to pass a *command* there, i.e. the path of
> the ssh binary. See the code around get_ssh_command() in connect.c. The
> whole env/config value we look up gets passed as one.
> 
> So if you need arguments you need to create a wrapper script and set ssh
> command to that script.

Thanks. I didn't know that, because this technique worked for years on the older platform variant. My wrapper works fine on the newer system.

With appreciation,
Randall

