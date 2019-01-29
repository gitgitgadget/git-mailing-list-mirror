Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC51211B5
	for <e@80x24.org>; Tue, 29 Jan 2019 09:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfA2JZ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 04:25:56 -0500
Received: from mail-yw1-f45.google.com ([209.85.161.45]:45035 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfA2JZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 04:25:56 -0500
Received: by mail-yw1-f45.google.com with SMTP id b63so7909823ywc.11
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 01:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oZCq75gDGIxlFQZVGtMwWzTnnYW1veZFta0frIZXmzY=;
        b=tuTR4r2qlMZ0xLIBnHK8qjKvUA20pR1wx2uEQbY4QgqcVLSCqDlY7Ba6IHoZL4TxUD
         wzIsOlvfs5+RV0sfd2Y498vYzo343ErWSZtEjMDna7Fo+dFgTt4mYbGzxLSo9m69oHlJ
         pA/2vIinzEGXoQnal+i/OoxP/+KLYrOtjQoF3Qxix2zJzev9PJEeXBPiqp+q9IzWtpzi
         OznrrX4ivEW6GcrPDBGRkNXf2vHfcZK7WF80usP8/KmkAp3OTMeNZeNPkA3A5ue0EEcu
         VxK+wRIPPdOVD/pwOM+0q5ZcWY8FzjEZ22WUkVG2MAsr5snJSoVhLFVEpKg7jG+WqE6U
         4PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oZCq75gDGIxlFQZVGtMwWzTnnYW1veZFta0frIZXmzY=;
        b=JN2pWMdcrR8wxYe4qlq3v5JHO6HTMU96xfQjzhqBPvcjeboRkeT+AJsMW+KC8ZHVWl
         KBAHymelfVRw0cDA5pNaa0+aJfFxE2kCy0/gDXgAsRkhidAVB0pKokP07lMmJaUVBv6t
         0IQhHmoI7fDvPY2y5nuo4LsJQwKHuDvD2HmpNI4nmzwAjjhTIue57mHSEGJDNNbSTtyX
         OUWZ4evT49ZxiZmGwIfrBffFdU0cxF/yZIWp5dwKDy9VqqKwjBccNU0G23gUe73XuROw
         cp1e036V0gcdnk/YXkuWIZAF2iSwsvTW95Gv/tPVqhjcGMlh4PCC+kRDGxNVKCsj4LAb
         sA+A==
X-Gm-Message-State: AJcUukdTg4EZ6fnstD0DeFHryhTtMJPNgRCs0LnGzLxz+4z8WI2hgK+r
        mWDIHEfFfYQx2rONO/GiPh8n14YbYtSDTx0dcX3M+sNS
X-Google-Smtp-Source: ALg8bN4QpJWFy44WJrTnF88jJR6qNmdUTdLwDjNcIsXnPkIeuIoCQwAb/R8e/r62QkIXMUcFCddQQslEVgNNTeg5jDQ=
X-Received: by 2002:a0d:f541:: with SMTP id e62mr24793155ywf.253.1548753954534;
 Tue, 29 Jan 2019 01:25:54 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?zp3PhM6tzr3PhM6/z4IgzqPPhM6xz43Pgc6/z4I=?= 
        <stdedos@gmail.com>
Date:   Tue, 29 Jan 2019 11:25:18 +0200
Message-ID: <CAHMHMxWpqTDyCQPXPY6WPeMBHFzYGE=Z0Q8pSL=9TecwuP9fwg@mail.gmail.com>
Subject: No clear API/Error message to validate a "revision object" using git rev-parse
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there everyone,

Minor bug report:
I have a utility script to find "reference points" that contain a
commit (git-x-in-y)

The script needs to accept "any valid reference point", that includes
e.g. tags as well.
I validate said input by passing whatever argument through git rev-parse.

If the tag name is invalid, say:
$ git rev-parse version.3
version.3
fatal: ambiguous argument 'version.3': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

So, I follow the recommendation to add '--', since I know that I won't
be adding any paths:

$ git rev-parse version.3 --
fatal: bad revision 'version.3'

However, what happens with the correct tags is, I get the trailing
double dash in:
$  git rev-parse version-0.false --
d43292476ea9ab8c3d32940352b680549b64e8d8
--
$

A further leading argument, e.g. '' makes the situation worse:
$ git rev-parse version-0.false -- ''
d43292476ea9ab8c3d32940352b680549b64e8d8
--

$

`--verify`s error message is even more cryptic:
$ git rev-parse --verify version.3
fatal: Needed a single revision
$ git rev-parse --verify version-0.false
80f20b100cca5166b22cbcc1f4a6ac1eae64a0d0

Further attempts do not help either:
$  git rev-parse --revs-only version-3 ; echo $?
0
$

Am I writing the command wrong, or is there some part of it I don't understand?

Ntentos Stavros
