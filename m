From: =?ISO-8859-15?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch,
   not .txt
Date: Thu, 18 Jan 2007 16:10:02 +0100
Message-ID: <45AF8DCA.9030008@etek.chalmers.se>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>	<87ps9d7j6t.fsf@morpheus.local>	<7vejptsglj.fsf@assigned-by-dhcp.cox.net>	<625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>	<7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>	<7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>	<81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com> <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net> <45AF6AC6.2060206@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, Josh Boyer <jwboyer@gmail.com>,
	git@vger.kernel.org, davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 16:39:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZLr-0005Ie-Md
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbXARPiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbXARPiw
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:38:52 -0500
Received: from anubis.medic.chalmers.se ([129.16.30.218]:39505 "EHLO
	anubis.medic.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbXARPiv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:38:51 -0500
X-Greylist: delayed 1727 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 10:38:51 EST
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by anubis.medic.chalmers.se (Postfix) with ESMTP id 081198C00;
	Thu, 18 Jan 2007 16:10:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.9) Gecko/20070101 Thunderbird/1.5.0.9 Mnenhy/0.7.4.666
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <45AF6AC6.2060206@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37111>

Andreas Ericsson wrote:
> Most have only "attach" through various means of point-and-click and
> drag-and-drop. Thunderbird too lacks the very basic ability of "include
> this file as part of the message". I still haven't been able to find an
> addon for it that does just that.

I use the External Editor extension with Thunderbird (it's mentioned in SubmittingPatches).

The script below is used as the external editor, which gives me an easy way to send patches
inline with Thunderbird.

/Lukas

#!/bin/bash

CONFFILE=~/.appprc

if [ -e "$CONFFILE" ] ; then
	LAST_DIR=`grep "^LAST_DIR=" $CONFFILE|sed -e 's/^LAST_DIR=//'`
	cd $LAST_DIR
else
	cd > /dev/null
fi

PATCH=$(zenity --file-selection)

if [ "$?" != "0" ] ; then
	#zenity --error --text "No patchfile given."
	exit 1
fi

cd - > /dev/null

SUBJECT=`sed -n -e '/^Subject: /p' $PATCH`
HEADERS=`sed -e '/^Subject: /d' $1`

echo "$SUBJECT" > $1
echo "$HEADERS" >> $1
sed -e '1,/^$/d' $PATCH >> $1

LAST_DIR=`dirname $PATCH`
sed -e 's@^LAST_DIR=.*@LAST_DIR='$LAST_DIR'@' $CONFFILE > $CONFFILE"_"
mv $CONFFILE"_" $CONFFILE
