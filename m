From: Tarmo =?ISO-8859-1?Q?T=E4nav?= <tarmo@itech.ee>
Subject: diff.noprefix breaks rebase
Date: Tue, 31 Aug 2010 15:53:05 +0300
Message-ID: <1283259185.24737.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 15:25:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqQpw-0003OM-C4
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 15:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab0HaNZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 09:25:07 -0400
Received: from ns1.itech.ee ([212.47.220.100]:50113 "EHLO mail.itech.ee"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753345Ab0HaNZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 09:25:06 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Aug 2010 09:25:06 EDT
Received: from localhost (unknown [127.0.0.1])
	by mail.itech.ee (Postfix) with ESMTP id 06FD01577CF
	for <git@vger.kernel.org>; Tue, 31 Aug 2010 13:17:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at itech.ee
Received: from mail.itech.ee ([127.0.0.1])
	by localhost (fondo.itech.ee [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9LhDCUp0g7v3 for <git@vger.kernel.org>;
	Tue, 31 Aug 2010 16:16:21 +0300 (EEST)
Received: from [192.168.1.65] (88-196-191-152-dsl.trt.estpak.ee [88.196.191.152])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: tarmo)
	by mail.itech.ee (Postfix) with ESMTPSA id ACAE71574C7
	for <git@vger.kernel.org>; Tue, 31 Aug 2010 15:55:49 +0300 (EEST)
X-Mailer: Evolution 2.30.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154899>

Hi,

It seems that diff.noprefix causes rebase to misplace files that exist
in paths that have names similiar to the git diff default prefixes. So a
commit that adds /db/somefile will after a rebase place the file
into /somefile. 

Example test-case below:

mkdir test
cd test
git init
touch x
git add x
git commit -m x
touch z
git add z
git commit -m z
mkdir db
touch db/y
git add db
git commit -m db
git config diff.noprefix true
git rebase --onto master^^ master^ master
ls -R
.:
x  y

expecting to see:
ls -R
.:
db  x

./db:
y


Regards,
Tarmo
