Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55962C43219
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 16:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJLQmf convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 12 Oct 2022 12:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJLQmd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 12:42:33 -0400
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 09:42:31 PDT
Received: from mail.am-soft.de (mail.am-soft.de [157.90.39.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A85BB05B
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:42:30 -0700 (PDT)
Received: from mail.am-soft.de (localhost [127.0.0.1])
        by mail.am-soft.de (Postfix) with ESMTP id 2AFC9547D9DF;
        Wed, 12 Oct 2022 18:36:01 +0200 (CEST)
Envelope-To: git@vger.kernel.org
Received: from bit02ex.bitstoregruppe.local (exchange01.bitstore.group [116.202.141.225])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.am-soft.de (Postfix) with ESMTPSA id 246C8547D9DD
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 18:36:01 +0200 (CEST)
Received: from tschoening-nb.fritz.box (46.28.86.14) by bit02ex.bitstoregruppe.local (192.168.254.21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 12 Oct 2022 18:35:59 +0200
Date:   Wed, 12 Oct 2022 18:35:51 +0200
From:   =?utf-8?Q?Thorsten_Sch=C3=B6ning?= <tschoening@am-soft.de>
Organization: AM-SoFT IT-Service - Bitstore Hameln GmbH
Message-ID: <1681596318.20221012183551@am-soft.de>
To:     <git@vger.kernel.org>
Subject: How to best maintain directories like /etc/sysstat in GIT?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [46.28.86.14]
X-ClientProxiedBy: bit02ex.bitstoregruppe.local (192.168.254.21) To bit02ex.bitstoregruppe.local
 (192.168.254.21)
X-C2ProcessedOrg: 0ff26194-4f6a-446b-ba8c-65299b4f97ea
X-AV-Checked: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I'm using SVN to maintain lots of different host specific configs like
crontab files, web server configs and the directory /etc/sysstat. The
current approach is to simply have some directory structure in trunk
named by topics like /trunk/Mail/Postfix for some reference host, if
any makes sense at all. That config is then copied to e.g.
/tags/Mail/Postfix/some.other.host and Postfix for that host
maintained in that writable tag.

GIT doesn't have writable tags, which might be worked around using
branches or one repo per host or stuff. The more important difference
is that SVN can have a working copy for each and every maintained
directory. So one can really make /etc/postfix or /etc/sysstat a
wroking copy and maintained that only, without additionally necessary
subdirs and without having .svn in /etc or alike. AFAIK that is not
possible in GIT, even with sparse checkouts one needs a subdir of
some kind, which is pretty incomplatible with many system wide
configs. Unless one wants to put .git into / or /etc or alike, which
is what I would loike to avoid.

Any useful suggestions for workarounds?

I can only think of two things: Putting the GIT clone somewhere and
link directories into that. Which won't work very well for directories
for which I only want to maintain some and not all files and seems
like a lot of work, might break package management etc.

The other thing I have in mind is using branches and their implicit
available ROOT. So I would create /etc/sysstat as branch name, clone
some repo into /etc/sysstat and checkout the corresponding branch
name. That branch would only contain the files for that directory. For
other directories other branch names would need to be created. The
problems I see are with introducing host names, branch name lengths
and stuff.

Any further ideas? Thanks!

Mit freundlichen Grüßen

Thorsten Schöning

-- 
AM-SoFT IT-Service - Bitstore Hameln GmbH
Mitglied der Bitstore Gruppe - Ihr Full-Service-Dienstleister für IT und TK

E-Mail: Thorsten.Schoening@AM-SoFT.de
Web:    http://www.AM-SoFT.de/

Tel:   +49 5151-  9468- 0
Tel:   +49 5151-  9468-55
Mobil: +49  178-8 9468-04

AM-SoFT IT-Service - Bitstore Hameln GmbH, Brandenburger Str. 7c, 31789 Hameln
AG Hannover HRB 221853 - Geschäftsführer: Janine Galonska


Für Rückfragen stehe ich Ihnen jederzeit zur Verfügung. 

Mit freundlichen Grüßen, 

Thorsten Schöning


Telefon: +49 5151 9468-55
Fax: 
E-Mail: TSchoening@am-soft.de

AM-Soft IT-Service - Bitstore Hameln GmbH
Brandenburger Straße 7c
31789 Hameln

Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte Informationen und ist ausschliesslich für den Adressaten bestimmt. Jeglicher Zugriff auf diese E-Mail durch andere Personen als den Adressaten ist untersagt. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtümlich erhalten haben, informieren Sie bitte sofort den Absender und vernichten Sie diese E-Mail. Sollten Sie nicht der für diese E-Mail bestimmte Adressat sein, ist Ihnen jede Veröffentlichung, Vervielfältigung oder Weitergabe wie auch das Ergreifen oder Unterlassen von Massnahmen im Vertrauen auf erlangte Information untersagt. 

This e-mail may contain confidential and/or privileged information and is intended solely for the addressee. Access to this email by anyone else is unauthorized. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited and may be unlawful. 

Hinweise zum Datenschutz: bitstore.group/datenschutz



