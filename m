From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/3] git-p4: fixing --changes-block-size handling
Date: Sun,  7 Jun 2015 22:35:02 +0100
Message-ID: <1433712905-7508-1-git-send-email-luke@diamand.org>
References: <55747A05.3070704@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 23:36:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1iEn-0007IA-NC
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 23:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbbFGVf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 17:35:57 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33049 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbFGVfz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 17:35:55 -0400
Received: by wgez8 with SMTP id z8so89508156wge.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 14:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=et24w6rI5s59vr1lWLevOUTsj9FKQkT0YcaBEkzf6L8=;
        b=JXALrLi0W0LlUu99ZBLG/E83MDU6KKHJ3HmdkC/o026NTK7fc5QHxe0WZZ+tkp4/2W
         GYyufaDqq4WIQw3ZSznIxmy7wC0tQ1eObnsVW4qE3tg2Mbt2dCbHJYfX5Fxi20h8Kk+I
         qtUyZferIG1ehkPOBlG8KavOL/HzJyi3Txz/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=et24w6rI5s59vr1lWLevOUTsj9FKQkT0YcaBEkzf6L8=;
        b=FPI4XG0vuX1AWDOMba85E5x6HAPD6romb2lrGcYRXEBpxW2F8UZfYM49HsV4yjcTnP
         DvXDV0MIdtTZeclZ6VnkcJrc6clbKaSiRsYUauM4OK4J/rKNMeQWAwcJg/buQSk6HKeS
         Vzii7se2sGJlKQPLXr8/qBxcmUJTRant2yzlvmjR+RuFuycjIcd2SK38C3S+rnfZMSZ7
         gqAqILOHfkyyRYyYLT2pSvWVahDGiFvT8iXrX/e8tslfAd/irjvebrCVoMtAMIN/NLcB
         VSPV2EJP0e9B6Vszc/cOonRAzKbgd2dQMhJfs4wKapnGEJsGv4Zc+LV4SzrBidXeG7V1
         5m+w==
X-Gm-Message-State: ALoCoQnKP+eEK/C0+8YJQBA+EiZ2sLpGy8NmRExKCCmaxzPsGVZwG30Sp09MZIDBLrf74HAFI86E
X-Received: by 10.194.90.171 with SMTP id bx11mr25143878wjb.129.1433712954429;
        Sun, 07 Jun 2015 14:35:54 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id w11sm1140489wjr.48.2015.06.07.14.35.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2015 14:35:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <55747A05.3070704@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270981>

Updated per Lex's suggestion, so that git-p4 always uses the block mode,
and takes advantage of this to simplify the loop. This exposed a bug
in the termination condition.

One thing to note: 'git p4 sync' claims to support arbitrary p4 revision
specifications. I need to check that this is tested and hasn't been broken
by these changes.

Luke

Luke Diamand (3):
  git-p4: additional testing of --changes-block-size
  git-p4: test with limited p4 server results
  git-p4: fixing --changes-block-size handling

 git-p4.py               | 45 ++++++++++++++++++------------
 t/t9818-git-p4-block.sh | 73 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 92 insertions(+), 26 deletions(-)

-- 
2.4.1.502.gb11c5ab
