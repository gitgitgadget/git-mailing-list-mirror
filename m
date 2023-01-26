Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3CFC54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 13:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAZNnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 08:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAZNno (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 08:43:44 -0500
X-Greylist: delayed 2303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Jan 2023 05:43:36 PST
Received: from pannekake.samfundet.no (pannekake.samfundet.no [IPv6:2001:67c:29f4::50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942CB755
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 05:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=gunderson.no; s=legacy; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aiKYGw4STV6VTesmiIzsG8qCMFMYygNgN+LPpDdneZ4=; b=rjliiOpA80DLyMa//dpfI64sIX
        26Xz6qec2hB+K8EIELXfdrtkDKEMc1xz4I5CWEv2j2pC7EBds2oL9pKhCYkZq8FgG2vJAfKMSGX10
        i/3ltrHgB9MlvnHwqJIhkJpLNf21Qqmn5kocp0HnS0iO0PbLqPAEo+U3gEw8nzE0MI0cTfdd9PueQ
        fEv8eYYuLAXwfppjLLVmwmfPkx61w1C+7kdul9shya8li4OUqJHiUUjMq+C2sb7A6eFASV36UfMIP
        CkEcGhoEIXeOF7RW4JEku24EnXRDyIaO4HvM1UU+Xo5+Im0DD+KuJqrmFQJaCSPpHGuhA4SzyOAVJ
        INhfiQFw==;
Received: from sesse by pannekake.samfundet.no with local (Exim 4.94.2)
        (envelope-from <steinar+bounces@gunderson.no>)
        id 1pL1wD-00GjF6-42
        for git@vger.kernel.org; Thu, 26 Jan 2023 14:05:09 +0100
Date:   Thu, 26 Jan 2023 14:05:09 +0100
From:   "Steinar H. Gunderson" <steinar+git@gunderson.no>
To:     git@vger.kernel.org
Subject: git log --follow wrongly includes delete commit
Message-ID: <20230126130509.ovii7ji7hi5wm7qx@sesse.net>
X-Operating-System: Linux 6.1.3 on a x86_64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm in the Chromium repository; it can be checked out at
https://chromium.googlesource.com/chromium/src.git (you don't need the
sub-repostiories). HEAD is pointing to 4e0db738b37c. git 2.39.1.

When I run

  git log --raw --follow base/third_party/xdg_user_dirs/xdg_user_dir_lookup.h

this is the first commit that it lists (snipped):

commit 5d4451ebf298d9d71f716cc0135f465cec41fcd0
[...]
:100644 000000 9e81e1b53029f 0000000000000 D base/third_party/xdg_user_dirs/xdg_user_dir_lookup.h

This indicates that the last thing that happened to the file is a delete.
However, the file isn't deleted; it's alive and well. git log without
--follow does not list this commit at all.

So either git log --follow is listing a delete commit that doesn't make
sense, or it's missing whatever commit put it back into place afterwards.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
