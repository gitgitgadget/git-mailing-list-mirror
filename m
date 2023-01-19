Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F295C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjASSTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjASSTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 13:19:41 -0500
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993941449F
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 10:19:38 -0800 (PST)
Received: from localhost.localdomain ([88.110.98.79])
        by smtp.talktalk.net with SMTP
        id IZUipjyTdLVi2IZUipC7TD; Thu, 19 Jan 2023 18:18:36 +0000
X-Originating-IP: [88.110.98.79]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=qs8Jj6vsB7NiZ+3IlNxB6Q==:117
 a=qs8Jj6vsB7NiZ+3IlNxB6Q==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=VwQbUJbxAAAA:8 a=JOICPDiYJa5JK_teO4AA:9
 a=AjGcO6oz07-iQ99wixmX:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        self <philipoakley@iee.email>
Subject: [PATCH v5 0/5] Pretty formats: Clarify column alignment
Date:   Thu, 19 Jan 2023 18:18:22 +0000
Message-Id: <20230119181827.1319-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <20221112143616.1429-1-philipoakley@iee.email>
References: <20221112143616.1429-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGTp0OUqD3NGPy3/1ba5RpzvzF0pUJsTRnGtJrNXAOebb88jZKzL8tJoeIccMntvl6Pg6HkLx1s3kCowat7FEpQbN85CobO5YByUIQHQnRXntpxuAym2
 dk+wzCTKl+oE0DA7dylFuv7uovCJOkr+PMA7kIbVOxdCcuyxO2/+J8VGU700eqVpPDNGOI1f8En1ynj2+O/KawNK6YTsyg0tzGjmBgcD9AXen7pX3F8YGQy/
 5eEf8+yoJWOZQDxwMm+LWrZ5VEW3GWAzKIevySyYsPR4yMoTYWxDLlG+jm9M0suNGMpJFLV2k9BuSOp/TkokRg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow up to earlier versions of the series [1,2,3,4] that looked
to add left and right hard truncation of the column limited placeholders.

Taylor had provided an early review at [5].

Junio identified [6] that one problem would be that wide characters may
need to be cut in half and this wasn't properly covered.

I noted that there were other existing complications, and the wide
character problem could already be seen with particular placeholders.

I said I would at least update the docs [7] to cover features that weren't
fully documented and add a few simple tests to show the wide character
and other discovered problems.

The series now has 5 patches. The first four add documentation to match
their original code changes.

The final patch adds the tests for the special character cases, and adds a cautionary note to the docs.

The added tests make assumptions as to the desired solution in the 'expect'
result, and alternatives are discussed as to how to 'split' a wide
character to fit a single column when required to fit to column limits.

This series is unaffected by the security fix (CVE-2022-41903 size_t/int)
in Git 2.39.1 [8] within this formatting code.

Philip

[1] https://lore.kernel.org/git/20221030185614.3842-1-philipoakley@iee.email/ [PATCH 0/1] extend the truncating pretty formats
[2] https://lore.kernel.org/git/20221101225724.2165-1-philipoakley@iee.email/ [PATCH v2 0/1] extend the truncating pretty formats
[3] https://lore.kernel.org/git/20221102120853.2013-1-philipoakley@iee.email/ [PATCH v3] pretty-formats: add hard truncation, without ellipsis, options
[4] https://lore.kernel.org/git/20221112143616.1429-1-philipoakley@iee.email/ [PATCH v4] pretty-formats: add hard truncation, without ellipsis, options
[5] https://lore.kernel.org/git/Y17PS%2F2LgRIJKGoo@nand.local/ (Taylor: t4205-log-pretty-formats.sh. Is that coverage ..)
[6] https://lore.kernel.org/git/xmqqfsedywli.fsf@gitster.g/ (Junio: Imagine there are series of wide characters,...)
[7] https://lore.kernel.org/git/093e1dca-b9d4-f1f2-0845-ad6711622cf5@iee.email/ (po: I'll at least work on the doc clarification..)
[8] https://lore.kernel.org/git/xmqq7cxl9h0i.fsf@gitster.g/


Philip Oakley (5):
  doc: pretty-formats: separate parameters from placeholders
  doc: pretty-formats: delineate `%<|(` parameter values
  doc: pretty-formats document negative column alignments
  doc: pretty-formats describe use of ellipsis in truncation
  doc: pretty-formats note wide char limitations, and add tests

 Documentation/pretty-formats.txt | 32 +++++++++++++++++++++-----------
 t/t4205-log-pretty-formats.sh    | 27 +++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 11 deletions(-)

-- 
2.39.1.windows.1

