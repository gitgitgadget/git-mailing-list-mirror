From: Luke Diamand <luke@diamand.org>
Subject: [BUG] git-p4 can't cope with dollars in filenames
Date: Fri, 23 Sep 2011 20:38:59 +0100
Message-ID: <4E7CE053.2020309@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 23 21:39:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Bai-0006iO-PH
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 21:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907Ab1IWTjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 15:39:05 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55788 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab1IWTjD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 15:39:03 -0400
Received: by wwf22 with SMTP id 22so4093141wwf.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 12:39:02 -0700 (PDT)
Received: by 10.227.10.201 with SMTP id q9mr4020269wbq.68.1316806742400;
        Fri, 23 Sep 2011 12:39:02 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id gd6sm17919624wbb.1.2011.09.23.12.39.00
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 12:39:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181995>

Hi!

If you have a dollar in a filename and attempt to submit it to Perforce 
via git-p4 it fails.

e.g. this sequence:

% touch foo\$bar.c
% git commit -m 'whatever' foo\$bar.c
% git-p4 submit

....
....
Submit aborted -- fix problems then use 'p4 submit -c 3'.

The problem is all the places that use the git-p4 read_pipe() function, 
which is a wrapper around os.popen(). popen() does shell expansion which 
does hilarious things to files with dollars in their name.

You can have hours of fun and entertainment with this. Adding a file 
called foo\`fortune\`.h is especially amusing.

I'm going to try to come up with a fix for this.

Luke
