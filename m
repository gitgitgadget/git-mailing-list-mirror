From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: git config problem with strange config files
Date: Mon, 31 Dec 2007 18:47:41 +0100
Message-ID: <200712311847.41499.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9sSeHzpS0yabeW3"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 31 18:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9Oie-00018B-Ub
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 18:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbXLaRqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 12:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbXLaRqG
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 12:46:06 -0500
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:52846 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751152AbXLaRqE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Dec 2007 12:46:04 -0500
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 6A0D34C3DB
	for <git@vger.kernel.org>; Mon, 31 Dec 2007 18:46:02 +0100 (CET)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 53BE9100C2
	for <git@vger.kernel.org>; Mon, 31 Dec 2007 18:46:02 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id EEF53103922
	for <git@vger.kernel.org>; Mon, 31 Dec 2007 18:46:00 +0100 (CET)
User-Agent: KMail/1.9.7
X-Virus-Scanned: ClamAV 0.91.2/5310/Mon Dec 31 14:06:43 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69409>

--Boundary-00=_9sSeHzpS0yabeW3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

In case of a strange .git/config file "git config key value" can create a 
bogus config entry, where one old value is wrong and the new value resides in 
the wrong section until the config file is fixed up by hand

The attached test config has a trailing tab in the last line
and no newline after that.
When git config is run the new section name is placed directly after the 
trailing tab, which corrupts the old value.

To reproduce  the error do the following:

mkdir git_test_config && cd git_test_config
git init
<copy the attached config file to .git/config>
git config section2.key bar
git config --get section2.key
-> returns nothing
git config --get section.key
-> foo [section2]
-> error: More than one value for the key section.key: bar

i tried to make a test out of this but i failed to create a config file 
without a trailing newline using here documents :-(

Tested using v1.5.4.rc2 and v1.5.4-rc2-6-gab11903

Greetings Peter

--Boundary-00=_9sSeHzpS0yabeW3
Content-Type: text/plain;
  charset="us-ascii";
  name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config"

[section]
	key = foo	
--Boundary-00=_9sSeHzpS0yabeW3
Content-Type: text/plain;
  charset="us-ascii";
  name="config_bogus"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config_bogus"

[section]
	key = foo	[section2]
	key = bar

--Boundary-00=_9sSeHzpS0yabeW3--
