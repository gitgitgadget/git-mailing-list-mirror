From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: bug? 'git log -M100' is different from 'git log -M100%'
Date: Tue, 18 Dec 2012 05:04:46 +0530
Message-ID: <20121217233446.GA5987@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 01:34:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkl8k-00051z-VZ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 01:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab2LRAeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 19:34:18 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:49079 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab2LRAeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 19:34:17 -0500
X-Greylist: delayed 3559 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2012 19:34:17 EST
Received: by mail-da0-f43.google.com with SMTP id u36so9301dak.30
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 16:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=a+IMCG11A0lj5VgsIEYcJrYn9R77StJ1PAadpQNal6k=;
        b=YHRkSFTJ1JFKb3RSKAxUSNerD1iFIVVZk8i175W2MNwEOaeZAtWaCErzi7kWPocwMO
         zKUU9v0pmj2LlOF5ik+k9cr3PihpWWTx1tPsuEHbHdCFaYWBV5hGqc3br9SkTleb0TrN
         Tj3vd0SFxawQwy6j9Si86/52PbFoZjJO9oToveaxpjadgf1jrIVD7PcaCOzzXDrBIaMa
         PYX0+uCIL++K0VwQvGPf8H4i9hVX7HawJMwAmBOPyIuAzTE/S/Di9KvC3h81QtRBH91V
         uUfSgoWA4fBI3ccqvYNuTVvufyLWhuTYNfMi7a9H0CMxy5DFNaBLoFYeYdpnEVbKXD2h
         dYZQ==
X-Received: by 10.68.232.195 with SMTP id tq3mr139054pbc.70.1355787298149;
        Mon, 17 Dec 2012 15:34:58 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.173.130])
        by mx.google.com with ESMTPS id bh9sm217332pab.12.2012.12.17.15.34.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Dec 2012 15:34:57 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211723>

Hi,

When using -M with a number to act as a threshold for declaring
a change as being a rename, I found a... quirk.  Any 2-digit
number after the M will work, but if the number is 100, it will
require a % to be appended to be effective.

Here's a transcript that will demonstrate the problem when run
in an empty directory.

    # setup
    git init
    seq 1 100 > f1
    git add f1
    git commit -m f1
    git rm f1
    ( seq 1 45; seq 1001 1010; seq 56 100 ) > f2
    git add f2
    git commit -m f2

    # here's the buglet

    git log -1 --stat --raw -M
    # this tells you the files are 83% similar

    git log -1 --stat --raw -M82
    # this shows it like a rename

    git log -1 --stat --raw -M83
    # this also

    git log -1 --stat --raw -M84
    # this shows two separate files

    git log -1 --stat --raw -M99
    # this also

    # so far so good...

    git log -1 --stat --raw -M100
    # but this shows it like a rename

    git log -1 --stat --raw -M100%
    # adding a percent sign fixes it, now they're two separate
    # files.  It seems to be required only when you ask for 100%

-- 
Sitaram Chamarty
