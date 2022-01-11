Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D886C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiAKC6E convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 Jan 2022 21:58:04 -0500
Received: from elephants.elehost.com ([216.66.27.132]:40938 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiAKC6D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:58:03 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20B2w2ru002986
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Jan 2022 21:58:02 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>
Cc:     <git@vger.kernel.org>
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com> <Ydzw+RqR6IfbT/oM@nand.local>
In-Reply-To: <Ydzw+RqR6IfbT/oM@nand.local>
Subject: RE: [BUG] Re: Git 2.35.0-rc0
Date:   Mon, 10 Jan 2022 21:57:57 -0500
Organization: Nexbridge Inc.
Message-ID: <010b01d80697$0c848770$258d9650$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIzMkomfuhrYaYzn51cwdtqNnfQqQHkNVZQq5em75A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 10, 2022 9:53 PM, Taylor Blau wrote:
> On Mon, Jan 10, 2022 at 09:20:15PM -0500, rsbecker@nexbridge.com
> wrote:
> > Hi All,
> >
> > Git 2.35.0-rc0 is not portable:
> >
> > uncompress2(uncompressed + block_header_skip, &dst_len,
> >                    ^
> > "/home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/reftabl
> > e/bloc
> > k.c", line 213: error(114):
> >           identifier "uncompress2" is undefined
> >
> > This is not a POSIX compliant call.
> 
> uncompress2() isn't a POSIX thing, it's part of zlib IIUC. The new caller is in the
> reftable code, which provides a build knob
> NO_UNCOMPRESS2 that you can use if your version of zlib does not have
> uncompress2().
> 
> uncompress2() was added to zlib back in 37281ac (Add uncompress2()
> function, which returns the input size used., 2016-11-15), which first
> appeared in version 1.2.9.
> 
> If your system doesn't have a modern-ish zlib, you may try building with that
> knob, or upgrading your system's copy of zlib. And if NonStop doesn't have a
> modern zlib available at all, we should modify the NonStop section of
> config.mak.uname.

There is no provision in reftable/block.c to avoid using uncompress2, so the knob will not help. Our zlibc is not that recent (as in it does not have uncompress2) and we cannot make the 2.35.0 timeframe to upgrade it. The current zlib seems to require gcc and is very difficult to port at this stage. This is a blocker situation.

--Randall

