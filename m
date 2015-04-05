From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 0/2] git-p4: Improve client path detection
Date: Sun, 05 Apr 2015 20:27:11 +0100
Message-ID: <55218C8F.209@diamand.org>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 21:27:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeqD1-0006EU-NZ
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 21:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbbDET1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 15:27:38 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35586 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbbDET1h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 15:27:37 -0400
Received: by wgyo15 with SMTP id o15so1856194wgy.2
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 12:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=xIzS7M8GMLUegkHBYRZdBRJzgYLi/NWGMdZ70WD7qbI=;
        b=KYbr99qdgni5POCICtPHbE1ZT9W6uLo2PsIPgdjcG1DAB7VnzB5gvzJoN1NI/RBdHP
         8HcKNu5ykgFTJmopS/s9wVyR07GWYOjH3CtAK+ZyeHccFm4ADQ8Nftx1n/l7a60exj43
         iYato+jZjkLBcYPeLsI4Yc7MLdY44SwWSTAiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xIzS7M8GMLUegkHBYRZdBRJzgYLi/NWGMdZ70WD7qbI=;
        b=WJP/OLGWOKWMWXpo5GGdNId/srVNAvz5t9B0HSMtWRhD9b79o1DBG+ypzZGc6ScIg2
         /X7W0wg6Ik9MPkmWkVipM/fg8Ie2FL8vtaCVtYb0oTQDy9cp+tUEWHf0wU9RiLAXxSL4
         HaQlpeDdvcccRP8eAAqsohhcSigqHn02y5ST3HB5FKCTsgO8TtzW5UKPvPi9R7K6if5U
         9nrbujs3KB769RSkdU/F+UQLG4pZAzskrO6P0HalT4hGq+YYJDQIxE0SAvYHh1zMNTd5
         iWAipqcViIw4YIdxRNJoWAMcVw94ib8tD7w2VwFc4b8mHdQqzuEyBtuFiNt6PoW7ekX+
         A77A==
X-Gm-Message-State: ALoCoQmhLgk8ZFDeyZCjYm3UdrI1RazkO1QIRM7dOIPhRNan+U0rQ273ONG8ousvTiXNhabIiBrD
X-Received: by 10.194.86.135 with SMTP id p7mr25071029wjz.89.1428262055751;
        Sun, 05 Apr 2015 12:27:35 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id m1sm3539135wiw.7.2015.04.05.12.27.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Apr 2015 12:27:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266815>

On 28/03/15 12:28, Vitor Antunes wrote:
> I'm adding a test case for a scenario I was confronted with when using branch
> detection and a client view specification. It is possible that the implemented
> fix may not cover all possible scenarios, but there is no regression in the
> available tests.

Vitor, one thing I wondered about with this part of the change:

-            if entry["depotFile"] == depotPath:
+            if entry["depotFile"].find(depotPath) >= 0:

Does this mean that if 'p4 where' produces multiple lines of output that 
this will get confused, as it's just going to search for an instance of 
depotPath.

The example in the Perforce man page for 'p4 where' would trigger this 
for example:

http://www.perforce.com/perforce/r14.2/manuals/cmdref/p4_where.html

-//a/b/file.txt //client/a/b/file.txt //home/user/root/a/b/file.txt
//a/b/file.txt //client/b/file.txt /home/user/root/b/file.txt

As an experiment, I hacked git-p4 to always use p4Where rather than 
getClientRoot(), which I would have thought ought to work, but while 
most of the tests passed, Pete's client-spec torture tests failed.

Luke


>
> Vitor Antunes (2):
>    git-p4: Check branch detection and client view together
>    git-p4: Improve client path detection when branches are used
>
>   git-p4.py                |   11 ++++--
>   t/t9801-git-p4-branch.sh |   98 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 105 insertions(+), 4 deletions(-)
>
