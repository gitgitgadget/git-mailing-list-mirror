From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 3/4 v6] cache-tree: subdirectory tests
Date: Fri, 11 Jul 2014 15:46:31 -0700
Organization: Twitter
Message-ID: <1405118791.3775.26.camel@stross>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
	 <1405038686-1138-3-git-send-email-dturner@twitter.com>
	 <CAPig+cQVjy5eBtGLsX3uaTEsHyvyjhqCMFaLDn9Upueis-z1eQ@mail.gmail.com>
	 <xmqqbnsv6hmc.fsf@gitster.dls.corp.google.com>
	 <xmqq7g3j6gzr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:46:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5jaS-0000wR-Rt
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 00:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbaGKWqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 18:46:37 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:46575 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbaGKWqg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 18:46:36 -0400
Received: by mail-qc0-f175.google.com with SMTP id i8so1586442qcq.20
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 15:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=Z1e6r/lHp/pokyxfEOzsnWtS3m5XueIHG66LA02pNHw=;
        b=TpBO0NtXkzblqMvnfDeXS4YrKRTFclI+lrrvV6eWU+x6O3O7eUWxG2EjyO2p6Ni5GL
         uWz9m/2zjdIIDL26LGmupch4DlucfJk51F1EY1VZbcevsqHynrGaSvbmSzEigeM74YSh
         Ps2zILZUDG1AsLNCugHfp8PiIDPYsSZM2fuuaeL9KHmGjh187ODl56VQGKcS5HXiJ83I
         027fVqqjqjiIMIXmFNPlEjpH9VGKhulV/yScjfvBKZDteQIjv5xpnTby0j3TnO16Y4VX
         Tj3JXL0WPSutqFVhT1nCXP7kLm2lJLn1l7zFCLCYOLB8G3PmYehGrchiHPClyJua9abv
         6n9Q==
X-Gm-Message-State: ALoCoQkSQnkrvQak5jJlCc3KwdQWD7IPP7LsfUu4sHmAxPkKk5XZzG+WEhmWMooU0INuwF3GBzNy
X-Received: by 10.224.103.134 with SMTP id k6mr496060qao.27.1405118795770;
        Fri, 11 Jul 2014 15:46:35 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id v10sm6513300qaj.25.2014.07.11.15.46.33
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 15:46:34 -0700 (PDT)
In-Reply-To: <xmqq7g3j6gzr.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253341>

On Fri, 2014-07-11 at 08:40 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >>> +       sed -n -e "s/[0-9]* subtrees//" -e '/#(ref)/d' -e '/^invalid /p' >actual &&
> >
> > Is the second one to remove "#(ref)", which appears for a good
> > "reference" cache tree entry shown for comparison, necessary?  Do
> > they ever begin with "invalid"?  If they ever begin with "invalid"
> > that itself may even be a noteworthy breakage to catch, no?
> 
> Answering to myself...
> 
> Because test-dump-cache-tree uses DRY_RUN to create only an in-core
> copy of tree object, and we notice that the reference cache-tree
> created in the tests contains the object name of a tree that does
> not yet exist in the object database.  We get "invalid #(ref)" for
> such node.
> 
> In the ideal world, I think whoever tries to compare two cache-trees
> (i.e. test-dump-cache-tree) should *not* care, because we are merely
> trying to show what the correct tree object name for the node would
> be, but this is only for testing, so the best way forward would be
> to:
> 
>  - Stop using DRY_RUN in test-dump-cache-tree.c;
> 
>  - Stop the code to support DRY_RUN from cache-tree.c (nobody but
>    the test uses it); and
> 
>  - Drop the "-e '#(ref)/d'" from the above.
> 
> I would think.

Do you mean that I should do this in this patch set, or that it's a good
idea for the future?

Also, if we don't use DRY_RUN, won't test-dump-cache-tree add trees to
the actual ODB, which would be odd for a test program?
