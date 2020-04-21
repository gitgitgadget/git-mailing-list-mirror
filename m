Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18662C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 21:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E853920724
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 21:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgDUV0d convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 21 Apr 2020 17:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726124AbgDUV0c (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 17:26:32 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Apr 2020 14:26:32 PDT
Received: from herc.mirbsd.org (herc.mirbsd.org [IPv6:2001:470:1f15:10c:202:b3ff:feb7:54e8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AFFAC0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 14:26:32 -0700 (PDT)
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 03LKHB0O009418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 20:17:14 GMT
Date:   Tue, 21 Apr 2020 20:17:11 +0000 (UTC)
From:   Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To:     git@vger.kernel.org
Subject: =?utf-8?Q?Missing_=E2=80=9Cgit_diff=E2=80=9D_functionality?=
Message-ID: <Pine.BSM.4.64L.2004212007350.25168@herc.mirbsd.org>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I’d like to ask whether adding two, if not three, functionalities
to “git diff” is possible and has any takers.

The first two are relatively straightforward and already exist
in at least GNU diff (as incorporated in GNU CVS, for example).


       -I, --ignore-matching-lines=RE
              ignore changes where all lines match RE

I use this like
	cvs diff -uprOLDTAG -I '[$]OtherBSD:.*[$]'
and missed this in git dearly.


       -x, --exclude=PAT
              exclude files that match PAT

       -X, --exclude-from=FILE
              exclude files that match any pattern in FILE

I used to do 'diff -pruN -x CVS -x .git cvscheckout gitcheckout | less'
but have recently become accustomed to…
  alias cdiff='git diff --color=always --no-index --no-prefix'
  alias cwdiff='git diff --color=always --no-index --no-prefix --word-diff'
  alias cwdiffc='git diff --color=always --no-index --no-prefix --word-diff-regex=.'
… and doing a 'cdiff cvscheckout gitcheckout' lacks this exclusion.


Thirdly, there’s some functionality in GNU diff to make the content
not begin at the second/third column but at the eigth, so tabs don’t
break in the output. The resulting diff is obviously not a valid
unidiff, but…

@@ foo @@
     if (bar)
-	baz(1);
+        baz(2);

… reads different from…

@@ foo @@
	    if (bar)
-		baz(1);
+	        baz(2);

… and while only the first one is unidiff, the second one has its
uses (especially in plaintext files with tab-formatted tables) for
human consumption. Basically, you replace the leading space with
a HT for unchanged lines and add one after the +/- for the others.


Thanks for your consideration,
//mirabilos

PS: https://github.com/mirabilos/git-find still wishes to be
    merged into git.git (I asked for this… years ago?), and
    https://github.com/mirabilos/recvhook/tree/standalone is
    my merge-back-able attempt at improving post-receive-email
    which got neglected upstream and wants back…
-- 
„Cool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
mksh auf jedem System zu installieren.“
	-- XTaran auf der OpenRheinRuhr, ganz begeistert
(EN: “[…]uhr.gz is a reason to install mksh on every system.”)
