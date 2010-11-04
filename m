From: Jonathan Nieder <jrnieder@gmail.com>
Subject: error: git checkout-index: unable to write file
Date: Thu, 4 Nov 2010 14:00:07 -0500
Message-ID: <20101104190007.GA17101@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 20:00:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE537-0003tT-10
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 20:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab0KDTAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 15:00:33 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60118 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab0KDTAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 15:00:31 -0400
Received: by gwj21 with SMTP id 21so1677975gwj.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=8oA2+mTHo4uqEJ50Cm5JftKQ2c0lDC+kGefbdPj1fLg=;
        b=oydxBeotDDElw5ebnX1Nbuty/cazje3YdYP1E23dKpdlpVOInrdKbHBrlTe0D0AZfx
         anSootY0pHwuFrf0zNKg3KkpFd1pT9skwWgCr5sGvpS6AZB9DKN0EJdKBAbJHZ/xmgJP
         1eATJKdbR+XoxDyv8XcEz7p1GsrvgOKi362uI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=J/OuSXxyaLuc820LXPRXa7WHF70Vgw9MR7SX/n+8ciNtyN+ANdc0gmS15ufJt7vQFj
         +Pq3WEUgFu0CACN3b1lLpmY5x8eI64dzNzMPnnwRMOsRasr0PJPZG+0iyP4S0j0uCKIo
         C7b6tq9bQA4BQMoEkAsr6O7YzJ9WcwqNziUMU=
Received: by 10.223.86.197 with SMTP id t5mr100082fal.38.1288897230629;
        Thu, 04 Nov 2010 12:00:30 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id y13sm186848fah.2.2010.11.04.12.00.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 12:00:30 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160749>

Hi gitsters,

Just tried cloning an enormous repo to /tmp (which uses tmpfs)
and got

 error: git checkout-index: unable to write file webkit/tools/test_shell/resources/textAreaResizeCorner.png
 error: git checkout-index: unable to write file webkit/tools/test_shell/run_all_tests.cc
 error: git checkout-index: unable to write file webkit/tools/test_shell/simple_appcache_system.cc
 error: git checkout-index: unable to write file webkit/tools/test_shell/simple_appcache_system.h

[etc].

Maybe we can do better?  It seems non-ideal in a few ways:

 1) it is not checkout-index but read-tree -m that prints the message
 2) errno is forgotten
 3) I would prefer if "git clone" errored out quickly for ENOSPC instead
    of continuing to fill in the cracks with what small files it can
    find.  Though I suppose the current behavior is better for errors
    like EPERM and ENAMETOOLONG, so I can't complain much.
