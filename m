From: Will Palmer <wmpalmer@gmail.com>
Subject: [BUG] git-svn parses --pretty=medium log output, fails when
 log.decorate is true
Date: Tue, 05 Oct 2010 11:18:46 +0100
Message-ID: <1286273926.2364.6.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 05 12:18:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P34bo-0001mO-JC
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 12:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421Ab0JEKSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 06:18:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58786 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab0JEKSv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 06:18:51 -0400
Received: by wyb28 with SMTP id 28so5851069wyb.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=ABU7RN0ZKEZbCT5yWq2RL+hW7JiCg9f6INV9/l76daE=;
        b=i2NLL6qbRNJODa81NJ1GnaqbttVQlLDEPy3UgrhsKH7byDaSAorVmeh3BrKhs6oLYi
         k9oUY3zhtVlPooZTA9ihpRR9a3rgSQw177/4ncTqP7t/EqBRi9y475Xse4754kWI7uxb
         QmbnBJDGTNx5Lf6AWbkNK8MEdF4ctGaXrjZfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=gsoMhBUbv0XYwLtqfzDwsUR/HNA9PCFACqu8Ck8u4JMttqBGi476QOusO0t9h/z4bE
         ekY6WRAKCobDfaeNRuvfaFQBYok3yxzyl5EGVNeML2DTl+/3KidncVgAbSuNIERifzq3
         OxB+sktzxo/tR57eh1nlDQZF4pdSe9uJj6tu4=
Received: by 10.227.180.205 with SMTP id bv13mr9403989wbb.39.1286273929779;
        Tue, 05 Oct 2010 03:18:49 -0700 (PDT)
Received: from [192.168.2.64] (09020403.dsl.redstone-isp.net [193.164.118.24])
        by mx.google.com with ESMTPS id bj11sm5198037wbb.10.2010.10.05.03.18.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 03:18:48 -0700 (PDT)
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158184>

I started receiving this error during "git svn dcommit" today:

Use of uninitialized value $hash in string eq
at /home/wpalmer/libexec/git-core/git-svn line 1534.

Examining that section reveals that git-svn is running 
"git log --no-color --first-parent --pretty=medium"

and parsing the output in order to find commit hashes and git-svn-id:
lines. This breaks when log.decorate is true.

This could be patched-up by adding "--no-decorate" to the options
git-svn passes, but that seems to me like it would just be adding to the
pile, as "--pretty=medium" is a moving target. I assume the correct
solution is to specify the format exactly as it is expected.
