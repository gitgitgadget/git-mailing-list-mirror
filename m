From: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Subject: [StGit] import --mail/--mbox question
Date: Thu, 15 Jan 2009 00:35:50 +0900
Message-ID: <496E0656.2090705@ruby.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 16:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN867-0007Lm-Sd
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 16:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbZANPyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 10:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbZANPyc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 10:54:32 -0500
Received: from smtp13.dti.ne.jp ([202.216.231.188]:34275 "EHLO
	smtp13.dti.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbZANPyb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 10:54:31 -0500
X-Greylist: delayed 1119 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jan 2009 10:54:30 EST
Received: from shinya-kuribayashis-macbook.local (PPPa2728.tokyo-ip.dti.ne.jp [61.195.15.228]) by smtp13.dti.ne.jp (3.11s) with ESMTP AUTH id n0EFZoih028642 for <git@vger.kernel.org>; Thu, 15 Jan 2009 00:35:50 +0900 (JST)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105647>

Hi,

I've been wondering this for quite some time, now try to sort out.

---

Question: when importing Mozilla Thunderbird mails (eml or mbox), the
imported patch always have committer's date in git log, not submitter's
date.  However, if importing the same mails with git am, we could see
submitter's date in git log.

Is this intentionally-designed log management of StGit?  I would expect
the submitter's date & locale is kept when importing patches from
e-mails.

Reproducible: Always

Steps to Reproduce:

1. Prepare eml or mbox file.

  [Thunderbird eml file]
   - Select a mail,
   - File -> Save as -> File, 
   - Format -> Mail files

  [mbox file]
   - use add-ons, such as ImportExportTools(MboxImport)
   - extract directly from profile/ dir

2. Import eml/mbox file with --mail/--mbox option

  $ stg import --mail [eml file]
  $ stg import --mbox [mbox file]

3. Check git log

Example:

  Mbox header (this mbox contains one patch)
  ------------------------------------------
  From - Wed Jan  7 00:41:57 2009
  X-Account-Key: account3
  X-UIDL: 6d997fc0c53b4541c56eeeeb45732171
  X-Mozilla-Status: 0001
  X-Mozilla-Status2: 00000000
  X-Mozilla-Keys:                                                                                 X-DTI-Virus-Check: checked
  X-DTI-Recipient: <skuribay@ruby.dti.ne.jp>
  Return-Path: <sr@denx.de>
  Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.126.188]) by pop.ruby.dti.ne.jp (3.10p) with ESMTP id n06AZr2v009835 for <skuribay@ruby.dti.ne.jp>; Tue, 6 Jan 2009 19:35:53 +0900 (JST)
  Received: from localhost.localdomain (p5B2A461A.dip.t-dialin.net [91.42.70.26])
          by mrelayeu.kundenserver.de (node=mrelayeu1) with ESMTP (Nemesis)
          id 0MKwpI-1LK9Hn0ym1-0002Ja; Tue, 06 Jan 2009 11:35:51 +0100
  From: Stefan Roese <sr@denx.de>
  To: u-boot@lists.denx.de
  Cc: skuribay@ruby.dti.ne.jp
  Subject: [PATCH 1/3 v2] MIPS: Add VCT board series support (Part 1/3)
  Date: Tue,  6 Jan 2009 11:35:46 +0100
  Message-Id: <1231238146-2813-1-git-send-email-sr@denx.de>
  X-Mailer: git-send-email 1.6.1
  X-Provags-ID: V01U2FsdGVkX19dTpfkGdmBDPbfKKBfEQYFLGbts7teQcJyLTZ
   xUdZWxGujKNfCpOIRv/s7i7nrf13E4zGP6P0nibSP6yFfDLBv3
   0qZDbTBuPI1ViEQrnIGZCASl9Z6H8em

  This patch adds support for the Micronas VCT board series.
  Currently the following platforms are supported:
  :
  :

  Resulting git log
  -----------------
  commit b659910dd0d75220c3cdbd3408a5025340e6a562
  Author: Stefan Roese <sr@denx.de>
  Date:   Thu Jan 15 00:06:27 2009 +0900 <-- this is my date & locale(JP)

      MIPS: Add VCT board series support (Part 1/3)

      This patch adds support for the Micronas VCT board series.
      Currently the following platforms are supported:

        vct_premium
        vct_premium_small
        vct_premium_onenan
  :
  :

Version:

  Stacked GIT 0.14.3.327.ge4f6.dirty
  git version 1.5.4.3
  Python version 2.5.2 (r252:60911, Jul 31 2008, 17:28:52) 
  [GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]


Thanks in advance,

  Shinya
