From: E R <pc88mxer@gmail.com>
Subject: not all tests pass when on an NFS partition
Date: Thu, 12 Feb 2009 14:20:19 -0600
Message-ID: <3a69fa7c0902121220n4ea2f19di6fe984dd2002772@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 21:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXi4a-0000Vc-T8
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 21:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758583AbZBLUUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 15:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757966AbZBLUUX
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 15:20:23 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:56526 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758583AbZBLUUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 15:20:22 -0500
Received: by yx-out-2324.google.com with SMTP id 8so470544yxm.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=vU2apOEsrWtQ6azd0Um5D5SBlpuNNmW2pu2EWOMrZ9I=;
        b=jo8svsNa0b7g6NnkDoz/ik2WlpVMJ3BkGubbmOePPVHTj0U6p2VeTq2TMkTSGPWHiN
         QcFo53yjPNTUblHQALneAgpzqIbmsj7JOMrzLApzsYRsruMyPidd6KYbVoEjELxw4H4N
         XMSwaYuemyVR5qp1GyNYBZvtCkK0sqgq1V+h0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Tg0buIdJDT+Hwq4fSa5eRq5wXxQZs8Q1FiIjgmA4ugR//oKJSCM9PfQqi++Rwq7q+D
         9TW4m7Ms2DEJAiO8eEaoRTKymmpoIcsDJDDMw8xifj+LvdHuhzc7ml6asVZ7QH22a4re
         PzYa47u1RdZBm3HAzrs1w4S0VTEgjxRiB2HAI=
Received: by 10.100.137.12 with SMTP id k12mr1677234and.55.1234470019346; Thu, 
	12 Feb 2009 12:20:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109639>

When I run 'make test' for git-1.6.1.3 it will fail on this test when
running on an NFS partition.
Is this a known problem? Is this a real problem?

My uname -a: Linux XXX 2.6.18-92.1.17.el5 #1 SMP Tue Nov 4 13:45:01
EST 2008 i686 athlon i386 GNU/Linux


*** t5304-prune.sh ***
*   ok 1: setup
*   ok 2: prune stale packs
*   ok 3: prune --expire
* FAIL 4: gc: implicit prune --expire


                before=$(git count-objects | sed "s/ .*//") &&
                BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
                BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
                test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
                test -f $BLOB_FILE &&
                test-chmtime =-$((86400*14-30)) $BLOB_FILE &&
                git gc &&
                test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
                test -f $BLOB_FILE &&
                test-chmtime =-$((86400*14+1)) $BLOB_FILE &&
                git gc &&
                test $before = $(git count-objects | sed "s/ .*//") &&
                ! test -f $BLOB_FILE
