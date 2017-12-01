Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC2B20954
	for <e@80x24.org>; Fri,  1 Dec 2017 18:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbdLASbc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 1 Dec 2017 13:31:32 -0500
Received: from elephants.elehost.com ([216.66.27.132]:35436 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbdLASbb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 13:31:31 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.136.74])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vB1IVSjZ041275
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 1 Dec 2017 13:31:29 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff Hostetler'" <git@jeffhostetler.com>, <git@vger.kernel.org>
References: <004201d36ac8$db62b900$92282b00$@nexbridge.com> <bdd01692-198a-f5ec-3c88-7d99e4adced5@jeffhostetler.com>
In-Reply-To: <bdd01692-198a-f5ec-3c88-7d99e4adced5@jeffhostetler.com>
Subject: RE: [RFE] Inverted sparseness
Date:   Fri, 1 Dec 2017 13:31:23 -0500
Message-ID: <004701d36ad2$9a7fcea0$cf7f6be0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIMw3dWTpn6gCmf6prp0zs6Tn9TmQL9821xoqQskiA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 1, 2017 1:19 PM, Jeff Hostetler wrote:
>On 12/1/2017 12:21 PM, Randall S. Becker wrote:
>> I recently encountered a really strange use-case relating to sparse clone/fetch that is really backwards from the discussion that has been going on, and well, I'm a bit embarrassed to bring it up, but I have no good solution including building a separate data store that will end up inconsistent with repositories (a bad solution).  The use-case is as follows:
>> 
>> Given a backbone of multiple git repositories spread across an organization with a server farm and upstream vendors.
>> The vendor delivers code by having the client perform git pull into a specific branch.
>> The customer may take the code as is or merge in customizations.
>> The vendor wants to know exactly what commit of theirs is installed on each server, in near real time.
>> The customer is willing to push the commit-ish to the vendor's upstream repo but does not want, by default, to share the actual commit contents for security reasons.
>> 	Realistically, the vendor needs to know that their own commit id was put somewhere (process exists to track this, so not part of the use-case) and whether there is a subsequent commit contributed >by the customer, but the content is not relevant initially.
>> 
>> After some time, the vendor may request the commit contents from the customer in order to satisfy support requirements - a.k.a. a defect was found but has to be resolved.
>> The customer would then perform a deeper push that looks a lot like a "slightly" symmetrical operation of a deep fetch following a prior sparse fetch to supply the vendor with the specific commit(s).

>Perhaps I'm not understanding the subtleties of what you're describing, but could you do this with stock git functionality.

>Let the vendor publish a "well known branch" for the client.
>Let the client pull that and build.
>Let the client create a branch set to the same commit that they fetched.
>Let the client push that branch as a client-specific branch to the vendor to indicate that that is the official release they are based on.

>Then the vendor would know the official commit that the client was using.
This is the easy part, and it doesn't require anything sparse to exist.

>If the client makes local changes, does the vendor really need the SHA of those -- without the actual content?
>I mean any SHA would do right?  Perhaps let the client create a second client-specific branch (set to
> the same commit as the first) to indicate they had mods.
>Later, when the vendor needs the actual client changes, the client does a normal push to this 2nd client-specific branch at the vendor.
>This would send everything that the client has done to the code since the official release.

What I should have added to the use-case was that there is a strong audit requirement (regulatory, actually) involved that the SHA is exact, immutable, and cannot be substitute or forged (one of the reasons git is in such high regard). So, no I can't arrange a fake SHA to represent a SHA to be named later. It SHA of the installed commit is part of the official record of what happened on the specific server, so I'm stuck with it.

>I'm not sure what you mean about "it is inside a tree".

m---a---b---c---H1
          `---d---H2

d would be at a head. b would be inside. Determining content of c is problematic if b is sparse, so I'm really unsure that any of this is possible.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



