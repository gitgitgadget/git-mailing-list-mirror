From: Luke Noel-Storr <luke.noel-storr@integrate.co.uk>
Subject: Unknown option for merge-recursive: -Xdiff-algorithm=minimal
Date: Tue, 24 Sep 2013 10:00:30 +0100
Message-ID: <E523B437-A9D4-40DD-9720-C419CB6AC016@integrate.co.uk>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 24 11:00:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOOU5-0001g6-4C
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 11:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab3IXJAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 05:00:32 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:49408 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab3IXJAb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Sep 2013 05:00:31 -0400
Received: by mail-wi0-f177.google.com with SMTP id cb5so3498542wib.4
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 02:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:content-transfer-encoding
         :subject:message-id:date:to:mime-version;
        bh=6yiUKMW7amWhaYZ0+ZTCsZmvm2H4NN9orimBR/LdQfg=;
        b=VQAz54PDFIH7BVr1Uvhib1npHDwhY4Mx7sUxuE+0ODTULqs52mOepN+Vgg/9v7Lza/
         BrJTwLAhxGmdB9L2lJZGUOEcPKT+6UJEhYt4Ssip2hvedRN46yJkNmjzrMHDQUke3ELS
         SUYdCQtA6c9jieoRjQyvaQ2uePsbctvulv7yk20hhlNAPp35Riq1Xc/yHRVpnXXvalk8
         kqBIcOpEG4v8VceMIOsP/tlnrA4izmswGvH7PqFANTnIZCwJzydMEy5mfpWqcA21GWVG
         uqHXglVy+jS8BSxaa950BM1B12YLSf97FZmeSQcL0KoHFbBHCTmjonLkpsV9hGIRIAzF
         iOfQ==
X-Gm-Message-State: ALoCoQlLBkczbVfKVZ/5QZIHgJ9buucDf3oBMa6E0nXGwdg7CzPmRRN5Kivqe9ti7QkoQ3a7jRpU
X-Received: by 10.194.77.167 with SMTP id t7mr21128448wjw.27.1380013230177;
        Tue, 24 Sep 2013 02:00:30 -0700 (PDT)
Received: from unknown-14:10:9f:de:5b:73.home (host81-133-108-122.in-addr.btopenworld.com. [81.133.108.122])
        by mx.google.com with ESMTPSA id d11sm5381077wic.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 02:00:29 -0700 (PDT)
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235287>

Hi,

I'm trying to use the diff-algorithm option for recursive merge, but get the above error.  I've tried various different ways of specifying the option, but none work.

To try and find what the correct syntax is I tried peeping into the source code, and it looks like it may actually be an error in the code.

This is from merge-recursive.c line 2072:

	else if (!strcmp(s, "diff-algorithm=")) {
		long value = parse_algorithm_value(s+15);
		if (value < 0)
			return -1;
		/* clear out previous settings */
		DIFF_XDL_CLR(o, NEED_MINIMAL);
		o->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
		o->xdl_opts |= value;
	}

I believe !strcmp(s, "diff-algorithm=") should actually be !prefixcmp(s, "diff-algorithm=")

Could someone confirm this is a bug, and is there any other way I can specify the diff algorithm?


Many Thanks,

Luke Noel-Storr.
