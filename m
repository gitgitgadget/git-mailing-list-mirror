Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E451FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 01:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755331AbeASBXG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 18 Jan 2018 20:23:06 -0500
Received: from elephants.elehost.com ([216.66.27.132]:62730 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755152AbeASBW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 20:22:57 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0J1MrqJ039647
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Jan 2018 20:22:53 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Stefan Beller'" <sbeller@google.com>
Cc:     <randall.s.becker@rogers.com>, "'git'" <git@vger.kernel.org>
References: <20180118224243.5016-1-randall.s.becker@rogers.com> <CAGZ79kb4Zr6QnNydRX56B_4Jo5fveufBFJAD7r_8U-NRSMa2qQ@mail.gmail.com> <87a7xaiu7z.fsf@evledraar.gmail.com>
In-Reply-To: <87a7xaiu7z.fsf@evledraar.gmail.com>
Subject: RE: [RFC PATCH] NonStop port changes for git 2.16.0.
Date:   Thu, 18 Jan 2018 20:22:49 -0500
Message-ID: <00ba01d390c4$083b7360$18b25a20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKGERhTgCchMwVIke5wy32jaCZ+0AG9Oe9rApJvi32h8uZ2IA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 18, 2018 7:11 PM, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jan 18 2018, Stefan Beller jotted:
> > On Thu, Jan 18, 2018 at 2:42 PM,  <randall.s.becker@rogers.com> wrote:
> >> Further: there are 6 known breakages that have been reported. The
> >> perl issues relating to completion codes are being examined at
> >> present by the platform support teams so are not addressed by this
> patch.
> >
> > For perl I'd suggest cc'ing Ævar (cc'd just now) as that seems his
> > field of expertise.
> 
> Just to make sure I'm keeping up, this refers to some breakage not detailed
> in the patch above, right?
> 
> The only perl-related change I see is undoing part of 6c109904bc ("Port to HP
> NonStop", 2012-09-19) having to do with how we find perl/python (which,
> not being at all familiar with NonStop, makes sense to me).
> 
> But sure, if there's some details about those 6 issues I might have time to
> take a look, but it sounds like it's being looked at by NonStop support...

The issue I found is that NonStop perl is reporting completion code 162/169 when 'die "stuff";' is run from stdin, while reporting 255 when a real file is used. This isn't covered by the patch. The values are in the range 128+sig#, but no such signals are value on the platform (SIGABEND is 31 and SIGGUARDIAN is 99 with a gap between those). I had tried a few experiments mapping the wonky completion codes in run-command.c to something sane but that caused more breakages (60) in the test suite than leaving well enough alone (6). From what I can determine, git is behaving reasonably properly in the conditions tested, but the test suite structure in its use of perl is triggering artifacts that appear to be breakages when really not. This is currently being investigated by the HPE support team, so I'm leaving perl completion matters in their hands for now.

Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



