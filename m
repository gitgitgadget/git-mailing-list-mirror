From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [Bug] incomplete defence agains creating a branch named HEAD
Date: Wed, 05 Aug 2015 17:46:17 +0200
Message-ID: <1438789577.17587.7.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 17:46:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN0th-0000mb-66
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 17:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbbHEPqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 11:46:24 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33913 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbbHEPqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 11:46:21 -0400
Received: by wicne3 with SMTP id ne3so10302892wic.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 08:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:content-type
         :mime-version:content-transfer-encoding;
        bh=YyKPTrQcOGW697YAblZjPZ4CKJyIdxaLXgjJk/Im3m0=;
        b=cYrKHeF0+h6TkaPEmKEkHYABZMLab5FKSCIYwVtCLYkrIQPJG1n0UFsZskaKMTNlOa
         8zeCgMoFOsy3xY9AKKHZFJvvNMjIt1D9hBo6c5YokK+6kr9kswE/5igccLsI8zITvSlb
         /rEkguz2OiLoZpHp0NpbgOZ7nwIe+OFL9ZDu/swe567PJq9gLbsapqqfVOrMxKVzcORD
         ME+krt4iqM26qWVuEjYe9oaApNWZ/nlswtcJjn0Wn1Kj88OcYJZPxEbq9YRkC+NY46XO
         7Lx0V54wSiyB8bql4tFXeTHVLe1nHlzIr4puaBI60gHq7IgwI1DmY8QOGtRWMoEOGNll
         B0mg==
X-Gm-Message-State: ALoCoQk6fJolf8C7YR7cVY1DKZCMQRSswGZcksB0rBtwTxsi3h4G21JlpmJXNv+BEpp6tfLrGKMe
X-Received: by 10.194.57.232 with SMTP id l8mr22488599wjq.48.1438789580728;
        Wed, 05 Aug 2015 08:46:20 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by smtp.gmail.com with ESMTPSA id fm8sm8210986wib.9.2015.08.05.08.46.18
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2015 08:46:19 -0700 (PDT)
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275372>

So git branch doesn't like to create a branch named HEAD

$ git branch HEAD
fatal: it does not make sense to create 'HEAD' manually

But, you can trick it into doing so anyway:

$ git branch @
$ git branch -a
  HEAD
* master

At which point git status becomes a bit confused:

$ git status
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
On branch master
nothing to commit, working directory clean

Oh, and git checkout will accept either HEAD or @ to create a branch
with the name HEAD anyway:

$ git checkout -b HEAD
Switched to a new branch 'HEAD'

$ git checkout -b @
Switched to a new branch 'HEAD'

imho none of these should create a branch named HEAD, but should do what
'git branch HEAD' does and fail with a sensible error message.

All these shenanigans came up when trying to help an user who is
mirroring a mercurial repo that has a branch named '@'. Whether or not
git should allow branches named '@' I don't have an opinion on, I know
'@' is pretty special when dealing with refs.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
