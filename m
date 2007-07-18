From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] Force listingblocks to be monospaced in manpages
Date: Wed, 18 Jul 2007 22:33:57 +0100
Message-ID: <20070718213725.31383.50523.julian@quantumfyre.co.uk>
References: <m3k5sxiiib.fsf@pc7.dolda2000.com>
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 23:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBHF0-0008IU-Ei
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 23:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760332AbXGRVjH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 17:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760692AbXGRVjG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 17:39:06 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:42436 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755333AbXGRVjB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 17:39:01 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 37C9DB9A2D
	for <git@vger.kernel.org>; Wed, 18 Jul 2007 22:39:00 +0100 (BST)
Received: (qmail 27217 invoked by uid 103); 18 Jul 2007 22:38:59 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3689. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.025041 secs); 18 Jul 2007 21:38:59 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 18 Jul 2007 22:38:59 +0100
X-git-sha1: d143ec5a9834d62c96213ee97a6e3ff55ebf12a7 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <m3k5sxiiib.fsf@pc7.dolda2000.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52902>

For the html output we can use a stylesheet to make sure that the
listingblocks are presented in a monospaced font.  For the manpages do
it manually by inserting a ".ft C" before and ".ft" after the block in
question.

In order for these roff commands to get through to the manpage they
have to be element encoded to prevent quoting.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Wed, 18 Jul 2007, Fredrik Tolf wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> On Wed, 18 Jul 2007, Fredrik Tolf wrote:
>>
>>> I often read manpages using a `man -t whatever | ggv -' command, since
>>> I like how it is rendered in PostScript. However, it turns out that
>>> some things in the Git manpages don't really render very well using
>>> that method. For example, in the git-rebase manpage, there are two
>>> history graphs that look like this when reading the manpages normally
>>> in a terminal:
>>
>> It's a proportional font issue ...
>>
>> Running "groff -Tps -f C -man $(man -w git-rebase) | ggv -" should
>> display it correctly.  (The "-f C" being the part the man doesn't do)
>>
>> No idea how to make it use that font by default though ... not even
>> sure if you can put that kind of information into a man page?
>
> Well, if it were a "pure" manpage, I'd try to use pic(1) to do it for
> the PS version, but I don't suspect asciidoc has a similar feature. I
> don't actually know, though -- again, I know virtually nothing about
> asciidoc.

How about this?

Seems to work for me - but I'm not an asciidoc/docbook/roff expert ...

 Documentation/asciidoc.conf |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 6b6220d..d54fe29 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -27,7 +27,13 @@ ifdef::backend-docbook[]
 [listingblock]
 <example><title>{title}</title>
 <literallayout>
+ifdef::doctype-manpage[]
+&#10;&#x2302;ft C&#10;
+endif::doctype-manpage[]
 |
+ifdef::doctype-manpage[]
+&#10;&#x2302;ft&#10;
+endif::doctype-manpage[]
 </literallayout>
 {title#}</example>
 endif::backend-docbook[]
-- 
1.5.2.2
