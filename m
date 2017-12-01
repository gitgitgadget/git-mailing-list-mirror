Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F91720954
	for <e@80x24.org>; Fri,  1 Dec 2017 17:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbdLARWK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 1 Dec 2017 12:22:10 -0500
Received: from elephants.elehost.com ([216.66.27.132]:23750 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdLARVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 12:21:44 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.136.74])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vB1HLgw9038838
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 1 Dec 2017 12:21:43 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [RFE] Inverted sparseness
Date:   Fri, 1 Dec 2017 12:21:37 -0500
Message-ID: <004201d36ac8$db62b900$92282b00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdNqyGs8lMgHRSeGSHuQ6x9luum0pg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently encountered a really strange use-case relating to sparse clone/fetch that is really backwards from the discussion that has been going on, and well, I'm a bit embarrassed to bring it up, but I have no good solution including building a separate data store that will end up inconsistent with repositories (a bad solution).  The use-case is as follows:

Given a backbone of multiple git repositories spread across an organization with a server farm and upstream vendors.
The vendor delivers code by having the client perform git pull into a specific branch.
The customer may take the code as is or merge in customizations.
The vendor wants to know exactly what commit of theirs is installed on each server, in near real time.
The customer is willing to push the commit-ish to the vendor's upstream repo but does not want, by default, to share the actual commit contents for security reasons.
	Realistically, the vendor needs to know that their own commit id was put somewhere (process exists to track this, so not part of the use-case) and whether there is a subsequent commit contributed by the customer, but the content is not relevant initially.

After some time, the vendor may request the commit contents from the customer in order to satisfy support requirements - a.k.a. a defect was found but has to be resolved.
The customer would then perform a deeper push that looks a lot like a "slightly" symmetrical operation of a deep fetch following a prior sparse fetch to supply the vendor with the specific commit(s).

This is not hard to realize if the sparse commit is HEAD on a branch, but if its inside a tree, well, I don't even know where to start. To self-deprecate, this is likely a bad idea, but it has come up a few times.

Thoughts? Nasty Remarks?

Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



