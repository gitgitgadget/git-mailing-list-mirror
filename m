Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5AB207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 12:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbcJIMsD convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 9 Oct 2016 08:48:03 -0400
Received: from mail.pdinc.us ([67.90.184.27]:49228 "EHLO mail.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbcJIMsC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 08:48:02 -0400
Received: from black7 (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail.pdinc.us (8.14.4/8.14.4) with ESMTP id u99Cm1tc020617;
        Sun, 9 Oct 2016 08:48:01 -0400
Reply-To: <git@vger.kernel.org>,
          =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "=?UTF-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>
References: <7E06D61EACFB462AB96DD60720930968@black7> <c9c90c24-3bf7-cd57-cad6-db28db16f323@web.de>
In-Reply-To: <c9c90c24-3bf7-cd57-cad6-db28db16f323@web.de>
Subject: RE: A head scratcher, clone results in modified files (tested linux and cygwin) - .gitattributes file?
Date:   Sun, 9 Oct 2016 08:48:00 -0400
Organization: PD Inc
Message-ID: <B539E7023E19454A80C564A234BA9014@black7>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdIiGB0a5TcYwI8URwOlr6npe3u/lQAEWpMA
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.23403
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Torsten Bögershausen
> Sent: Sunday, October 09, 2016 06:27
> 
> On 09/10/16 08:48, Jason Pyeron wrote:
> 
> 
> The whole .gitattributes needs to be adopted, I think
> 
> Git 2.10 or higher has "git ls-files --eol":
> 
> git ls-files --eol   | grep "i/crlf.*auto"
> i/crlf  w/crlf  attr/text=auto src/site/xdoc/upgradeto2_3.xml
> i/crlf  w/crlf  attr/text=auto 
> src/test/resources/org/apache/commons/io/FileUtilsTestDataCRLF.dat
> i/crlf  w/crlf  attr/text=auto src/test/resources/test-file-gbk.bin
> i/crlf  w/crlf  attr/text=auto 
> src/test/resources/test-file-iso8859-1-shortlines-win-linebr.bin
> i/crlf  w/crlf  attr/text=auto 
> src/test/resources/test-file-utf8-win-linebr.bin
> i/crlf  w/crlf  attr/text=auto 
> src/test/resources/test-file-windows-31j.bin
> i/crlf  w/crlf  attr/text=auto 
> src/test/resources/test-file-x-windows-949.bin
> i/crlf  w/crlf  attr/text=auto 
> src/test/resources/test-file-x-windows-950.bin
> ############
> Problem:
> xml file had been commited  with CRLF : either normalize it 
> or declare "-text".
> 
> The same is valid for the other files as well.
> They are identified by auto as text, and commited with CRLF.
> My feeling is that they should be declared as "-text".
> Or, to be more compatible, with "-crlf":
> 

Good call.

> Solution:
> Make up your mind about the xml file and the html files.
> If they are text, they need to be normalized.
> 
> 
> Question:
> What happens, if you do this:
> # Auto detect text files and perform LF normalization
> *        crlf=auto
> 
> *.bin    -crlf
> *.dat    -crlf

*.bin     -text
*.dat     -text

#fix that issue

> *.java   crlf diff=java
> *.html   crlf diff=html
> *.css    crlf
> *.js     crlf
> *.sql    crlf
> 

Or create a subordinate

src/test/resources/.gitattributes:
*        -text

Since these are "test" resources, some with text extensions from above.

Thanks!

-Jason

