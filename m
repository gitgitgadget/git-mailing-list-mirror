From: Mark Levedahl <mlevedahl@gmail.com>
Subject: builtin git-bundle - pack contains many more objects than required
Date: Mon, 05 Mar 2007 23:17:04 -0500
Message-ID: <45ECEB40.4000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Johannes.Schindelin@gmx.de, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 05:17:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOR7M-0002bl-W5
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 05:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933921AbXCFERK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 23:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933928AbXCFERJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 23:17:09 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:16157 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933929AbXCFERG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 23:17:06 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1787203wxd
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 20:17:05 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=HGKwc4slKg6u6cSxwF5jhHXVfL8KnsQtbV121cQ0+6Z3yFzbMpNfm20Jok8eBFj/Fcb7k9Fax5nrobbO7loKSH3LKz1b5JAXO3yLzttrEZr55Gs1K0B+PJ7b0u8QzL0zh+UUNZTfE6sF5QT78BIIiQI/C/z4EH7hod+CpRFEM3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=J4PcwVnJgIBsnLbRjnJid+oObvRWWExwBY0um5x+RLT9AASBfCi7Yxz4EWj4qVR+4ZQF3kS/XwMimttvp5xBDKDJD2e1EkuPmU3P3MdznPZs2aK5ePAKgI9xYzHz52+2K77sspRi5rrQijHjCytn9i2+CkdtCUM5kklEzBjCmug=
Received: by 10.70.73.12 with SMTP id v12mr7129158wxa.1173154625341;
        Mon, 05 Mar 2007 20:17:05 -0800 (PST)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id 38sm13886667wrl.2007.03.05.20.17.02;
        Mon, 05 Mar 2007 20:17:02 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41536>

builtin-bundle in version v1.5.0.3-271-g5ced057 (commit 
5ced0572217f82f20c4a3460) (and probably before) includes far more 
objects in the pack than are actually necessary. Comparison to the 
original shell scripts I wrote shows the prerequisites and refs always 
agree between those (and that is what I tested before), so the problem 
is apparently in the arguments as passed to pack-objects. I confess to 
not understanding the revision walking code called from 
builtin-bundle.c, so I do not have a patch.

However, a simple example:

git>git-rev-list --objects HEAD~1..HEAD
5ced0572217f82f20c4a3460492768e07c08aeea
1d30eaabe4b6f7218e4e4cfff5670a493aa7358e
2a1d6a2be1511f65b601897f05962e5f673257d8 contrib
cbd77b2f57114d4fa2f119f1b1ee17968d6d67d4 contrib/emacs
8554e3967cc692c6916e5aee35952074d07e8bf0 contrib/emacs/Makefile

shows that the bundle for this case should have five objects as shown. 
In this case, 916 objects are actually included in the pack when executing

git bundle create test.bdl HEAD~1..HEAD

Mark
