From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Breaking the ref-transactions-reflog series in smaller parts
Date: Wed, 19 Nov 2014 13:40:22 -0800
Message-ID: <1416433224-29763-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org,
	mhagger@alum.mit.edu, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 19 22:40:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCzT-0000Oz-CB
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265AbaKSVkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:40:37 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64094 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757256AbaKSVkb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 16:40:31 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so1511237iec.10
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 13:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YBVEWoRf+QGTbmsD1zgb4npfyCLTX1sBS30LzJPN8B4=;
        b=ATPHTctx8s6sMY5GmT8V3M+BaZZt+8NEUgrJEhOD+YjD+B9ShpA6LqLS6zIQpsZW7U
         h41ycMAPkdSnCIq75W88nkoiKp+tOerQUsxP7wFVKnEGd6txqMESYdw3ySHBAzIC7GTg
         k9KZSJ7pGH7l5m+A6QcaGAOsFggxv33JoKxTT2x6lSDfjeUAjVL1uJyLnr+PmQbs/T16
         cIY/G99BLwH5VZUtqrWIlBNqH1BZTl29kMR2H8FXK6m4fATjhH5+TOaqecjJvTDZQ+Nw
         Bi6DPpDwRWY2ZwiJtXofODMWEbDFz99xnluy/Z4DmFrwBPueMUU5ERKV+uwfA2C3LjZN
         V0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YBVEWoRf+QGTbmsD1zgb4npfyCLTX1sBS30LzJPN8B4=;
        b=H1D8pxjPSkMEViqAeai1IjPJ8pw1BnE3JK0MTeawoyzWtDOKezXU5fxZxLwQ06PlnP
         vECEAw+hPZG4uUd6qGwcxia9HDSi5ab1XT2ILOt2lKR0oXxMQOBWDQl6nokUV51RVrV0
         HCZziYOnTdcU+YbKvW8z0mhu142V8vmzYswIzPeUvMJtf2j52FOnIziiFqTrXQmY8Gok
         HrMsuvp4NWj6ExmYlqWaDpGD3L1NhY1wJEY+d4igaxcBaYFYXYw8rJhaesBnG2St+Tjs
         as1WDfuqPPPYHHfvg5MgpfcTHd6R+lbJMIrp4JaBOVlMZg7AuAdg7jxBQBbh9jpPUs1W
         hTnA==
X-Gm-Message-State: ALoCoQnbM36pOCe8xxn75D9kBO1yAoOLpdzSlJhTlN5oikhxoCD7w1KvbhccLdmHCy7K7YDs3wKy
X-Received: by 10.50.43.225 with SMTP id z1mr12456983igl.29.1416433230537;
        Wed, 19 Nov 2014 13:40:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:7876:7c52:1268:8374])
        by mx.google.com with ESMTPSA id j62sm246939ioj.1.2014.11.19.13.40.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 13:40:30 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.13.g0786cdb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

so I think the patch series ref-transactions-reflog[1] sent previously to the list
is still too large for easy review and I want to break it up more.
So in this series we'll digest only 2 small patches, which do not seem to be 
controversial (yet;) and seem to be useful no matter how the discussion on
the other series continues.

ref_transaction_create as well as ref_transaction_delete are just special cases
of ref_transaction_update, so let's reduce some redundant code. While this doesn't
change code in pathes, which are supposed to be run, we do have slight changes 
in error messages starting with "BUG: ". So in the best case, the user will never
see these messages at all.

Thanks,
Stefan

[1] http://thread.gmane.org/gmane.comp.version-control.git/259712

Ronnie Sahlberg (2):
  refs.c: make ref_transaction_create a wrapper for
    ref_transaction_update
  refs.c: make ref_transaction_delete a wrapper for
    ref_transaction_update

 refs.c | 49 ++++---------------------------------------------
 refs.h |  2 +-
 2 files changed, 5 insertions(+), 46 deletions(-)

-- 
2.2.0.rc2.13.g0786cdb
