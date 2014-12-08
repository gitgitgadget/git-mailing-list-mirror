From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting
 the reflog file
Date: Mon, 08 Dec 2014 11:40:56 +0100
Message-ID: <54858038.9090004@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>	<1417734515-11812-8-git-send-email-mhagger@alum.mit.edu> <CAN05THTH2XDaUmchehF0gY0-GSgD_O9rJH7F5Gc3dHLCPz3GsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: ronnie sahlberg <ronniesahlberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 11:41:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxvkr-00079F-Ha
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 11:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbaLHKlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 05:41:21 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47386 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754988AbaLHKlF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 05:41:05 -0500
X-AuditID: 12074412-f79e46d0000036b4-ad-5485803bb3ac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 99.1C.14004.B3085845; Mon,  8 Dec 2014 05:40:59 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0B15.dip0.t-ipconnect.de [93.219.11.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB8AevD3001754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 8 Dec 2014 05:40:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CAN05THTH2XDaUmchehF0gY0-GSgD_O9rJH7F5Gc3dHLCPz3GsA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqGvd0Bpi0LBMzKLrSjeTRUPvFWaL
	tzeXMFr09n1itdi8uZ3FgdVj56y77B4LNpV6XLyk7PF5k1wASxS3TVJiSVlwZnqevl0Cd8b2
	9TPZC7r4Kx7Ou8LewDiDp4uRk0NCwESie+cnNghbTOLCvfVANheHkMBlRom2PfMYIZyzTBK3
	dzcwgVTxCmhL3O74ztLFyMHBIqAqseFaMUiYTUBXYlFPM1iJqECQxMk919khygUlTs58wgJi
	iwjoScxZcA1sJrNAH6PElif/mUESwgLREnd+NLOC2EIChxglVp8QA7E5BQIlpq8+BlbDLKAu
	8WfeJShbXqJ562zmCYwCs5DsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30
	cjNL9FJTSjcxQgJbaAfj+pNyhxgFOBiVeHgXPGgJEWJNLCuuzD3EKMnBpCTK+6emNUSILyk/
	pTIjsTgjvqg0J7UY6GIOZiUR3sQ4oBxvSmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILU
	IpisDAeHkgQvTz1Qo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoVuOLgdEKkuIB
	2isD0s5bXJCYCxSFaD3FqCglzusEkhAASWSU5sGNhaWrV4ziQF8K806qA6riAaY6uO5XQIOZ
	gAa/SAQbXJKIkJJqYJTre7uO+dkO5u9m68Kuih1vmiB2OOvNFGnOhJnbCx5P7rQzDG7uujm5
	sGfv5p9zKur23GuOqJV/8J1R/Zyi4v2DM6QzV2loNR86Xfp4kqDfxGgn7rv/+wQT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261006>

On 12/05/2014 03:59 AM, ronnie sahlberg wrote:
> On Thu, Dec 4, 2014 at 3:08 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> We don't actually need the locking functionality, because we already
>> hold the lock on the reference itself,
> 
> No. You do need the lock.
> The ref is locked only during transaction_commit()
> 
> If you don't want to lock the reflog file and instead rely on the lock
> on the ref itself you will need to
> rework your patches so that the lock on the ref is taken already
> during, for example, transaction_update_ref() instead.
> 
> But without doing those changes and moving the ref locking from
> _commit() to _update_ref() you will risk reflog corruption/surprises
> if two operations collide and both rewrite the reflog without any lock held.

Ronnie, I don't understand your comments.

It is a statement of fact (to the best of my knowledge) that reflogs are
supposed to be modified only under a lock on the corresponding
reference, namely "$GIT_DIR/refs/$refname.lock". We do not require
reflog writers to hold "$GIT_DIR/logs/$refname.lock".

In this function, "$GIT_DIR/logs/$refname.lock" happens to be the name
of the temporary file being used to stage the new contents of the
reflog. But that is more or less a coincidence; we could call the
temporary file whatever we want because it has no locking implications.
However, what we want to do with the file in this code path (write a new
version then rename the new version on top of the old version, deleting
the temporary file if the program is interrupted) is the same as what we
do with lockfiles, so we use the lockfile code because it is convenient.

This patch series has nothing to do with ref_transaction_commit() or any
of the transaction machinery. It has to do with expire_reflog(), which
is invoked outside of any transaction.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
