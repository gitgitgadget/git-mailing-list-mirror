Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4490BC2BB40
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E152322515
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408923AbgLNXMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:12:55 -0500
Received: from elephants.elehost.com ([216.66.27.132]:26328 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbgLNXMx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 18:12:53 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0BENC9eH047589
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Dec 2020 18:12:09 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git-2.30.0-rc0 - Compile Fails on HPE NonStop
Date:   Mon, 14 Dec 2020 18:12:03 -0500
Message-ID: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdbSbgISgZDkt2rwQ6ey7AqE5rKZcA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2.30.0-rc0 fails to compile strmap.o, and probably others, since this is in
a header file:

"git-compat-util.h", line 277: warning(1252):
          missing return statement at end of non-void function "setitimer"

  	return strmap_remove(&map->map, str, 0);
  	       ^
"strmap.h", line 168: error(210):
          a void function may not return a value

  	return strmap_remove(&set->map, str, 0);
  	       ^
"strmap.h", line 252: error(210):
          a void function may not return a value

Aside from inlining bodies, this should not have compiled on any platform:

static inline void strset_remove(struct strset *set, const char *str)
{
        return strmap_remove(&set->map, str, 0);
}

What is really intended here?

Sorry,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.





