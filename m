From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Decompression speed: zip vs lzo
Date: Wed, 9 Jan 2008 23:01:36 +0100
Message-ID: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 23:02:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCj0H-0007xO-0I
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 23:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbYAIWBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 17:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbYAIWBi
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 17:01:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:6522 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbYAIWBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 17:01:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so355761rvb.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 14:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=PJLYfto8QRFYqNksfApkoVsw0ICXigjgAL1GMat0RUA=;
        b=fMMICb+L4krhjGFNAX+dBMOak0ZwLjaxSoufD8ebj2F8SD0E4FuSmMTyAbAEqQJ3MCbEIBZElAebdwVyocVmyK2U+PtYIHjkP7xFVpAg+4UdAMdOG2FXUkjXnh5B6vLACMFsLjXywsPey6lhJ/BIIxvISyHJmNvzKNvmq6CfjpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=thCHrEXLX8nr8HVfEZu2MDfYiYIR+Z5ojblr3+wMG3BPgZrz/Q+h5b1tBjUaWvuiS9zi5TepXFwBuyisNrl6xv40JD2jJG/jVoRIKSZe6KP2o1viXyIxmZ+9APhMnHWZ2nYpb9mZAER462HzKyuytIzUZOPcHJEcW553UwCdJNY=
Received: by 10.141.167.5 with SMTP id u5mr758955rvo.71.1199916096912;
        Wed, 09 Jan 2008 14:01:36 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Wed, 9 Jan 2008 14:01:36 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70019>

I have created a big tar from linux tree:

linux-2.6.tar   300,0 MB

Then I have created to compressed files with zip and lzop utility (the
latter uses the lzo compression algorithm):

linux-2.6.zip  70,1 MB

linux-2.6.tar.lzo  108,0 MB

Then I have tested the decompression speed:

$ time unzip -p linux-2.6.zip > /dev/null
3.95user 0.09system 0:04.05elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+189minor)pagefaults 0swaps

$ time lzop -d -c linux-2.6.tar.lzo > /dev/null
2.10user 0.07system 0:02.18elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+234minor)pagefaults 0swaps


So bottom line is that lzo decompression speed is almost the double of zip.


Marco

P.S: Compression size is better for zip but a more realistic test
would be to try with a delta packaged repo instead of a simple tar of
source files. Because delta packaged is already compressed in his way
perhaps difference in final file sizes is smaller.
