From: Kris Shannon <kris@shannon.id.au>
Subject: Problem with git bundle creation
Date: Wed, 13 Oct 2010 12:58:20 +1100
Message-ID: <AANLkTimsMgsuiS4iT2z_ggD8t0V9xj7ezwxRHk9WgaOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 03:58:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5qc3-0008GY-4B
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 03:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab0JMB6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 21:58:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64254 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab0JMB6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 21:58:23 -0400
Received: by bwz15 with SMTP id 15so2878198bwz.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 18:58:21 -0700 (PDT)
Received: by 10.204.176.144 with SMTP id be16mr7134390bkb.53.1286935100150;
 Tue, 12 Oct 2010 18:58:20 -0700 (PDT)
Received: by 10.204.131.210 with HTTP; Tue, 12 Oct 2010 18:58:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158902>

git clone git://github.com/freenet/fred-official.git
git bundle create bad.gitbundle -1 build01194
head -2 bad.gitbundle

Problem manifested by a commit message which happens to have a hyphen
in just the wrong place such that git rev-list --boundary
--pretty=oneline has a line which exceeds the 1024 buffer limit that
git bundle is using for reading and happens to read in the rest of the
commit messsage as a boundary commit.

git bundle should probably be checking that the fgets buffer actually
ends in a newline and if it doesn't then slurp in more until it does
(probably discarding it in the process)
